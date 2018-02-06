Function Get-MSProjectData {
    <#
    .SYNOPSIS
        Determining Project Data
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
        RQL: Determining Project Data, Software version >= 4.0.0.8
        History:
        16.0 SP2    New attribute "useanyserver" and "usealternativeserver" documented.
         6.0        Because of the possibility to create a project as a test project the attribute testproject has been added to the query.
         5.0        Attribute notavailable is no longer used in PROJECT element in the server response. The following attributes have been added: lockedbysystem, inhibitlevel, lockinfo, createallowed and dbtypeid.
         4.5        The following attributes are no longer used in the PROJECT element: datasource, provider, databasepath, user and password.
         4.1.5.1b   Attribute reddotstartpageguid has been added to the PROJECT element in the output.
         4.1.5      The output has been supplemented with the projectversion attribute in the PROJECT element.
    #>
    [Alias('Get-CMSProjectData')]
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
        if (-not $ProjectGUID) {
            $ProjectGUID = Get-MSSessionProperty -Name ("ProjectGUID");
        }
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]'><ADMINISTRATION><PROJECT action='load' guid='[!guid_project!]'/></ADMINISTRATION></IODATA>").Replace("[!guid_project!]", ($ProjectGUID|ConvertTo-RQLGuid));
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        return $Response;
        Show-MSSessionWebServiceDebug;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}