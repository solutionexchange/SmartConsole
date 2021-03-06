﻿Register-MSConfigStore;

Set-MSConfigDebugMode -Value ($false); # $true oder $false

Register-MSSession -UseDefaults ($true);
Select-MSSession -UseDefaults ($true);
Enter-MSSession -UseDefaults ($true);

$AsyncQueueProcessList1 = (Get-MSAsyncQueueProcessList).SelectNodes("IODATA/PROCESSLIST1/ASYNCQUEUE");
$AsyncQueueProcessList1 | ForEach-Object {$_.SetAttribute("lastexecute", (Get-Date -Date ($_.lastexecute|ConvertFrom-OADate) -Format ("dd.MM.yyyy HH:mm:ss")))};

Write-Output ("`r`nProcessList (1) > Running:`r`n");
$AsyncQueueProcessList1 | Select-Object -Property ("guid", "automatic", "priority", "active", "servername", "projectname", "jobguid", "name");

Write-Output ("`r`n");
Write-Output ("Total Processes currently running: {0}`r`n" -f $AsyncQueueProcessList1.Count);

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;