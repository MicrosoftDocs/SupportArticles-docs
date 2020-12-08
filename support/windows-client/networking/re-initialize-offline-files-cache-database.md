---
title: How to re-initialize the offline files cache and database in Windows XP
description: Provides two methods to re-initialize the offline files cache and database.
ms.date: 12/07/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# How to re-initialize the offline files cache and database in Windows XP

_Original product version:_ &nbsp;   
_Original KB number:_ &nbsp; 230738

## Summary

The Offline Files (CSC or Client Side Caching) cache and database has a built-in capability to restart if its contents are suspected of being corrupted. If corruption is suspected, the Synchronization Wizard may return the following error message:Unable to merge offline changes on \\ **server_name** \ **share_name**. The parameter is incorrect.

## More Information

### Method 1

The Offline Files cache is a folder structure located in the %SystemRoot%\CSC folder, which is hidden by default. The CSC folder, and any files and subfolders it contains, should not be modified directly; doing so can result in data loss and a complete breakdown of Offline Files functionality.

If you suspect corruption in the database, then the files should be deleted using the Offline Files viewer. After the files are deleted out of the Offline Files viewer, a synchronization of files may then be forced using Synchronization Manager. If the cache still does not appear to function correctly, an Offline Files reset can be performed using the following procedure:

1. In Folder Options , on the Offline Files tab, press CTRL+SHIFT, and then click Delete Files . The following message appears:The Offline Files cache on the local computer will be re-initialized. Any changes that have not been synchronized with computers on the network will be lost. Any files or folders made available offline will no longer be available offline. A computer restart is required.

Do you wish to re-initialize the cache?

2. Click Yes two times to restart the computer.

### Method 2

#### Use Registry Editor

To have us re-initialize the offline files cache and database for you, go to the "[Fix it for me](#fixitformealways)" section. If you prefer to fix this problem yourself, go to the "[Let me fix it myself](#letmefixitmyselfalways)" section.

#### Fix it for me

To fix this problem automatically, click the **Fix it** button or link. Click **Run** in the **File Download** dialog box, and follow the steps in the Fix it wizard.

Notes 
- Make sure the files are synchronized before you run the automatic fix. Otherwise, unsynchronized changes will be lost.
- The sync relationship for redirected folders will be re-created the next time group policy applies. Alternatively run gpupdate /force.
- This wizard may be in English only. However, the automatic fix also works for other language versions of Windows.
- If you are not on the computer that has the problem, save the Fix it solution to a flash drive or a CD and then run it on the computer that has the problem.
Then, go to the "[Did this fix the problem?](#fixedalways)" section.

#### Let me fix it myself

If you cannot access the **Offline Files**  tab, use this method to re-initialize the Offline Files (CSC) cache on the system by modifying the registry. Use this method also to re-initialize the offline files database/client-side cache on multiple systems. Add the following registry subkey: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\NetCache` 
Key Name: FormatDatabase
Key Type: DWORD
Key Value: 1
> [!NOTE]
>  The actual value of the registry key is ignored. This registry change requires a restart. When the computer is restarting, the shell will re-initialize the CSC cache, and then delete the registry key if the registry entry exists.

> [!WARNING]
> All cache files are deleted and unsynchronized data is lost.

#### Use Reg.exe

You can also automate the process of setting this registry value by using the Reg.exe command line editor. To do this, type the following command in the Reg.exe window: REG.EXE. REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\NetCache" /v FormatDatabase /t REG_DWORD /d 1 /f 
> [!NOTE]
> For specific steps to re-initialize the offline files cache and database in Windows Vista or Windows 7, click the following article number to view the article in the Microsoft Knowledge Base:

[942974](https://support.microsoft.com/help/942974) On a Windows Vista or Windows 7-based client computer, you can still access offline files even though the file server is removed from the network  

## References

For more information, click the following article number to view the article in the Microsoft Knowledge Base: 
 [230739](https://support.microsoft.com/help/230739) Structure of the Offline Files cache folder 

#### Did this fix the problem?


- Check whether the problem is fixed. If the problem is fixed, you are finished with this section. If the problem is not fixed, you can [contact support](/contactus).
- We would appreciate your feedback. To provide feedback or to report any issues with this solution, please leave a comment on the "[Fix it for me](http://blogs.technet.com/fixit4me/)" blog or send us an [email](mailto:fixit4me@microsoft.com?subject=kb).
