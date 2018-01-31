Function Remove-MSCategory {
    <#
    .SYNOPSIS
        Deleting Categories
    .DESCRIPTION
        Use this RQL query to delete a existing categories. All of the keywords assigned to a category will be deleted as well. So too all of the keyword assignments made for pages and structural elements.
        If the keywords belonging to this category have not been assigned to any pages or structural elements in the project, the category and all of its keywords will be deleted immediately. If, however, assignments have been made, the category cannot be deleted in software version 4.5. Beginning with software version 5.0, even these assignments can be deleted when you delete a category.
        Warnging: If you delete categories, you also delete all of their keywords and all of the corresponding keyword links to pages and structural elements. This can have an enormous impact on the project. Once the deletion process has finished, you still need to clear the page cache.
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: Deleting Categories, Software version >= 4.5
        History
         5.0        With the aid of the attribute force and password, it is possible to delete even those categories which have keywords still assigned to pages or structural elements.
    #>
    [Alias('Remove-CMSCategory')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        [string] $CategoryGUID,
        # {DESCRIPTION}
        [Parameter(
            Position = 1,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        [bool] $Force,
        # {DESCRIPTION}
        [Parameter(
            Position = 2,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        [string] $Password
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]'><PROJECT><CATEGORY action='delete' guid='[!guid_category!]' force='[!value_force!]' password='[!value_password!]' /></PROJECT></IODATA>").Replace("[!guid_category!]", ($CategoryGUID|ConvertTo-RQLGuid));
        if ($Force) {
            $Request = $Request.Replace("[!value_force!]", "1");
        }
        else {
            $Request = $Request.Replace(" force='[!value_force!]'", "");
        }
        if ($Password) {
            $Request = $Request.Replace("[!value_password!]", $Password);
        }
        else {
            $Request = $Request.Replace(" password='[!value_password!]'", "");
        }
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        Show-MSSessionWebServiceDebug;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}