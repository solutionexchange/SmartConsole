Function Get-MSAsyncQueueProcessList {
    <#
    .SYNOPSIS
        ASYNCQUEUE list
    .DESCRIPTION
        Contains a list of jobs which are either waiting to be executed, or are being executed by the process server.
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: ASYNCQUEUE list, Software version >= 16.0
        History:
        16.0        RQL documentation was created in version 16.0 and is compatible with earlier versions.
    #>
    [Alias('Get-CMSAsyncQueueProcessList')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $false,
            ParameterSetName = 'byMSSession'
        )]
        [string] $ProjectGUID,
        [Parameter(
            Position = 1,
            Mandatory = $false,
            ParameterSetName = 'byMSSession'
        )]
        [bool] $UseSession = $false
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        if ($UseSession) {
            $ProjectGUID = Get-MSSessionProperty -Name ("ProjectGUID");
        } 
        if ($ProjectGUID) {
            $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]' dialoglanguageid='[!dialog_language_id!]'><ADMINISTRATION><ASYNCQUEUE action='list' project='[!guid_project!]'/></ADMINISTRATION></IODATA>").Replace("[!guid_project!]", ($ProjectGUID|ConvertTo-RQLGuid));
        }
        else {
            $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]' dialoglanguageid='[!dialog_language_id!]'><ADMINISTRATION><ASYNCQUEUE action='list'/></ADMINISTRATION></IODATA>");
        }
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        return $Response;
        Show-MSSessionWebServiceDebug;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}