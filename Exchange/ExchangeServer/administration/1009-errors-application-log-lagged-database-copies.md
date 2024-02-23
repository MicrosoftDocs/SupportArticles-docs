---
title: Event ID 1009 flood Application log for lagged database copies in Exchange Server 2016
description: Describes a scenario in which many Event ID 1009 messages are logged for lagged database copies in Exchange Server 2016.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: v-six, genli, christys, meerak, anthonge, ninob, v-six
appliesto: 
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2016 Enterprise Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# 1009 errors flood Application log for lagged database copies in Exchange Server 2016

_Original KB number:_ &nbsp;4023757

## Symptoms

Consider the following scenario:

- You have Exchange Database Availability Groups (DAGs) deployed in your organization and enabled lagged database copies configuration.
- You have Cumulative Update 4 or Cumulative Update 5 installed for Microsoft Exchange Server 2016 installed.

In this situation, you notice many warning messages with **event ID 1009**  in the Application log in Exchange Server 2016. The message resembles the following:

```console
Log Name: <Log Name>
Source: MSExchangeFastSearch
Date: <Date>
Event ID: 1009
Task Category: General
Level: Warning
Keywords: <Keywords>
User: N/A
Computer: <Computer Name>
Description:
The indexing of mailbox database <Database Name> encountered an unexpected exception. Error details: Microsoft.Exchange.Search.Core.Abstraction.OperationFailedException: The component operation has failed. ---> Microsoft.Exchange.Search.Core.Abstraction.OperationFailedException: The component operation has failed. ---> Microsoft.Exchange.Search.Engine.FeedingSkippedException: "Feeding was skipped for <Database ID> due to the state 'Unknown', error code: 'Unknown'."
```

:::image type="content" source="media/1009-errors-application-log-lagged-database-copies/event-1009.png" alt-text="Screenshot of the window for Even Properties - Event 1009.":::

## Resolution

You can safely ignore these logged events. However, [Cumulative Update 6 for Exchange Server 2016](https://support.microsoft.com/help/4012108) includes a change that represses these messages.
