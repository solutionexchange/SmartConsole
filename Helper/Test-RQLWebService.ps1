# Version 0.1.1

Register-MSConfigStore;
Set-MSConfigDebugMode -Value ($false); # $true oder $false

#$WSMSession = ("Test"); # Alternativ weglassen - siehe weiter unten - dann wird automatisch Default genommen
#$WSMUsername = ("Admin");
# GUID des Projektes im Format 09dd6c35-ad5d-4905-ab0f-4fbc0a37f61c oder 09DD6C35AD5D4905AB0F4FBC0A37F61C
#$WSMProjectGUID = ("09dd6c35-ad5d-4905-ab0f-4fbc0a37f61c");
#$WSMUrl = ("https://cms-admin.wf-de.vodafone.com/cms/WebService/RqlWebService.svc?WSDL");

#Register-MSSession -SessionName ($WSMSession) -Uri ($WSMUrl); # SessionName = Test
Register-MSSession -UseDefaults ($true); # SessionName = Default

#Select-MSSession -SessionName ($WSMSession); # für SessionName = Test
Select-MSSession -UseDefaults ($true);
Enter-MSSession -UseDefaults ($true);

#Enter-MSProject -ProjectGUID ($WSMProjectGUID);

Get-MSAllApplicationServers;
$AllApplicationServers = ([xml](Get-MSSessionProperty -Name ("LastResponse"))).SelectNodes("IODATA/EDITORIALSERVERS/EDITORIALSERVER");

#Get-MSAllUsers;
Get-MSAllLoggedOnUsers;
$AllLoggedOnUsers = ([xml](Get-MSSessionProperty -Name ("LastResponse"))).SelectNodes("IODATA/USERS/USER");


#Get-UserOfProject -ProjectGUID ($WSMProjectGUID);


#Get-AsyncQueueProcessList;
#Get-AsyncQueueProcessList -UseSession ($true);
#Get-AsyncQueueProcessList -ProjectGUID ($WSMProjectGUID);
#Get-AsyncQueueProcess -ProcessGUID ("9EE71CE6AB144FF3BABCCD9E75E8248A");
#Start-AsyncQueueProcess -ProcessGUID ("9EE71CE6AB144FF3BABCCD9E75E8248A");

<#
Get-AllProjectVariants;
Get-ProjectData;

New-Page;
Get-PagePreview;

Get-CategoryData;
Get-CategoryKeywords;
Get-KeywordData;
Get-ProjectCategories;
Get-ProjectCategoriesKeywords;
Get-ProjectKeywords;
Remove-Category;
Remove-Keyword;
Rename-Category;
Rename-Keyword;
New-Category;
New-Keywords;
Set-KeywordAssignment;

Get-ContentClassAllProperties;
Get-ContentClassData;
Get-ContentClassDisplayFormat;
Get-ContentClasses;
Get-ContentClassFolders;
Get-ContentClassProjectVariants;
Get-ContentClassTemplates;

#>

#<#
foreach ($LoggedOnUser in $AllLoggedOnUsers) {
    $LoggedOnServer = ($AllApplicationServers | Where-Object {$_.guid -eq $LoggedOnUser.serverguid}).name;
    Write-Output ("User {0} logged on at {1}." -f $LoggedOnUser.name, $LoggedOnServer);
}
#>

Write-Output ("Total Accounts: {0}" -f $AllLoggedOnUsers.Count);


<#
Write-Output ("`r`nRequest:");
(Get-CmsSessionProperty -Name ("LastRequest"))|Format-RQL; # Optional
Write-Output ("`r`nResponse:")
(Get-CmsSessionProperty -Name ("LastResponse"))|Format-RQL; # Optional 
Write-Output ("`r`n");
#>

#Show-MSSession; # Optional
Exit-MSSession -UseDefaults ($true);
Unregister-MSSession -UseDefaults ($true);

Unregister-MSConfigStore;