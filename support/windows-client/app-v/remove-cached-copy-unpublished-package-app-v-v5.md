---
title: How to remove a cached copy of an unpublished package in Microsoft App-V v5
description: This article describes the behavior of the APP-V client for unpublishing and explains how to remove (delete) a previously published package from the APP-V client.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, gautama
ms.custom: sap:package-conversion, csstroubleshoot
---
# How to remove a cached copy of an unpublished package in Microsoft App-V v5

This article describes how to remove a cached copy of an unpublished package in Microsoft App-V v5.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2768945

## Summary

When a previously published package is unpublished from the Microsoft Application Virtualization (App-V) Management Server, all entry points (for example, Shortcuts, FTA's, etc.) for that package are removed from the App-V client, however the cached copy of the package is not removed (deleted) from %programdata%\\App-V\\{PkGID}\\{VerID}.

Also when a new version of a previously cached package is streamed, the older version of the cache is not removed. Instead, hard links are between the package files that have remained unchanged between the different versions.

> [!NOTE]
> The folder %programdata%\\App-V is the default path for PackageInstallationRoot. To check the path run `Get-AppvClientConfiguration` and examine the value of PackageInstallationRoot.

At times, you might want to remove unpublished packages from the computer (for example, to reclaim lost disk space). You can remove packages by running the PowerShell command `Remove-AppvClientPackage`. Much like uninstall native applications, the `Remove-AppvClientPackage` must be run with administrative rights.

## More Information

`Remove-AppvClientPackage` supports the following inputs for the package:

- Name
- PackageID
- Version
- VersionID

To find the values the parameters listed above, you can make use of `Get-AppvClientPackage -All` . The output is a list of all packages that are present on the computer.

> [!Note]
>
> 1. The -All switch is needed to list the unpublished packages.
> 2. Also the publishing status is checked for the user in whose context the command is being run.
> 3. Virtual Applications which are installed via MSI should be removed from Add Remove Programs. You should not remove them by using Remove-AppvClientPackage.

From a PowerShell prompt run: `Get-AppvClientPackage -all`. It should return something similar to the following:

```powershell
PS C:\temp> Get-AppvClientPackage -All  
 
PackageId : x1x1x1x1-x1x1-x1x1-x1x1-x1x1x1x1x1x1  
VersionId : x2x2x2x2-x2x2-x2x2-x2x2-x2x2x2x2x2x2 
Name : MyVirtualPackage  
Version : 0.0.0.1  
Path : c:\temp\MyVirtualPackage.appv  
IsPublishedToUser : False  
UserPending : False  
IsPublishedGlobally : False  
GlobalPending : False  
InUse : False  
InUseByCurrentUser : False  
PackageSize : 1234567  
PercentLoaded : 100  
IsLoading : False  
HasAssetIntelligence : True  
  
PackageId : y1y1y1y1-y1y1-y1y1-y1y1-y1y1y1y1y1y1  
VersionId : y2y2y2y2-y2y2-y2y2-y2y2-y2y2y2y2y2y2  
Name : MyVirtualPackage  
Version : 0.0.0.2  
Path : c:\temp\MyVirtualPackage_2.appv  
IsPublishedToUser : False  
UserPending : False  
IsPublishedGlobally : False  
GlobalPending : False  
InUse : False  
InUseByCurrentUser : False  
PackageSize : 1234900 
PercentLoaded : 100  
IsLoading : False 
HasAssetIntelligence : True  
```

To remove the older version of the MyVirtualPackage package, run the following:

To remove a package using the PackageID, run this:

```PowerShell
Remove-AppVClientPackage - x1x1x1x1-x1x1-x1x1-x1x1-x1x1x1x1x1x1  
```

Just be sure to modify the Version and Package IDs used above so that they reflect the correct package you are trying to remove.

To remove all packages, including all Versions of all packages irrespective of their publishing status run the following:

```PowerShell
Get-AppvClientPackage -All | Remove-AppVClientPackage
```
