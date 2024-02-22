---
title: MAPI apps cannot access archive mailboxes in RDB
description: MAPI applications can't access archive mailboxes in Recovery Databases (RDB).
ms.date: 10/30/2023
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Exchange Server 2010
search.appverid: MET150
---
# MAPI applications cannot access archive mailboxes in Recovery Databases

_Original KB number:_ &nbsp; 2590306

If you develop an Extended MAPI application for use with Microsoft Exchange Server 2010, the application can't access an archive mailbox in a Recovery Database (RDB).

## More information

This is a design limitation of Exchange Server 2010. MAPI applications can't access an archive mailbox in an RDB because of the design of the RPC Client Access server role. When a MAPI application attempts to sign in, it will encounter a **MAPI_E_FAILONEPROVIDER (0x8004011d)** error. To work around this limitation, you can use the `Restore-Mailbox` cmdlet to restore data from the archive mailbox in the RDB.
