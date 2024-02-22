---
title: Full hierarchy sync fails with error
description: Describes an issue that occurs when the sync state of the public folder hierarchy exceeds the maximum message size.
ms.date: 01/24/2024
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
search.appverid: MET150
---
# Full hierarchy sync fails with Microsoft.Mapi.MapiExceptionMaxSubmissionExceeded

_Original KB number:_ &nbsp; 3068989

## Symptoms

A full hierarchy sync to a public folder mailbox fails with a **Microsoft.Mapi.MapiExceptionMaxSubmissionExceeded** error.

## Cause

The sync state of the public folder hierarchy exceeds the maximum message size.

## Resolution

Increase the value of the `MaxSendSize` and the `MaxReceiveSize` parameters for all public folder mailboxes. To do this, run the `Set-Mailbox` cmdlet.

```powershell
Set-Mailbox -Public <PFMailboxName> -MaxSendSize 30MB -MaxReceiveSize 30MB
```
