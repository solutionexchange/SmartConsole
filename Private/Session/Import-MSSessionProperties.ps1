Function Import-MSSessionProperties {
    <#
    .SYNOPSIS
        ... {SYNOPSIS} ...
    .DESCRIPTION
        ... {DESCRIPTION} ...
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        ... {NOTES} ...
    #>
    [Alias('Import-CMSSessionProperties')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        [string] $Request
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        #$Xml = [xml]("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]' dialoglanguageid='[!dialog_language_id!]'>{0}</IODATA>" -f $Request);
        $Xml = [xml]$Request;
        if ($Xml.IODATA.HasAttributes) {
            $Xml.IODATA.loginguid = (Get-MSSessionProperty -Name ("LoginGUID"))|ConvertTo-RQLGuid;
            $Xml.IODATA.sessionkey = (Get-MSSessionProperty -Name ("SessionKey"))|ConvertTo-RQLGuid;
            if ($Xml.IODATA.dialoglanguageid) {
                $Xml.IODATA.dialoglanguageid = ("ENU"); #Get-CmsSessionProperty -Name ("DialogLanguageId");
            }
        }
        if ($Xml.IODATA.HasChildNodes) {
            if ($Xml.IODATA.GetElementsByTagName("ADMINISTRATION").action -eq "login") {
                $Xml.IODATA.ADMINISTRATION.name = Get-MSSessionProperty -Name ("Username");
                $Xml.IODATA.ADMINISTRATION.password = Get-MSSessionProperty -Name ("Password");
            }
            if ($Xml.IODATA.GetElementsByTagName("ADMINISTRATION").action -eq "validate") {
                $Xml.IODATA.ADMINISTRATION.guid = (Get-MSSessionProperty -Name ("LoginGUID"))|ConvertTo-RQLGuid;
                if ($Xml.IODATA.ADMINISTRATION.HasChildNodes) {
                    if ($Xml.IODATA.ADMINISTRATION.GetElementsByTagName("PROJECT").HasAttributes) {
                        $Xml.IODATA.ADMINISTRATION.PROJECT.guid = (Get-MSSessionProperty -Name ("ProjectGUID"))|ConvertTo-RQLGuid;
                    }
                }
            }
            if ($Xml.IODATA.GetElementsByTagName("ADMINISTRATION").HasChildNodes) {
                if ($Xml.IODATA.ADMINISTRATION.GetElementsByTagName("LOGOUT").HasAttributes) {
                    $Xml.IODATA.ADMINISTRATION.LOGOUT.guid = (Get-MSSessionProperty -Name ("LoginGUID"))|ConvertTo-RQLGuid;
                }
            }
            if ($Xml.IODATA.GetElementsByTagName("PREVIEW").url -eq "/CMS/ioRD.asp") {
                $Xml.IODATA.PREVIEW.projectguid = (Get-MSSessionProperty -Name ("ProjectGUID"))|ConvertTo-RQLGuid;
                $Xml.IODATA.PREVIEW.loginguid = (Get-MSSessionProperty -Name ("LoginGUID"))|ConvertTo-RQLGuid;
            }
            if ($Xml.IODATA.GetElementsByTagName("PROJECT").HasAttributes) {
                if ($Xml.IODATA.PROJECT.sessionkey) {
                    $Xml.IODATA.PROJECT.sessionkey = (Get-MSSessionProperty -Name ("SessionKey"))|ConvertTo-RQLGuid;
                }
            }
        }
        return $Xml.OuterXml;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}