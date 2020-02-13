function Remove-MSPageCache
{
    <#
    .SYNOPSIS
         List all pages
    .DESCRIPTION
         Use this CMDlet to list all pages of a project for the language variant used by the user executing the query.
    #>
    [Alias('Remove-CMSPageCache')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        [Parameter(
                Position = 0,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string[]] $PageGuids
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;

        $Request = (
            "<IODATA sessionkey='[!key!]' loginguid='[!guid_login!]'>
                <PAGEBUILDER languagevariantid='ENU'>
                    <PAGES action='pagevaluesetdirty'>
                    {0}
                </PAGES>
              </PAGEBUILDER>
            </IODATA>" -f ([System.String]::Concat(($PageGuids | ForEach-Object -Process {[System.String]::Format("<PAGE guid='{0}'/>", $_)})))
        );
        
        $Request = Import-MSSessionProperties -Request ($Request);
        Invoke-MSRQLRequest -Request ($Request);

        Show-MSSessionWebServiceDebug;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}
