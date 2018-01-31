Function Write-CHost {
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
    [CmdletBinding(DefaultParameterSetName = 'byMessage')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $false,
            ParameterSetName = 'byMessage'
        )]
        [string] $Message = ''
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        [string]$PipedMessage = @($Input);
        if (!$Message) {  
            if ($PipedMessage) {
                $Message = $PipedMessage;
            }
        }
        if ($Message) {
            $Colors = @("black", "blue", "cyan", "darkblue", "darkcyan", "darkgray", "darkgreen", "darkmagenta", "darkred", "darkyellow", "gray", "green", "magenta", "red", "white", "yellow");
            $DefaultForegroundColor = "gray";
            $CurrentColor = $DefaultForegroundColor;
            $MessageFragments = $Message.Split("#");
            foreach ($Color in $MessageFragments) {
                if ($Colors -contains $Color.ToLower() -and $CurrentColor -eq $DefaultForegroundColor) {
                    $CurrentColor = $Color;
                }
                else {
                    Write-Host -NoNewline -ForegroundColor $CurrentColor $Color;
                    $CurrentColor = $DefaultForegroundColor
                }
            }
            Write-Host
        }
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}