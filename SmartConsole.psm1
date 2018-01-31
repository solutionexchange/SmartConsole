#Requires -Version 2.0

# Public functions
@( Get-ChildItem -Path "$PSScriptRoot\Public\*.ps1" ) | ForEach-Object {
    . $_.FullName
}

# Private functions
@( Get-ChildItem -Path "$PSScriptRoot\Private\Config\*.ps1" ) | ForEach-Object {
    . $_.FullName
}
@( Get-ChildItem -Path "$PSScriptRoot\Private\Core\*.ps1" ) | ForEach-Object {
    . $_.FullName
}
@( Get-ChildItem -Path "$PSScriptRoot\Private\Debug\*.ps1" ) | ForEach-Object {
    . $_.FullName
}
@( Get-ChildItem -Path "$PSScriptRoot\Private\Session\*.ps1" ) | ForEach-Object {
    . $_.FullName
}
@( Get-ChildItem -Path "$PSScriptRoot\Private\Store\*.ps1" ) | ForEach-Object {
    . $_.FullName
}
@( Get-ChildItem -Path "$PSScriptRoot\Private\Tools\*.ps1" ) | ForEach-Object {
    . $_.FullName
}