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
        [AllowNull()]
        $ReportData = $null,
        [Parameter(
                Position = 3,
                Mandatory = $false,
                ParameterSetName = 'byMSSession'
        )]
        [Switch] $AsPlainText
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);

        Register-MSConfigStore;

        Set-MSConfigDebugMode -Value ($false); # $true oder $false

        Register-MSSession -UseDefaults ($true);
        Select-MSSession -UseDefaults ($true);
        Enter-MSSession -UseDefaults ($true);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);

        # Check if a HTML template for the given report name exists and assign it to PreContenta nd PostContent params
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

        # In these next few lines we merge the base report html templates with report specific html templates
        # and replace some variables for report data
        $PreContentParam = (Get-Content -Path $PSScriptRoot/Templates/Base/PreContent.html)
        if ($null -ne (Get-Variable -Name "PreContent" -ValueOnly))
        {
            $PreContentParam += Get-Content -Path (Get-Variable -Name "PreContent" -ValueOnly)
        }
        $PreContentParam = $PreContentParam.Replace("%ReportName%", $ReportName)
        $PreContentParam = $PreContentParam.Replace("%Date%", (Get-Date -Format "dd.MM.yyy"))
        $PreContentParam = $PreContentParam.Replace("%Time%", (Get-Date -Format "HH:mm:ss"))
        $PreContentParam = $PreContentParam.Replace("%Cluster%", (([System.Uri](Get-MSSessionProperty -Name ("Uri")))).Host)
        $PreContentParam = $PreContentParam.Replace("%Username%", (Get-MSSessionProperty -Name ("Username")))

        $PostContentParam = (Get-Content -Path $PSScriptRoot/Templates/Base/PostContent.html)
        if ($null -ne (Get-Variable -Name "PostContent" -ValueOnly))
        {
            $PostContentParam += Get-Content -Path (Get-Variable -Name "PostContent" -ValueOnly)
        }
        $Body = $ReportData | ConvertTo-Html -PreContent $PreContentParam -PostContent $PostContentParam -Head  (Get-Content -Path $PSScriptRoot/Templates/Base/Head.html) | Out-String

        if ($true -eq $AsPlainText)
        {
            return $Body
        }
        else
        {
            $MailConfig = Get-Content -Path $PSScriptRoot/mail.config.json | ConvertFrom-Json
            $Password = ConvertTo-SecureString -String $MailConfig.SmtpPassword -AsPlainText -Force
            $Credentials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $MailConfig.SmtpUsername, $Password
            Send-MailMessage -From $MailConfig.From -to $Recipients -Subject "Report: $( $ReportName )" -Body $Body -SmtpServer $MailConfig.SmtpServer -Port $MailConfig.SmtpPort -UseSsl -Credential $Credentials
        }
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);

        Exit-MSSession -UseDefaults ($true);
        Unregister-MSSession -UseDefaults ($true);

        Unregister-MSConfigStore;
    }
}
