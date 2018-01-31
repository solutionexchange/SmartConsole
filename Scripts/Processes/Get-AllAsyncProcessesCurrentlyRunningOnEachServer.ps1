Register-MSConfigStore;

Set-MSConfigDebugMode -Value ($false); # $true oder $false

Register-MSSession -UseDefaults ($true);
Select-MSSession -UseDefaults ($true);
Enter-MSSession -UseDefaults ($true);

Get-MSAllApplicationServers;
$AllApplicationServers = ([xml](Get-MSSessionProperty -Name ("LastResponse"))).SelectNodes("IODATA/EDITORIALSERVERS/EDITORIALSERVER");

Get-MSAsyncQueueProcessList;
$AsyncQueueProcessList1 = ([xml](Get-MSSessionProperty -Name ("LastResponse"))).SelectNodes("IODATA/PROCESSLIST1/ASYNCQUEUE");

Write-Output ("`r`n");

foreach ($ApplicationServer in $AllApplicationServers) {
    Write-Output ("On server {0} is currently running:`r`n" -f $ApplicationServer.name);
    foreach ($Process in ($AsyncQueueProcessList1 | Where-Object {$_.server -eq $ApplicationServer.guid})) {
        Write-Output ("Process {0}`r`n - name: {1}`r`n - project: {2}`r`n - jobguid: {3}`r`n - lastexecute: {4}`r`n" -f $Process.guid, $Process.name, $Process.projectname, $Process.jobguid, ($Process.lastexecute|ConvertFrom-OADate));
    }
    Write-Output ("`r`n");
}

Write-Output ("`r`n");
Write-Output ("Total Processes currently running: {0}`r`n" -f $AsyncQueueProcessList1.Count);

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;