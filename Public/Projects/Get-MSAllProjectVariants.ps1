Function Get-MSAllProjectVariants {
    <#
    .SYNOPSIS
        Listing Project Variants
    .DESCRIPTION
        You can list all existing project variants with name and GUID. Via the checked attribute in the response, you can see which project variant has been defined as the display format.
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: Listing Project Variants, Software version >= 4.0.0.8
        History:
         6.1        The userdisplayvariant attribute has been added to the PROJECTVARIANTS element in the server response in order to display the user-defined display format.
         4.1.5      The following attributes have been removed from the PROJECTVARIANTS element in the server response: nothingchecked and forpreviewguid.
    #>
    [Alias('Get-CMSAllProjectVariants')]
    [CmdletBinding()]
    param()
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]' dialoglanguageid='[!dialog_language_id!]'><PROJECT><PROJECTVARIANTS action='list' /></PROJECT></IODATA>");
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        return $Response;
        Show-MSSessionWebServiceDebug;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}