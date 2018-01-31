Function Set-Configuration {
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
    [CmdletBinding(DefaultParameterSetName = 'byConfiguration')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $false,
            ParameterSetName = 'byConfiguration'
        )]
        [string] $Username,
        # {DESCRIPTION}
        [Parameter(
            Position = 1,
            Mandatory = $false,
            ParameterSetName = 'byConfiguration'
        )]
        [string] $Uri,
        # {DESCRIPTION}
        [Parameter(
            Position = 2,
            Mandatory = $false,
            ParameterSetName = 'byConfiguration'
        )]
        [string] $ProjectGUID
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        if (Test-Path -Path ("{0}\..\Store\configuration.xml" -f $PSScriptRoot)) {
            $ConfigurationFile = [xml](Get-Content -Path ("{0}\..\Store\configuration.xml" -f $PSScriptRoot));
        }
        else {
            Copy-Item -Path ("{0}\..\Store\configuration.xml.sample" -f $PSScriptRoot) -Destination ("{0}\..\Store\configuration.xml" -f $PSScriptRoot);
            $ConfigurationFile = [xml](Get-Content -Path ("{0}\..\Store\configuration.xml" -f $PSScriptRoot));
        }
        if ($Username) {
            $ConfigurationFile.configuration.defaults.username = $Username;
        }
        if ($Uri) {
            $ConfigurationFile.configuration.defaults.uri = $Uri;
        }
        if ($ProjectGUID) {
            $ConfigurationFile.configuration.defaults.projectguid = $ProjectGUID;
        }
    }
    end {
        $ConfigurationFile.Save("{0}\..\Store\configuration.xml" -f $PSScriptRoot);
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}