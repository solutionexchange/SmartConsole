Function Set-MSKeywordAssignment {
    <#
    .SYNOPSIS
        Assign Keywords to Pages or Links, and remove Keywords from Pages or Links
    .DESCRIPTION
        Use this RQL to add keywords to a page or link, or to remove it from a page or link.
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: Assign Keywords to Pages or Links, and remove Keywords from Pages or Links, Software version >= 4.5
    #>
    [Alias('Set-CMSKeywordAssignment')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $false,
            ParameterSetName = 'byMSSession'
        )]
        [string] $PageGUID,
        # {DESCRIPTION}
        [Parameter(
            Position = 1,
            Mandatory = $false,
            ParameterSetName = 'byMSSession'
        )]
        [string] $LinkGUID,
        # {DESCRIPTION}
        [Parameter(
            Position = 2,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        [string] $KeywordGUID,
        # {DESCRIPTION}
        [Parameter(
            Position = 3,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        [ValidateSet('Assign', 'Remove')]
        [string] $Action,
        # {DESCRIPTION}
        [Parameter(
            Position = 4,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        [bool] $AllKeywords = $false
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_Login!]' sessionkey='[!key!]'><PROJECT sessionkey='[!key!]'><REQUESTBODY/></PROJECT></IODATA>");
        $RequestBody = ("");
        if ($Action) {
            if ($PageGUID) {
                $RequestBody = $RequestBody + ("<PAGE guid='[!guid!]' action='assign'><KEYWORDS>").Replace("[!guid!]", ($PageGUID|ConvertTo-RQLGuid)); ;
                foreach ($GUID in $KeywordGUID) {
                    $RequestBody = $RequestBody + ("<KEYWORD guid='[!guid_keyword!]' changed='1' delete='0'/>").Replace("[!guid_keyword!]", ($GUID|ConvertTo-RQLGuid));
                }
                $RequestBody = $RequestBody + ("</KEYWORDS></PAGE>");
            }
            elseif ($LinkGUID) {
                $RequestBody = $RequestBody + ("<LINK guid='[!guid!]' action='assign' allkeywords='0'><KEYWORDS>").Replace("[!guid!]", ($LinkGUID|ConvertTo-RQLGuid));
                foreach ($GUID in $KeywordGUID) {
                    $RequestBody = $RequestBody + ("<KEYWORD guid='[!guid_keyword!]' changed='1' delete='0'/>").Replace("[!guid_keyword!]", ($GUID|ConvertTo-RQLGuid));
                }
                $RequestBody = $RequestBody + ("</KEYWORDS></LINK>");
                if ($AllKeywords -eq $true) {
                    $RequestBody = $RequestBody.Replace(" allkeywords='0'", " allkeywords='1'");
                }
            }
            if ($Action -eq "Remove") {
                $RequestBody = $RequestBody.Replace(" delete='0'", " delete='1'");
            }
            else {
                $RequestBody = $RequestBody.Replace(" delete='0'", "");
            }
            $Request = $Request.Replace("<REQUESTBODY/>", $RequestBody);
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