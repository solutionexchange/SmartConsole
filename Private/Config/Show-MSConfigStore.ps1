Function Show-MSConfigStore {
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
    [Alias('Show-CMSConfigStore')]
    [CmdletBinding()]
    param()
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        if ((Get-Variable -Scope Global -Name ("MSConfigurationStore") -ValueOnly -ErrorAction SilentlyContinue -ErrorVariable Error).PSObject.Properties.Count -gt 0) {
            Write-Host ("<<--[Global MS Configuration Store]-----`r`n") -ForegroundColor Green;
            (Get-Variable -Scope Global -Name ("MSConfigurationStore") -ValueOnly) | Select-Object * | Format-List;
            Write-Host ("--------------------------------------->>`r`n`r`n") -ForegroundColor Green;
        }
        if ($Error) {
            Write-Debug -Message ("[ Error => function {0} ]" -f $MyInvocation.MyCommand);
            Write-Error ("Script: {0}`r`nCommand: {1}`r`nError: " -f $MyInvocation.ScriptName, $MyInvocation.MyCommand + $Error);
            Get-PSCallStack | Format-List;
            break;
        }
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}