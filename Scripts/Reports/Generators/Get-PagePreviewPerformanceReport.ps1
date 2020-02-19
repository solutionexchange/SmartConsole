function Get-PagePreviewPerformanceReport
{
    <#
    .SYNOPSIS
        Generates a report out of the Measure-PagePreviewPerformance CMDlet
    .DESCRIPTION
        Generates a report out of the Measure-PagePreviewPerformance CMDlet
    #>
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        [Parameter(
                Position = 0,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string[]] $Tags
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);

        $Result = (Measure-PagePreviewPerformance -Tags $Tags).GetEnumerator() | Sort-Object -Property TimeCached -Descending

        return $Result | ConvertTo-Html
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}
