Register-MSConfigStore;

Set-MSConfigDebugMode -Value ($false); # $true oder $false

Register-MSSession -UseDefaults ($true);
Select-MSSession -UseDefaults ($true);
Enter-MSSession -UseDefaults ($true);

$AsyncQueueProcessList2 = (Get-MSAsyncQueueProcessList).SelectNodes("IODATA/PROCESSLIST2/ASYNCQUEUE");
$AsyncQueueProcessList2 | ForEach-Object {$_.SetAttribute("lastexecute", (Get-Date -Date ($_.lastexecute|ConvertFrom-OADate) -Format ("dd.MM.yyyy HH:mm:ss")))};

Write-Output ("`r`nProcessList (2) > Waiting:`r`n");
$AsyncQueueProcessList2 | Select-Object -Property ("guid", "automatic", "priority", "active", "name", "projectname", "jobguid", "servername", "lastexecute");

Write-Output ("`r`n");
Write-Output ("Total Processes currently waiting: {0}`r`n" -f $AsyncQueueProcessList2.Count);

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;