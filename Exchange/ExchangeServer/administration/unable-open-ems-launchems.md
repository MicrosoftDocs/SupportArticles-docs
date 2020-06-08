---
title: Unable to open EMS on an Exchange Server 2019 Edge Transport server by using LaunchEMS command
description: This article describes an issue in which you are unable to open EMS on an Exchange Server 2019 Edge Transport server by using LaunchEMS command. Provides a resolution.
author: TobyTu
ms.author: cmcgurk
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- CI 106819
- CSSTroubleshoot
ms.reviewer: cmcgurk, EXOL_Triage
appliesto:
- Exchange Server 2019
search.appverid: 
- MET150
---

# Can't open EMS on an Exchange Server 2019 Edge Transport server by using the LaunchEMS command

## Symptoms

Consider the following scenario:

- You have installed the Microsoft Exchange Server 2019 Edge Transport role on Windows Server 2019 Core.
- You try to use the `LaunchEMS` command to open the Exchange Management Shell.

In this scenario, the Exchange Management Shell does not open. However, the command does work on an Exchange Server 2019 Mailbox server.

## Cause

This issue occurs because the `LaunchEMS` command isn't created on the Exchange Server 2019 Edge Transport servers during installation.

## Resolution

To fix this issue on an Exchange Server 2019 Edge Transport server, you can open the Exchange Management Shell by running the following commands in the given order at the command prompt:

```
exshell.psc1
```

```
exchange.ps1
```
