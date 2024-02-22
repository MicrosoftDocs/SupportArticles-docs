---
title: An existing Public Folder deployment has been detected error in Exchange Server
description: Error occurs when you create a public folder mailbox in Exchange 2013 or Exchange 2016, because there's an existing public folder from a legacy version of Exchange whose data must be migrated.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: jmartin, v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Error when creating a public folder mailbox in Exchange Server: An existing Public Folder deployment has been detected

_Original KB number:_ &nbsp;3004062

## Symptoms

When you try to create a public folder mailbox in Microsoft Exchange Server, you receive the following error message:

> An existing Public Folder deployment has been detected. To migrate existing Public Folder data, create new Public  
> Folder mailbox using -HoldForMigration switch.

## Cause

This problem occurs when the Exchange organization coexists with an earlier version of Exchange Server, and one or more public folder databases from the earlier version of Exchange still exist.

## Resolution

To resolve this issue, use one of the following methods.

### Method 1: Create the mailbox by using the -HoldForMigration switch

This option lets an administrator create a public folder mailbox in order to begin a migration from the existing public folders:

1. Open the Exchange Management Shell.
1. Run the following cmdlet to create the public folder mailbox:

   ```powershell
   New-Mailbox "Public Folder Mailbox" -PublicFolder -HoldForMigration
   ```

### Method 2: Remove all public folder databases from earlier versions of Exchange Server

1. Remove existing public folder databases. To do this, see [Remove Public Folder Databases](/previous-versions/office/exchange-server-2010/dd876883(v=exchg.141)).
1. Create the public folder mailbox by using either the Exchange Admin Center (EAC) or the Exchange Management Shell (EMS). To do this, see [Create a public folder mailbox](/Exchange/collaboration/public-folders/create-public-folder-mailboxes).