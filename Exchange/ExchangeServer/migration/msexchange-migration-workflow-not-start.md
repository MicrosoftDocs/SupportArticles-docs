---
title: Microsoft Exchange Migration Workflow service doesn't start in Exchange Server 2013 Cumulative Update 3
description: Describes an issue in which Microsoft Exchange Migration Workflow Service doesn't start in Exchange Server 2013 Cumulative Update 3.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration\Issues with Move Mailbox within same organization
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: batre, v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Microsoft Exchange Migration Workflow service fail to start in Exchange Server 2013 Cumulative Update 3

_Original KB number:_ &nbsp;2901754

## Symptoms

After you install Microsoft Exchange Server 2013 Cumulative Update 3, you see that a new service, Microsoft Exchange Migration Workflow, is configured in Manual startup mode. However, the service doesn't start even when you try to manually start it. Additionally, you notice following events in Application log:

```console
Log Name: Application
Source: MSExchange Migration Workflow
Event ID: 1002
Task Category: Service
Level: Warning
Keywords: Classic
User: N/A
Computer: name.contoso.com
Description: The Microsoft Exchange Migration Workflow service didn't start because it's disabled.
```

```console
Log Name: Application
Source: MSExchange Migration Workflow
Event ID: 1003
Task Category: Service
Level: Error
Keywords: Classic
User: N/A
Computer: name.contoso.com
Description: The Microsoft Exchange Migration Workflow service failed to start.
```

## Cause

The Microsoft Exchange Migration Workflow service is just a placeholder for a service that will be implemented in the future. So the behavior that's described in the "Symptoms" section is the expected behavior.

> [!NOTE]
> Leave the service startup type set to **Manual** or change it to **Disabled** to prevent the system from trying to automatically start the service.
