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
        [string[]] $Tags
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

        $CategorySearchConfiguration = @()
        foreach ($Tag in $Tags)
        {
            $CategorySearchConfiguration += [pscustomobject][ordered] @{
                CategoryGuid = $Tag
                Operator = "eq"
            }
        }

        $ProjectPages = Find-MSPages -CategorySearchConfiguration $CategorySearchConfiguration
        $PerformanceResults = @()

        Write-Host $ProjectPages.Count

        foreach ($ProjectPage in $ProjectPages) {
            Remove-MSPageCache -PageGuids ($ProjectPage.guid) | Out-Null
            $PreviewTime = (Measure-Command {Get-MSPagePreview -PageGUID $ProjectPage.guid})
            $PreviewTimeCached = (Measure-Command {Get-MSPagePreview -PageGUID $ProjectPage.guid})

            $PerformanceResult = [pscustomobject][ordered]@{
                Id         = $ProjectPage.id;
                Guid       = $ProjectPage.guid;
                Headline   = $ProjectPage.headline;
                Time       = "$($PreviewTime.Seconds).$($PreviewTime.MilliSeconds)";
                TimeCached = "$($PreviewTimeCached.Seconds).$($PreviewTimeCached.MilliSeconds)";
            }

            $PerformanceResults += $PerformanceResult
        }

        return $PerformanceResults
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);

        Exit-MSSession -UseDefaults ($true);
        Unregister-MSSession -UseDefaults ($true);

        Unregister-MSConfigStore;
    }
}
