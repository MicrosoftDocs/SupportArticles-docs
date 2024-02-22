---
title: Mailbox migration number exceeds the default limit
description: Fixes an issue in which you receive a Mailbox Replication Proxy Service can't process this request because it has reached the maximum number of active MRS connections allowed error message when moving mailboxes between on-premises and Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: timothyh, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Request has reached the maximum number of active MRS connections allowed during a hybrid mailbox move

_Original KB number:_ &nbsp; 3091026

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the [Microsoft 365 Hybrid Configuration wizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Problem

When you move mailboxes between the on-premises Microsoft Exchange Server environment and Microsoft Exchange Online in a hybrid deployment, you notice that the migrations are stalled or seem to be stopped. When you view the move logs, you see the following error message:

> MRSProxyConnectionLimitReachedTransientException: The Mailbox Replication Proxy Service can't process this request because it has reached the maximum number of active MRS connections allowed. Current connections: 100, Connections limit: 100.

## Cause

This issue occurs if the number of moves that use a migration endpoint exceed the default limit of 100 concurrent migrations.

## Solution

To fix this issue, increase the number of maximum concurrent connections for the Mailbox Replication Proxy (MRSProxy) service.

> [!WARNING]
> Increasing these values can affect resources and performance on the on-premises servers. Adjust these settings with caution.

### In Exchange Server 2013

1. Open the MsExchangeMailboxReplication.exe.config file that's located at `C:\Program Files\Microsoft\Exchange Server\V15\Bin`.
2. Change the value for `MaxMRSConnections` from **100** to **320**:

    \<MRSProxyConfiguration MaxMRSConnections="320" *check*  

> [!NOTE]
> You have to update this setting every time that you install a cumulative update for Exchange Server.

### In Exchange Server 2010

On each Client Access server that has MRSProxy enabled, increase the number of concurrent connections to a value that's slightly larger than the default value for Exchange Online. For example, change the value to 320 concurrent connections.

To do this, open the Exchange Management Shell, and then run the following command:

```powershell
Set-WebServicesVIrtualDirectory -server <ServerName> -MRSProxyMaxConnections 320
```

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
