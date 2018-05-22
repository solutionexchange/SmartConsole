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

$ResultArray =  @();

foreach ($ContentClassFolder in $AllProjectContentClassFolders) {
    $AllContentClassesOfFolder = (Get-MsContentClasses -ContentClassFolderGUID ($ContentClassFolder.guid)).SelectNodes("IODATA/TEMPLATES/TEMPLATE");
    foreach ($ContentClass in $AllContentClassesOfFolder) {
        $ResultObject = New-Object -TypeName PSCustomObject -Property @{
            ContentClassFolder = $ContentClassFolder.name;
            ContentClass = $ContentClass.name;
            MissingProjectVariant = @();
        }
        Write-Progress -Activity ("Working... checking content class folder: {0}." -f $ContentClassFolder.name) -Status ("Please wait - check for missing project variants at content class: {0}." -f $ContentClass.name);
        $Results = ("");
        $ContentClassProjectVariants = (Get-MSContentClassProjectVariants -ContentClassGUID ($ContentClass.guid)).SelectNodes("IODATA/TEMPLATE/TEMPLATEVARIANTS/TEMPLATEVARIANT");
        if($ContentClassProjectVariants -ne $null) {
            $Results = Compare-Object -ReferenceObject $AllProjectVariants.guid -DifferenceObject $ContentClassProjectVariants.projectvariantguid -PassThru;
            if($Results) {
                $MissingProjectVariant = @();
                foreach ($Result in $Results) {
                    $MissingProjectVariant += ($AllProjectVariants | Where-Object {$_.guid -eq $Result}).name;
                }
                $ResultObject.MissingProjectVariant = $MissingProjectVariant;
                $ResultArray += $ResultObject;
            }
        }
        else {
            $MissingProjectVariant = $AllProjectVariants.name;
            $ResultObject.MissingProjectVariant = $MissingProjectVariant;
            $ResultArray += $ResultObject;
        }
    }
}

$ResultArray | Format-Table;

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;