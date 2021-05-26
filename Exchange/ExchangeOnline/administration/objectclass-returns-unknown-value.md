---
title: ObjectClass returns Unknown when running cmdlet
description: Discusses an issue in which the ObjectClass property returns a value of Unknown when you run the Get-MailboxStatistics cmdlet in Exchange Server or Exchange Online in Office 365.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Online
- CSSTroubleshoot
ms.reviewer: 
appliesto:
- Exchange Online
- Exchange Server 2016 Enterprise Edition
- Exchange Server 2016 Standard Edition
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition
search.appverid: MET150
---
# ObjectClass Unknown is returned when you use the Get-MailboxStatistics cmdlet

_Original KB number:_ &nbsp; 2795291

## Problem

When you use the `Get-MailboxStatistics` Windows PowerShell cmdlet to get information about a mailbox in on-premises Exchange Server or Exchange Online in Office 365, the `ObjectClass` property unexpectedly returns a value of **Unknown**.

For example, when you run the `Get-MailboxStatistics admin | FL *object*` command, you receive the following output:

```output
ObjectClass : Unknown
ObjectState: Unchanged
```

In earlier versions of Exchange Server and in Exchange Online in Office 365, the `ObjectClass` property returns the correct value. For example, this property returns **Mailbox** for user mailboxes and **Mailbox, Disabled** for equipment and room mailboxes.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
