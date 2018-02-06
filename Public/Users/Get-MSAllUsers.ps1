Function Get-MSAllUsers {
    <#
    .SYNOPSIS
        Listing All Users
    .DESCRIPTION
        You can list all the users of the Management Server alphabetically, independent of their roles, project or group. The user executing the RQL needs to have the module Server Module.
    .EXAMPLE
        ... {EXAMPLE#1} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: Listing All Users, Software version >= 4.0.0.8
        History:
         6.0        Attribute loginguid has been removed from the server response.
    #>
    [Alias('Get-CMSAllUsers')]
    [CmdletBinding()]
    param()
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]'><ADMINISTRATION><USERS action='list'/></ADMINISTRATION></IODATA>");
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        return $Response;
        Show-MSSessionWebServiceDebug;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}