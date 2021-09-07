---
title: Public folders are displayed in GAL despite having been cleaned up
description: Public folders remain on the global address list (GAL) even though you have removed them. This article provides a resolution.
author: simonxjx
ms.author: batre
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting 
ms.service: exchange-online
localization_priority: Normal
ms.custom: 
- Exchange Online
- CI 116313
- CSSTroubleshoot
ms.reviewer: batre
appliesto:
- Exchange Online
search.appverid: 
- MET150
---
# Public folders are displayed in GAL despite having been cleaned up

## Symptoms

Public folder entries still appear in the global address list (GAL) after removing the public folder mailboxes and/or the public folders.

## Cause

Mail enabled public folders weren't removed properly. The mail enabled public folder (MEPF) objects may still be present.

## Resolution

Check if the stale entry appears in OWA or Outlook online mode. If the entry appears in cached mode and not in OWA or Outlook online mode, the Offline Address Book (OAB) may not be updated on the Outlook cached mode client yet.

If the stale entry appears in OWA and Outlook online mode as well:

1. Connect to Exchange Online PowerShell.
2. Run the following command to list mail enabled public folders:

    ```powershell
    Get-MailPublicFolder
    ```

3. Verify if the stale public folder entry is there.
4. If you see the stale public folder entry, run this command to remove the mail enabled public folders:

    ```powershell
    Get-MailPublicFolder <name of stale public folder> | Disable-MailPublicFolder
    ```

    You may get the following warning, which is expected if the public folder is not present:

    > WARNING: Failed to locate the public folder \<name of public folder> because the following error occurred: Microsoft.Exchange.Data.StoreObjects.ObjectNotFoundException: No active public folder mailboxes were found. This happens when no public folder mailboxes are provisioned or they are provisioned in 'HoldForMigration' mode. If you're not currently performing a migration, create a public folder mailbox.

    > [!NOTE]
    > Make Sure the MEPF's are no longer needed before removing them.

    After removing the entry, use OWA to verify if the entry appears in GAL.

5. If Get-MailPublicFolder doesn't show a stale entry, run this command to check if there's any other object with the same name or email address:

    Search by name:

    ```powershell
    Get-Recipient |?{$_.Name -like "*pub*"}'
    ```

    Search by email address:

    ```powershell
    Get-Recipient |?{$_.EmailAddresses -like "*pub*"}
    ```

    If you find another object with the same name or email address, remove it using the appropriate command, i.e. Remove-mailbox if it's a mailbox object type.

6. Use Outlook on the Web to verify if the entries have been removed.
    > [!NOTE]
    > Address list changes take a while to be reflected in Outlook client .
