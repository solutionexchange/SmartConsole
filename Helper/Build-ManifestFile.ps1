$BuildDate = Get-Date;
$PrivatePS1Files = (Get-ChildItem -Path ("$PSScriptRoot\..\Private\*.ps1") -Recurse);
$PublicPS1Files = (Get-ChildItem -Path ("$PSScriptRoot\..\Public\*.ps1") -Recurse);
$AllPS1Files = (Get-ChildItem -Path ("$PSScriptRoot\..\*.ps1") -Recurse);
$RootFiles = (Get-ChildItem -Path ("$PSScriptRoot\..\*.*"));
$WikiFiles = (Get-ChildItem -Path ("$PSScriptRoot\..\Wiki\*.*") -Recurse);
$SampleFiles = (Get-ChildItem -Path ("$PSScriptRoot\..\*.sample") -Recurse);
$AllFolders = (Get-ChildItem -Path ("$PSScriptRoot\..\") -Directory -Recurse);
$AllItems = $AllPS1Files + $RootFiles + $SampleFiles + $WikiFiles + $AllFolders;

foreach ($item in $AllItems) {
    $item.LastWriteTime = $BuildDate;
}

$ExportFunctionsToExport = $PrivatePS1Files.BaseName + $PublicPS1Files.BaseName;
$ExportCmdletsToExport = ("*");
$ExportVariablesToExport = ("*");
$ExportAliasesToExport = ("*");
$ExportPath = ("$PSScriptRoot\..\SmartConsole.psd1");
$ExportGuid = ("382987ca-c990-4633-a398-07a50089a2f9");
$ExportDescription = ("PowerShell Module Wrapper for OpenText Web Site Management and Delivery Server (RedDot CMS & CPS).")
$ExportAuthor = ("Thomas Pollinger");
$ExportCompanyName = ("OpenText Web Solutions Usergroup e.V. (OWUG)");
$ExportVersion = ("0.2.0");
$ExportPowerShellVersion = ("4.0");
$ExportCompatiblePSEditions = ("Desktop");
$ExportRootModule = (".\SmartConsole.psm1");
$ExportDotNetFrameworkVersion = ("4.6.1");

New-ModuleManifest -Path ($ExportPath) -Guid ($ExportGuid) -Description ($ExportDescription) -Author ($ExportAuthor) -CompanyName ($ExportCompanyName) -ModuleVersion ($ExportVersion) -PowerShellVersion ($ExportPowerShellVersion) -CompatiblePSEditions ($ExportCompatiblePSEditions)  -RootModule ($ExportRootModule) -DotNetFrameworkVersion ($ExportDotNetFrameworkVersion) -FunctionsToExport ($ExportFunctionsToExport) -CmdletsToExport ($ExportCmdletsToExport) -VariablesToExport ($ExportVariablesToExport) -AliasesToExport ($ExportAliasesToExport);