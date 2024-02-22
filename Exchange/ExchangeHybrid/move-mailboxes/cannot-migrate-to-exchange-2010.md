---
title: Moving mailboxes to Exchange Server 2010 isn't supported
description: You can't migrate Exchange Online mailboxes to Exchange Server 2010 in a hybrid deployment because Exchange Server 2010 has reached end of support.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
localization_priority: Normal
ms.custom: 
  - CI 158896
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: meerak, rroddy, bradhugh, ninob, v-chazhang
search.appverid: MET150
appliesto: 
  - Exchange Online
  - Exchange Server 2010
  - MSfC O365-Exchange Online
ms.date: 01/24/2024
---

# Can't move Exchange Online mailboxes to Exchange Server 2010

In an Exchange Server hybrid deployment, if you try to move Exchange Online mailboxes to on-premises Microsoft Exchange Server 2010, you receive the following error message:

> MigrationPermanentException: **Moving mailbox to Exchange version 'Version 14.x (Build \<build number>\)' is not supported**. Mailboxes can be moved to Exchange Server 2013 and later versions only. --> Moving mailbox to Exchange version 'Version 14.x (Build \<build number>\)' is not supported. Mailboxes can be moved to Exchange Server 2013 and later versions only.

This issue occurs because [Exchange Server 2010 has reached the end of support](/microsoft-365/enterprise/exchange-2010-end-of-support). Microsoft no longer supports moving mailboxes from Exchange Online to Exchange Server 2010.

You can move Exchange Online mailboxes to Microsoft Exchange Server 2013 and later versions. To upgrade from Exchange Server 2010, see the following articles:

- [Upgrade from Exchange 2010 to Exchange 2013](/exchange/upgrade-from-exchange-2010-to-exchange-2013-exchange-2013-help)
- [Upgrade to a newer version of Exchange Server on-premises](/microsoft-365/enterprise/exchange-2010-end-of-support#upgrade-to-a-newer-version-of-exchange-server-on-premises)
