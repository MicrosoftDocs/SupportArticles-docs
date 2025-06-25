---
title: Can't migrate on-premises archive mailboxes to Microsoft 365 in a hybrid migration
description: This article describes an issue in which you cannot migrate an on-premises archive mailbox to Microsoft 365 in a hybrid migration. Provides a workaround.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Archiving
  - CSSTroubleshoot
ms.reviewer: alinastr
appliesto: 
  - Exchange Online
  - Exchange Server 2013
  - Exchange Server 2010
  - Exchange Server 2016
  - Exchange Server 2019
search.appverid: MET150
ms.date: 05/05/2025
---

# Can't migrate on-premises archive mailboxes to Microsoft 365 in a hybrid migration

_Original KB number:_&nbsp;4508006

## Symptoms

Consider the following scenario in a Microsoft Exchange Server hybrid environment:

- You create a hybrid migration batch to migrate mailboxes from on-premises to Microsoft 365.
- You add an on-premises mailbox, [user@contoso.com](mailto:user@contoso.com), to the batch.
- You configure the primary mailbox to move together with the archive mailbox.
- You enable an archive mailbox for [user@contoso.com](mailto:user@contoso.com) after you start the migration batch.

In this scenario, after the migration is completed successfully, you notice that the on-premises archive mailbox data isn't migrated. Instead, a new archive mailbox is provisioned in Microsoft 365.

## Cause

This behavior is expected. If you enable the archive mailbox after the mailbox move is started, the archive mailbox won't be migrated to Microsoft 365. However, the primary mailbox is still moved successfully because of the current architecture design.

## Workaround

To work around this issue, use either of the following methods:

- Enable the archive mailbox before you start the mailbox migration to Microsoft 365.
- Reconnect the disconnected on-premises archive mailbox within 30 days (or within the mailbox retention period that you customized on the database), and then import the data into the newly provisioned archive mailbox in Microsoft 365. For more information about how to reconnect the archive mailbox, see [this Exchange Support Team Central Europe Blog article](/archive/blogs/appssrv/identify-and-reconnect-disabled-mailboxes-in-exchange-online-2013-and-2016).
