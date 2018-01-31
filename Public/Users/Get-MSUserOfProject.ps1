Function Get-MSUserOfProject {
    <#
    .SYNOPSIS
        Listing the Users of a Project
    .DESCRIPTION
        You can list all users of a project, ordered by their ID.
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: Listing the Users of a Project, Software version >= 5.0
        History:
        11.2 HF1    Attributes denyprojectsettings and denyadministerpublication added to response.
        11.1 HF1    Attribute istranslator was removed from server response.
         5.5        With the additional attribute extendedinfo you can obtain more information about a project.
         5.0        The notavailable attribute is no longer used in the PROJECTS element in the server response. The following attributes are new: inhibitlevel, lockinfo, checkdatabase, lockedbysystem, istranslator and inhibit.
    #>
    [Alias('Get-CMSUserOfProject')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        [string] $ProjectGUID
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]'><ADMINISTRATION><PROJECT guid='[!guid_project!]'><USERS action='list'/></PROJECT></ADMINISTRATION></IODATA>").Replace("[!guid_project!]", ($ProjectGUID|ConvertTo-RQLGuid));
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        Show-MSSessionWebServiceDebug;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}