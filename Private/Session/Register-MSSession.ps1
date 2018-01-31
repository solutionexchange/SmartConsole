Function Register-MSSession {
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
    [Alias('Register-CMSSession')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $false,
            ParameterSetName = 'byMSSession'
        )]
        [string] $SessionName = 'Default',
        # {DESCRIPTION}
        [Parameter(
            Position = 1,
            Mandatory = $false,
            ParameterSetName = 'byMSSession'
        )]
        [string] $Uri,
        # {DESCRIPTION}
        [Parameter(
            Position = 2,
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
        New-Variable -Scope Global -Name ("MSSessionStore{0}" -f $SessionName) -Value (New-Object PSCustomObject) -ErrorAction SilentlyContinue -ErrorVariable Error;
        if ($Error) {
            Write-Host ("Script: {0}`r`nCommand: {1}`r`nError: " -f $MyInvocation.ScriptName, $MyInvocation.MyCommand + $Error) -ForegroundColor Red;
            Get-PSCallStack | Format-List;
            break;
        }
        Set-MSConfigActiveSession -SessionName ($SessionName);
        if ($UseDefaults) {
            Get-Configuration;
            $Uri = Get-MSSessionProperty -Name ("Uri");
        }
        [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true};
        Set-MSSessionProperty -Name ("Proxy") -Value (New-WebServiceProxy -Uri ($Uri) -Namespace ($SessionName));
        Set-MSSessionProperty -Name ("ErrorA") -Value ([ref](Get-MSSessionProperty -Name ("Proxy")).Value);
        Set-MSSessionProperty -Name ("ResultA") -Value ([ref](Get-MSSessionProperty -Name ("Proxy")).Value);
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}