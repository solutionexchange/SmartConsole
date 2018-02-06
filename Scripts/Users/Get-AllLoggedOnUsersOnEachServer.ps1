Register-MSConfigStore;

Set-MSConfigDebugMode -Value ($false); # $true oder $false

Register-MSSession -UseDefaults ($true);
Select-MSSession -UseDefaults ($true);
Enter-MSSession -UseDefaults ($true);

$AllApplicationServers = (Get-MSAllApplicationServers).SelectNodes("IODATA/EDITORIALSERVERS/EDITORIALSERVER");
$AllLoggedOnUsers = (Get-MSAllLoggedOnUsers).SelectNodes("IODATA/USERS/USER");

Write-Output ("`r`n");

foreach ($ApplicationServer in $AllApplicationServers) {
    Write-Output ("On server {0} is logged on with session id:" -f $ApplicationServer.name);
    foreach ($LoggedOnUser in ($AllLoggedOnUsers | Where-Object {$_.serverguid -eq $ApplicationServer.guid})) {
        if ($LoggedOnUser.loginguid -eq (Get-MSSessionProperty -Name ("LoginGUID"))) {
            $CurrentSession = (" *");
        }
        else {
            $CurrentSession = ("");
        }
        Write-Output (" - (last action {1})  >>>  {3}  >>>  {0}{2}" -f $LoggedOnUser.name, ($LoggedOnUser.lastactiondate|ConvertFrom-OADate), $CurrentSession, $LoggedOnUser.loginguid);
    }
    Write-Output ("`r`n");
}

Write-Output ("`r`n* This is your current session.`r`n");
Write-Output ("Total Users logged on: {0}`r`n" -f $AllLoggedOnUsers.Count);

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;