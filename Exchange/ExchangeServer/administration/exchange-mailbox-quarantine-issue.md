---
title: Quarantined mailboxes detected on Exchange Server 2010
description: Fixes an issue that a mailbox is quarantined and users can't access it.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: Brianpr, charray, v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Mailboxes are quarantined and not allowed to access in Exchange Server 2010

_Original KB number:_ &nbsp;2603736

## Symptoms

A user can't access a mailbox that resides on a Microsoft Exchange 2010 server.

## Cause

The mailbox is a potential threat to the health of the Information store and has been quarantined.

There are several types of events for which the Exchange store tags a mailbox as a potential threat:

- If a thread doing work for that mailbox fails
- If there are more than five threads in that mailbox that haven't made progress for a long time

## Resolution

The cause of the poison mailbox must be identified and corrected. Once this is accomplished, to gain access to the mailbox immediately, the registry key for the quarantined mailbox should be reset manually by deleting it.

> [!NOTE]
> If this manual step is forgotten, the Exchange store automatically resets quarantined mailboxes six hours after the quarantined flag was set.

## More information

For more information, see [Poison Mailbox Detection and Correction](/previous-versions/office/exchange-server-2010/bb331958(v=exchg.141)#sh).