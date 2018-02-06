Register-MSConfigStore;

Set-MSConfigDebugMode -Value ($false); # $true oder $false

Register-MSSession -UseDefaults ($true);
Select-MSSession -UseDefaults ($true);
Enter-MSSession -UseDefaults ($true);

(Start-MSAsyncQueueProcess -ProcessGUID ("6CBD4FAD3CB5493A9CB78C169CBA71AA")).SelectNodes("IODATA/ADMINISTRATION/ASYNCQUEUE");

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;