Function Get-MSPageInformationExtended {
    <#
    .SYNOPSIS
         Display additional data for a page
    .DESCRIPTION
         Display additional data for a page. Currently onl supports keywords as additional information
    #>
    [Alias('Get-CMSPageInformationExtended')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        [Parameter(
                Position = 0,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string] $PageGUID,
        [Parameter(
                Position = 1,
                Mandatory = $false,
                ParameterSetName = 'byMSSession'
        )]
        [Boolean] $Keywords = 0
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = (
            "<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]'>
                <PAGE action='load' guid='[!guid_page!]' option='extendedinfo'
                contentbased='0' keywords='{0}' recursive='0' cacheimageelements='0' />
            </IODATA>" -f (@{$true=1;$false=0}[$Keywords -eq $true])
        ).Replace("[!guid_page!]", ($PageGUID|ConvertTo-RQLGuid));

        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);

        Show-MSSessionWebServiceDebug;
        return $Response;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}
