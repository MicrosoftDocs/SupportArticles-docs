---
title: Items reappear in a user's mailbox or are duplicated in the archive mailbox when an archiving policy is enabled during IMAP migration
description: Discusses a scenario in Microsoft 365 in which enabling an archiving policy through messaging records management (MRM) causes items to reappear in the user's mailbox and items to be duplicated in the archive mailbox.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Archiving
  - CSSTroubleshoot
ms.reviewer: jchapp
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 05/05/2025
---

# Items reappear in a user's mailbox or are duplicated in the archive mailbox when an archiving policy is enabled during IMAP migration

_Original KB number:_&nbsp;2783045

## Problem

In Microsoft 365, users may experience one or both of the following symptoms:

- Items that are expected to be archived reappear in their inbox in Microsoft Outlook and Outlook Web App.
- Items are duplicated in the archive mailbox.

## Cause

This problem occurs if you enabled a messaging records management (MRM) retention policy to archive items from the mailbox, and you have an active IMAP migration batch running to migrate items to the mailbox.

The IMAP migration process can't detect the archive mailbox. It means that items that have already been archived are treated as if they're missing from the primary mailbox. Therefore, these items are migrated again. This makes it appear as if items in the primary mailbox came back out of the archive mailbox.

If the MRM policy runs again before this condition is discovered, the re-synced items will be moved to the archive mailbox. Therefore, duplicated items appear in the archive mailbox.

## Solution

To fix this problem, use one of the following methods:

- Disable the archiving policy until the IMAP migration process is complete.
- Stop the migration batch to prevent more duplicate items from being created. Additionally, you must manually remove the duplicated items from the mailbox. Or, delete the mailbox, and then remigrate it to Microsoft 365.

## More information

This behavior is by design. Data migration copies all items from the source mailbox to the destination mailbox.
