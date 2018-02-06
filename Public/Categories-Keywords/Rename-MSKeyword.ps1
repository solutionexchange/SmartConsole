Function Rename-MSKeyword {
    <#
    .SYNOPSIS
        Renaming Keywords
    .DESCRIPTION
        With this RQL query you can change the names of keywords. It also allows you to change varying keywords in different categories simultaneously.
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: Renaming Keywords, Software version >= 4.5
    #>
    [Alias('Rename-CMSKeyword')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        [string] $KeywordGUID,
        # {DESCRIPTION}
        [Parameter(
            Position = 1,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        [string] $KeywordName
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]'><PROJECT><CATEGORY><KEYWORD action='save' guid='[!guid_keyword!]' value='[!value!]'/></CATEGORY></PROJECT></IODATA>").Replace("[!guid_keyword!]", ($KeywordGUID|ConvertTo-RQLGuid)).Replace("[!value!]", $KeywordName);
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        return $Response;
        Show-MSSessionWebServiceDebug;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}