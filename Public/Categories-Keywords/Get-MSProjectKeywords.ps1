Function Get-MSProjectKeywords {
    <#
    .SYNOPSIS
        Listing the Keywords of a Project
    .DESCRIPTION
        With this RQL query you can list all the keywords belonging to a particular project.
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: Listing the Keywords of a Project, Software version >= 4.5
    #>
    [Alias('Get-CMSProjectKeywords')]
    [CmdletBinding()]
    param()
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]' dialoglanguageid='[!dialog_language_id!]'><PROJECT><CATEGORY><KEYWORDS action='list'/></CATEGORY></PROJECT></IODATA>");
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        return $Response;
        Show-MSSessionWebServiceDebug;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}