Function Get-MSKeywordData {
    <#
    .SYNOPSIS
        Determining Keyword Data
    .DESCRIPTION
        With this RQL query you can display all information belonging to a specific keyword.
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: Determining Keyword Data, Software version >= 4.5
        History:
         5.0        The server answer returns the category GUID of a specific keyword.
    #>
    [Alias('Get-CMSKeywordData')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        [string] $KeywordGUID
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        Set-MSSessionProperty -Name ("KeywordGUID") -Value ($KeywordGUID);
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]' dialoglanguageid='[!dialog_language_id!]'><PROJECT><CATEGORY><KEYWORD action='load' guid='[!guid_keyword!]'/></CATEGORY></PROJECT></IODATA>").Replace("[!guid_keyword!]", ($KeywordGUID|ConvertTo-RQLGuid));
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        return $Response;
        Show-MSSessionWebServiceDebug;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}