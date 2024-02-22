---
title: Running Update cmdlet fails
description: Fixes an issue in which you receive an error message that states the network path was not found. This issue occurs when you run an Update cmdlet in an Exchange Server 2010 environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Error when you run an Update cmdlet in an Exchange Server 2010 environment: The network path was not found

_Original KB number:_ &nbsp; 2770541

## Symptoms

When you run an `Update` cmdlet in an Exchange Server 2010 environment, you receive an error message: The network path was not found. For example, when you run the `Update-MailboxDatabaseCopy -Identity "Database Name" -DeleteExistingFiles` cmdlet in Exchange Management Shell, you receive an error message that resembles the following:

> The network path was not found.
> Warning: An unexpected error has occurred and a Watson dump is being generated: The network path was not found.

## Cause

This issue occurs because the Remote Registry service is stopped on the server where you run the `Update` cmdlet.

## Workaround

To work around this issue, start the Remote Registry service. To do this, follow steps:

1. On the computer where you want to run the cmdlet, select **Start**, type *services.msc* in the Start Search box, and then press Enter. Microsoft Management Console starts with the Services snap-in open.
2. In the console pane, right-click **Remote Registry**, and then select **Start**.
