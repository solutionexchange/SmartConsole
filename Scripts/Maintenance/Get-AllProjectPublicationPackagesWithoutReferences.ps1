Register-MSConfigStore;

Set-MSConfigDebugMode -Value ($false); # $true oder $false

# GUID des Projektes im Format 09dd6c35-ad5d-4905-ab0f-4fbc0a37f61c oder 09DD6C35AD5D4905AB0F4FBC0A37F61C
#$WSMProjectGUID = ("072d6659-a806-425b-aca8-d29f37fd6e7d"); # Vodafone Internet
#$WSMProjectGUID = ("8c681c01-ece4-4fc8-b1fb-45c4a7760501"); # Vodafone Intranet
#$WSMProjectGUID = ("8A300F4B74AA4D4CB5C54C2165FC56D1"); # Shared Components - Simplicity
#$WSMProjectGUID = ("6A89CD93325D42FD81A42FA836547016"); # vodafone Internet - Fachhandel Online
$WSMProjectGUID = ("7C503F8E943E4E6CACE63B2DEB82BBF4"); # Development - Defects and Testing

Register-MSSession -UseDefaults ($true);
Select-MSSession -UseDefaults ($true);
Enter-MSSession -UseDefaults ($true);

Enter-MSProject -ProjectGUID ($WSMProjectGUID) | Out-Null;

#(Get-MSSessionProperty -Name ("Proxy")).Timeout; # Show Default 100000 = 100 Seconds
(Get-MSSessionProperty -Name ("Proxy")).Timeout = 600000; # Set new value to 600000 = 600 Seconds

$PublicationPackagesNoReference = @();

$CounterCurrent = 0;
$CounterNotInUse = 0;
$ValuePercentComplete = 0;
Write-Progress -Activity ("Working...") -PercentComplete ($ValuePercentComplete) -CurrentOperation ("{0}% complete" -f [math]::Round($ValuePercentComplete)) -Status ("Please wait - collecting data.");
$AllProjectPublicatioNPackages = (Get-MSProjectPublicationPackages).SelectNodes("IODATA/EXPORTPACKETS/EXPORTPACKET");

$WorkingStep = (95 / ($AllProjectPublicatioNPackages.guid).Count);

$ValuePercentComplete = 5;
Write-Progress -Activity ("Working...") -PercentComplete ($ValuePercentComplete) -CurrentOperation ("{0}% complete" -f [math]::Round($ValuePercentComplete)) -Status ("Please wait - found {0} publication packages. Go to next step." -f ($AllProjectPublicatioNPackages.guid).Count);

foreach ($PublicationPackage in $AllProjectPublicatioNPackages) {
    $CounterCurrent++;
    Write-Progress -Activity ("Working... (Checking publication package {1} of {0} | Found {2} publication package without references)" -f ($AllProjectPublicatioNPackages.guid).Count, $CounterCurrent, $CounterNotInUse) -PercentComplete ($ValuePercentComplete) -CurrentOperation ("{0}% complete" -f [math]::Round($ValuePercentComplete)) -Status ("Please wait - determining references for publication package: {0}." -f $PublicationPackage.name);
    $AllReferences = (Get-MSPublicationPackageReferenceList -PackageGUID ($PublicationPackage.guid)).SelectNodes("IODATA/REFERENCES/REFERENCE");
    if (($AllReferences.value).Count -eq 0) {
        $PublicationPackagesNoReference += $PublicationPackage;
        $CounterNotInUse++;
    }
    $ValuePercentComplete += $WorkingStep;
}

Write-Progress -Activity ("Finished...") -PercentComplete ($ValuePercentComplete) -CurrentOperation ("{0}% complete" -f [math]::Round($ValuePercentComplete)) -Status ("Please wait - Sending output to console.");

$PublicationPackagesNoReference; # Optional - Output to console
#$PublicationPackagesNoReference | Out-File -FilePath ("C:\Temp\Result-PublicationPackagesNoReference-{0}.txt" -f $WSMProjectGUID) -Encoding ("utf8") -Force; # Optional - Output to file

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;