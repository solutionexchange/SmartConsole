function Send-MaintenanceReport
{
    <#
    .SYNOPSIS
        This CMDlet sends an email with a maintenance report from maintenance scripts
    .DESCRIPTION
        This CMDlet sends an email to a list of recipients with a maintenance report from maintenance scripts.
        The ReportName parameter is used to define pre/post content and a css uri from the templates folder
    #>
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        [Parameter(
                Position = 0,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string[]] $Recipients,
        [Parameter(
                Position = 1,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string[]] $ReportName,
        [Parameter(
                Position = 2,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        $ReportData
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);

        $Files = @("PreContent", "PostContent")
        foreach ($File in $Files)
        {
            if (Test-Path $PSScriptRoot/Templates/$ReportName/$File.html -PathType Leaf)
            {
                Set-Variable -Name $File -Value $PSScriptRoot/Templates/$ReportName/$File.html
            }
            else
            {
                Set-Variable -Name $File -Value $null
            }
        }

        $PreContentParam = (Get-Content -Path $PSScriptRoot/Templates/Base/PreContent.html)
        if ($null -ne (Get-Variable -Name "PreContent" -ValueOnly))
        {
            $PreContentParam += Get-Content -Path (Get-Variable -Name "PreContent" -ValueOnly)
        }
        $PreContentParam = $PreContentParam.Replace("%ReportName%", $ReportName)
        $PreContentParam = $PreContentParam.Replace("%Date%", (Get-Date -Format "dd.MM.yyy"))
        $PreContentParam = $PreContentParam.Replace("%Time%", (Get-Date -Format "HH:mm:ss"))

        $PostContentParam = (Get-Content -Path $PSScriptRoot/Templates/Base/PostContent.html)
        if ($null -ne (Get-Variable -Name "PostContent" -ValueOnly))
        {
            $PostContentParam += Get-Content -Path (Get-Variable -Name "PostContent" -ValueOnly)
        }

        return $ReportData | ConvertTo-Html -PreContent $PreContentParam -PostContent $PostContentParam -Head  (Get-Content -Path $PSScriptRoot/Templates/Base/Head.html)
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}
