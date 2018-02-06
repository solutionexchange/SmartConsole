Function Find-MSSpecialPages {
    <#
    .SYNOPSIS
        (Extended) Page Search > Special Pages
    .DESCRIPTION
        You can use this RQL to search for pages based on various criteria and settings. 
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: (Extended) Page Search, Software version >= 7.5
        History:
        16.0 SP2        Added the SEARCHITEM of type element. Added the SEARCHITEM of type linkingschedule.
        11.0.0          Added description for searchguid attribute of the xsearch request in order to implement result paging.
    #>
    [Alias('Find-CMSSpecialPages')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        [ValidateSet('linked', 'unlinked', 'recyclebin', 'active', 'all')]
        [string] $PageType,
        # {DESCRIPTION}
        [Parameter(
            Position = 1,
            Mandatory = $false,
            ParameterSetName = 'byMSSession'
        )]
        [int] $ResultSize = 100
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_Login!]' sessionkey='[!key!]' dialoglanguageid='[!dialog_language_id!]'><PAGE action='xsearch' orderby='changedate' pagesize='[!resultsize!]'><SEARCHITEMS><SEARCHITEM key='specialpages' value='[!pagetype!]' operator='eq' displayvalue=''/></SEARCHITEMS></PAGE></IODATA>").Replace("[!pagetype!]", $PageType).Replace("[!resultsize!]", $ResultSize);
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        return $Response;
        Show-MSSessionWebServiceDebug;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}