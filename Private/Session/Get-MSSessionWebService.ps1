Function Get-MSSessionWebService {
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
    [Alias('Get-CMSSessionWebService')]
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ParameterSetName = 'byMSSession'
        )]
        [string] $MemberType
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        $ActiveMSSession = Get-MSConfigActiveSession;
        Write-Host ("<<--[MS WebService]---------------------`r`n") -ForegroundColor Green;
        Write-Host ("MemberType : {0}" -f $MemberType) -ForegroundColor Green;
        Write-Host ("MSSession : {0}" -f $ActiveMSSession) -NoNewline -ForegroundColor Green | Format-List;
        Get-MSSessionProperty ("Proxy") | Get-Member -MemberType $MemberType | Format-Table;
        Write-Host ("--------------------------------------->>`r`n`r`n") -ForegroundColor Green;
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}