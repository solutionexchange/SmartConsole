Function Get-MSPublicationTargetData {
    <#
    .SYNOPSIS
        Listing Publication Packages
    .DESCRIPTION
        You can list all existing publication packages in a project with name and GUID.
    .NOTES
        RQL: Listing Publication Packages, Software version >= 5.0
    #>
    [Alias('Get-CMSPublicationTargetData')]
    [CmdletBinding()]
    param(
        [Parameter(
                Position = 0,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string] $PublicationTargetGUID
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]'><PROJECT sessionkey='[!key!]'><EXPORT guid='[!guid_export!]' action='load'/></PROJECT></IODATA>").Replace("[!guid_export!]", ($PublicationTargetGUID|ConvertTo-RQLGuid));
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        Show-MSSessionWebServiceDebug;
        return $Response;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}
