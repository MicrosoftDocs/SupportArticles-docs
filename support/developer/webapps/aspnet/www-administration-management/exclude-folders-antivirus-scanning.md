---
title: Exclude folders from antivirus scanning
description: This article discusses a problem that In ASP.NET applications, certain folders must be excluded from antivirus scanning. If they are not, this might cause AppDomain to unload and then trigger performance issues.
ms.date: 04/15/2020
ms.custom: sap:Configuration
---
# Folders to exclude from antivirus scanning in ASP.NET applications

This article helps you resolve the problem that the `AppDomain` in ASP.NET applications might be unloaded when some folders aren't excluded by antivirus software.

_Original product version:_ &nbsp; ASP.NET, .NET Framework 4.8, 4.7, 4.6, 4.5.2, 3.5 Service Pack 1  
_Original KB number:_ &nbsp; 3126034

## Summary

In ASP.NET applications, certain folders should be excluded from antivirus scanning. If they are not, the scan could cause inadvertent `AppDomain` unloads, and this causes performance issues.

ASP.NET uses the `ReadDirectoryChangesW` Win32 function to monitor directories and files. In the following scenarios, the ASP.NET `AppDomain` class is unloaded:

1. The application's physical root path and all of its subdirectories are monitored for subdirectory name changes or deletions. The `AppDomain` is unloaded if any of these changes.

2. The `bin`, `App_Code`, `App_WebReferences`, `App_GlobalResources`, and `App_Browsers` subdirectories of the application root folder are monitored for creation, deletion, renaming, ACL changes, changes to the last-write time, and changes to the size. If any of these things change, the `AppDomain` is unloaded.

3. The `machine.config` and root *web.config* files are monitored for changes. A change to either of these files will unload the `AppDomain`.

4. The *web.config* file of parent applications is monitored. A change to this file will unload the `AppDomain`.

5. The *web.config* file in the application root is monitored. A change to this file will unload the `AppDomain`.

6. The `hash.web` file that's located in the hash subdirectory of the Temporary ASP.NET Files folder is monitored. This monitoring was added to support development scenarios in which both the `ClientBuildManager` and the runtime `BuildManager` are updating the application files. Because there are two build managers, there was a need to keep them in sync, and the `hash.web` file is used for that purpose.

7. The *web.config* file in any subdirectory of the application is monitored. A change to this file will unload the `AppDomain`.

8. The `App_LocalResources` subdirectory of each virtual subdirectory is monitored for creation, deletion, renaming, ACL changes, changes to the last-write time, and changes to the size. If any of these things change, the `AppDomain` is unloaded.

Based on the files and folders that are monitored, the following directories are recommended for exclusion from antivirus scanning:

- The root directory and all of its subdirectories for the ASP.NET application.
- The .NET Framework config files directory. This varies by the version of .NET Framework and on whether the ASP.NET application is running in 32-bit or 64-bit processes.
- The root directory of the ASP.NET application's parent application.
- The Temporary ASP.NET Files folder.

We also recommend that the following IIS directories be excluded from antivirus scans in ASP.NET applications:

- `%systemroot%\System32\inetsrv\config`
- `%systemdrive%\inetpub\temp`

## More information

To avoid `AppDomain` unloads, disable `FCNMode` (FCN stands for File Change Notification). For information about how to disable `FCNMode`, see [ASP.NET 2.0-connected applications on a website may appear to stop responding](https://support.microsoft.com/help/911272). However, disabling FCNMode is not recommended.
