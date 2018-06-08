Register-MSConfigStore;

Set-MSConfigDebugMode -Value ($false); # $true oder $false

Register-MSSession -UseDefaults ($true);
Select-MSSession -UseDefaults ($true);
Enter-MSSession -UseDefaults ($true);

# GUID des Projektes im Format 09dd6c35-ad5d-4905-ab0f-4fbc0a37f61c oder 09DD6C35AD5D4905AB0F4FBC0A37F61C
#$WSMProjectGUID = ("072d6659-a806-425b-aca8-d29f37fd6e7d"); # Vodafone Internet
#$WSMProjectGUID = ("6A89CD93325D42FD81A42FA836547016"); # Vodafone Internet - Fachhandel Online
#$WSMProjectGUID = ("107CB9590FBB4C1AB7B8F7FE2449EE85"); # Vodafone Internet - Innovation Park
#$WSMProjectGUID = ("8C681C01ECE44FC8B1FB45C4A7760501"); # Vodafone Intranet
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
$LoopRun = 0;
$OlderThanDays = -14;

$RemovedUnlinkedPages = @();

$ValuePercentComplete = 0;
Write-Progress -Activity ("Working...") -PercentComplete ($ValuePercentComplete) -CurrentOperation ("{0}% complete" -f [math]::Round($ValuePercentComplete)) -Status ("Please wait - collecting data.");
$UnlinkedPages = (Find-MSSpecialPages -PageType ("unlinked") -ResultSize 10000 -CreateDate ((Get-Date).AddDays($OlderThanDays))).SelectNodes("IODATA/PAGES/PAGE");

while ($UnlinkedPages.Count -gt 0) {

    $LoopRun++;
    $WorkingStep = (90 / $UnlinkedPages.Count);
    $ValuePercentComplete = 10;
    Write-Progress -Activity ("Working...") -PercentComplete ($ValuePercentComplete) -CurrentOperation ("{0}% complete" -f [math]::Round($ValuePercentComplete)) -Status ("Please wait - Found {0} unlinked pages for Loop {1} in project {2}" -f ($UnlinkedPage.guid).Count, $LoopRun, ($ResultProject.name));
    $CountTotal += $UnlinkedPages.Count;

    foreach ($UnlinkedPage in $UnlinkedPages) {
        $Counter++;
        Write-Progress -Activity ("Working... (Remove unlinked page {1} of {4} in total | Found {0} unlinked pages for loop {2} in project: {3})" -f ($UnlinkedPages.guid).Count, $Counter, $LoopRun, ($ResultProject.name), $CountTotal) -PercentComplete ($ValuePercentComplete) -CurrentOperation ("{0}% complete" -f [math]::Round($ValuePercentComplete)) -Status ("Please wait - remove page: {0}." -f $UnlinkedPage.headline);
        $Result = (Remove-MSPage -PageGUID ($UnlinkedPage.guid) -ForceDelete2910 ($true) -ForceDelete2911 ($true)).SelectNodes("IODATA").("#text");
        $RemovedUnlinkedPages += $UnlinkedPage;
        $ValuePercentComplete += $WorkingStep;
    }

    $ValuePercentComplete = 0;
    Write-Progress -Activity ("Working...") -PercentComplete ($ValuePercentComplete) -CurrentOperation ("{0}% complete" -f [math]::Round($ValuePercentComplete)) -Status ("Please wait - collecting data.");
    $UnlinkedPages = (Find-MSSpecialPages -PageType ("unlinked") -ResultSize 10000).SelectNodes("IODATA/PAGES/PAGE");

}

Write-Progress -Activity ("Finished...") -PercentComplete ($ValuePercentComplete) -CurrentOperation ("{0}% complete" -f [math]::Round($ValuePercentComplete)) -Status ("Please wait - Sending output to console.");

$RemovedUnlinkedPages | Select-Object -Property ("guid", "id", "headline", "status", "flags") | Format-Table; # Optional
#$RemovedUnlinkedPages | Select-Object -Property ("guid", "id", "headline", "status", "flags") | Format-Table | Out-File -FilePath ("C:\Temp\Result-RemovedUnlinkedPages-{0}.txt" -f $WSMProjectGUID) -Encoding ("utf8") -Force; # Optional - Output to file

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;