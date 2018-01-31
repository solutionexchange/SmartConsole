Function Get-MSContentClassTemplates {
    <#
    .SYNOPSIS
        Listing the Templates of a Content Class
    .DESCRIPTION
        You can list all the templates of a content class, along with their names and GUIDs. With the attribute withstylesheets, it is possible to list the stylesheets that have been assigned to the content class.
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: Listing the Templates of a Content Class, Software version >= 4.0.0.8
        History:
         6.1        To facilitate content class versioning, the following attributes have been added to the TEMPLATEVARIANTS element: draft, lock, lockdate, lockuserguid, lockusermail, lockusername, and waitforrelease The following attributes have been added to the TEMPLATEVARIANT element: changeddate, changeduserguid, changedusername, createdate, createuserguid, createusername, draft, and waitforrelease.
         5.6        To be able to differentiate between a template and a stylesheet, the attribute isstylessheet has been added to the TEMPLATEVARIANTS element in the server response.
         5.0        Attribute folderguid has been added to the TEMPLATEVARIANTS element in the server response. Attribute description has been added to - and attribute donotgenerate removed from - the TEMPLATEVARIANT element.
    #>
    [Alias('Get-CMSContentClassTemplates')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
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
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]'><PROJECT><TEMPLATE guid='[!guid_template!]'><TEMPLATEVARIANTS action='list' withstylesheets='1' /></TEMPLATE></PROJECT></IODATA>").Replace("[!guid_template!]", ($ContentClassGUID|ConvertTo-RQLGuid));
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        Show-MSSessionWebServiceDebug;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}