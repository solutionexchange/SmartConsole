#Requires -Version 2.0


@( Get-ChildItem -Path "$PSScriptRoot\*.ps1" ) | ForEach-Object {
    . $_.FullName
}
@( Get-ChildItem -Path "$PSScriptRoot\Generators\*.ps1" ) | ForEach-Object {
    . $_.FullName
}
@( Get-ChildItem -Path "$PSScriptRoot\..\Maintenance\*.ps1" ) | ForEach-Object {
    if ((Get-Content $_.FullName).StartsWith("function") -eq $true)
    {
        . $_.FullName
    }
}
