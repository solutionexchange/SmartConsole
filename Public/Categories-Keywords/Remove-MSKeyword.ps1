Function Remove-MSKeyword {
    <#
    .SYNOPSIS
        Deleting Keywords
    .DESCRIPTION
        Use this RQL query to delete an existing keyword. All of the assignments made for this keyword, to pages and structural elements, will be deleted as well.
        If there are no assignments to pages or structural elements in a project, the keyword you select will be deleted immediately. In software version 4.5, however, the keyword will not be deleted if keyword assignments exist. Beginning with software version 5.0, even these assignments can be deleted when you delete a keyword.
        Warning: If a keyword is deleted so too will all of its assignments to pages and elements. This can have an enormous impact on the project. Once the deletion process has finished, you still need to clear the page cache.
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: Deleting Keywords, Software version >= 4.5
        History:
         5.0        With the aid of the attribute force and password, it is possible to delete even keywords that are still assigned to pages or structural elements.
    #>
    [Alias('Remove-CMSKeyword')]
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
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]' dialoglanguageid='[!dialog_language_id!]'><PROJECT><KEYWORD action='delete' guid='[!guid_keyword!]' force='[!value_force!]' password='[!value_password!]' /></PROJECT></IODATA>").Replace("[!guid_keyword!]", ($KeywordGUID|ConvertTo-RQLGuid));
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
        return $Response;
        Show-MSSessionWebServiceDebug;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}