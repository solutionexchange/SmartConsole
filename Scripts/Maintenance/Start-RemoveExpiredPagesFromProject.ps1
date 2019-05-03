Register-MSConfigStore;

Set-MSConfigDebugMode -Value ($false); # $true oder $false

Register-MSSession -UseDefaults ($true);
Select-MSSession -UseDefaults ($true);
Enter-MSSession -UseDefaults ($true);

# GUID des Projektes im Format 09dd6c35-ad5d-4905-ab0f-4fbc0a37f61c oder 09DD6C35AD5D4905AB0F4FBC0A37F61C
#$WSMProjectGUID = ("072d6659-a806-425b-aca8-d29f37fd6e7d"); # Vodafone Internet
#$WSMProjectGUID = ("6A89CD93325D42FD81A42FA836547016"); # Vodafone Internet - Fachhandel Online
#$WSMProjectGUID = ("107CB9590FBB4C1AB7B8F7FE2449EE85"); # Vodafone Internet - Innovation Park
#$WSMProjectGUID = ("8C681C01ECE44FC8B1FB45C4A7760501"); # Vodafone Intranet (AskVodafone)
#$WSMProjectGUID = ("BA2A9869B57D4BA89E598F6B4B48F0B6"); # Vodafone Mobile
#$WSMProjectGUID = ("771B99172E8B404794FA805EF961EF57"); # vodafone Applications - MobileApp
#$WSMProjectGUID = ("8A300F4B74AA4D4CB5C54C2165FC56D1"); # Shared Components - Simplicity
#$WSMProjectGUID = ("09754F11ECFB485E98AA72853155CB00"); # Shared Data - Tariff Details
$WSMProjectGUID = ("7C503F8E943E4E6CACE63B2DEB82BBF4"); # Development - Defects and Testing

$Result = Enter-MSProject -ProjectGUID ($WSMProjectGUID);
$ResultProject = ($Result).SelectNodes("IODATA/PROJECT");
$ResultProject.name;

$Counter = 0;
$CountTotal = 0;
$Date = ("31.12.2018");

$DisconnectedPages = @();
$SkippedPages = @();

$ValuePercentComplete = 0;
Write-Progress -Activity ("Working...") -PercentComplete ($ValuePercentComplete) -CurrentOperation ("{0}% complete" -f [math]::Round($ValuePercentComplete)) -Status ("Please wait - collecting data.");
$ExpiredPages = (Find-MSPagesLinkingSchedule -PageSize (2000) -MaxHits (2000) -LinkingScheduleDate (Get-Date -Date ($Date))).SelectNodes("IODATA/PAGES/PAGE");

$WorkingStep = (99 / $ExpiredPages.Count);
$ValuePercentComplete = 1;
Write-Progress -Activity ("Working...") -PercentComplete ($ValuePercentComplete) -CurrentOperation ("{0}% complete" -f [math]::Round($ValuePercentComplete)) -Status ("Please wait - Found {0} expired pages in project {1}" -f ($ExpiredPages.guid).Count, ($ResultProject.name));
$CountTotal += $ExpiredPages.Count;

foreach ($ExpiredPage in $ExpiredPages) {
    $Counter++;
    Write-Progress -Activity ("Working... (Disconnected pages {0} | Skipped pages {1} | Found {2} expired pages in project: {3})" -f ($DisconnectedPages).Count, ($SkippedPages).Count, ($ExpiredPages.guid).Count, ($ResultProject.name)) -PercentComplete ($ValuePercentComplete) -CurrentOperation ("{0}% complete" -f [math]::Round($ValuePercentComplete)) -Status ("Please wait - ({1}) - check linking of page: {0}." -f $ExpiredPage.headline, $Counter);
    $CountLinking = (Get-MSPageLinkingAppearanceSchedules -PageGUID ($ExpiredPage.guid)).SelectNodes("IODATA/LINKSFROM/LINK");
    if ($CountLinking.Count -eq 1) {
        Write-Progress -Activity ("Working... (Disconnected pages {0} | Skipped pages {1} | Found {2} expired pages in project: {3})" -f ($DisconnectedPages).Count, ($SkippedPages).Count, ($ExpiredPages.guid).Count, ($ResultProject.name)) -PercentComplete ($ValuePercentComplete) -CurrentOperation ("{0}% complete" -f [math]::Round($ValuePercentComplete)) -Status ("Please wait - ({1}) - check linking of page: {0}." -f $ExpiredPage.headline, $Counter);
        $DisconnectedPages += $ExpiredPage;
        $Result = Disconnect-MSPage -PageGUID ($ExpiredPage.guid) -LinkGuid ($ExpiredPage.mainlink);
    }
    else {
        Write-Progress -Activity ("Working... (Disconnected pages {0} | Skipped pages {1} | Found {2} expired pages in project: {3})" -f ($DisconnectedPages).Count, ($SkippedPages).Count, ($ExpiredPages.guid).Count, ($ResultProject.name)) -PercentComplete ($ValuePercentComplete) -CurrentOperation ("{0}% complete" -f [math]::Round($ValuePercentComplete)) -Status ("Please wait - ({1}) - check linking of page: {0}." -f $ExpiredPage.headline, $Counter);
        #Write-Output ("GUID: {2} | Total: {0} | Expired: {1}" -f $CountLinking.Count, ($CountLinking | Where-Object { $_.dateend -ne "0" }).Count, $ExpiredPage.guid);
        #$CountLinking | Select-Object -Property "dateend" | Where-Object { $_.dateend -le (ConvertTo-OADate -Date (Get-Date -Date ($Date))) };
        $SkippedPages += $ExpiredPage;
    }
    $ValuePercentComplete += $WorkingStep;
}

Write-Progress -Activity ("Finished...") -PercentComplete ($ValuePercentComplete) -CurrentOperation ("{0}% complete" -f [math]::Round($ValuePercentComplete)) -Status ("Please wait - Sending output to console.");

$DisconnectedPages.Count;
$SkippedPages.Count;

#$DisconnectedPages | Select-Object -Property ("guid", "mainlink", "id", "headline") | Format-Table; # Optional
$DisconnectedPages | Select-Object -Property ("guid", "mainlink", "id", "headline") | Format-Table | Out-File -FilePath ("C:\Temp\Result-RemovedExpiredPages-{0}-{1}.txt" -f $WSMProjectGUID, (Get-Date -Format ("yyyyMMdd-HHmmss"))) -Encoding ("utf8") -Force; # Optional - Output to file (txt)
Export-Clixml -InputObject $DisconnectedPages -Path ("C:\Temp\Result-RemovedExpiredPages-{0}-{1}.xml" -f $WSMProjectGUID, (Get-Date -Format ("yyyyMMdd-HHmmss"))) -Force; # Optional - Output to file (object)

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;