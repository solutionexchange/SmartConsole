Function Set-MSPublishingTargetForPublicationCombination {
    <#
    .SYNOPSIS
        Defining Publishing Targets for Publication Combination
    .DESCRIPTION
        You can specify an existing publishing target for each publication combination. The published pages will be published to this target.
    #>
    [Alias('Set-CMSPublishingTargetForPublicationCombination')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        [Parameter(
                Position = 0,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string] $PublicationCombinationGuid,
        [Parameter(
                Position = 1,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string] $PublishingTargetGuid
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]'><PROJECT><EXPORTSETTING guid='[!guid_exportsetting!]'><EXPORTTARGETS action='save'><EXPORTTARGET guid='[!guid_exporttarget!]' selected='1' /></EXPORTTARGETS></EXPORTSETTING></PROJECT></IODATA>")
        $Request = $Request.Replace("[!guid_exportsetting!]", $PublicationCombinationGuid)
        $Request = $Request.Replace("[!guid_exporttarget!]", $PublishingTargetGuid)
        $Request = Import-MSSessionProperties -Request ($Request)
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        Show-MSSessionWebServiceDebug;
        return $Response;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}
