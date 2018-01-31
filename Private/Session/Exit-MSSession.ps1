Function Exit-MSSession {
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
    [Alias('Exit-CMSSession')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $false,
            ParameterSetName = 'byMSSession'
        )]
        [bool] $UseDefaults = $false
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        $ActiveMSSession = Get-MSConfigActiveSession;
        Set-MSTimestamp;
        $Request = ("<IODATA loginguid='[!guid_login!]' sessionkey='[!key!]' dialoglanguageid='[!dialog_language_id!]'><ADMINISTRATION><LOGOUT guid='[!guid_login!]'/></ADMINISTRATION></IODATA>");
        $Request = Import-MSSessionProperties -Request ($Request);
        [xml]$Response = Invoke-MSRQLRequest -Request ($Request);
        Show-MSSessionWebServiceDebug;
        (Get-Variable -Scope Global -Name ("MSSessionStore{0}" -f $ActiveMSSession) -ValueOnly).PSObject.Members | Where-Object {$_.Name -like ("*GUID") -or $_.Name -like ("*ID") -or $_.Name -like ("*Key")} | ForEach-Object { (Get-Variable -Scope Global -Name ("MSSessionStore{0}" -f $ActiveMSSession) -ValueOnly).PsObject.Members.Remove($_.Name) };
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}