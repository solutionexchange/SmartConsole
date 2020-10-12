function Set-PublishingTargetsReport
{
    <#
    .SYNOPSIS
        Generates a report out of the Set-PublishingTargets CMDlet
    .DESCRIPTION
        Generates a report out of the Set-PublishingTargets CMDlet
    #>
    [CmdletBinding(DefaultParameterSetName = 'byMSSession')]
    param(
        [Parameter(
                Position = 0,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string] $SearchAttribute,
        [Parameter(
                Position = 1,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string] $SearchString,
        [Parameter(
                Position = 2,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string[]] $ReplaceStrings,
        [Parameter(
                Position = 3,
                Mandatory = $true,
                ParameterSetName = 'byMSSession'
        )]
        [string[]] $NewTargetNameSuffixes,
        [Parameter(
                Position = 4,
                Mandatory = $false,
                ParameterSetName = 'byMSSession'
        )]
        [string[]] $Fingerprints
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);

        $Result = Set-PublishingTargets -SearchAttribute $SearchAttribute `
                                        -SearchString $SearchString `
                                        -ReplaceStrings $ReplaceStrings `
                                        -NewTargetNameSuffixes $NewTargetNameSuffixes `
                                        -Fingerprints $Fingerprints

        $Output = "<table><tr><th>Project</th><th>Messages</th></tr>"
        foreach ($ProjectName in $Result.Keys)
        {
            $Output += "<tr><td>$ProjectName</td><td><ul>"

            foreach ($Message in $Result[$ProjectName])
            {
                $Output += "<li>$Message</li>"
            }

            $Output += "</ul></td></tr>"
        }

        $Output += " </table>"
        return $Output
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}
