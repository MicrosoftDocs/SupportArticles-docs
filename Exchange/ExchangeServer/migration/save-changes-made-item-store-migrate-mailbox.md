---
title: Error (Cannot save changes made to an item to store) while migrating mailbox to Exchange Online
description: This article fixes an issue in which you can't migrate mailboxes from on-premises to Exchange Online with "Cannot save changes made to an item to store" error.
author: TobyTu
ms.author: pramods
ms.reviewer: pramods
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom:
- CSSTroubleshoot
- CI 123834
search.appverid: 
- MET150
appliesto:
- Exchange Online
- Exchange Server 2019
- Exchange Server 2016
- Exchange Server 2013
- Exchange Server 2010
---
# Error while migrating mailbox to Exchange Online: Cannot save changes made to an item to store

## Symptoms

When you migrate on-premises Exchange mailboxes to Exchange Online organization, you receive this error message:

> "Cannot save changes made to an item to store. --> MapiExceptionMessagePerFolderCountQuotaExceeded: Unable to save changes. (hr=0x80004005, ec=1252)"

## Cause

There is at least one on-premises mailbox folder that contains over 1 million items. It exceeds the limit for Exchange Online mailbox folder.

For more information about Exchange Online mailbox folder limits, see [Exchange Online limits](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits#mailbox-folder-limits).

## Resolution

### For Microsoft Exchange Server 2013, Exchange Server 2016, and Exchange Server 2019

1. Run these commands in the on-premises PowerShell to check which folder contains more than 1 million items.

    ```powershell
    $root=Get-MailboxFolderStatistics -Identity user@contoso.com

    $root | sort itemsinfolder -descending |ft folderpath,itemsinfolder
    ```

2. Check if any folder under **NonIpmRoot** contains more than 1 million items.

    ```powershell
    $non_root=Get-MailboxFolderStatistics user@contoso.com -FolderScope NonIpmRoot

    $non_root | sort itemsinfolder -descending |ft folderpath,itemsinfolder
    ```

3. If the faulty folder is accessible from Outlook or [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases/tag/20.0.20280.01) tool, move some of the items to other folders and resume the migration.

    There's a high chance that a folder named **Deferred action** contains more than 1 million items. You can delete some (HardDelete) using MFCMAPI. The folder is right below the root of the mailbox.

### For Microsoft Exchange server 2010

1. Run this command in the on-premises PowerShell to check which folder contains more than 1 million items.

    ```powershell
    $root=Get-MailboxFolderStatistics -Identity user@contoso.com

    $root | sort itemsinfolder -descending |ft folderpath,itemsinfolder
    ```

2. Move the items to other folders and resume the migration.
3. If you didn't find the folder in the command above, use [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases/tag/20.0.20280.01) to connect to the mailbox. Clean-up folders in **NonIpmRoot**.

    > [!NOTE]
    > In Exchange Server 2010, `Get-MailboxFolderStatistics` doesn't have a `-FolderScope NonIpmRoot` switch.
