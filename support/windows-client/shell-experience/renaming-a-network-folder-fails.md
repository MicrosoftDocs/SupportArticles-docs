---
title: Renaming a network folder fails
description: Resolves an issue where Renaming a network folder in Windows 7 Explorer fails.
ms.data: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: File Explorer/Windows Explorer
ms.technology: ShellExperience
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

| Policy Path| User Configuration\Administrative Templates\Windows Components\Windows Explorer |
|---|---|
| Policy Setting| "Turn off the caching of thumbnails in hidden thumbs.db files" |
| Policy Value| Enabled |
|||

**Important** This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, click the following article number to view the article in the Microsoft Knowledge Base:
 [322756](https://support.microsoft.com/kb/322756) How to back up and restore the registry in Windows
Alternatively, you can directly edit the registry with the following setting:

To have us edit the registry folders for you, go to the "[Fix it for me](https://support.microsoft.com/help/2025703#x_x_x_fixitforme)" section. If you prefer to fix this problem yourself, go to the "[Let me fix it myself](https://support.microsoft.com/help/2025703#x_x_x_letmefixitmyself)" section.

#### **Fix it for me**  

To fix this problem automatically, click the **Fix this problem** link. Then click **Run** in the **File Download** dialog box, and follow the steps in this wizard.

[![fixit](https://support.microsoft.com//library/images/support/KBGraphics/PUBLIC/EN-US/2297543/fixitbtn.jpg)
](https://go.microsoft.com/?linkid=9790365) 
<!--a.x_x_x_x_button{width:139px;display:block;height:56px}--> [](https://go.microsoft.com/?linkid=9763740) [Fix this problem](https://go.microsoft.com/?linkid=9763740) 
Microsoft Fix it 50790  

**Note** This wizard may be in English only. However, the automatic fix also works for other language versions of Windows.

**Note** If you are not on the computer that has the problem, you can save the automatic fix to a flash drive or to a CD so that you can run it on the computer that has the problem.

#### **Let me fix it myself**  

You can directly edit the registry with the following setting:

| Registry path| HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer |
|---|---|
| Setting Name| "DisableThumbsDBOnNetworkFolders" |
| Type| REG_DWORD |
| Value| 1 |
|||

Another workaround is to wait approximately 1-5 minutes then retry the rename operation.
