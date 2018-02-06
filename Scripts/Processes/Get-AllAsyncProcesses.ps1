Register-MSConfigStore;

Set-MSConfigDebugMode -Value ($false); # $true oder $false

Register-MSSession -UseDefaults ($true);
Select-MSSession -UseDefaults ($true);
Enter-MSSession -UseDefaults ($true);

$AsyncQueueProcessList = Get-MSAsyncQueueProcessList;
$AsyncQueueProcessList1 = ($AsyncQueueProcessList).SelectNodes("IODATA/PROCESSLIST1/ASYNCQUEUE");
$AsyncQueueProcessList2 = ($AsyncQueueProcessList).SelectNodes("IODATA/PROCESSLIST2/ASYNCQUEUE");
$AsyncQueueProcessList1 | ForEach-Object {$_.SetAttribute("lastexecute", (Get-Date -Date ($_.lastexecute|ConvertFrom-OADate) -Format ("dd.MM.yyyy HH:mm:ss")))};
$AsyncQueueProcessList2 | ForEach-Object {$_.SetAttribute("lastexecute", (Get-Date -Date ($_.lastexecute|ConvertFrom-OADate) -Format ("dd.MM.yyyy HH:mm:ss")))};


Write-Output ("`r`nProcessList (1) > Running:`r`n");
$AsyncQueueProcessList1 | Select-Object -Property ("guid", "automatic", "priority", "active", "name", "projectname", "jobguid", "servername", "lastexecute");

Write-Output ("`r`nProcessList (2) > Waiting:`r`n");
$AsyncQueueProcessList2 | Select-Object -Property ("guid", "automatic", "priority", "active", "name", "projectname", "jobguid", "servername", "lastexecute");

Write-Output ("`r`n");
Write-Output ("Total Processes running: {0}" -f $AsyncQueueProcessList1.Count);
Write-Output ("Total Processes waiting: {0}`r`n" -f $AsyncQueueProcessList2.Count);

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;