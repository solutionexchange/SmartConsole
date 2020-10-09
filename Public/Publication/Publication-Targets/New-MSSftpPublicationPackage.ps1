Function New-MSSftpPublicationPackage {
    <#
    .SYNOPSIS
        Creates a new SFTP Publication Package
    .DESCRIPTION
        Creates a new SFTP Publication Package with the given data.
    #>
    [Alias('New-CMSSftpPublicationPackage')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        [Parameter(
                Position = 0,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string] $Name,
        [Parameter(
                Position = 1,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [int] $NoBOM,
        [Parameter(
                Position = 2,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string] $ReplaceCrlfWithLfinPublishedFile,
        [Parameter(
                Position = 3,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string] $Username,
        [Parameter(
                Position = 4,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string] $Password,
        [Parameter(
                Position = 5,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string] $Path,
        [Parameter(
                Position = 6,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string] $Port,
        [Parameter(
                Position = 7,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [AllowEmptyString()]
        [string] $UrlPrefix,
        [Parameter(
                Position = 8,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string] $Fingerprint,
        [Parameter(
                Position = 9,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string] $KeyFile,
        [Parameter(
                Position = 10,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string] $KeyFilePassword
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]'><PROJECT><EXPORT action='addnew' type='6208' nobom='[!nobom!]' replacecrlfwithlfinpublishedfile='[!replacecrlfwithlfinpublishedfile!]' name='[!export_name!]' username='[!username!]' password='[!password!]' path='[!path!]' port='[!port!]' urlprefix='[!urlprefix!]' fingerprint='[!fingerprint!]' keyfile='[!keyfile!]' keyfilepassword='[!keyfilepassword!]' proxytype='0'/></PROJECT></IODATA>")
        $Request = $Request.Replace("[!nobom!]", $NoBOM)
        $Request = $Request.Replace("[!replacecrlfwithlfinpublishedfile!]", $ReplaceCrlfWithLfinPublishedFile)
        $Request = $Request.Replace("[!export_name!]", $Name)
        $Request = $Request.Replace("[!username!]", $Username)
        $Request = $Request.Replace("[!password!]", $Password)
        $Request = $Request.Replace("[!path!]", $Path)
        $Request = $Request.Replace("[!port!]", $Port)
        $Request = $Request.Replace("[!urlprefix!]", $UrlPrefix)
        $Request = $Request.Replace("[!fingerprint!]", $Fingerprint)
        $Request = $Request.Replace("[!keyfile!]", $KeyFile)
        $Request = $Request.Replace("[!keyfilepassword!]", $KeyFilePassword)
        $Request = Import-MSSessionProperties -Request ($Request)
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        Show-MSSessionWebServiceDebug;
        return $Response;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}
