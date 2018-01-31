Function Format-XML {
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
        Format-RQL
    .LINK
        Write-CHost
    .NOTES
        ... {NOTES} ...
    #>
    [CmdletBinding(DefaultParameterSetName = 'byXML')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ParameterSetName = 'byXML',
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true
        )]
        [xml] $Xml,
        # {DESCRIPTION}
        [Parameter(
            Position = 1,
            Mandatory = $false,
            ParameterSetName = 'byXML'
        )]
        [int] $Indentation = 2,
        # {DESCRIPTION}
        [Parameter(
            Position = 2,
            Mandatory = $false,
            ParameterSetName = 'byXML'
        )]
        [string] $Formatting = 'Indented'
    )
    begin {
        Write-Debug -Message ("[ Enter => function {0} ]" -f $MyInvocation.MyCommand);
    }
    process {
        Write-Debug -Message ("[ Process => function {0} ]" -f $MyInvocation.MyCommand);
        $StringWriter = New-Object System.IO.StringWriter;
        $XmlTextWriter = New-Object System.Xml.XmlTextWriter ($StringWriter);
        $XmlTextWriter.Formatting = $Formatting;
        $XmlTextWriter.Indentation = $Indentation;
        $Xml.WriteTo($XmlTextWriter);
        $XmlTextWriter.Flush();
        $StringWriter.Flush();
        Write-Output $StringWriter.ToString();
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}