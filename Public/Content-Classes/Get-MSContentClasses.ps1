Function Get-MSContentClasses {
    <#
    .SYNOPSIS
        Listing Content Classes
    .DESCRIPTION
        This RQL query allows you to list all Content Classes of a Project. You can limit the output to the Content Classes of one folder.
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: Listing Content Classes, Software version >= 4.5
        History:
        16.0 SP2    The following attributes have been added to the server response: 'ismasterpage' and 'navigationlist'.
    #>
    [Alias('Get-CMSContentClasses')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $false,
            ParameterSetName = 'byMSSession'
        )]
        [string] $ContentClassFolderGUID
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]' dialoglanguageid='[!dialog_language_id!]'><TEMPLATES folderguid='[!guid_folder!]' action='list'/></IODATA>");
        if ($ContentClassFolderGUID) {
            $Request = $Request.Replace("[!guid_folder!]", ($ContentClassFolderGUID|ConvertTo-RQLGuid));
        }
        else {
            $Request = $Request.Replace(" folderguid='[!guid_folder!]'", "");
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