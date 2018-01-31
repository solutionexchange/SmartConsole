Register-MSConfigStore;

Set-MSConfigDebugMode -Value ($false); # $true oder $false

Register-MSSession -UseDefaults ($true);
Select-MSSession -UseDefaults ($true);
Enter-MSSession -UseDefaults ($true);

Get-MSAllUsers;
$AllUsers = ([xml](Get-MSSessionProperty -Name ("LastResponse"))).SelectNodes("IODATA/USERS/USER");

Get-MSAllLoggedOnUsers;
$AllLoggedOnUsers = ([xml](Get-MSSessionProperty -Name ("LastResponse"))).SelectNodes("IODATA/USERS/USER");

Write-Output ("`r`n");

foreach ($User in $AllUsers) {
    Write-Output ("{0} ({4})`r`n - {1}`r`n - {2}`r`n - {3}`r`n" -f $User.name, $User.fullname, $User.email, $User.guid, $User.id);
}

Write-Output ("`r`n");
Write-Output ("Currently logged on: {0}`r`n" -f $AllLoggedOnUsers.Count);
Write-Output ("Total accounts: {0}`r`n" -f $AllUsers.Count);

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;