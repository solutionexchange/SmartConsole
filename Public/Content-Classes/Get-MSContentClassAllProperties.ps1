Function Get-MSContentClassAllProperties {
    <#
    .SYNOPSIS
        Determining All Content Class Properties
    .DESCRIPTION
        You can display all the elements, data, and templates of a content class.
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: Determining All Content Class Properties, Software version >= 4.0.0.8
        History:
        16.0 SP2    The following attributes have been added to the server response: 'ismasterpage' and 'navigationlist'.
        11.2        Added Element "PREVIEWELEMENTSREFERENCE" and "ELEMENT". PAGENAMEPATTERN attribute has been added.
        11.2        Added <ELEMENTS authorization=""/> attribute.
         6.1        To facilitate content class versioning, the following attributes have been added to the TEMPLATEVARIANTS element in the server response: draft, lock, lockdate, lockuserguid, lockusermail, lockusername, and waitforrelease. The following attributes have been added to the TEMPLATEVARIANT element: changedate, changeduserguid, changedusername, createdate, createuserguid, createusername, draft, and waitforrelease.
         5.6        To be able to differentiate between a template and a stylesheet, the attribute isstylessheet has been added to the TEMPLATEVARIANTS element in the server response.
         5.5        The server response no longer uses the attribute webserverpreview in the element TEMPLATE. Instead, the TEMPLATE element of the server response now has the attribute sharedrights for global content classes.
         5.0        The following attributes have been added to the TEMPLATE element in the server response: templaterights, folderrelease, and ignoreglobalworkflow. The attribute folderguid has been added to the TEMPLATEVARIANTS element.
    #>
    [Alias('Get-CMSContentClassAllProperties')]
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
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]' dialoglanguageid='[!dialog_language_id!]'><PROJECT><TEMPLATE action='load' guid='[!guid_template!]'><ELEMENTS childnodesasattributes='1' action='load'/><TEMPLATEVARIANTS action='list'/></TEMPLATE></PROJECT></IODATA>").Replace("[!guid_template!]", ($ContentClassGUID|ConvertTo-RQLGuid));
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        Show-MSSessionWebServiceDebug;
        return $Response;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}