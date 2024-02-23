---
title: Description of the Files folder in Microsoft 365
description: Description of the Files folder that's listed in the output of Get-MailboxFolderStatistics for a mailbox.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: kerbo, kellybos, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Description of the Files folder in Microsoft 365

_Original KB number:_ &nbsp; 4025474

## Summary

A Files folder is listed in the output of `Get-MailboxFolderStatistics`  for a mailbox. It is in the root of the mailbox but not visible to the end user. It may show a large amount of content that otherwise appears to be unusable.

## More information

The Files folder within a mailbox is used to store the metadata of attachments that come into the mailbox. This content is then used to improve search performance and the overall user experience when search is used to find attachments. From the perspective of eDiscovery, the folder doesn't contain usable items, because the content is just reference (metadata) to real attachments that are already stored in the IPM visible subtree (for example, in the Inbox or whichever folder the mail with the attachment ended up in).

Content in the Files does not count against the user's quota. It is instead included in the system quota.

```powershell
Get-MailboxStatistics user@contoso.com | fl *SystemMessage*
```

```console
SystemMessageSize : 16.09 MB (16,873,043 bytes)  
SystemMessageCount : 15533  
SystemMessageSizeWarningQuota : 9.5 GB (10,200,547,328 bytes)  
SystemMessageSizeShutoffQuota : 10 GB (10,737,418,240 byte
```
