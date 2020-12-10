Function Get-MSPublishingTargets {
    <#
    .SYNOPSIS
        Listing publishing targets
    .DESCRIPTION
        You can list all existing publishing targets in a project with name, GUID, path and type
    .NOTES
        RQL: Listing publishing targets, Software version >= 5.0
    #>
    [Alias('Get-CMSPublishingTargets')]
    [CmdletBinding()]
    param()
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = "<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]'><PROJECT><EXPORTS action='list' /></PROJECT></IODATA>"
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        Show-MSSessionWebServiceDebug;
        return $Response;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}
