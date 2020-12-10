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
                Mandatory = $false,
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

        $PreContent = Get-Content -Path $PSScriptRoot/Templates/Base/PreContent.html
        $PreContent = $PreContent.Replace("%ReportName%", $ReportName)
        $PreContent = $PreContent.Replace("%Date%", (Get-Date -Format "dd.MM.yyy"))
        $PreContent = $PreContent.Replace("%Time%", (Get-Date -Format "HH:mm:ss"))
        $PreContent = $PreContent.Replace("%Cluster%", (([System.Uri](Get-MSSessionProperty -Name ("Uri")))).Host)
        $PreContent = $PreContent.Replace("%Username%", (Get-MSSessionProperty -Name ("Username")))

        $PostContent = Get-Content -Path $PSScriptRoot/Templates/Base/PostContent.html

        $Body = ConvertTo-Html -PreContent $PreContent -PostContent $PostContent -Head  (Get-Content -Path $PSScriptRoot/Templates/Base/Head.html) | Out-String
        $Body = $Body.Replace("%Content%", $ReportData)

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
