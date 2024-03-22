---
title: How to reinitialize the offline files cache and database in Windows XP
description: Provides two methods to reinitialize the offline files cache and database.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:folder-redirection-and-offline-files-and-folders-csc, csstroubleshoot
---
# How to reinitialize the offline files cache and database in Windows XP

This article provides two methods to reinitialize the offline files cache and database in Windows XP.

_Applies to:_ &nbsp; Windows XP  
_Original KB number:_ &nbsp; 230738

## Summary

The Offline Files (CSC or Client Side Caching) cache and database has a built-in capability to restart if its contents are suspected of being corrupted. If corruption is suspected, the Synchronization Wizard may return the following error message:
> Unable to merge offline changes on \\\\**server_name**\\**share_name**. The parameter is incorrect.

## More Information

### Method 1

The Offline Files cache is a folder structure located in the %SystemRoot%\CSC folder, which is hidden by default. The CSC folder, and any files and subfolders it contains, should not be modified directly; doing so can result in data loss and a complete breakdown of Offline Files functionality.

If you suspect corruption in the database, then the files should be deleted using the Offline Files viewer. After the files are deleted out of the Offline Files viewer, a synchronization of files may then be forced using Synchronization Manager. If the cache still does not appear to function correctly, an Offline Files reset can be performed using the following procedure:

1. In **Folder Options**, on the **Offline Files** tab, press CTRL+SHIFT, and then click **Delete Files**. The following message appears:
    > The Offline Files cache on the local computer will be re-initialized. Any changes that have not been synchronized with computers on the network will be lost. Any files or folders made available offline will no longer be available offline. A computer restart is required.

    Do you wish to reinitialize the cache?

2. Click Yes two times to restart the computer.

### Method 2

#### Use Registry Editor

If you cannot access the **Offline Files**  tab, use this method to reinitialize the Offline Files (CSC) cache on the system by modifying the registry. Use this method also to reinitialize the offline files database/client-side cache on multiple systems. Add the following registry subkey: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\NetCache`  
Key Name: FormatDatabase  
Key Type: DWORD  
Key Value: 1

> [!NOTE]
> The actual value of the registry key is ignored. This registry change requires a restart. When the computer is restarting, the shell will re-initialize the CSC cache, and then delete the registry key if the registry entry exists.

> [!WARNING]
> All cache files are deleted and unsynchronized data is lost.

#### Use Reg.exe

You can also automate the process of setting this registry value by using the Reg.exe command line editor. To do this, type the following command in the Reg.exe window:

```console
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\NetCache" /v FormatDatabase /t REG_DWORD /d 1 /f
```

> [!NOTE]
> For specific steps to re-initialize the offline files cache and database in Windows Vista or Windows 7, click the following article number to view the article in the Microsoft Knowledge Base:  
[942974](https://support.microsoft.com/help/942974) On a Windows Vista or Windows 7-based client computer, you can still access offline files even though the file server is removed from the network.
