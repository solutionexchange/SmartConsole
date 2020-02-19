function Get-AllContentClassesInEditing
{
    <#
    .SYNOPSIS
        Retrieves all content classes which are currently being edited
    .DESCRIPTION
        With this CMDlet you can get a report about which content classes are being edited and since when
    #>
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        [Parameter(
                Position = 0,
                Mandatory = $false,
                ParameterSetName = 'byMSSession'
        )]
        [string] $ContentClassFolderGUID
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);

        Register-MSConfigStore;

        Set-MSConfigDebugMode -Value ($false); # $true oder $false

        Register-MSSession -UseDefaults ($true);
        Select-MSSession -UseDefaults ($true);
        Enter-MSSession -UseDefaults ($true);

        Enter-MSProject -ProjectGUID (Get-MSSessionProperty -Name ("ProjectGUID")) | Out-Null;
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);

        $AllContentClassesOfFolder = (Get-MSContentClasses -ContentClassFolderGUID ($ContentClassFolder.guid)).SelectNodes("IODATA/TEMPLATES/TEMPLATE");

        $Result = @()
        foreach ($ContentClass in $AllContentClassesOfFolder) {
            $ContentClassProperties = Get-MSContentClassAllProperties -ContentClassGUID $ContentClass.guid
            $TemplateVariants = $ContentClassProperties.SelectNodes("IODATA/TEMPLATE/TEMPLATEVARIANTS")
            foreach ($TemplateVariant in $TemplateVariants)
            {
                if ($TemplateVariant.lock -eq "1")
                {
                    foreach ($TemplateVariantAtom in $TemplateVariants.SelectNodes("TEMPLATEVARIANT"))
                    {
                        if ($TemplateVariantAtom.draft -eq "1")
                        {
                            # Using ordered so we can assure this is the correct order of attributes
                            $ResultObject = [pscustomobject][ordered]@{
                                ContentClassName = $ContentClass.name
                                TemplateVariant = $TemplateVariantAtom.name
                                Guid = $TemplateVariantAtom.guid
                                Lockdate = $TemplateVariantAtom.changeddate | ConvertFrom-OADate
                                Lockuser = $TemplateVariantAtom.changedusername
                            }

                            $Result += $ResultObject
                        }
                    }
                }
            }
        }

        return $Result
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);

        Exit-MSSession -UseDefaults ($true);
        Unregister-MSSession -UseDefaults ($true);

        Unregister-MSConfigStore;
    }
}
