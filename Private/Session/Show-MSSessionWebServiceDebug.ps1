Function Show-MSSessionWebServiceDebug {
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
    [Alias('Show-CMSSessionWebServiceDebug')]
    [CmdletBinding()]
    param()
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        if (Get-MSConfigDebugMode) {
            $ActiveMSSession = Get-MSConfigActiveSession;
            Write-Host ("<<--[Global MS Session Debug]-----------`r`n") -ForegroundColor Green;
            Write-Host ("MSSession : {0}`r`n" -f $ActiveMSSession) -ForegroundColor Green | Format-List;
            Write-Host ("LastRequest :");
            Get-MSSessionProperty -Name ("LastRequest") | Format-RQL;
            Write-Host ("`r`nLastResponse :");
            Get-MSSessionProperty -Name ("LastResponse") | Format-RQL;
            Write-Host ("`r`n--------------------------------------->>`r`n`r`n") -ForegroundColor Green;
        }
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}