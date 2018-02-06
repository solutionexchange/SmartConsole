Register-MSConfigStore;

Set-MSConfigDebugMode -Value ($false); # $true oder $false

Register-MSSession -UseDefaults ($true);
Select-MSSession -UseDefaults ($true);
Enter-MSSession -UseDefaults ($true);

$AllApplicationServers = (Get-MSAllApplicationServers).SelectNodes("IODATA/EDITORIALSERVERS/EDITORIALSERVER");
$AllLoggedOnUsers = (Get-MSAllLoggedOnUsers).SelectNodes("IODATA/USERS/USER");

($AllLoggedOnUsers | Where-Object {$_.loginguid -eq (Get-MSSessionProperty -Name ("LoginGUID"))}).name += " *";
$AllLoggedOnUsers | ForEach-Object {$_.SetAttribute("servername", ($AllApplicationServers | Where-Object -Property "guid" -EQ -Value $_.serverguid).name)};

Write-Output ("`r`n");
$AllLoggedOnUsers | Select-Object -Property ("servername", "lastactiondate", "loginguid", "name") | Sort-Object -Property "name";

Write-Output ("`r`n* This is your current session.`r`n");
Write-Output ("Total Users logged on: {0}`r`n" -f $AllLoggedOnUsers.Count);

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;