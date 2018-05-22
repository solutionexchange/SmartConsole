Function Get-MSPublicationPackageReferenceList {
    <#
    .SYNOPSIS
        Displaying the Publication Package Reference List
    .DESCRIPTION
        A publication package can be connected with several link elements (content classes and page elements) in the active language variant. You can use this RQL query to determine which elements are connected to a publication package via the reference list.
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: Displaying the Publication Package Reference List, Software version >= 5.0 
    #>
    [Alias('Get-CMSPublicationPackageReferenceList')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        [string] $PackageGUID
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]' dialoglanguageid='[!dialog_language_id!]'><PROJECT><EXPORTPACKET guid='[!guid_exportpacket!]'><REFERENCES action='list' maxrecords='10' /></EXPORTPACKET></PROJECT></IODATA>").Replace("[!guid_exportpacket!]", ($PackageGUID|ConvertTo-RQLGuid));
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        Show-MSSessionWebServiceDebug;
        return $Response;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}