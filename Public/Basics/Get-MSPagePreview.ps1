Function Get-MSPagePreview {
    <#
    .SYNOPSIS
        Retrieving a SmartEdit Page Preview
    .DESCRIPTION
        You can retrieve a SmartEdit page preview. The query returns the HTML source code for the preview (no IODATA element!).
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: Retrieving a SmartEdit Page Preview, Software version >= 10.1
    #>
    [Alias('Get-CMSPagePreview')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        [string] $PageGUID
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        Set-MSSessionProperty -Name ("PageGUID") -Value ($PageGUID);
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]'><PREVIEW projectguid='[!guid_project!]' loginguid='[!guid_login!]' url='/CMS/ioRD.asp' querystring='Action=Preview&amp;Pageguid=[!guid_page!]' /></IODATA>").Replace("[!guid_page!]", ($PageGUID|ConvertTo-RQLGuid));
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        Show-MSSessionWebServiceDebug;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}