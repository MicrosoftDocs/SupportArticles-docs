---
title: Invalid reparse points when deleting OneDrive-synced files locally
description: Fixes an issue in which you can't delete a OneDrive-synced file locally because of invalid reparse points.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
  - CI 167100
ms.reviewer: bpeterse, salarson
appliesto: 
  - OneDrive for Business
search.appverid: MET150
ms.date: 12/17/2023
---
# Error 0x80071128 or 0x80071129 when deleting a OneDrive-synced file locally

## Symptoms  

When you try to delete a file from a local folder that's synced with OneDrive, you receive one of the following error messages:

> Error 0x80071128: The data present in the reparse point buffer is invalid.

> Error 0x80071129: The tag present in the reparse point buffer is invalid.  

**Note** This issue occurs when OneDrive [Files On-Demand](https://support.microsoft.com/office/sync-files-with-onedrive-files-on-demand-62e8d748-7877-420f-b600-24b56562aa70) is turned on.  

## Cause  

When Files on Demand is enabled in OneDrive, all synced files and folders are implemented as reparse points. When you unlink OneDrive or stop syncing a library, OneDrive removes all the reparse points. If some reparse points are invalid, OneDrive can't remove them, and it will return the error.
  
## Resolution  

To fix this issue, use [chkdsk](/windows-server/administration/windows-commands/chkdsk) to remove invalid reparse points.

**Note** Chkdsk may take several hours to complete its process on large drives. Therefore, we recommend that you run chkdsk outside active hours, such as at night or on weekends.  
  
1. Select **Start**, type *cmd*, right-click **Command Prompt**, and then select **Run as administrator**.  
2. Run the `chkdsk <volume> /R /F` command.

   If the drive can't be locked, you'll be prompted by the following message:  

   > Chkdsk cannot run because the volume is in use by another process. Would you like to schedule this volume to be checked the next time the system restarts? (Y/N)  

   In this case, enter *Y*, and then press Enter. Then, restart the computer to run `chkdsk`.  

## More information

A reparse point contains the following components:

- Reparse point tag: The reparse tag uniquely identifies the owner of the reparse point. The owner is the implementer of the file system filter driver that's associated with a reparse tag. For more information, see [Reparse Point Tags](/windows/win32/fileio/reparse-point-tags).
- Reparse data: The data is used by the owner to do some kind of work. In the case of the Windows Cloud Files Filter Driver (CldFlt), the data contains file IDs and other information that's required for OneDrive to process the specific file. For more information, see [Reparse Points](/windows/win32/fileio/reparse-points).  
