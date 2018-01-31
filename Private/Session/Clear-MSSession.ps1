Function Clear-MSSession {
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
    [Alias('Clear-CMSSession')]
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
        [bool] $UseDefaults = $false
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Clear-Variable -Scope Global -Name ("MSSessionStore{0}" -f $SessionName) -ErrorAction SilentlyContinue -ErrorVariable Error;
        if ($Error) {
            Write-Host ("Script: {0}`r`nCommand: {1}`r`nError: " -f $MyInvocation.ScriptName, $MyInvocation.MyCommand + $Error) -ForegroundColor Red;
            Get-PSCallStack | Format-List;
            break;
        }
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}