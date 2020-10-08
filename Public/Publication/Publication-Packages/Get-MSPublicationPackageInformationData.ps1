Function Get-MSPublicationPackageInformationData {
    <#
    .SYNOPSIS
        Listing informational data of Publication Package
    .DESCRIPTION
        You can list all informational data from a publication package wit the given Guid
    #>
    [Alias('Get-CMSPublicationPackageInformationData')]
    [CmdletBinding()]
    param(
        [Parameter(
                Position = 0,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string] $PublicationPackageGUID
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]'><PROJECT><EXPORTPACKET action='loadpacket' guid='[!guid_exportpacket!]' /></PROJECT></IODATA>").Replace("[!guid_exportpacket!]", ($PublicationPackageGUID|ConvertTo-RQLGuid));
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        Show-MSSessionWebServiceDebug;
        return $Response;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}
