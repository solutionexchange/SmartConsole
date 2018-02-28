Function Get-MSContentClassDisplayFormat {
    <#
    .SYNOPSIS
        Determining Template Display Formats
    .DESCRIPTION
        The display format is assigned to a project variant in every project, to display the page preview and for SmartEdit mode. This project variant is assigned a template. You can use this query to return the GUID of the template that is assigned to the project variant with property "Display Format." If there is no template assigned to a project variant with property "Display Format," an error message is returned.
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: Determining Template Display Formats, Software version >= 4.0.0.8
        History:
         6.1        To facilitate content class versioning, the following attributes have been added to the TEMPLATEVARIANT element in the server response: changeddate, changedusername, createusername, draft, pdforientation and waitforrelease.
         5.0        The following attributes have been added to the TEMPLATEVARIANT element in the server response: folderguid and templaterights. The attribute donotgenerate has been removed.
    #>
    [Alias('Get-CMSContentClassDisplayFormat')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        [string] $ContentClassGUID
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]' dialoglanguageid='[!dialog_language_id!]'><PROJECT><TEMPLATE guid='[!guid_template!]'><TEMPLATEVARIANTS action='loadfirst' /></TEMPLATE></PROJECT></IODATA>").Replace("[!guid_template!]", ($ContentClassGUID|ConvertTo-RQLGuid));
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        Show-MSSessionWebServiceDebug;
        return $Response;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}