Function Set-SecurePasswordFile {
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
        ... {LINK} ....
    .NOTES
        ... {NOTES} ...
    #>
    [CmdletBinding()]
    param()
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        [byte[]] $Key = (1..16);
        $CredentialsInput = Get-Credential -Message ("Please type your Credentials for the Management Server:");
        $CredentialsUsername = $CredentialsInput.GetNetworkCredential().Username;
        $CredentialsPassword = $CredentialsInput.GetNetworkCredential().Password;
        if ($CredentialsUsername) {
            $CredentialsSecureStringPassword = $CredentialsPassword | ConvertTo-SecureString -AsPlainText -Force;
            $SecureStringOutPut = $CredentialsSecureStringPassword | ConvertFrom-SecureString -Key $Key;
            Set-Content ("{0}\..\Store\{1}.pwd" -f $PSScriptRoot, $CredentialsUsername) ($SecureStringOutPut) -ErrorAction SilentlyContinue -ErrorVariable Error;
            if ($Error) {
                Write-Error ("Script: {0}`r`nCommand: {1}`r`nError: " -f $MyInvocation.ScriptName, $MyInvocation.MyCommand + $Error);
                Get-PSCallStack | Format-List;
                break;
            }
        }
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}