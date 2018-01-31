Function Invoke-MSRQLRequest {
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
    [Alias('Invoke-CMSRQLRequest')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        $Request
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        $ActiveMSSession = Get-MSConfigActiveSession;
        $Response = (Get-MSSessionProperty -Name ("Proxy")).Execute($Request, (Get-MSSessionProperty -Name ("ErrorA")), (Get-MSSessionProperty -Name ("ResultA")));
        Set-MSSessionProperty -Name ("LastRequest") -Value ($Request);
        Set-MSSessionProperty -Name ("LastResponse") -Value ($Response);
        if ((Get-Variable -Scope Global -Name ("MSSessionStore{0}" -f $ActiveMSSession) -ValueOnly).ErrorA.Value) {
            Write-Host ("ErrorA : {0}`r`n" -f (Get-Variable -Scope Global -Name ("MSSessionStore{0}" -f $ActiveMSSession) -ValueOnly).ErrorA.Value) -ForegroundColor Red | Format-List;
            Write-Host ("Script: {0}`r`nCommand: {1}" -f $MyInvocation.ScriptName, $MyInvocation.MyCommand) -ForegroundColor Red;
            Get-PSCallStack | Format-List;
            break;
        }
        return $Response;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}