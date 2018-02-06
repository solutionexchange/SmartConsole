Register-MSConfigStore;

Set-MSConfigDebugMode -Value ($false); # $true oder $false

$WSMProjectGUID = ("072d6659-a806-425b-aca8-d29f37fd6e7d");

Register-MSSession -UseDefaults ($true);
Select-MSSession -UseDefaults ($true);
Enter-MSSession -UseDefaults ($true);

$AsyncQueueProcessList2 = (Get-MSAsyncQueueProcessList -ProjectGUID ($WSMProjectGUID)).SelectNodes("IODATA/PROCESSLIST2/ASYNCQUEUE");

Write-Output ("`r`nProcessList (2) > Waiting:`r`n");
$AsyncQueueProcessList2 | Select-Object -Property ("guid", "automatic", "priority", "active", "name", "projectname", "jobguid", "servername", "lastexecute");

Write-Output ("`r`n");
Write-Output ("Total Processes currently waiting for Project: {0}`r`n" -f $AsyncQueueProcessList2.Count);

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;