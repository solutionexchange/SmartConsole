Function Get-MSPages {
    <#
    .SYNOPSIS
         List all pages
    .DESCRIPTION
         Use this CMDlet to list all pages of a project for the language variant used by the user executing the query.
    #>
    [Alias('Get-CMSPages')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        [Parameter(
                Position = 0,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string[]] $Tags
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = (
            "<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]'>
                <PROJECT>
                    <PAGES action='list'/>
                </PROJECT>
            </IODATA>"
        );
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);

        $Pages = $Response.SelectNodes("IODATA/PAGES/PAGE")

        if ($null -ne $Tags)
        {
            for ([int]$i = 0; $i -lt $Pages.Count; $i++)
            {
                $PageTagSupport = $false

                $ExtendedPageInformation = Get-MSPageInformationExtended -PageGUID $Pages[$i].GUID -Keywords $true
                $Keywords = $ExtendedPageInformation.SelectNodes("IODATA/PAGE/CATEGORIES/CATEGORY/KEYWORDS/KEYWORD")
                foreach ($Keyword in $Keywords)
                {
                    if ($Tags.Contains($Keyword.Value))
                    {
                        $PageTagSupport = $true
                    }
                }

                if ($false -eq $PageTagSupport)
                {
                    [void]$Pages[$i].ParentNode.RemoveChild($Pages[$i])
                }
            }
        }

        $Result = $Response.SelectNodes("IODATA/PAGES/PAGE");

        Show-MSSessionWebServiceDebug;
        return $Result
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}
