Function New-MSKeywords {
    <#
    .SYNOPSIS
        Creating Keywords
    .DESCRIPTION
        Use this RQL query to add new keywords to existing categories. You can also create multiple keywords in multiple categories.
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: Creating Keywords, Software version >= 4.5
    #>
    [Alias('New-CMSKeywords')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        [String] $CategoryGUID,
        # {DESCRIPTION}
        [Parameter(
            Position = 1,
            Mandatory = $false,
            ParameterSetName = 'byMSSession'
        )]
        $Keywords,
        # {DESCRIPTION}
        [Parameter(
            Position = 2,
            Mandatory = $false,
            ParameterSetName = 'byMSSession'
        )]
        $Array
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]' dialoglanguageid='[!dialog_language_id!]'><PROJECT><REQUESTBODY/></PROJECT></IODATA>");
        if ($CategoryGUID) {
            $RequestBody = ("<CATEGORY guid='[!guid_category!]'>").Replace("[!guid_category!]", ($CategoryGUID|ConvertTo-RQLGuid));
            foreach ($Keyword in $Keywords) {
                $RequestBody = $RequestBody + ("<KEYWORD action='addnew' value='$Keyword'/>");
            }
            $RequestBody = $RequestBody + ("</CATEGORY>");
        }
        elseif ($Array) {
            foreach ($CategoryGUID in $Array.Keys) {
                $RequestBody = $RequestBody + ("<CATEGORY guid='[!guid_category!]'>").Replace("[!guid_category!]", ($CategoryGUID|ConvertTo-RQLGuid));
                foreach ($Keyword in $Array[$CategoryGUID]) {
                    $RequestBody = $RequestBody + ("<KEYWORD action='addnew' value='$Keyword'/>");
                }
                $RequestBody = $RequestBody + ("</CATEGORY>");
            }
        }
        $Request = $Request.Replace("<REQUESTBODY/>", $RequestBody);
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        return $Response;
        Show-MSSessionWebServiceDebug;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}