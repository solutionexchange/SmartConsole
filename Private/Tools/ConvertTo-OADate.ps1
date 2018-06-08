Function ConvertTo-OADate {
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
    [CmdletBinding(DefaultParameterSetName = 'byOLEAutomationDate')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ParameterSetName = 'byOLEAutomationDate',
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true
        )]
        [datetime] $Date
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        return $Date.ToOADate();
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}