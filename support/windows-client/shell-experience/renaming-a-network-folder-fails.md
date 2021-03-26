---
title: Renaming a network folder fails
description: Resolves an issue where Renaming a network folder in Windows 7 Explorer fails.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: File Explorer/Windows Explorer
ms.technology: windows-client-shell-experience
---
# Renaming a network folder in Windows 7 Explorer fails with "the action can't be completed..."

This article provides a solution to an issue where Renaming a network folder in Windows 7 Explorer fails.

_Original product version:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2025703

## Symptoms

Steps to reproduce the issue:  

1. Map a drive to a network share that contains several subfolders that contains images files or PDFs  

2. Open an Explorer window and navigate to the parent folder.  

3. Attempt to rename each folder successively, while drilling into the subfolder contents.  

4. Continue step 3 until an error dialog containing the following text appears indicating that the subfolder cannot be renamed:  
 "The action can't be completed because the folder or a file in it is open in another program. Close the file or folder and try again."  

## Cause

The folder rename operation fails because thumbcache.dll still has an open handle to the local thumbs.db file and does not currently implement a mechanism to release the handle to the file in a more dynamic and timely fashion.

## Resolution

To work around the issue, enable User Group Policy setting for "Turn off the caching of thumbnails in hidden thumbs.db files":

**Policy Path** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`User Configuration\Administrative Templates\Windows Components\Windows Explorer`  
**Policy Setting** &nbsp;"Turn off the caching of thumbnails in hidden thumbs.db files"  
**Policy Value** &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Enabled  

> [!Important]
 This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
 [322756](https://support.microsoft.com/kb/322756) How to back up and restore the registry in Windows  

You can directly edit the registry with the following setting:

**Registry path** `HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer`  
**Setting Name** `"DisableThumbsDBOnNetworkFolders"`  
**Type** &emsp;&emsp;&emsp;&emsp;&nbsp;REG_DWORD  
**Value** &emsp;&emsp;&emsp;&emsp;1  

Another workaround is to wait approximately 1-5 minutes then retry the rename operation.
