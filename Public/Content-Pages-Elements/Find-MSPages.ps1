Function Find-MSPages {
    <#
    .SYNOPSIS
         Find pages
    .DESCRIPTION
         Use this CMDlet to find all pages for specific criteria
    #>
    [Alias('Find-CMSPages')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        [Parameter(
                Position = 0,
                Mandatory = $false,
                ParameterSetName = 'byMSSession'
        )]
        [array] $CategorySearchConfiguration = $null
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;

        $CategorySearchConfigurationString = ""

        if ($null -ne $CategorySearchConfiguration)
        {
            foreach ($Configuration in $CategorySearchConfiguration)
            {
                $CategorySearchConfigurationString = ("<SEARCHITEM key='keyword' value='{0}' operator='{1}' />" -f $Configuration.CategoryGuid, $Configuration.Operator)
            }
        }

        $Request = (
        "<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]'>
                <PAGE action='xsearch'>
                    <SEARCHITEMS>
                        {0}
                    </SEARCHITEMS>
                </PAGE>
            </IODATA>"
        ) -f $CategorySearchConfigurationString;

        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);

        $Result = $Response.SelectNodes("IODATA/PAGES/PAGE");

        Show-MSSessionWebServiceDebug;
        return $Result
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}
