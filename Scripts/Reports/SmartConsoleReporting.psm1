#Requires -Version 2.0


@( Get-ChildItem -Path "$PSScriptRoot\*.ps1" ) | ForEach-Object {
    . $_.FullName
}
@( Get-ChildItem -Path "$PSScriptRoot\Generators\*.ps1" ) | ForEach-Object {
    . $_.FullName
}
@( Get-ChildItem -Path "$PSScriptRoot\..\Maintenance\*.ps1" ) | ForEach-Object {
    $Content = (Get-Content $_.FullName)
    if ($Content.StartsWith("function") -eq $true -or $Content.StartsWith("Function") -eq $true)
    {
        . $_.FullName
    }
}
