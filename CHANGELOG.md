# Changelog

about **SmartConsole for Web Site Management** (Release 16.0 and also 11.2).



## v0.1.8 - 2018-01-31

### New Features

- New aliases added per command, MS=CMS and DS=CPS. For more details, please have a look into the [OVERVIEW.md](Wiki\OVERVIEW.md) document.





### Breaking changes

- Read the [BREAKINGCHANGES.md](\wiki\BREAKINGCHANGES.md) document for more information.





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

- Read the [OVERVIEW.md](\wiki\OVERVIEW.md) document for more information.





### FAQ

- Read the [FAQ.md](\wiki\FAQ.md) document for more information.





### Known Issues

- Read the [KNOWNISSUES.md](\wiki\KNOWNISSUES.md) document for more information.




------



## v0.1.7 - 2018-01-29

### New Features

- New script `Get-AllUsersOnSystemSortByID.ps1` with `| Format-List` or `| Format-Table` support.





### Breaking changes

- Read the [BREAKINGCHANGES.md](\wiki\BREAKINGCHANGES.md) document for more information.





### Test, Build and Packaging Improvements

- Add package description in manifest / build file.





### Documentation, Graphics and Help Content

- Rework some parts in the document *README.md*.
- Create a `CHANGELOG.sample.md` file and add it to `\Templates\`.





### Overview

- Read the [OVERVIEW.md](\wiki\OVERVIEW.md) document for more information.





### FAQ

- Read the [FAQ.md](\wiki\FAQ.md) document for more information.





### Known Issues

- Read the [KNOWNISSUES.md](\wiki\KNOWNISSUES.md) document for more information.




------



## v0.1.6 - 2018-01-25


### Breaking changes

- Read the [BREAKINGCHANGES.md](\wiki\BREAKINGCHANGES.md) document for more information.





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

- Read the [OVERVIEW.md](\wiki\OVERVIEW.md) document for more information.





### FAQ

- Read the [FAQ.md](\wiki\FAQ.md) document for more information.




### Known Issues

- Read the [KNOWNISSUES.md](\wiki\KNOWNISSUES.md) document for more information.