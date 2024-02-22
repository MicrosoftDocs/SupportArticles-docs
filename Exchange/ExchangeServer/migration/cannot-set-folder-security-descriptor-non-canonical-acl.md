---
title: Cannot set folder security descriptor with non-canonical ACL error when you move a mailbox in Exchange Server 2013
description: Resolves an issue in which you receive a (Cannot set folder security descriptor with non-canonical ACL) error message. This issue occurs when you try to move mailboxes in an Exchange Server 2013 environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: batre, v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Error when you move a mailbox in an Exchange Server 2013 environment: Cannot set folder security descriptor with non-canonical ACL

_Original KB number:_ &nbsp;2764844

## Symptoms

When you try to move a mailbox in a Microsoft Exchange Server 2013 environment, you receive the following error message:
> Error: Cannot set folder security descriptor with non-canonical ACL.

## Cause

This issue occurs because the mailbox has a corrupted access control list (ACL).

## Resolution

To resolve this issue, follow these steps:

1. Run the following commands to identify the ACL that causes this issue:

    ```powershell
    $mr = get-moverequeststatistics -IncludeReport <mailboxIdentity>  

    $mr.Report.Failures
    ```

2. Remove the corrupted ACL by using the ExFolders tool.

## Workaround

To work around this issue, run the following `new-MoveRequest` cmdlet together with the `-SkipMoving:FolderACls` switch:

```powersehll
New-moverequest -Identity <username> -Target Database "database name" -SkipMoving:FolderViews
```

> [!NOTE]
> When you move the mailbox by using the `-SkipMoving:FolderACls` switch, Exchange Server 2013 doesn't move the ACLs of the folders in the mailbox. Therefore, after you move the mailbox, all the folders have default permissions.
