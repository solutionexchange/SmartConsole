Function Set-MSConfigActiveSession {
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
    [Alias('Set-CMSConfigActiveSession')]
    [CmdletBinding(DefaultParameterSetName = 'byMSConfigurationStore')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $false,
            ParameterSetName = 'byMSConfigurationStore'
        )]
        [string] $SessionName = 'Default'
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        if (Get-Variable -Scope Global -Name ("MSConfigurationStore") -ValueOnly -ErrorAction SilentlyContinue -ErrorVariable Error) {
            Add-Member -InputObject (Get-Variable -Scope Global -Name ("MSConfigurationStore") -ValueOnly) -MemberType NoteProperty -Name ("ActiveMSSession") -Value ($SessionName) -Force -ErrorAction SilentlyContinue -ErrorVariable Error;
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