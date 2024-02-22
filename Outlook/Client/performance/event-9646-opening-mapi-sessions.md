---
title: Event ID 9646 if service account opens MAPI sessions
description: Event ID 9646 is logged when a service account opens many MAPI sessions in Exchange Server 2013 and 2010. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: sschiem
appliesto: 
  - Exchange Server 2013 Enterprise Edition
  - Exchange Server 2010 Enterprise
search.appverid: MET150
ms.date: 10/30/2023
---
# Event ID 9646 when a service account opens many MAPI sessions

_Original KB number:_ &nbsp; 2742012

## Symptoms

Consider the following scenarios:

Scenario 1

- You install Microsoft Exchange Server.
- You create a service account for a third-party application that interacts with Exchange.
- The service account must open many MAPI sessions to the Exchange Information Store (EIS). For example, the service account must open more than 32 MAPI sessions in order to index or synchronize email messages.

Scenario 2

- A server in a forest is running Exchange Server.
- The server that is running Exchange Server is in the resource forest.
- Disabled accounts in the resource forest are linked to enabled accounts in the account forest.
- You create a service account for a third-party application that interacts with Exchange.
- The service account in the resource forest must open many MAPI sessions to the EIS. For example, the service account must open more than 32 MAPI sessions in order to index or synchronize email messages.

In these scenarios, the service account may be disconnected from the Exchange server. In addition, an Error event that resembles the following occurs in the Application log on the Exchange server:

```console
Event Type: Error
Event Source: MSExchangeIS
Event Category: General
Event ID: 9646

Description:
Mapi session "/o=ExchangeOrg/ou=First Administrative Group/cn=Recipients/cn=User" exceeded the maximum of 32 objects of type "session".
```

## Cause

This issue occurs because the default maximum number of connections that an account can open was exceeded.

> [!NOTE]
> By default, an account can open a maximum of 32 connections to the EIS.

## Resolution

To resolve this issue, grant the service account the View Information Store status permission. The View Information Store status permission lets that account open an unlimited number of sessions.

To do this, run the following cmdlet:

```cmd
Add-ADPermission -Identity "Exchange Administrative Group (FYDIBOHF23SPDLT)" - **User account_or_group_name** -AccessRights ExtendedRight -ExtendedRights "View information store status" -InhertanceType Descendents
```

> [!NOTE]
> In Scenario 2 in the Symptoms section, you must grant the account in the account forest the View Information Store status permission at the administrative group level.

## More information

The connection limit of 32 sessions per account helps protect the EIS from resource exhaustion. We recommend that you use caution when you grant the View Information Store status permission.

The View Information Store status permission does not apply to Exchange Server 2013. In Exchange Server 2013, you should use the Administer information store permission. However, depending on the MAPI application, this may still not resolve the issue. Additionally, the MAPI application may have to specify `OPENSTORE_USE_ADMIN_PRIVILEGE` when it opens every mailbox. This includes the mailbox that is configured in the profile.
