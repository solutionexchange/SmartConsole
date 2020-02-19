Function Get-MSPagePreview {
    <#
    .SYNOPSIS
         Retrieve a SmartEdit page preview.
    .DESCRIPTION
         Retrieve a SmartEdit page preview. The query returns the HTML source code for the preview (no IODATA element!).
    #>
    [Alias('Get-CMSPagePreview')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        [Parameter(
                Position = 0,
                Mandatory = $false,
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
        $Request = (
            "<IODATA loginguid='[!guid_login!]' sessionkey='[!guid_sessionkey!]'>
                <PREVIEW projectguid='[!guid_project!]' loginguid='[!guid_login!]'
                url='/CMS/ioRD.asp' querystring='Action=Preview&amp;Pageguid={0}' />
            </IODATA>"
        ) -f $PageGUID

        $Request = Import-MSSessionProperties -Request ($Request);
        [string] $Response = Invoke-MSRQLRequest -Request ($Request);

        Show-MSSessionWebServiceDebug;
        return $Response;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}
