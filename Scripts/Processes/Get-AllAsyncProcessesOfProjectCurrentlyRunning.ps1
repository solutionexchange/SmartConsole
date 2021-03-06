﻿Register-MSConfigStore;

Set-MSConfigDebugMode -Value ($false); # $true oder $false

$WSMProjectGUID = ("072d6659-a806-425b-aca8-d29f37fd6e7d");

Register-MSSession -UseDefaults ($true);
Select-MSSession -UseDefaults ($true);
Enter-MSSession -UseDefaults ($true);

$AsyncQueueProcessList1 = (Get-MSAsyncQueueProcessList -ProjectGUID ($WSMProjectGUID)).SelectNodes("IODATA/PROCESSLIST1/ASYNCQUEUE");
$AsyncQueueProcessList1 | ForEach-Object {$_.SetAttribute("lastexecute", (Get-Date -Date ($_.lastexecute|ConvertFrom-OADate) -Format ("dd.MM.yyyy HH:mm:ss")))};

Write-Output ("`r`nProcessList (1) > Running:`r`n");
$AsyncQueueProcessList1 | Select-Object -Property ("guid", "automatic", "priority", "active", "name", "projectname", "jobguid", "servername", "lastexecute");

Write-Output ("`r`n");
Write-Output ("Total Processes currently running for Project: {0}`r`n" -f $AsyncQueueProcessList1.Count);

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;