Function Get-MSContentClassProjectVariants {
    <#
    .SYNOPSIS
        Listing Template Project Variants
    .DESCRIPTION
        You can list the GUIDs of all the project variants that are assigned to the templates of a specific content class.
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: Listing Template Project Variants, Software version >= 4.0.0.8
        History:
         6.1        To facilitate content class versioning, the attribute draft has been added to the TEMPLATEVARIANT element.
         5.0        The attribute folderguid has been added to the TEMPLATEVARIANTS element in the server response.
    #>
    [Alias('Get-CMSContentClassProjectVariants')]
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
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]'><PROJECT><TEMPLATE guid='[!guid_template!]'><TEMPLATEVARIANTS action='projectvariantslist' /></TEMPLATE></PROJECT></IODATA>").Replace("[!guid_template!]", ($ContentClassGUID|ConvertTo-RQLGuid));
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        Show-MSSessionWebServiceDebug;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}