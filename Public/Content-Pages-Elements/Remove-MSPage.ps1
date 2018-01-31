Function Remove-MSPage {
    <#
    .SYNOPSIS
        Deleting Pages
    .DESCRIPTION
        You can delete a page from the project structure.*
        Warning: The page will be irrevocably deleted from all language variants if the page has not been published, yet. If the page has already been published for at least one time then the page will be send to the 'Recycle Bin' instead. See Emptying Recycle Bin for detailed information on how to empty the 'Recycle Bin'.
        The page is also being removed ("disconnected") from all links pointing to the page.
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        * Server Response for the Following Error:   Incorrect page GUID
        ok is also returned if an error occurs. No error message is sent. 
        Potential errors:
        Management Server can return an error message when you delete a page. The following Error Messages are known:
            #RDError2910    References still point to elements of this page.
            #RDError2911    At least one element is still assigned as target container to a link.
            #RDError15805   You have no right to delete this page.
        RQL: Deleting Pages, Software version >= 4.0.0.8
        History:
        16.0        Language variants have to be specifiy as nodes and no longer as attribute.
        11.0.0      The page is being moved to the Recycle Bin instead of being deleted. Also the page is automatically unlinked.
        4.1.5       The page is deleted in all language variants.
    #>
    [Alias('Remove-CMSPage')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        [string] $PageGUID,
        # {DESCRIPTION}
        [Parameter(
            Position = 1,
            Mandatory = $false,
            ParameterSetName = 'byMSSession'
        )]
        [bool] $ForceDelete2910 = $false,
        # {DESCRIPTION}
        [Parameter(
            Position = 2,
            Mandatory = $false,
            ParameterSetName = 'byMSSession'
        )]
        [bool] $ForceDelete2911 = $false
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
        if ($ForceDelete2910) {
            $ForceDelete2910Replace = ("1");
        }
        else {
            $ForceDelete2910Replace = ("0");
        }
        if ($ForceDelete2911) {
            $ForceDelete2911Replace = ("1");
        }
        else {
            $ForceDelete2911Replace = ("0");
        }
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]'><PAGE action='delete' forcedelete2910='[!forcedelete_2910!]' forcedelete2911='[!forcedelete_2911!]' guid='[!guid_page!]'/></IODATA>").Replace("[!guid_page!]", ($PageGUID|ConvertTo-RQLGuid)).Replace("[!forcedelete_2910!]", $ForceDelete2910Replace).Replace("[!forcedelete_2911!]", $ForceDelete2911Replace);
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        Show-MSSessionWebServiceDebug;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}