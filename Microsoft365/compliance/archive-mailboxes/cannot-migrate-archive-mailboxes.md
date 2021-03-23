---
title: Cannot migrate on-premises archive mailboxes to Office 365 in a hybrid migration
description: This article describes an issue in which you cannot migrate an on-premises archive mailbox to Office 365 in a hybrid migration. Provides a workaround.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office 365
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: alinastr
appliesto: 
- Exchange Online
- Exchange Server 2013
- Exchange Server 2010
- Exchange Server 2016
- Exchange Server 2019
search.appverid: MET150
---

# Cannot migrate on-premises archive mailboxes to Office 365 in a hybrid migration

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

_Original KB number:_&nbsp;4508006

## Symptoms

Consider the following in a Microsoft Exchange Server hybrid environment:

- You create a hybrid migration batch to migrate mailboxes from on-premises to Office 365.
- You add an on-premises mailbox, [user@contoso.com](mailto:user@contoso.com), to the batch.
- You configure the primary mailbox to move together with the archive mailbox.
- You enable an archive mailbox for [user@contoso.com](mailto:user@contoso.com) after you start the migration batch.

In this scenario, after the migration is completed successfully, you notice that the on-premises archive mailbox data isn't migrated. Instead, a new archive mailbox is provisioned in Office 365.

## Cause

This is expected behavior. If you enable the archive mailbox after the mailbox move is started, the archive mailbox won't be migrated to Office 365. However, the primary mailbox is still moved successfully because of the current architecture design.

## Workaround

To work around this issue, use either of the following methods:

- Enable the archive mailbox before you start the mailbox migration to Office 365.
- Reconnect the disconnected on-premises archive mailbox within 30 days (or within the mailbox retention period that you customized on the database), and then import the data into the newly provisioned archive mailbox in Office 365. For more information about how to re-connect the archive mailbox, see [this Exchange Support Team Central Europe Blog article](/archive/blogs/appssrv/identify-and-reconnect-disabled-mailboxes-in-exchange-online-2013-and-2016).