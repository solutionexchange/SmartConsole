Function ConvertTo-Boolean {
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
    [CmdletBinding(DefaultParameterSetName = 'byBoolean')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ParameterSetName = 'byBoolean',
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true
        )]
        [string] $Value
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        switch ($Value) {
            "y" { return $true; }
            "yes" { return $true; }
            "true" { return $true; }
            "t" { return $true; }
            1 { return $true; }
            "n" { return $false; }
            "no" { return $false; }
            "false" { return $false; }
            "f" { return $false; }
            0 { return $false; }
        }
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}