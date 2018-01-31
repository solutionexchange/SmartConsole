Register-MSConfigStore;

Set-MSConfigDebugMode -Value ($false); # $true oder $false

Register-MSSession -UseDefaults ($true);
Select-MSSession -UseDefaults ($true);
Enter-MSSession -UseDefaults ($true);

# GUID des Projektes im Format 09dd6c35-ad5d-4905-ab0f-4fbc0a37f61c oder 09DD6C35AD5D4905AB0F4FBC0A37F61C
#$WSMProjectGUID = ("072d6659-a806-425b-aca8-d29f37fd6e7d"); # Vodafone Internet
#$WSMProjectGUID = ("6A89CD93325D42FD81A42FA836547016"); # Vodafone Internet - Fachhandel Online
#$WSMProjectGUID = ("8C681C01ECE44FC8B1FB45C4A7760501"); # Vodafone Intranet
#$WSMProjectGUID = ("BA2A9869B57D4BA89E598F6B4B48F0B6"); # Vodafone Mobile
#$WSMProjectGUID = ("8A300F4B74AA4D4CB5C54C2165FC56D1"); # Shared Components - Simplicity
$WSMProjectGUID = ("7C503F8E943E4E6CACE63B2DEB82BBF4"); # Development - Defects and Testing

Enter-MSProject -ProjectGUID ($WSMProjectGUID);

$StartDate = Get-Date;
$Counter = 0;
$LoopRun = 0;

Find-MSSpecialPages -PageType ("unlinked") -ResultSize 10000;
$UnlinkedPages = ([xml](Get-MSSessionProperty -Name ("LastResponse"))).SelectNodes("IODATA/PAGES/PAGE");

while ($UnlinkedPages.Count -gt 0) {

    $LoopRun++;
    Write-Host ("`r`nTotal Pages {0} for Loop {1}`r`n" -f $UnlinkedPages.Count, $LoopRun);

    foreach ($UnlinkedPage in $UnlinkedPages) {
        $Counter++;
        Write-Host ("{0} | {1} | {2} | {3} | {4}" -f ($UnlinkedPage.CREATION.date|ConvertFrom-OADate), ($UnlinkedPage.CHANGE.date|ConvertFrom-OADate), $LoopRun, $Counter, $UnlinkedPage.headline);
        Remove-MSPage -PageGUID ($UnlinkedPage.guid) -ForceDelete2910 ($true) -ForceDelete2911 ($true);
    }

    Find-MSSpecialPages -PageType ("unlinked") -ResultSize 10000;
    $UnlinkedPages = ([xml](Get-MSSessionProperty -Name ("LastResponse"))).SelectNodes("IODATA/PAGES/PAGE");

}

$EndDate = Get-Date;

Write-Host ("`r`nStart @ {0} | End @ {1}`r`n" -f $StartDate, $EndDate);

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;