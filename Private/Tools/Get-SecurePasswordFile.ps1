Function Get-SecurePasswordFile {
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
    [CmdletBinding(DefaultParameterSetName = 'byCredentials')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ParameterSetName = 'byCredentials'
        )]
        [string] $Username
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
        function Get-ScriptDirectory {
            $Invocation = (Get-Variable MyInvocation -Scope 1).Value;
            if ($Invocation.MyCommand.Path) {
                return Split-Path $Invocation.MyCommand.Path;
            }
        }
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        [byte[]] $Key = (1..16);
        $CredentialsUsername = $Username;
        $CredentialsPasswordFile = Get-Content ("{0}\..\Store\{1}.pwd" -f $PSScriptRoot, $CredentialsUsername) -ErrorAction SilentlyContinue -ErrorVariable Error;
        if ($Error) {
            Write-Error ("Script: {0}`r`nCommand: {1}`r`nError: " -f $MyInvocation.ScriptName, $MyInvocation.MyCommand + $Error);
            Get-PSCallStack | Format-List;
            break;
        }
        else {
            $CredentialsSecurePassword = $CredentialsPasswordFile | ConvertTo-SecureString -Key $Key;
            $Credentials = New-Object System.Management.Automation.PSCredential -ArgumentList ($CredentialsUsername, $CredentialsSecurePassword);
            return $Credentials;
        }
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}