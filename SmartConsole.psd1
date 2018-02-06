#
# Modulmanifest für das Modul "SmartConsole"
#
# Generiert von: Thomas Pollinger
#
# Generiert am: 06.02.2018
#

@{

# Die diesem Manifest zugeordnete Skript- oder Binärmoduldatei.
RootModule = '.\SmartConsole.psm1'

# Die Versionsnummer dieses Moduls
ModuleVersion = '0.2.4'

# Unterstützte PSEditions
CompatiblePSEditions = 'Desktop'

# ID zur eindeutigen Kennzeichnung dieses Moduls
GUID = '382987ca-c990-4633-a398-07a50089a2f9'

# Autor dieses Moduls
Author = 'Thomas Pollinger'

# Unternehmen oder Hersteller dieses Moduls
CompanyName = 'OpenText Web Solutions Usergroup e.V. (OWUG)'

# Urheberrechtserklärung für dieses Modul
Copyright = '(c) 2018 Thomas Pollinger. Alle Rechte vorbehalten.'

# Beschreibung der von diesem Modul bereitgestellten Funktionen
Description = 'PowerShell Module Wrapper for OpenText Web Site Management and Delivery Server (RedDot CMS & CPS).'

# Die für dieses Modul mindestens erforderliche Version des Windows PowerShell-Moduls
PowerShellVersion = '4.0'

# Der Name des für dieses Modul erforderlichen Windows PowerShell-Hosts
# PowerShellHostName = ''

# Die für dieses Modul mindestens erforderliche Version des Windows PowerShell-Hosts
# PowerShellHostVersion = ''

# Minimum version of Microsoft .NET Framework required by this module. Diese Voraussetzung gilt nur für die Desktop-Edition von PowerShell.
DotNetFrameworkVersion = '4.6.1'

# Minimum version of the common language runtime (CLR) required by this module. Diese Voraussetzung gilt nur für die Desktop-Edition von PowerShell.
# CLRVersion = ''

# Die für dieses Modul erforderliche Prozessorarchitektur ("Keine", "X86", "Amd64").
# ProcessorArchitecture = ''

# Die Module, die vor dem Importieren dieses Moduls in die globale Umgebung geladen werden müssen
# RequiredModules = @()

# Die Assemblys, die vor dem Importieren dieses Moduls geladen werden müssen
# RequiredAssemblies = @()

# Die Skriptdateien (PS1-Dateien), die vor dem Importieren dieses Moduls in der Umgebung des Aufrufers ausgeführt werden.
# ScriptsToProcess = @()

# Die Typdateien (.ps1xml), die beim Importieren dieses Moduls geladen werden sollen
# TypesToProcess = @()

# Die Formatdateien (.ps1xml), die beim Importieren dieses Moduls geladen werden sollen
# FormatsToProcess = @()

# Die Module, die als geschachtelte Module des in "RootModule/ModuleToProcess" angegebenen Moduls importiert werden sollen.
# NestedModules = @()

# Aus diesem Modul zu exportierende Funktionen. Um optimale Leistung zu erzielen, verwenden Sie keine Platzhalter und löschen den Eintrag nicht. Verwenden Sie ein leeres Array, wenn keine zu exportierenden Funktionen vorhanden sind.
FunctionsToExport = 'Clear-MSConfigStore', 'Get-MSConfigActiveSession', 
               'Register-MSConfigStore', 'Set-MSConfigActiveSession', 
               'Show-MSConfigStore', 'Unregister-MSConfigStore', 
               'Invoke-MSRQLRequest', 'Set-MSTimestamp', 'Get-MSConfigDebugMode', 
               'Set-MSConfigDebugMode', 'Clear-MSSession', 'Enter-MSSession', 
               'Exit-MSSession', 'Get-MSSessionProperty', 'Get-MSSessionWebService', 
               'Import-MSSessionProperties', 'Register-MSSession', 
               'Select-MSSession', 'Set-MSSessionProperty', 'Show-MSSession', 
               'Show-MSSessionWebServiceDebug', 'Unregister-MSSession', 
               'ConvertFrom-OADate', 'ConvertFrom-RQLGuid', 'ConvertTo-Boolean', 
               'ConvertTo-RQLGuid', 'Format-RQL', 'Format-XML', 'Get-Configuration', 
               'Get-ScriptDirectory', 'Get-SecurePasswordFile', 'Set-Configuration', 
               'Set-Pause', 'Set-SecurePasswordFile', 'Write-CHost', 
               'Get-MSPagePreview', 'Get-MSCategoryData', 'Get-MSCategoryKeywords', 
               'Get-MSKeywordData', 'Get-MSProjectCategories', 
               'Get-MSProjectCategoriesKeywords', 'Get-MSProjectKeywords', 
               'New-MSCategory', 'New-MSKeywords', 'Remove-MSCategory', 
               'Remove-MSKeyword', 'Rename-MSCategory', 'Rename-MSKeyword', 
               'Set-MSKeywordAssignment', 'Get-MSContentClassAllProperties', 
               'Get-MSContentClassData', 'Get-MSContentClassDisplayFormat', 
               'Get-MSContentClasses', 'Get-MSContentClassProjectVariants', 
               'Get-MSContentClassTemplates', 'New-MSPage', 'Remove-MSPage', 
               'Enter-MSProject', 'Get-MSAllProjects', 'Get-MSAllProjectVariants', 
               'Get-MSContentClassFolders', 'Get-MSProjectData', 
               'Find-MSSpecialPages', 'Get-MSAllApplicationServers', 
               'Get-MSAsyncQueueProcess', 'Get-MSAsyncQueueProcessList', 
               'Start-MSAsyncQueueProcess', 'Get-MSAllLoggedOnUsers', 
               'Get-MSAllUsers', 'Get-MSUserOfProject'

# Aus diesem Modul zu exportierende Cmdlets. Um optimale Leistung zu erzielen, verwenden Sie keine Platzhalter und löschen den Eintrag nicht. Verwenden Sie ein leeres Array, wenn keine zu exportierenden Cmdlets vorhanden sind.
CmdletsToExport = '*'

# Die aus diesem Modul zu exportierenden Variablen
VariablesToExport = '*'

# Aus diesem Modul zu exportierende Aliase. Um optimale Leistung zu erzielen, verwenden Sie keine Platzhalter und löschen den Eintrag nicht. Verwenden Sie ein leeres Array, wenn keine zu exportierenden Aliase vorhanden sind.
AliasesToExport = '*'

# Aus diesem Modul zu exportierende DSC-Ressourcen
# DscResourcesToExport = @()

# Liste aller Module in diesem Modulpaket
# ModuleList = @()

# Liste aller Dateien in diesem Modulpaket
# FileList = @()

# Die privaten Daten, die an das in "RootModule/ModuleToProcess" angegebene Modul übergeben werden sollen. Diese können auch eine PSData-Hashtabelle mit zusätzlichen von PowerShell verwendeten Modulmetadaten enthalten.
PrivateData = @{

    PSData = @{

        # 'Tags' wurde auf das Modul angewendet und unterstützt die Modulermittlung in Onlinekatalogen.
        # Tags = @()

        # Eine URL zur Lizenz für dieses Modul.
        # LicenseUri = ''

        # Eine URL zur Hauptwebsite für dieses Projekt.
        # ProjectUri = ''

        # Eine URL zu einem Symbol, das das Modul darstellt.
        # IconUri = ''

        # 'ReleaseNotes' des Moduls
        # ReleaseNotes = ''

    } # Ende der PSData-Hashtabelle

} # Ende der PrivateData-Hashtabelle

# HelpInfo-URI dieses Moduls
# HelpInfoURI = ''

# Standardpräfix für Befehle, die aus diesem Modul exportiert werden. Das Standardpräfix kann mit "Import-Module -Prefix" überschrieben werden.
# DefaultCommandPrefix = ''

}

