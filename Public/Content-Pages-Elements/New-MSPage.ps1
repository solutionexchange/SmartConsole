Function New-MSPage {
    <#
    .SYNOPSIS
        Creating Pages
    .DESCRIPTION
        With this RQL you can create one or multiple pages based on a content class. If you want to create multiple pages, you can change the content class for any further page.
        The content class contains only one text element. Therefore, the example response of the server is short. If you are using more elements in a content class, the server response changes for the elements ELEMENTS and ELEMENT.
        In this query example the page is not assigned a structural element. Therefore, you can find the created page in SmartTree under Editing Special Pages / Unlinked Pages.
        If you create more than one page, the result in the server response for each page is logged in an extra IODATA element.
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: Creating Pages, Software version >= 4.0.0.8
        History:
        16.0        The attribute eltdragdrop is not used any more and has been removed from the server response.
         7.0        In the query you no longer have to specify a headline for a new page.
         5.0        The following attributes are no longer supported in the LINK element for the server query: reddotcacheguid, insertpos and value. In addition, attribute reddotcacheguid has been removed from the PAGE element.
         5.0        Attributes manuallysorted and changed are no longer used in the LINK element in the server response.
         5.0        The following attributes have been added: status, oldlinkedpageguid and userguid in the LINK element and emailreceiver, userguid, targetlinkguid and linkednew to the PAGE element.
         4.1.5      In the server response the elements ELEMENTS and ELEMENT have been added. In the PAGE element the attributes tmpeditlinkguid, dialoglanguageid and mainlinkguid have been added. Attribute editlinkguid has been removed.
    #>
    [Alias('New-CMSPage')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        [string] $HeadlinePage,
        # {DESCRIPTION}
        [Parameter(
            Position = 1,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        [string] $ContentClassGUID
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]'><PAGE action='addnew' templateguid='[!guid_template!]' headline='[!headline_page!]'/></IODATA>").Replace("[!guid_template!]", ($ContentClassGUID|ConvertTo-RQLGuid)).Replace("[!headline_page!]", $HeadlinePage);
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        return $Response;
        Show-MSSessionWebServiceDebug;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}