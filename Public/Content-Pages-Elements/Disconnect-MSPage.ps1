Function Disconnect-MSPage {
    <#
    .SYNOPSIS
        Disconnecting Pages
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
    [Alias('Disconnect-CMSPage')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        [string] $PageGUID,
        # {DESCRIPTION}
        [Parameter(
            Position = 1,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        [string] $LinkGUID
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]' dialoglanguageid='[!dialog_language_id!]'><LINK action='save' guid='[!guid_link!]'><PAGES><PAGE deleted='1' guid='[!guid_page!]' /></PAGES></LINK></IODATA>").Replace("[!guid_page!]", $PageGUID).Replace("[!guid_link!]", $LinkGUID);
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        Show-MSSessionWebServiceDebug;
        return $Response;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}