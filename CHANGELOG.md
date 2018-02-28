# Changelog

about **SmartConsole for Web Site Management** (Release 16.0 and also 11.2).



## v0.2.5 - 2018-02-28

### New Features

- New script `Get-AllUsersOfProject.ps1` with `| Format-List` or `| Format-Table` support.

- New function `Get-MSUserRoleOfProject.ps1`.
  ​

### Breaking changes

- Read the [BREAKINGCHANGES.md](Wiki/BREAKINGCHANGES.md) document for more information.
  ​



### General cmdlet updates and fixes

- Fix for DebugMode at all functions.
  ​



### Overview

- Read the [OVERVIEW.md](Wiki/OVERVIEW.md) document for more information.
  ​



### FAQ

- Read the [FAQ.md](Wiki/FAQ.md) document for more information.
  ​



### Known Issues

- Read the [KNOWNISSUES.md](Wiki/KNOWNISSUES.md) document for more information.
  ​

------



## v0.2.4 - 2018-02-06

### Breaking changes

- Read the [BREAKINGCHANGES.md](Wiki/BREAKINGCHANGES.md) document for more information.





### Engine updates and fixes

- Added to all RQL-Queries  `dialoglanguageid='[!dialog_language_id!]'`.





### General cmdlet updates and fixes

- Added the `| ConvertFrom-OADate` function to all date issues.





### Overview

- Read the [OVERVIEW.md](Wiki/OVERVIEW.md) document for more information.





### FAQ

- Read the [FAQ.md](Wiki/FAQ.md) document for more information.





### Known Issues

- Read the [KNOWNISSUES.md](Wiki/KNOWNISSUES.md) document for more information.




------



## v0.2.3 - 2018-02-06

### Breaking changes

- Read the [BREAKINGCHANGES.md](Wiki/BREAKINGCHANGES.md) document for more information.





### General cmdlet updates and fixes

- Revision of all scripts for performance optimization.
- Optimization of the scripts for pipeline functions like `| Format-Table` or `| Format list` etc.





### Code Cleanup

- Optimization of the functions for output performance.
- Optimization of the RQL-Requests to the backend and aggregation of multiple requests within some scripts.





### Overview

- Read the [OVERVIEW.md](Wiki/OVERVIEW.md) document for more information.





### FAQ

- Read the [FAQ.md](Wiki/FAQ.md) document for more information.





### Known Issues

- Read the [KNOWNISSUES.md](Wiki/KNOWNISSUES.md) document for more information.




------



## v0.2.2 - 2018-02-06

### New Features

- New script `Get-AllProjectsExtendedInfo.ps1` with `| Format-List` or `| Format-Table` support.
- New script `Get-AllProjectsForUser.ps1` with `| Format-List` or `| Format-Table` support.





### Breaking changes

- Read the [BREAKINGCHANGES.md](Wiki/BREAKINGCHANGES.md) document for more information.





### Engine updates and fixes

- Revision of the way how to get return values.





### General cmdlet updates and fixes

- Revision of all scripts to the adapted functionality.
- Optimization of the scripts for pipeline functions like `| Format-Table` or `| Format list` etc.





### Code Cleanup

- Optimization of queries for speed.





### Documentation, Graphics and Help Content

- Updated `OVERVIEW.md` with the new scripts.





### Overview

- Read the [OVERVIEW.md](Wiki/OVERVIEW.md) document for more information.





### FAQ

- Read the [FAQ.md](Wiki/FAQ.md) document for more information.





### Known Issues

- Read the [KNOWNISSUES.md](Wiki/KNOWNISSUES.md) document for more information.




------



## v0.2.1- 2018-02-05

### Breaking changes

- Read the [BREAKINGCHANGES.md](Wiki/BREAKINGCHANGES.md) document for more information.





### Test, Build and Packaging Improvements

- Removed some files from private store.





### Overview

- Read the [OVERVIEW.md](Wiki/OVERVIEW.md) document for more information.





### FAQ

- Read the [FAQ.md](Wiki/FAQ.md) document for more information.





### Known Issues

- Read the [KNOWNISSUES.md](Wiki/KNOWNISSUES.md) document for more information.




------



## v0.2.0 - 2018-02-05

### New Features

- Add new function `Get-MSAllProjects`
- New script `Get-AllProjects.ps1` with `| Format-List` or `| Format-Table` support.





### Breaking changes

- Read the [BREAKINGCHANGES.md](Wiki/BREAKINGCHANGES.md) document for more information.





### Test, Build and Packaging Improvements

- Fix module version number to `0.2.0` for this release. ([#2](https://github.com/solutionexchange/SmartConsole/issues/2))





### Documentation, Graphics and Help Content

- Update `OVERVIEW.md`
- Fix link issue in `README.md`  ([#1](https://github.com/solutionexchange/SmartConsole/issues/1))





### Overview

- Read the [OVERVIEW.md](Wiki/OVERVIEW.md) document for more information.





### FAQ

- Read the [FAQ.md](Wiki/FAQ.md) document for more information.





### Known Issues

- Read the [KNOWNISSUES.md](Wiki/KNOWNISSUES.md) document for more information.




------



## v0.1.9 - 2018-02-01


### Breaking changes

- Read the [BREAKINGCHANGES.md](Wiki/BREAKINGCHANGES.md) document for more information.





### Test, Build and Packaging Improvements

- Fix import issue, after reorganization into subdirectories.





### Documentation, Graphics and Help Content

- Fix of some display and link errors in the documentation files.




### Overview

- Read the [OVERVIEW.md](Wiki/OVERVIEW.md) document for more information.





### FAQ

- Read the [FAQ.md](Wiki/FAQ.md) document for more information.





### Known Issues

- Read the [KNOWNISSUES.md](Wiki/KNOWNISSUES.md) document for more information.




------



## v0.1.8 - 2018-01-31

### New Features

- New aliases added per command, MS=CMS and DS=CPS. For more details, please have a look into the [OVERVIEW.md](Wiki/OVERVIEW.md) document.





### Breaking changes

- Read the [BREAKINGCHANGES.md](Wiki/BREAKINGCHANGES.md) document for more information.





### General cmdlet updates and fixes

- Add *session GUID* at output for script:
  - `Get-AllLoggedOnUsersOnEachServer.ps1`
  - `Get-AllLoggedOnUsersWithServername.ps1`





### Test, Build and Packaging Improvements

- The minimum requirement for PowerShell has been reduced from 5.1 to 4.0.
- Rename all files in `\Templates\` and add suffix `.sample`.
- Reorganization of `\Public\` and `\Scripts\` directories into thematic subdirectories.





### Documentation, Graphics and Help Content

- Fix a typo in `CHANGELOG.md`.
- Add *Requirements* to `README.md`.
- Add *PowerShell Edition and Version* to `KNOWNISSUES.md`.





### Overview

- Read the [OVERVIEW.md](Wiki/OVERVIEW.md) document for more information.





### FAQ

- Read the [FAQ.md](Wiki/FAQ.md) document for more information.





### Known Issues

- Read the [KNOWNISSUES.md](Wiki/KNOWNISSUES.md) document for more information.




------



## v0.1.7 - 2018-01-29

### New Features

- New script `Get-AllUsersOnSystemSortByID.ps1` with `| Format-List` or `| Format-Table` support.





### Breaking changes

- Read the [BREAKINGCHANGES.md](Wiki/BREAKINGCHANGES.md) document for more information.





### Test, Build and Packaging Improvements

- Add package description in manifest / build file.





### Documentation, Graphics and Help Content

- Rework some parts in the document *README.md*.
- Create a `CHANGELOG.sample.md` file and add it to `\Templates\`.





### Overview

- Read the [OVERVIEW.md](Wiki/OVERVIEW.md) document for more information.





### FAQ

- Read the [FAQ.md](Wiki/FAQ.md) document for more information.





### Known Issues

- Read the [KNOWNISSUES.md](Wiki/KNOWNISSUES.md) document for more information.




------



## v0.1.6 - 2018-01-25


### Breaking changes

- Read the [BREAKINGCHANGES.md](Wiki/BREAKINGCHANGES.md) document for more information.





### General cmdlet updates and fixes

- Add *Currently logged on* output to `..\Scripts\Get-AllLoggedOnUsersWithServername.ps1`.





### Code Cleanup

- Fix a typo in `..\Scripts\Get-AllLoggedOnUsersWithServername.ps1`.
- Fix a typo in `..\Scripts\Get-AllUsersOnSystem.ps1`.





### Test, Build and Packaging Improvements

- Add a configuration.xml.sample to `..\Private\Store\` subfolder.
- Add a *CHANGELOG.md* to the package.
- Add some more documentation to `..\wiki\` subfolder:
  - *BREAKINGCHANGES.md*
  - *FAQ.md*
  - *KNOWNISSUES.md*
  - *OVERVIEW.md*





### Documentation, Graphics and Help Content

- Fix a typo in *README.md*.




### Overview

- Read the [OVERVIEW.md](Wiki/OVERVIEW.md) document for more information.





### FAQ

- Read the [FAQ.md](Wiki/FAQ.md) document for more information.




### Known Issues

- Read the [KNOWNISSUES.md](Wiki/KNOWNISSUES.md) document for more information.