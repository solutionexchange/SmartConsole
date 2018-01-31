Function Set-MSConfigDebugMode {
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
    [Alias('Set-CMSConfigDebugMode')]
    [CmdletBinding(DefaultParameterSetName = 'byMSConfigurationStore')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ParameterSetName = 'byMSConfigurationStore'
        )]
        [ValidateSet($true, $false)]
        [bool] $Value
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Add-Member -InputObject (Get-Variable -Scope Global -Name ("MSConfigurationStore") -ValueOnly -ErrorAction SilentlyContinue -ErrorVariable Error) -MemberType NoteProperty -Name ("DebugMode") -Value ($Value) -Force -ErrorAction SilentlyContinue -ErrorVariable Error;
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