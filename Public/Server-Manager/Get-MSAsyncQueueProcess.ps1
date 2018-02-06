Function Get-MSAsyncQueueProcess {
    <#
    .SYNOPSIS
        ASYNCQUEUE load
    .DESCRIPTION
        RQL to load a process from administer publication or scheduled processes.
    .EXAMPLE
        ... {EXAMPLE} ...
    .INPUTS
        ... {INPUTS} ...
    .OUTPUTS
        ... {OUTPUTS} ...
    .LINK
        ... {LINK} ...
    .NOTES
        RQL: ASYNCQUEUE load, Software version >= 16.0
        History:
        16.0        RQL documentation was created in version 16.0 and is compatible with earlier versions.
    #>
    [Alias('Get-CMSAsyncQueueProcess')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        [string] $ProcessGUID
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]' dialoglanguageid='[!dialog_language_id!]'><ADMINISTRATION><ASYNCQUEUE action='load' guid='[!guid_process!]'/></ADMINISTRATION></IODATA>").Replace("[!guid_process!]", ($ProcessGUID|ConvertTo-RQLGuid));
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        return $Response;
        Show-MSSessionWebServiceDebug;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}