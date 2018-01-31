Register-MSConfigStore;

Set-MSConfigDebugMode -Value ($false); # $true oder $false

Register-MSSession -UseDefaults ($true);
Select-MSSession -UseDefaults ($true);
Enter-MSSession -UseDefaults ($true);

Get-MSAllApplicationServers;
$AllApplicationServers = ([xml](Get-MSSessionProperty -Name ("LastResponse"))).SelectNodes("IODATA/EDITORIALSERVERS/EDITORIALSERVER");

Get-MSAllLoggedOnUsers;
$AllLoggedOnUsers = ([xml](Get-MSSessionProperty -Name ("LastResponse"))).SelectNodes("IODATA/USERS/USER");

Write-Output ("`r`n");

foreach ($LoggedOnUser in $AllLoggedOnUsers) {
    if ($LoggedOnUser.loginguid -eq (Get-MSSessionProperty -Name ("LoginGUID"))) {
        $CurrentSession = (" *");
    }
    else {
        $CurrentSession = ("");
    }
    Write-Output ("At {1} is {3} as User {0}{2}" -f $LoggedOnUser.name, ($AllApplicationServers | Where-Object {$_.guid -eq $LoggedOnUser.serverguid}).name, $CurrentSession, $LoggedOnUser.loginguid);
}

Write-Output ("`r`n* This is your current session.`r`n");
Write-Output ("Currently logged on: {0}`r`n" -f $AllLoggedOnUsers.Count);

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;