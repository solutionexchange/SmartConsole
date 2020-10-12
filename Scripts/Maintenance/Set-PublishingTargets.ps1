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
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string] $SearchAttribute,
        # This parameter is used in combination with the $SearchAttribute and will be used to search the value
        # of the given attribute to find a match
        [Parameter(
                Position = 1,
                Mandatory = $true,
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
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string[]] $ReplaceStrings,
        # The new targets need names that can identify the them, so we don't reuse the same name as the outdated target
        # Please note, that this array must be size 1 our the same count as replace strings, otherwise an error will be thrown
        #>
        [Parameter(
                Position = 3,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string[]] $NewTargetNameSuffixes,
        # If we cannot get the fingerprint of the server manually, we need to pass it in here in order to use SFTP.
        # Must be the same number as ReplaceStrings or an error will be thrown
        #>
        [Parameter(
                Position = 4,
                Mandatory = $false,
                ParameterSetName = 'byMSSession'
        )]
        [string[]] $Fingerprints
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

        if ($NewTargetNameSuffixes.Count -ne 1 -and $NewTargetNameSuffixes.Count -ne $ReplaceStrings.Count)
        {
            Write-Error "Parameter NewTargetNameSuffixes must be an array with count of ONE or equal to count of ReplaceStrings"
            return;
        }

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
            # This map will hold information about the target (url) and the GUID the target will have
            $NewTargets = @{}
            # Whereas this map will hold information about the target (url) and whether there exists a publication combination already
            $PublicationCombinationMap = @{}
            foreach ($ReplaceString in $ReplaceStrings)
            {
                # This is just a map for better performance when
                $NewTargets.Add($ReplaceString, $null);
                $PublicationCombinationMap.Add($ReplaceString, $false);
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
            } elseif ($OutDatedTargetData.proxytype -ne 0)
            {
                $Report[$ProjectName] += "Outdated publishing target has proxy configuration and thus is unsupported. Skipping..."
            }

            $Counter = 0;
            # Because we cannot modify a collection we are iterating over, we need to copy the collection first
            # so that we iterate over a copy and modify the original hashtable
            $NewTargetsCopy = $NewTargets.Clone()
            # We now check if the given targets already exist, and if not, create new targets
            foreach ($NewTargetKey in $NewTargetsCopy.Keys)
            {
                $Value = $NewTargets[$NewTargetKey]
                if ($null -eq $Value)
                {
                    $Name = ($OutDatedTargetData.name + " " + $NewTargetNameSuffixes[$Counter])
                    $Report[$ProjectName] += "Creating new target $Name..."

                    # We're using a hash table to pass the parameters, because we want to dynamically be able to
                    # replace a specific property which cannot be done otherwise.
                    $Arguments = @{
                        Name = $Name
                        NoBOM = $OutDatedTargetData.nobom
                        ReplaceCrlfWithLfinPublishedFile = $OutDatedTargetData.replacecrlfwithlfinpublishedfile
                        Username = $OutDatedTargetData.username
                        Password = $OutDatedTargetData.password
                        Path = $OutDatedTargetData.path
                        Port = $OutDatedTargetData.port
                        UrlPrefix = $OutDatedTargetData.urlprefix
                        Fingerprint = $Fingerprints[$Counter]
                        KeyFile = $OutDatedTargetData.keyfile
                        KeyFilePassword = $OutDatedTargetData.keyfilepassword
                    }

                    # This is the replacement we talked about before
                    $Arguments[$SearchAttribute] = $NewTargetKey
                    $NewTargets[$NewTargetKey] = (New-MSSftpPublicationPackage @Arguments).SelectSingleNode("IODATA").InnerXml

                    $Counter++
                }
                else
                {
                    $Report[$ProjectName] += "Target for $NewTargetKey already exists ($Value). Not creating..."
                }
            }

            # We want to save publication target GUIDs that don't fit our matching, so that we don't do the same
            # request numerous times.
            $InvalidPublicationTargetGuidMap = @()
            $ExportPackages = (Get-MSProjectPublicationPackages).SelectNodes("IODATA/EXPORTPACKETS/EXPORTPACKET")

            # Counter for number of added combinations
            $AddedCounter = 0
            foreach ($ExportPackage in $ExportPackages)
            {
                $ExportPackageGuid = $ExportPackage.Guid

                $ExportPackageSettings = (Get-MSPublicationPackageInformationData -PublicationPackageGUID -$ExportPackageGuid).SelectNodes("IODATA/EXPORTPACKET/EXPORTSETTINGS/EXPORTSETTING")
                foreach ($ExportPackageSetting in $ExportPackageSettings)
                {
                    $PublicationCombinationGuid = $ExportPackageSetting.guid
                    $ExportTargets = $ExportPackageSetting.SelectNodes("EXPORTTARGETS/EXPORTTARGET")
                    $hasOutdatedTarget = $false;

                    foreach ($ExportTarget in $ExportTargets)
                    {
                        $PublicationTargetGuid = $ExportTarget.guid

                        # This is just for performance for further processing, so we don't need to ask for "invalid"
                        # things
                        if ($InvalidPublicationTargetGuidMap.Contains($PublicationTargetGuid))
                        {
                            continue;
                        }

                        if ($PublicationTargetGuid -eq $OutDatedTargetGuid)
                        {
                            $hasOutdatedTarget = $true
                        } elseif ($PublicationCombinationMap.ContainsKey($PublicationTargetGuid))
                        {
                            $PublicationCombinationMap[$PublicationTargetGuid] = $true
                        }
                    }

                    if ($hasOutdatedTarget -eq $false)
                    {
                        continue;
                    }

                    foreach ($PublicationCombinationMapKey in $PublicationCombinationMap.Keys)
                    {
                        if ($PublicationCombinationMap[$PublicationCombinationMapKey] -eq $false)
                        {
                            $Counter++
                            Set-MSPublishingTargetForPublicationCombination `
                                -PublicationCombinationGuid $PublicationCombinationGuid`
                                -PublishingTargetGuid $NewTargets[$PublicationCombinationMapKey] | Out-Null
                        }
                    }
                }
            }

            $Report[$ProjectName] += "Added $AddedCounter new combinations in this project"
        }

        return $Report
    }
    end {

        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);

        Exit-MSSession -UseDefaults ($true);
        Unregister-MSSession -UseDefaults ($true);

        Unregister-MSConfigStore;
    }
}
