---
title: Moving mailbox to Exchange version 'Version 14.3' is not supported
description: Describes an issue in which you can't off-board mailboxes to Exchange Server 2010 in a hybrid deployment because it is no longer supported.
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

# Can't migrate mailbox from Exchange Online to Exchange Server 2010

## Symptoms

You have a hybrid deployment of Exchange Online and on-premises Exchange Server 2010 environment. When you try to migrate an Exchange Online mailbox to your on-premises Exchange organization, you receive the following error message:

> MigrationPermanentException: Moving mailbox to Exchange version 'Version 14.3 (Build 123.0)' is not supported. Mailboxes can be moved to Exchange Server 2013 and later versions only. --> Moving mailbox to Exchange version 'Version 14.3 (Build 123.0)' is not supported. Mailboxes can be moved to Exchange Server 2013 and later versions only.

## Cause

Off-board mailboxes from Exchange Online to Exchange Server 2010 is no longer supported, because [Exchange Server 2010 reached its end of support](/microsoft-365/enterprise/exchange-2010-end-of-support).

## Resolution

To perform an off-boarding remote move migration, [upgrade Exchange Server 2010 to Exchange Server 2013](/exchange/upgrade-from-exchange-2010-to-exchange-2013-exchange-2013-help) and later versions that are supported.
