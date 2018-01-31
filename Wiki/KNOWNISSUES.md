# Known Issues

about **SmartConsole for Web Site Management** (Release 16.0 and also 11.2).



## v0.1.8 - 2018-01-31

#### Logon or Script failed

If a logon failed within a script, a restart of the script is not possible. Until the following commands are executed:

```powershell
PS ..\SmartConsole> Exit-MSSession
PS ..\SmartConsole> Unregister-MSSession
PS ..\SmartConsole> Unregister-MSConfigStore
```



#### PowerShell Edition and Version

- Currently only PowerShell version 4.0 or higher *(up to 5.1)* is supported.
- The necessary PowerShell edition is "Desktop".
- The new "Core" edition *(version 6.0 or newer)* is currently not supported.

