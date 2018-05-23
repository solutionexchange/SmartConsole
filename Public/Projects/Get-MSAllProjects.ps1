Function Get-MSAllProjects {
    <#
    .SYNOPSIS
        Listing Projects
    .DESCRIPTION
        You can list all existing Management Server projects. 
        And with the attribute userguid you can also list the roles (licenses) of a particular user in existing projects and with the attribute extendedinfo you can find out if additional Management Server projects may be created.
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: Listing Project Variants, Software version >= 4.0.0.8
        History:
        11.2 HF1    Attributes denyprojectsettings and denyadministerpublication added to response.
         7.0        You can archive pages within a project. Therefore, in the server response the archive attribute has been added to the PROJECT element.
         6.1        Attributes maxlevel, locked und testproject have been added to the server response.
         6.0        The request now has the additional optional attribute userguid . This attribute will mean that user roles in a specific project will be included in the server response. For this reason, the attributes userlevel, te, lm, and checked have been added to the PROJECT element of the server response.
         5.5        The request now has the additional optional attribute extendedinfo. This attribute checks if additional projects can be created, as some licenses limit the number of projects. The response now has the additional attribute newprojectcreateable, which contains precisely this information.
         5.0        The notavailable attribute is no longer used in the PROJECT element in the server response. In its place, the following attributes have been added inhibitlevel, lockinfo, lockedbysystem, and checkdatabase.
    #>
    [Alias('Get-CMSAllProjects')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $false,
            ParameterSetName = 'byMSSession'
        )]
        [bool] $ExtendedInfo,
        # {DESCRIPTION}
        [Parameter(
            Position = 1,
            Mandatory = $false,
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
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]' dialoglanguageid='[!dialog_language_id!]'><ADMINISTRATION><PROJECTS action='list' extendedinfo='[!extendet_info!]' userguid='[!guid_user!]' /></ADMINISTRATION></IODATA>");
        if ($ExtendedInfo) {
            $Request = $Request.Replace("[!extendet_info!]", "1");
        }
        else {
            $Request = $Request.Replace(" extendedinfo='[!extendet_info!]'", "");
        }
        if ($UserGUID) {
            $Request = $Request.Replace("[!guid_user!]", ($UserGUID|ConvertTo-RQLGuid));
        }
        else {
            $Request = $Request.Replace(" userguid='[!guid_user!]'", "");
        }
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        Show-MSSessionWebServiceDebug;
        return $Response;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}