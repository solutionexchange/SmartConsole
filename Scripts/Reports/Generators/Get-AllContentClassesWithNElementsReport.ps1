function Get-AllContentClassesWithNElementsReport
{
    <#
    .SYNOPSIS
        Generates a report out of the Get-AllContentClassesWithNElements CMDlet
    .DESCRIPTION
        Generates a report out of the Get-AllContentClassesWithNElements CMDlet
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
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);

        $Result = (Get-AllContentClassesWithNElements -ElementThreshold $ElementThreshold).GetEnumerator() | Sort-Object -Property ElementCount -Descending

        $PreContent = (Get-Content -Path $PSScriptRoot/../Templates/AllContentClassesWithNElements/PreContent.html).Replace("%ElementThreshold%", $ElementThreshold)
        return  $PreContent + ($Result | ConvertTo-Html)
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}
