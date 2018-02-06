Function Get-MSAllLoggedOnUsers {
    <#
    .SYNOPSIS
        Listing Logged On Users
    .DESCRIPTION
        You can list all the users that are currently connected with the server (i.e. logged on). Listings for instances of a certain user are also possible.
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: Listing Logged On Users, Software version >= 4.0.2.5
        History:
        16.0        The attributes 'name' and 'serverguid' have been added to the response of the RQL.
        10.0        The attributes 'repositoryguid' and 'repositoryname' of element USER are no longer supported.
         6.5        The request can be extended by the attribute userguid in order to show the current instances of a user. The server response now includes the following attributes: intern, lastactiondate, moduleguid, moduleid, moduledescription, projectguid, projectlevel, projectname, repositoryguid and repositoryname.
    #>
    [Alias('Get-CMSAllLoggedOnUsers')]
    [CmdletBinding()]
    param()
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]' dialoglanguageid='[!dialog_language_id!]'><ADMINISTRATION><USERS action='connectlist'/></ADMINISTRATION></IODATA>");
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        return $Response;
        Show-MSSessionWebServiceDebug;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}