Function Get-MSUserRoleOfProject {
    <#
    .SYNOPSIS
        Determining a User's Role in a Project
    .DESCRIPTION
        You can display the role and licenses that a user has in a specific project.
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: Listing the Users of a Project, Software version >= 4.0.0.8
        History:
        11.2 HF1    Attributes denyprojectsettings and denyadministerpublication added.
         5.0        Attribute notavailable is no longer used in the PROJECTS element in the server response. The following attributes have been added: lockedbysystem, inhibitlevel, lockinfo, checkdatabase and inhibit.
         4.1.5      The attributes projectversion and reddotstartpageguid have been added to the PROJECT element.
    #>
    [Alias('Get-CMSUserRoleOfProject')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        [string] $ProjectGUID,
        # {DESCRIPTION}
        [Parameter(
            Position = 1,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        [string] $UserGUID
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]' dialoglanguageid='[!dialog_language_id!]'><ADMINISTRATION><USER guid='[!guid_user!]'><PROJECT guid='[!guid_project!]' action='load'/></USER></ADMINISTRATION></IODATA>").Replace("[!guid_project!]", ($ProjectGUID|ConvertTo-RQLGuid)).Replace("[!guid_user!]", ($UserGUID|ConvertTo-RQLGuid));
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        Show-MSSessionWebServiceDebug;
        return $Response;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}