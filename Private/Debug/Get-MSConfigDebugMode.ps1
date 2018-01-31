Function Get-MSConfigDebugMode {
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
    [Alias('Get-CMSConfigDebugMode')]
    [CmdletBinding()]
    param()
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        $Value = (Get-Variable -Scope Global -Name ("MSConfigurationStore") -ValueOnly -ErrorAction SilentlyContinue -ErrorVariable Error).DebugMode;
        if ($Error) {
            Write-Debug -Message ("[ Error => function {0} ]" -f $MyInvocation.MyCommand);
            Write-Error ("Script: {0}`r`nCommand: {1}`r`nError: " -f $MyInvocation.ScriptName, $MyInvocation.MyCommand + $Error);
            Get-PSCallStack | Format-List;
            break;
        }
        return $Value;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}