Function Format-RQL {
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
        Format-XML
    .LINK
        Write-CHost
    .NOTES
        ... {NOTES} ...
    #>
    [CmdletBinding(DefaultParameterSetName = 'byRQL')]
    param(
        # {DESCRIPTION}
        [Parameter(
            Position = 0,
            Mandatory = $true,
            ParameterSetName = 'byRQL',
            ValueFromPipeline = $true,
            ValueFromRemainingArguments = $true
        )]
        [xml] $RQL,
        # {DESCRIPTION}
        [Parameter(
            Position = 1,
            Mandatory = $false,
            ParameterSetName = 'byRQL'
        )]
        [int] $Indentation = 2,
        # {DESCRIPTION}
        [Parameter(
            Position = 2,
            Mandatory = $false,
            ParameterSetName = 'byRQL'
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
        $RQL.WriteTo($XmlTextWriter);
        $XmlTextWriter.Flush();
        $StringWriter.Flush();
        $Output = $StringWriter.ToString();
        $Output = $Output -replace '((\w*)?IODATA|\/IODATA)', '#red#$1#gray#';
        $Output = $Output -replace '<(\w*[A-Z])', '<#yellow#$1#gray#';
        $Output = $Output -replace '<\/(\w*[A-Z])', '<#yellow#/$1#gray#';
        $Output = $Output -replace '(\/)>', '#yellow#$1#gray#>';
        $Output = $Output -replace '(\w+[a-zA-Z0-9])="(.*?)"', '#green#$1#gray#="#cyan#$2#gray#"';
        Write-Debug ("[ ENTER => RQL ]");
        Write-CHost $Output;
        Write-Debug ("[ LEAVE => RQL ]");
    }
    end {
        Write-Debug -Message ("[ Leave => function {0} ]" -f $MyInvocation.MyCommand);
    }
}