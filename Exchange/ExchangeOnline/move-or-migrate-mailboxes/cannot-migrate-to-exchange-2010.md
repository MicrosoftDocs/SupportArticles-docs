---
title: Moving mailboxes to Exchange Server 2010 isn't supported
description: You can't migrate Exchange Online mailboxes to Exchange Server 2010 in a hybrid deployment, because Exchange Server 2010 has reached end of support.
author: v-charloz
ms.author: v-chazhang
audience: ITPro
ms.service: exchange-online
ms.topic: troubleshooting
manager: dcscontentpm
localization_priority: Normal
ms.custom:
- CI 158896
- Exchange Online
- CSSTroubleshoot
ms.reviewer: meerak; rroddy; bradhugh; ninob
search.appverid: MET150
appliesto:
- Exchange Online
- Exchange Server 2010
- MSfC O365-Exchange Online
---

# Moving Exchange Online mailboxes to Exchange 2010 isn't supported

In an Exchange hybrid deployment, you try to move Exchange Online mailboxes to on-premises Exchange Server 2010. In this scenario, you receive the following error message:

> MigrationPermanentException: **Moving mailbox to Exchange version 'Version 14.x (Build \<build number>\)' is not supported**. Mailboxes can be moved to Exchange Server 2013 and later versions only. --> Moving mailbox to Exchange version 'Version 14.x (Build \<build number>\)' is not supported. Mailboxes can be moved to Exchange Server 2013 and later versions only.

## More information

[Exchange Server 2010 has reached end of support](/microsoft-365/enterprise/exchange-2010-end-of-support). Microsoft no longer supports moving mailboxes from Exchange Online to Exchange Server 2010.

You can move Exchange Online mailboxes to Exchange Server 2013 and later versions. To upgrade from Exchange Server 2010, see the following articles:

- [Upgrade from Exchange 2010 to Exchange 2013](/exchange/upgrade-from-exchange-2010-to-exchange-2013-exchange-2013-help)
- [Upgrade to a newer version of Exchange Server on-premises](/microsoft-365/enterprise/exchange-2010-end-of-support#upgrade-to-a-newer-version-of-exchange-server-on-premises)
