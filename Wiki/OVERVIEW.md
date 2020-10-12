# Overview

about **SmartConsole for Web Site Management** (Release 16.0 and also 11.2).



## Functions

### Management Server

*Note: * marks all aliases of a command.*



------



#### General

##### Configuration store management

- `Register-MSConfigStore` | 
  `Register-CMSConfigStore` *
- `Unregister-MSConfigStore` | 
  `Unregister-CMSConfigStore` *
- `Show-MSConfigStore` | 
  `Show-CMSConfigStore` *
- `Clear-MSConfigStore` | 
  `Clear-CMSConfigStore` *
- `Set-MSConfigActiveSession` | 
  `Set-CMSConfigActiveSession` *
- `Get-MSConfigActiveSession` | 
  `Get-CMSConfigActiveSession` *





##### Session management

- `Register-MSSession` | 
  `Register-CMSSession` *
- `Select-MSSession` | 
  `Select-CMSSession` *
- `Unregister-MSSession` | 
  `Unregister-CMSSession` *
- `Clear-MSSession` | 
  `Clear-CMSSession` *
- `Show-MSSession` | 
  `Show-CMSSession` *
- `Set-MSSessionProperty` | 
  `Set-CMSSessionProperty` *
- `Get-MSSessionProperty` | 
  `Get-CMSSessionProperty` *
- `Import-MSSessionProperties` | 
  `Import-CMSSessionProperties` *
- `Get-MSSessionWebService` | 
  `Get-CMSSessionWebService` *
- `Set-MSTimestamp` | 
  `Set-CMSTimestamp ` *




##### Communication

- `Invoke-MSRQLRequest` | 
  `Invoke-CMSRQLRequest ` *




##### Debugging

- `Set-MSConfigDebugMode` | 
  `Set-CMSConfigDebugMode` *
- `Get-MSConfigDebugMode` | 
  `Get-CMSConfigDebugMode` *
- `Show-MSSessionWebServiceDebug` | 
  `Show-CMSSessionWebServiceDebug` *




##### Configuration files

- `configuration.xml` used for "default settings".
- `configuration.xml.sample`



------



#### Basics

##### Logon and Logout

- `Enter-MSSession` | 
  `Enter-CMSSession ` *
- `Exit-MSSession` | 
  `Exit-CMSSession` *





##### Page preview

- `Get-MSPagePreview` | 
  `Get-CMSPagePreview` *



------



#### Tools and Helper

##### Conversion

- `ConvertFrom-OADate`
- `ConvertFrom-RQLGuid`
- `ConvertTo-Boolean`
- `ConvertTo-RQLGuid`





##### Format output

- `Format-RQL`
- `Format-XML`
- `Write-CHost`





##### Default configuration

- `Set-Configuration`
- `Get-Configuration`





##### Credentials management

- `Set-SecurePasswordFile`
- `Get-SecurePasswordFile`





##### Script helper

- `Get-ScriptDirectory`
- `Set-Pause`



------



#### Search

##### Special Pages

- `Find-MSSpecialPages` | 
  `Find-CMSSpecialPages` *



------



#### Server Manager

The RQL queries described in the Server Manager section allow you to adjust settings for all relevant servers. The majority of these settings are also available in the Management Server user interfaces via the Server Manager. Special attention has been given to the following subject areas, which are handled in the Users section: Directory Services, Users, and Groups.

The following topics are covered:




##### Application Server

The application server is the server where the Management Server software is installed. You use it to archive and administer all files, projects, user data, content classes, and so on.

- `Get-MSAllApplicationServers` | 
  `Get-CMSAllApplicationServers` *





##### Asynchronous Processes

The application server does not process all RQL queries synchronously. Asynchronous processes are triggered during the execution of some RQL statements. Because these processes can take a great deal of time (such as uploading a large image file), they run in the background. In these processes, the application server sends a response immediately after receiving the RQL statement, before the actions initiated by the query are complete.

Therefore, the server response for an asynchronous process confirms neither completion nor success of the corresponding action; it merely indicates that the process has started.

RQL queries that are based directly on the results of asynchronous processes may deliver incorrect results. You should take this into account when creating scripts with several steps.

- `Get-MSAsyncQueueProcess` | 
  `Get-CMSAsyncQueueProcess` *
- `Get-MSAsyncQueueProcessList` | 
  `Get-CMSAsyncQueueProcessList` *
- `Start-MSAsyncQueueProcess` | 
  `Start-CMSAsyncQueueProcess` *



------



#### Users

The *Users* section describes queries that you use to administer users and groups. The user and group data is maintained project-independently on the application server and can then be assigned to Management Server projects. You configure these settings, which are relevant for all servers, in the Server Manager in the Management Server user interface.

The following topics are covered:




##### Users - General

You can administer and edit the user data from all Management Server projects centrally.

- `Get-MSAllUsers` | 
  `Get-CMSAllUsers` *
- `Get-MSAllLoggedOnUsers` | 
  `Get-CMSAllLoggedOnUsers` *





##### Users - Project-Specific

Enables you to administer the user data for one or more projects.

- `Get-MSUserOfProject` | 
  `Get-CMSUserOfProject` *
- `Get-MSUserRoleOfProject` | 
  `Get-CMSUserRoleOfProject` *



------



#### Projects

The *Projects* section describes RQL queries used for general project configuration and administration.

The following topics are covered:




##### Projects - General

You can create, rename, copy, export, import, and delete projects.

- `Enter-MSProject` | 
  `Enter-CMSProject` *
- `Get-MSProjectData` | 
  `Get-CMSProjectData` *
- `Get-MSAllProjects` | 
  `Get-CMSAllProjects` *





##### Project variants

As soon as you create a new project, Management Server creates a project variant named "HTML". You can use other project variants to define the output format you want to use to publish the pages of a project (such as HTML, XML, SGML).

You can split a project based on the project variants and assign it to specific other areas of the project, or prohibit multi-format publication starting with a specific link.

- `Get-MSAllProjectVariants` | 
  `Get-CMSAllProjectVariants` *





##### Folders and Files

You use folders to store the text, image, HTML and media data of a project, along with its *Content Classes*. One Content Class Folder, and two File Folders are created by default for a project.

There are different types of folders like File Folders, Content Class Folders, Asset Managers, a.s.o.

- `Get-MSContentClassFolders` | 
  `Get-CMSContentClassFolders` *



------



#### Content, Pages and Elements

The *Content/Pages/Elements* section describes RQL queries for the editorial components of a project. The elements and the notes are discussed here only as they relate to pages. Other queries that pertain to elements and notes can be found in the section entitled *Content Classes*.

The following topics are covered:




##### Pages

- `New-MSPage` | 
  `New-CMSPage` *
- `Remove-MSPage` | 
  `Remove-CMSPage` *



------



#### Content Classes

The *Content Classes* section describes queries that you use to administer and edit content classes. The elements and the notes are discussed here only as they relate to content classes. Additional RQL queries for elements and notes are located in section *Content/Pages/Elements*.

The following topics are covered:




##### Content Classes - General

Content classes identify an object class used for storing content. They are the basis of every page in Management Server and represent the foundation of a project. Template identifies the content class format, for example, HTML - the code used to enter elements in the content class.

- `Get-MSContentClasses` | 
  `Get-CMSContentClasses` *
- `Get-MSContentClassData` | 
  `Get-CMSContentClassData` *
- `Get-MSContentClassAllProperties` | 
  `Get-CMSContentClassAllProperties` *
- `Get-MSContentClassProjectVariants` | 
  `Get-CMSContentClassProjectVariants` *





##### Templates

A content class can have several templates. The content class represents the basic structure of a page, which can be published in various formats. The templates contain the various codes, which allow you to publish projects in various formats, such as HTM, WML, or SGML.

- `Get-MSContentClassDisplayFormat` | 
  `Get-CMSContentClassDisplayFormat` *
- `Get-MSContentClassTemplates` | 
  `Get-CMSContentClassTemplates` *



------



#### Categories and Keywords

This section describes RQL queries for categories and keywords.

The following topics are covered:




##### Categories

You can assign categories and keywords to the pages of a project. Categories are superordinate divisions that help you to administer keywords. Every keyword must be assigned to a category.

This allows you, for example, to use the structural element List to create a list of links to pages that all contain the same keyword.

You can also define the maximum number of pages that will be displayed in the list. You can also use keywords to find specific pages of a particular topic. To be able to assign categories and keywords, you first need to create them. Categories and keywords can be renamed or deleted.

- `New-MSCategory` | 
  `New-CMSCategory` *
- `Get-MSCategoryData` | 
  `Get-CMSCategoryData` *
- `Rename-MSCategory` | 
  `Rename-CMSCategory` *
- `Get-MSProjectCategories` | 
  `Get-CMSProjectCategories` *
- `Get-MSProjectCategoriesKeywords` | 
  `Get-CMSProjectCategoriesKeywords` *
- `Remove-MSCategory` | 
  `Remove-CMSCategory` *





##### Keywords

You can assign categories and keywords to the pages of a project. Categories are superordinate divisions that help you to administer keywords. Every keyword must be assigned to a category.

This allows you, for example, to use the structural element List to create a list of links to pages that all contain the same keyword.  You can also define the maximum number of pages that will be displayed in the list. You can also use keywords to find specific pages of a particular topic. To be able to assign categories and keywords, you first need to create them. Categories and keywords can be renamed or deleted.

- `New-MSKeywords` | 
  `New-CMSKeywords` *
- `Get-MSKeywordData` | 
  `Get-CMSKeywordData` *
- `Get-MSCategoryKeywords` | 
  `Get-CMSCategoryKeywords` *
- `Get-MSProjectKeywords` | 
  `Get-CMSProjectKeywords` *
- `Remove-MSKeyword` | 
  `Remove-CMSKeyword` *
- `Rename-MSKeyword` | 
  `Rename-CMSKeyword` *
- `Set-MSKeywordAssignment` | 
  `Set-CMSKeywordAssignment` *



------



#### Publication

The "Publication/Export" section describes RQL queries that you use to administer the publication and subsequent export of projects and pages.

The following topics are covered:



##### Publication Packages

This section deals with queries involving publication packages. A publication package consists of several publication settings, one for each combination of language variant and project variant. Each publication setting defines where the content of a folder and the generated pages will be published. To do so, you can assign a publication folder to each folder and the virtual folder of generated pages. You can also assign several publication targets to each publication setting. The publishing process then includes all the publication targets.

The publication package on the project node provides the publication settings for the start page and, at the same time, serves as the default setting for all links that do not have their own publication packages.

- `Get-MSProjectPublicationPackages` | 
  `Get-CMSProjectPublicationPackages` *
- `Get-MSPublicationPackageReferenceList` | 
  `Get-MSPublicationPackageReferenceList` *
- `Get-MSPublicationPackageInformationData` |
  `Get-MSPublicationPackageInformationData` *
- `Set-MSPublishingTargetForPublicationCombination` |
  `Set-CMSPublishingTargetForPublicationCombination` *

##### Publishing Targets

This section deals with queries involving publishing targets. A publishing target is a target (filepath, ftp, sftp, etc.) where data is published to. Publishing targets are assigned to publishing packages

- `Get-MSPublicationTargetData` | 
  `Get-CMSPublicationTargetData` *
- `Get-MSPublishingTargets` | 
  `Get-CMSPublishingTargets` *
- `New-MSSftpPublicationPackage` |
  `New-CMSSftpPublicationPackage` *

------



## Scripts

`..\Scripts\`

### Management Server

#### System management



##### Maintenance

- `Start-RemoveUnlinkedPagesFromProject.ps1`
- `Get-AllContentClassesWithoutProjectVariantAssignment.ps1`
- `Get-AllProjectPublicationPackagesWithoutReferences.ps1`
- `Measure-PagePreviewPerformance.ps1`
- `Get-AllContentClassesInEditing.ps1`
- `Get-AllContentClassesWithNElements.ps1`
- `Set-PublishingTargets.ps1`





##### Processes

- `Get-AllAsyncProcesses.ps1`
- `Get-AllAsyncProcessesCurrentlyRunning.ps1`
- `Get-AllAsyncProcessesCurrentlyRunningOnEachServer.ps1`
- `Get-AllAsyncProcessesWaiting.ps1`
- `Get-AllAsyncProcessesOfProject.ps1`
- `Get-AllAsyncProcessesOfProjectCurrentlyRunning.ps1`
- `Get-AllAsyncProcessesOfProjectWaiting.ps1`
- `Start-AsyncProcess.ps1`




##### Projects

- `Get-AllProjects.ps1`
- `Get-AllProjectsExtendedInfo.ps1`
- `Get-AllProjectsForUser.ps1`


##### Reports
You can use the `SmartConsoleReporting.psm1` file to import all modules
suitable for reporting

The report scripts are used to generate HTML reports from other CMDlets.
There is a single PowerShell script 'Send-MaintenanceReport' that
accepts any value for the `$ReportData` parameter, which is then rendered 
into an HTML page, which means you must ensure that '$ReportData' can also be rendered.
 

###### Generating a report
To generate a report, create a new generator in '/Scripts/Reports/Generators'.
and give them an easily identifiable name, such as `{CMD-LET-USED-FOR-REPORT}-Report`.
In the report generator, call up the CMDLet for which you want to create a report
and modify it to your needs

Current generators are

- `Get-AllContentClassesInEditingReport.ps1`
- `Get-AllContentClassesWithNElementsReport.ps1`
- `Get-PagePreviewPerformanceReport.ps1`
- `Set-PublishingTargetsReport.ps1`

###### Templates
The templates folder contains HTML templates that will be used to generate the report.
For all reports the HTML templates inside `Base` will be used as a template
If you need specific report data add a folder with the CMDlet name you want to create a report for
and add a `PreContent.html` or `PostContent.html` which will then be added before/after the generated HTML
inside your Generator

###### Sending emails
Once you created all generators and templates you can use the `Send-MaintenanceReport` cmdlet
to send the report to either a text output (by using the `-AsPlainText` parameter) or email

Please make sure that you have a correct `mail.config.json` since that file will be used
to send an email

One example to generate a report for retrieving all content classes which are in editing is

`Send-MaintenanceReport -Recipients ("recipient@vodafone.com") -ReportName "Get-
AllContentClassesInEditing" -ReportData (Get-AllContentClassesInEditingReport)

or

`Send-MaintenanceReport -Recipients ("recipient@vodafone.com") -ReportName "Get-
AllContentClassesInEditing" -ReportData (Get-AllContentClassesInEditingReport) -AsPlainText | Out-File "C:\inediting.html"`

to send the output to a file instead.

##### Users

- `Get-AllLoggedOnUsersOnEachServer.ps1`
- `Get-AllLoggedOnUsersWithServername.ps1`
- `Get-AllUsersOfProject.ps1`
- `Get-AllUsersOnSystem.ps1`
- `Get-AllUsersOnSystemSortByID.ps1`
