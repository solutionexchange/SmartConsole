Register-MSConfigStore;

Set-MSConfigDebugMode -Value ($false); # $true oder $false

Register-MSSession -UseDefaults ($true);
Select-MSSession -UseDefaults ($true);
Enter-MSSession -UseDefaults ($true);

Get-MSAsyncQueueProcessList;
$AsyncQueueProcessList2 = ([xml](Get-MSSessionProperty -Name ("LastResponse"))).SelectNodes("IODATA/PROCESSLIST2/ASYNCQUEUE");

Write-Output ("`r`nProcessList (2) > Waiting:`r`n--------------");

foreach ($Process in $AsyncQueueProcessList2) {
    Write-Output ("Process {0}`r`n - name: {1}`r`n - project: {2}`r`n - jobguid: {3}`r`n - nextexecute: {4}`r`n" -f $Process.guid, $Process.name, $Process.projectname, $Process.jobguid, ($Process.nextexecute|ConvertFrom-OADate));
}

Write-Output ("`r`n");
Write-Output ("Total Processes waiting: {0}`r`n" -f $AsyncQueueProcessList2.Count);

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;