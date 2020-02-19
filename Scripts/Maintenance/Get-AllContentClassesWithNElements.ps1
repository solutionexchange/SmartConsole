function Get-AllContentClassesWithNElements
{
    <#
    .SYNOPSIS
        Retrieves all content classes which have more than a specific number of elements
    .DESCRIPTION
        Retrieves all content classes which have more than a specific number of elements
    #>
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        [Parameter(
                Position = 0,
                Mandatory = $false,
                ParameterSetName = 'byMSSession'
        )]
        [int] $ElementThreshold = 25
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

        $AllContentClassesOfFolder = (Get-MsContentClasses -ContentClassFolderGUID ($ContentClassFolder.guid)).SelectNodes("IODATA/TEMPLATES/TEMPLATE");

        $Result = @()
        foreach ($ContentClass in $AllContentClassesOfFolder) {
            $ContentClassProperties = Get-MSContentClassAllProperties -ContentClassGUID $ContentClass.guid
            $Elements = $ContentClassProperties.SelectNodes("IODATA/TEMPLATE/ELEMENTS/ELEMENT")

            if ($Elements.Count -lt $ElementThreshold)
            {
                continue;
            }

            $ContentClassData = [pscustomobject][ordered]@{
                ContentClassName = $ContentClass.name
                ContentClassGuid = $ContentClass.guid
                ElementCount = $Elements.Count
            }

            $Result += $ContentClassData
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
