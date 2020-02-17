function Measure-PagePreviewPerformance
{
    <#
    .SYNOPSIS
        Measuring performance of the page preview call
    .DESCRIPTION
        With this CMDlet you can get a report about the preview of a page in a cached vs. non-cached way
    #>
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        [Parameter(
                Position = 0,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string] $ProjectGUID,
        [Parameter(
                Position = 1,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string[]] $Tags
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);

        Register-MSConfigStore;

        Set-MSConfigDebugMode -Value ($false); # $true oder $false

        Register-MSSession -UseDefaults ($true);
        Select-MSSession -UseDefaults ($true);
        Enter-MSSession -UseDefaults ($true);

        Enter-MSProject -ProjectGUID ($ProjectGUID) | Out-Null;
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);

        $ProjectPages = Get-MSPages -Tags $Tags
        $PerformanceResults = @()

        foreach ($ProjectPage in $ProjectPages) {
            $PerformanceResult = New-Object -TypeName PSObject
            Add-Member -InputObject $PerformanceResult -MemberType NoteProperty -Name Id -Value $ProjectPage.id
            Add-Member -InputObject $PerformanceResult -MemberType NoteProperty -Name Guid -Value $ProjectPage.GUID
            Add-Member -InputObject $PerformanceResult -MemberType NoteProperty -Name Headline -Value $ProjectPage.headline

            Remove-MSPageCache -PageGuids ($PerformanceResult.Guid) | Out-Null

            $PreviewTime = (Measure-Command {Get-MSPagePreview -PageGUID $ProjectPage.GUID})
            $PreviewTimeCached = (Measure-Command {Get-MSPagePreview -PageGUID $ProjectPage.GUID})

            Add-Member -InputObject $PerformanceResult -MemberType NoteProperty -Name Time -Value "$($PreviewTime.Seconds).$($PreviewTime.MilliSeconds)"
            Add-Member -InputObject $PerformanceResult -MemberType NoteProperty -Name TimeCached -Value "$($PreviewTimeCached.Seconds).$($PreviewTimeCached.MilliSeconds)"

            $PerformanceResults += $PerformanceResult
        }

        return $PerformanceResults.GetEnumerator() | Sort-Object -Property TimeCached -Descending
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);

        Exit-MSSession -UseDefaults ($true);
        Unregister-MSSession -UseDefaults ($true);

        Unregister-MSConfigStore;
    }
}
