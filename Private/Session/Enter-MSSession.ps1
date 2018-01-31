Function Enter-MSSession {
    <#
    .SYNOPSIS
        ... {SYNOPSIS} ...
    .DESCRIPTION
        ... {DESCRIPTION} ...
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        ... {NOTES} ...
    #>
    [Alias('Enter-CMSSession')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $false,
            ParameterSetName = 'byMSSession'
        )]
        [string] $Username,
        # {DESCRIPTION}
        [Parameter(
            Position = 1,
            Mandatory = $false,
            ParameterSetName = 'byMSSession'
        )]
        [bool] $UseDefaults = $false
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        [byte[]] $Key = (1..16);
        if ($UseDefaults) {
            $CredentialsUserName = Get-MSSessionProperty -Name ("Username");
        }
        else {
            $CredentialsUserName = $Username;
        }
        $CredentialsPasswordFile = Get-Content ("$PSScriptRoot\..\Store\{0}.pwd" -f $CredentialsUserName) -ErrorAction Stop;
        $CredentialsSecurePassword = $CredentialsPasswordFile | ConvertTo-SecureString -Key $Key;
        $Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList ($CredentialsUserName, $CredentialsSecurePassword);
        Set-MSSessionProperty -Name ("Username") -Value ($Credentials.GetNetworkCredential().Username);
        Set-MSSessionProperty -Name ("Password") -Value ($Credentials.GetNetworkCredential().Password);
        Set-MSTimestamp;
        $Request = ("<IODATA><ADMINISTRATION action='login' name='[!username!]' password='[!password!]'/></IODATA>");
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        Show-MSSessionWebServiceDebug;
        Set-MSSessionProperty -Name ("UserGUID") -Value ($Response.IODATA.USER.guid);
        Set-MSSessionProperty -Name ("LoginGUID") -Value ($Response.IODATA.LOGIN.guid);
        Set-MSSessionProperty -Name ("SessionKey") -Value ($Response.IODATA.LOGIN.guid);
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}