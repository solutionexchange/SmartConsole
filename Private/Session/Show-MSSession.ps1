Function Show-MSSession {
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
    [Alias('Show-CMSSession')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
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
        $ActiveMSSession = Get-MSConfigActiveSession;
        Write-Host ("<<--[Global MS Session Store]-----------`r`n") -ForegroundColor Green;
        Write-Host ("MSSession : {0}" -f $ActiveMSSession) -NoNewline -ForegroundColor Green | Format-List;
        if ((Get-Variable -Scope Global -Name ("MSSessionStore{0}" -f $ActiveMSSession) -ValueOnly).PSObject.Properties.Count -gt 0) {
            (Get-Variable -Scope Global -Name ("MSSessionStore{0}" -f $ActiveMSSession) -ValueOnly) | Select-Object * -ExcludeProperty ("Proxy", "ErrorA", "ResultA", "Password") | Format-List;
            if ((Get-Variable -Scope Global -Name ("MSSessionStore{0}" -f $ActiveMSSession) -ValueOnly).ErrorA.Value) {
                Write-Host ("ErrorA : {0}`r`n" -f (Get-Variable -Scope Global -Name ("MSSessionStore{0}" -f $ActiveMSSession) -ValueOnly).ErrorA.Value) -ForegroundColor Red | Format-List;
                break;
            }
            if ((Get-Variable -Scope Global -Name ("MSSessionStore{0}" -f $ActiveMSSession) -ValueOnly).ResultA.Value) {
                Write-Host ("ResultA : {0}`r`n" -f (Get-Variable -Scope Global -Name ("MSSessionStore{0}" -f $ActiveMSSession) -ValueOnly).ResultA.Value) -ForegroundColor Yellow | Format-List;
            }
        }
        Write-Host ("--------------------------------------->>`r`n`r`n") -ForegroundColor Green;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}