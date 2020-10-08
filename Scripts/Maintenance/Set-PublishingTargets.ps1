Function Set-PublishingTargets
{
    <#
    .SYNOPSIS
        Sets a new publishing target for publishing packages
    .DESCRIPTION
        With this CMDlet you can iterate over existing publishing packages, search for a specific existing
        publishing target and replace or add new publishing targets to it which can also be created automatically
    #>
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # When replacing publishing targets, we need an attribute that we should search for, so that we know
        # what and how to replace
        [Parameter(
                Position = 0,
                Mandatory = $false,
                ParameterSetName = 'byMSSession'
        )]
        [string] $SearchAttribute,
        # This parameter is used in combination with the $SearchAttribute and will be used to search the value
        # of the given attribute to find a match
        [Parameter(
                Position = 1,
                Mandatory = $false,
                ParameterSetName = 'byMSSession'
        )]
        [string] $SearchString,
        # A list of strings that will be used to set new publishing targets where the data from the matched target
        # from the above parameters will be re-used except for the given attribute, where it's value will be
        # replaced by the value from this string array
        # This is an array, so we can create multiple new publishing targets at once.
         #>
        [Parameter(
                Position = 2,
                Mandatory = $false,
                ParameterSetName = 'byMSSession'
        )]
        [string[]] $ReplaceStrings
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);

        Register-MSConfigStore;

        Set-MSConfigDebugMode -Value ($false); # $true oder $false

        Register-MSSession -UseDefaults ($true);
        Select-MSSession -UseDefaults ($true);
        Enter-MSSession -UseDefaults ($true);

        $ProjectsWithOutDatedTargets = 0
        $Report = [ordered]@{}
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);

        $Projects = (Get-MSAllProjects).SelectNodes("IODATA/PROJECTS/PROJECT");
        foreach ($Project in $Projects)
        {
            $ProjectName = $Project.name
            # TODO - Remove start
            if ($ProjectName -ne "FastTrackTest1")
            {
                continue
            }
            # TODO - Remove end

            $Report.Add($ProjectName, @())

            # Inhibitlevel tells us about the lock level of the system and
            # -1 stands for "Locked to all users including Server Manager"
            # so since we can't access the projec tanyway, we can skip it.
            if ($Project.inhibitlevel -eq -1) {
                $Report[$ProjectName] += "Project is locked. Skipping..."
                continue;
            }

            $Report[$ProjectName] += "Project is accessible. Validating..."

            # We need to log into the project, since publishing targets can only be loaded for the current project
            # and not by providng a project id to the api endpoint
            Enter-MSProject -ProjectGUID $Project.Guid | Out-Null

            $OutDatedTargetGuid = $null
            $NewTargets = @{}
            foreach ($ReplaceString in $ReplaceStrings)
            {
                # This is just a map for better performance when
                $NewTargets.Add($ReplaceString, $null);
            }

            $PublishingTargets = (Get-MSPublishingTargets).SelectNodes("IODATA/EXPORTS/EXPORT")
            foreach ($PublishingTarget in $PublishingTargets)
            {
                $SearchValue = $PublishingTarget.Attributes[$SearchAttribute].Value;
                if ($SearchValue -eq $SearchString)
                {
                    $OutDatedTargetGuid = $PublishingTarget.guid
                    $ProjectsWithOutDatedTargets++
                }
                elseif ($ReplaceStrings.Contains($SearchValue))
                {
                    $NewTargets[$SearchValue] = $PublishingTarget.guid;
                }
            }

            if ($null -eq $OutDatedTargetGuid)
            {
                # There are no outdated targets in this project, so we can simply continue for the current project
                # since it doesn't need any further processing
                $Report[$ProjectName] += "No outdated targets found"
                continue;
            }
            $OutDatedTargetData = (Get-MSPublicationTargetData -PublicationTargetGUID $OutDatedTargetGuid).SelectSingleNode("IODATA/EXPORT")
            $PublishingTargetType = $OutDatedTargetData.type

            if ($PublishingTargetType -ne 6208)
            {
                $Report[$ProjectName] += "Outdated publishing target is not of type SFTP and thus unsupported. Skipping..."
                continue;
            }

            $OutDatedTargetData
            # We now check if the given targets already exist, and if not, create new targets
            foreach ($NewTargetKey in $NewTargets.Keys)
            {
                if ($null -eq $NewTargetKey)
                {


                }

            }

#            $NewTargets


#            # We want to save publication target GUIDs that don't fit our matching, so that we don't do the same
#            # request numerous times.
#            $InvalidPublicationTargetGuidMap = @()
#
#            $ExportPackages = (Get-MSProjectPublicationPackages).SelectNodes("IODATA/EXPORTPACKETS/EXPORTPACKET")
#            foreach ($ExportPackage in $ExportPackages)
#            {
#                $ExportPackageGuid = $ExportPackage.Guid
#                $ExportPackageName = $ExportPackage.name
#
#                $ExportPackageSettings = (Get-MSPublicationPackageInformationData -PublicationPackageGUID -$ExportPackageGuid).SelectNodes("IODATA/EXPORTPACKET/EXPORTSETTINGS/EXPORTSETTING")
#                foreach ($ExportPackageSetting in $ExportPackageSettings)
#                {
#                    $ProjectVariant = $ExportPackageSetting.projectvariantname
#                    $LanguageVariant = $ExportPackageSetting.languagevariantname
#
#                    $ExportTargets = $ExportPackageSetting.SelectNodes("EXPORTTARGETS/EXPORTTARGET")
#                    foreach ($ExportTarget in $ExportTargets)
#                    {
#                        $PublicationTargetGuid = $ExportTarget.guid
#
#                        if ($InvalidPublicationTargetGuidMap.Contains($PublicationTargetGuid))
#                        {
#                            continue;
#                        }
#
#                        $SearchAttributeValue = (Get-MSPublicationTargetData -PublicationTargetGUID $PublicationTargetGuid).SelectSingleNode("IODATA/EXPORT").Attributes[$SearchAttribute].Value
#
#                        if ($SearchAttributeValue -eq $SearchString)
#                        {
#                            Write-Host "Matched $SearchAttributeValue..."
#                        }
#                    }
#                }
#
#            }
#            $InvalidPublicationTargetGuidMap = @()
#
#            $First = $true;

        }
    }
    end {
        $Report

        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);

        Exit-MSSession -UseDefaults ($true);
        Unregister-MSSession -UseDefaults ($true);

        Unregister-MSConfigStore;
    }
}
