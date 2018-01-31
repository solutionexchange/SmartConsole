Function Get-Configuration {
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
        ... {LINK} ....
    .NOTES
        ... {NOTES} ...
    #>
    [CmdletBinding()]
    param()
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        $ConfigurationFile = [xml](Get-Content -Path ("{0}\..\Store\configuration.xml" -f $PSScriptRoot));
        Set-MSSessionProperty -Name ("Username") -Value ($ConfigurationFile.configuration.defaults.username);
        Set-MSSessionProperty -Name ("Uri") -Value ($ConfigurationFile.configuration.defaults.uri);
        Set-MSSessionProperty -Name ("ProjectGUID") -Value ($ConfigurationFile.configuration.defaults.projectguid);
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}