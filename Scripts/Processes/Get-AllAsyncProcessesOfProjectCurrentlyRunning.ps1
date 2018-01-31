Register-MSConfigStore;

Set-MSConfigDebugMode -Value ($false); # $true oder $false

$WSMProjectGUID = ("072d6659-a806-425b-aca8-d29f37fd6e7d");

Register-MSSession -UseDefaults ($true);
Select-MSSession -UseDefaults ($true);
Enter-MSSession -UseDefaults ($true);

Get-MSAsyncQueueProcessList -ProjectGUID ($WSMProjectGUID);
$AsyncQueueProcessList1 = ([xml](Get-MSSessionProperty -Name ("LastResponse"))).SelectNodes("IODATA/PROCESSLIST1/ASYNCQUEUE");

Write-Output ("`r`nProcessList (1) > Running:`r`n--------------");

foreach ($Process in $AsyncQueueProcessList1) {
    Write-Output ("Process {0}`r`n - name: {1}`r`n - project: {2}`r`n - jobguid: {3}`r`n - servername: {4}`r`n - lastexecute: {5}`r`n" -f $Process.guid, $Process.name, $Process.projectname, $Process.jobguid, $Process.servername, ($Process.lastexecute|ConvertFrom-OADate));
}

Write-Output ("`r`n");
Write-Output ("Total Processes currently running for Project: {0}`r`n" -f $AsyncQueueProcessList1.Count);

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;