---
title: Cannot save changes made to an item to store while migrating a mailbox to Exchange Online
description: This article explains how to fix an issue in which you can't migrate mailboxes from on-premises to Exchange Online with the error "Cannot save changes made to an item to store."
author: cloud-writer
ms.author: meerak
ms.reviewer: pramods, v-six, v-kccross
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Intra-Organization Migration
  - Exchange Server
  - CSSTroubleshoot
  - CI 123834
  - CI 9823
  - CI 11506
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
ms.date: 04/26/2026
---

# Cannot save changes made to an item to store when you migrate a mailbox to Exchange Online

## Summary

Mailbox migrations to Exchange Online can fail with a “Cannot save changes made to an item to store” error when a folder exceeds the per-folder item limit. This article shows how to identify and reduce oversized folders so migration can continue.

# Error while migrating mailbox to Exchange Online: Cannot save changes made to an item to store

## Symptoms

When you migrate on-premises Exchange mailboxes to Exchange Online, you receive this error message:

> "Cannot save changes made to an item to store. --> MapiExceptionMessagePerFolderCountQuotaExceeded: Unable to save changes. (hr=0x80004005, ec=1252)"

## Cause

At least one on-premises mailbox folder exceeds the limit of 1 million items.

For more information about Exchange Online mailbox folder limits, see [Exchange Online limits](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits#mailbox-folder-limits).

## Resolution

1. Open the Exchange Management Shell or connect to your Exchange server by using remote PowerShell.
1. Run the [Get-MailboxFolderStatistics](/powershell/module/exchangepowershell/get-mailboxfolderstatistics) PowerShell cmdlet to check which folder contains more than 1 million items.

    ```powershell
    $root=Get-MailboxFolderStatistics -Identity user@contoso.com

    $root | sort itemsinfolder -descending |ft folderpath,itemsinfolder
    ```

1. Check if any folder under **NonIpmRoot** contains more than 1 million items.

    ```powershell
    $non_root=Get-MailboxFolderStatistics user@contoso.com -FolderScope NonIpmRoot

    $non_root | sort itemsinfolder -descending |ft folderpath,itemsinfolder
    ```

1. If the folder that has too many items is accessible from Outlook or through the [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases/tag/20.0.20280.01) tool, move some items to other folders and resume the migration.

   It's possible that the **Deferred action** folder contains more than 1 million items. You can delete some of the items (HardDelete) using the MFCMAPI tool. This folder is under the root of the mailbox. To learn more about this folder, see the [Glossary](/openspecs/exchange_server_protocols/ms-oxorule/0ae81043-05e6-47e4-aa3f-f546512e96b6) for the MS-OXORULE Email Rules Protocol.
