function Get-AllContentClassesInEditingReport
{
    <#
    .SYNOPSIS
        Generates a report out of the Get-AllContentClassesInEditing CMDlet
    .DESCRIPTION
        Generates a report out of the Get-AllContentClassesInEditing CMDlet
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
    }
    process {
        [xml]$Result = (Get-AllContentClassesInEditing -ContentClassFolderGUID $ContentClassFolderGUID).GetEnumerator() | Sort-Object -Property Lockdate | ConvertTo-Html -Fragment

        # We want to add specific classes to the table dependent on if the entry has been locked for more than 48
        # hours or for more than 24 hours but less than 48 hours
        $CurrentDate = Get-Date
        $TimeSpan48Hours = New-TimeSpan -hours 48
        $TimeSpan24Hours = New-TimeSpan -hours 24

        # Starting at 1, since 0 is the table headers
        for ($i = 1; $i -le $Result.table.tr.count-1; $i++)
        {
            $DiffDate = $CurrentDate - (Get-Date $Result.table.tr[$i].td[3])

            $class = $Result.CreateAttribute("class")
            if ($DiffDate -gt $TimeSpan48Hours)
            {
                $class.value = "alert"
            }
            elseif ($DiffDate -lt $TimeSpan48Hours -And $DiffDate -gt $TimeSpan24Hours)
            {
                $class.value = "warning"
            }

            [void]$Result.table.tr[$i].attributes.append($class)
        }

        return (Get-Content -Path $PSScriptRoot/../Templates/AllContentClassesInEditing/PreContent.html) + $Result.InnerXml
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}
