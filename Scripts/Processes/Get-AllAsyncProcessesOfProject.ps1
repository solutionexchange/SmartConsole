Register-MSConfigStore;

Set-MSConfigDebugMode -Value ($false); # $true oder $false

$WSMProjectGUID = ("072d6659-a806-425b-aca8-d29f37fd6e7d");

Register-MSSession -UseDefaults ($true);
Select-MSSession -UseDefaults ($true);
Enter-MSSession -UseDefaults ($true);

$AsyncQueueProcessList = Get-MSAsyncQueueProcessList -ProjectGUID ($WSMProjectGUID);
$AsyncQueueProcessList1 = ($AsyncQueueProcessList).SelectNodes("IODATA/PROCESSLIST1/ASYNCQUEUE");
$AsyncQueueProcessList2 = ($AsyncQueueProcessList).SelectNodes("IODATA/PROCESSLIST2/ASYNCQUEUE");

Write-Output ("`r`nProcessList (1) > Running:`r`n");
$AsyncQueueProcessList1 | Select-Object -Property ("guid", "automatic", "priority", "active", "name", "projectname", "jobguid", "servername", "lastexecute");

Write-Output ("`r`nProcessList (2) > Waiting:`r`n");
$AsyncQueueProcessList2 | Select-Object -Property ("guid", "automatic", "priority", "active", "name", "projectname", "jobguid", "servername", "lastexecute");

Write-Output ("`r`n");
Write-Output ("Total Processes currently running for Project: {0}" -f $AsyncQueueProcessList1.Count);
Write-Output ("Total Processes waiting for Project: {0}`r`n" -f $AsyncQueueProcessList2.Count);

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;