---
title: OneDrive files or folders incorrectly show as syncing
description: Fixes an issue in which OneDrive shows files or folders in File Explorer as still syncing but on the taskbar as fully synced. 
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 168012
  - CSSTroubleshoot
ms.reviewer: bpeterse
appliesto: 
  - OneDrive for Business
  - Microsoft OneDrive
search.appverid: 
  - MET150
ms.date: 12/17/2023
---
# The OneDrive sync status icon incorrectly shows "syncing" in File Explorer

After you sync files or folders to OneDrive, the OneDrive icon in the taskbar notification area shows an "**Up to date**" status for files or folders that are fully synced. However, some or all of the files and folders in the OneDrive folder in File Explorer are still shown as "syncing." This article provides possible solutions that you can use to solve these issues.  

## Some files and folders show the "syncing" status  

### Cause

This issue might occur for the following reasons:

- The OneDrive folder contains hidden and temporary files. By default, hidden and temporary files display the "syncing" status, but they aren't synced by OneDrive. Therefore, they don't affect the "**Up to date**" status.
- The Windows Search index has an incorrect cached status. This can cause an unexpected sync status in some files and folders.  

### Resolution  

To resolve this issue, check whether there are hidden or temporary files and folders in the OneDrive folder. Remove any that you find:  

1. [Show hidden files and folders in File Explorer](https://support.microsoft.com/windows/view-hidden-files-and-folders-in-windows-97fbc472-c603-9d90-91d0-1166d1d9f4b5).  
2. Remove all hidden files and folders that aren't associated with the files that you're currently editing.
3. [Search for temporary Office files](/office/troubleshoot/word/recover-lost-unsaved-corrupted-document#searching-for-temporary-files). To remove these files, close any open Office files, and then [clear the Office document cache](https://support.microsoft.com/topic/delete-your-office-document-cache-b1d3765e-d71b-4bb8-99ca-acd22c42995d).
4. If clearing the Office document cache doesn't remove any temporary Office files that are still syncing, determine whether the files can be manually deleted.

   > [!WARNING]
   > This may cause data loss of the Office document. Therefore, make sure that the files can be safely deleted.

5. If the files aren't temporary Office files, determine whether they can be safely removed. If they can't be removed, move them out of the OneDrive folder to see whether the issue is resolved.

If there are no hidden or temporary files that cause the sync status to be incorrect, check whether this issue is caused by the Windows Search index:  

1. Select **Start**, and enter *Services*, and then select **Services** in the search results to open the Service application.
2. Double-click **Windows Search**, and then change the **Startup type** to **Disabled**.
3. In **Service status**, select **Stop**.
4. Select **OK**.
5. Refresh the File Explorer window. If the contents of the OneDrive folder no longer show as "syncing," the issue was caused by the cached search index. To resolve this issue, follow the next steps.
6. Return to the Services application, and revert the **Startup type** of the **Windows Search** service to **Automatic (Delayed Start)**.
7. Rebuild the Windows Search index:  

    1. Select **Start**, enter *Indexing*, and then select **Indexing Options** in the search results.
    1. Select **Advanced** > **Rebuild**.

       > [!NOTE]
       > This process can take some time to finish. It runs faster if the computer isn't in use. Therefore, we recommend that you rebuild the index outside active hours, such as at night or on weekends. If the issue isn't resolved, there might be a problem in the indexing layer. For more information, see [Fix problems in Windows Search](/troubleshoot/windows-client/shell-experience/fix-problems-in-windows-search).

## All files and folders show the "syncing" status

### Cause

This issue might occur if the `UseFindFirstFileEnumeration` Windows policy is set to **True**. This policy is designed for legacy file systems. It's not compatible with OneDrive Files on Demand. If this policy is set to **True**, File Explorer can't read the reparse tag on files and folders. Therefore, all files and folders are set to the default status of "syncing".

### Resolution

To resolve this issue, follow these steps to remove the `UseFindFirstFileEnumeration` registry value or change its value to **0**.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692) in case problems occur.
  
1. Select **Start**, enter *regedit*, and then select **Registry Editor** in the search results.
2. Locate the following registry subkey:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer`

3. Right-click `UseFindFirstFileEnumeration`, and then select **Delete**. Or, select **Modify**, and then set the value to **0**.  
4. Restart File Explorer.  
