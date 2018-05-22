Register-MSConfigStore;

Set-MSConfigDebugMode -Value ($false); # $true oder $false

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

$AllProjectVariants = (Get-MSAllProjectVariants).SelectNodes("IODATA/PROJECTVARIANTS/PROJECTVARIANT");
$AllProjectContentClassFolders = (Get-MSContentClassFolders).SelectNodes("IODATA/TEMPLATEGROUPS/GROUP");

foreach ($ContentClassFolder in $AllProjectContentClassFolders) {
    Write-Output ("CK-Folder: [ {0} ]" -f ($ContentClassFolder.name));
    $AllContentClassesOfFolder = (Get-MsContentClasses -ContentClassFolderGUID ($ContentClassFolder.guid)).SelectNodes("IODATA/TEMPLATES/TEMPLATE");
    foreach ($ContentClass in $AllContentClassesOfFolder) {
        $Results = ("");
        $ContentClassProjectVariants = (Get-MSContentClassProjectVariants -ContentClassGUID ($ContentClass.guid)).SelectNodes("IODATA/TEMPLATE/TEMPLATEVARIANTS/TEMPLATEVARIANT");
        $Results = Compare-Object -ReferenceObject $AllProjectVariants.guid -DifferenceObject $ContentClassProjectVariants.projectvariantguid -PassThru;
        if($Results) {
            Write-Output ("   CK: {0}" -f ($ContentClass.name));
            foreach ($Result in $Results) {
                Write-Output ("       PV: {0} is missing" -f (($AllProjectVariants | Where-Object {$_.guid -eq $Result}).name));
            }
            Write-Output ("`r`n");
        }
    }
    Write-Output ("`r`n");
}

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;