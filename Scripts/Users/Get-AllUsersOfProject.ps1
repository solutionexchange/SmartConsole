Register-MSConfigStore;

Set-MSConfigDebugMode -Value ($false); # $true oder $false

#$WSMProjectGUID = ("072d6659-a806-425b-aca8-d29f37fd6e7d"); # Vodafone Internet
$WSMProjectGUID = ("8c681c01-ece4-4fc8-b1fb-45c4a7760501"); # Vodafone Intranet

Register-MSSession -UseDefaults ($true);
Select-MSSession -UseDefaults ($true);
Enter-MSSession -UseDefaults ($true);

$AllUsersOfProject = (Get-MSUserOfProject -ProjectGUID ($WSMProjectGUID)).SelectNodes("IODATA/PROJECT/USERS/USER");
#$AllUsersOfProject | ForEach-Object {$_.SetAttribute("logindate", (Get-Date -Date ($_.logindate|ConvertFrom-OADate) -Format ("dd.MM.yyyy HH:mm:ss")))};

foreach ($User in $AllUsersOfProject) {
    $UserRole = (Get-MSUserRoleOfProject -ProjectGUID ($WSMProjectGUID) -UserGUID ($User.guid)).SelectNodes("IODATA/PROJECT");
    $AllUsersOfProject | Where-Object {$_.guid -eq $User.guid} | ForEach-Object {$_.SetAttribute("denyprojectsettings", $UserRole.denyprojectsettings)};
    $AllUsersOfProject | Where-Object {$_.guid -eq $User.guid} | ForEach-Object {$_.SetAttribute("denyadministerpublication", $UserRole.denyadministerpublication)};
    $AllUsersOfProject | Where-Object {$_.guid -eq $User.guid} | ForEach-Object {$_.SetAttribute("templateeditorright", $UserRole.templateeditorright)};
    $AllUsersOfProject | Where-Object {$_.guid -eq $User.guid} | ForEach-Object {$_.SetAttribute("userlevel", $UserRole.userlevel)};
}

Write-Output ("`r`n");
$AllUsersOfProject | Select-Object -Property ("name", "fullname", "denyprojectsettings", "denyadministerpublication", "templateeditorright", "userlevel");

Write-Output ("`r`n");

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;