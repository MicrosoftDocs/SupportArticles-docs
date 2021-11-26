---
title: Version is not supported when migrating mailbox to Exchange Server 2010
description: Describes an issue in which you can't migrate mailboxes to Exchange Server 2010 in a hybrid deployment because it is not supported.
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

# Version is not supported when migrating mailbox from Exchange Online to Exchange Server 2010

## Symptoms

You have a hybrid deployment of Exchange Online and on-premises Exchange Server 2010 environment. When you try to migrate an Exchange Online mailbox to your on-premises Exchange organization, you receive an error message that resembles the following:

> MigrationPermanentException: **Moving mailbox to Exchange version '\<Version number\> (\<Build number\>)' is not supported**. Mailboxes can be moved to Exchange Server 2013 and later versions only. --> Moving mailbox to Exchange version '\<Version number\> (\<Build number\>)' is not supported. Mailboxes can be moved to Exchange Server 2013 and later versions only.

## Cause

This issue occurs because [Exchange Server 2010 reached end of support on October 13, 2020](/microsoft-365/enterprise/exchange-2010-end-of-support), and it doesn't support to migrate an Exchange Online mailbox to Exchange Server 2010 organization.

## Resolution

You can migrate the Exchange Online mailbox to an organization of on-premises Exchange Server 2013 or a later version. For more information, see the following articles:

- [Upgrade from Exchange 2010 to Exchange 2013](/exchange/upgrade-from-exchange-2010-to-exchange-2013-exchange-2013-help)
- [Upgrade to a newer version of Exchange Server on-premises](/microsoft-365/enterprise/exchange-2010-end-of-support#upgrade-to-a-newer-version-of-exchange-server-on-premises)
