Register-MSConfigStore;

Set-MSConfigDebugMode -Value ($false); # $true oder $false

Register-MSSession -UseDefaults ($true);
Select-MSSession -UseDefaults ($true);
Enter-MSSession -UseDefaults ($true);

#$AllProjectsForUser = (Get-MSAllProjects -UserGUID (Get-MSSessionProperty -Name ("UserGUID"))).SelectNodes("IODATA/PROJECTS/PROJECT");
$AllProjectsForUser = (Get-MSAllProjects -UserGUID ("78054D5AA7304EB482AF1FCC70B60C11")).SelectNodes("IODATA/PROJECTS/PROJECT");

$AllProjectsForUser;

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;