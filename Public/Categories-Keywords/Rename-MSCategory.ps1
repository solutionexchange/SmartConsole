Function Rename-MSCategory {
    <#
    .SYNOPSIS
        Renaming a Category
    .DESCRIPTION
        With this RQL query you can change the name of a category.
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: Renaming a Category, Software version >= 4.5
    #>
    [Alias('Rename-CMSCategory')]
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
        [string] $CategoryName
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]' dialoglanguageid='[!dialog_language_id!]'><PROJECT><CATEGORY action='save' guid='[!guid_category!]' value='[!value!]'/></PROJECT></IODATA>").Replace("[!guid_category!]", ($CategoryGUID|ConvertTo-RQLGuid)).Replace("[!value!]", $CategoryName);
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        return $Response;
        Show-MSSessionWebServiceDebug;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}