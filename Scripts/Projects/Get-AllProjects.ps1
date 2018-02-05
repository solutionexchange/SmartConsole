Register-MSConfigStore;

Set-MSConfigDebugMode -Value ($false); # $true oder $false

Register-MSSession -UseDefaults ($true);
Select-MSSession -UseDefaults ($true);
Enter-MSSession -UseDefaults ($true);

Get-MSAllProjects;
$AllProjects = ([xml](Get-MSSessionProperty -Name ("LastResponse"))).SelectNodes("IODATA/PROJECTS/PROJECT");

$AllProjects;

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;