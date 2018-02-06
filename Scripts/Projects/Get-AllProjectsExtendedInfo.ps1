Register-MSConfigStore;

Set-MSConfigDebugMode -Value ($false); # $true oder $false

Register-MSSession -UseDefaults ($true);
Select-MSSession -UseDefaults ($true);
Enter-MSSession -UseDefaults ($true);

$AllProjectsWithExtendedInfo = (Get-MSAllProjects -ExtendedInfo ($true)).SelectNodes("IODATA/PROJECTS/PROJECT");

$AllProjectsWithExtendedInfo;

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;