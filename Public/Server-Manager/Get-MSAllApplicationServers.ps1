Function Get-MSAllApplicationServers {
    <#
    .SYNOPSIS
        Listing Application Servers
    .DESCRIPTION
        You can list the application servers together with their names and GUIDs (e. g. all servers in a cluster).
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: Listing Application Servers, Software version >= 4.0.0.8
        History:
         4.1.5      Attributes active and ip have been added to the server response.
    #>
    [Alias('Get-CMSAllApplicationServers')]
    [CmdletBinding()]
    param()
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]'><ADMINISTRATION><EDITORIALSERVERS action='list'/></ADMINISTRATION></IODATA>");
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        return $Response;
        Show-MSSessionWebServiceDebug;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}