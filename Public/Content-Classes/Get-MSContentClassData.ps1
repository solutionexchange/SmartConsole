Function Get-MSContentClassData {
    <#
    .SYNOPSIS
        Determining Content Class Data
    .DESCRIPTION
        You can display the data of a content class if you know its GUID.*
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        * Server Response in case of Error: If the session key and/or content class GUID is incorrect, an empty element is returned.
        RQL: Determining Content Class Data, Software version >= 4.0.0.8
        History:
        16.0 SP2    The following attributes have been added to the server response: 'ismasterpage', 'navigationlist' and 'smarteditvisible'.
        16.0 SP1    The attribute 'previewicondisplayname' has been added to the server response.
        11.2 SP1    Added Element "PREVIEWELEMENTSREFERENCE" and "ELEMENT". PAGENAMEPATTERN attribute has been added.
        10.1        Added adoptheadlinetoalllanguages attribute.
         5.5        Instead, the TEMPLATE element of the server response now has the attribute sharedrights for global content classes. The webserverpreview attribute has been removed.
         5.0        The following attributes have been added to the TEMPLATE element in the server response: templaterights, folderrelease, and ignoreglobalworkflow.
         4.1.5      The selectinnewpage attribute has been added to the TEMPLATE element in the server response.
    #>
    [Alias('Get-CMSContentClassData')]
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
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]' dialoglanguageid='[!dialog_language_id!]'><PROJECT><TEMPLATE action='load' guid='[!guid_template!]'/></PROJECT></IODATA>").Replace("[!guid_template!]", ($ContentClassGUID|ConvertTo-RQLGuid));
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        Show-MSSessionWebServiceDebug;
        return $Response;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}