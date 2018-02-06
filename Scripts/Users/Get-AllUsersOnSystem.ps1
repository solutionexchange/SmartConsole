Register-MSConfigStore;

Set-MSConfigDebugMode -Value ($false); # $true oder $false

Register-MSSession -UseDefaults ($true);
Select-MSSession -UseDefaults ($true);
Enter-MSSession -UseDefaults ($true);

$AllUsers = (Get-MSAllUsers).SelectNodes("IODATA/USERS/USER");
$AllLoggedOnUsers = (Get-MSAllLoggedOnUsers).SelectNodes("IODATA/USERS/USER");

Write-Output ("`r`n");
$AllUsers | Select-Object -Property ("id", "name", "fullname", "email", "guid");

Write-Output ("`r`n");
Write-Output ("Total Users logged on: {0}`r`n" -f $AllLoggedOnUsers.Count);
Write-Output ("Total accounts: {0}`r`n" -f $AllUsers.Count);

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;