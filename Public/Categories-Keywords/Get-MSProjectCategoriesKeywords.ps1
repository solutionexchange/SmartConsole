Function Get-MSProjectCategoriesKeywords {
    <#
    .SYNOPSIS
        Get Project Categories And Keywords
    .DESCRIPTION
        Gets the categories and keywords of the active project.*
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        * Each category is also a keyword. In this case the value is empty.
        RQL: Get Project Categories And Keywords, Software version >= 11.2 SP1
    #>
    [Alias('Get-CMSProjectCategoriesKeywords')]
    [CmdletBinding()]
    param()
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]' dialoglanguageid='[!dialog_language_id!]'><PROJECT><CATEGORIES action='get'/></PROJECT></IODATA>");
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        return $Response;
        Show-MSSessionWebServiceDebug;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}