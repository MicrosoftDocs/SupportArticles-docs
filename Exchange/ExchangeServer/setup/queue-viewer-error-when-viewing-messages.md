---
title: Error when you try to view queue messages in Queue Viewer
description: Resolves an issue in which Queue Viewer returns an error when you try to view queue messages.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - CI 171787
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: lusassl, srvar, nasira, meerak, v-trisshores
appliesto:
  - Exchange Server 2016
search.appverid: MET150
ms.date: 01/24/2024
---

# Error when you try to view queue messages in Queue Viewer

## Symptoms

Consider the following scenario:

- You have a client computer or server that has only the Microsoft Exchange Server 2016 [management tools](/exchange/plan-and-deploy/post-installation-tasks/install-management-tools) role (management computer).

- The management computer has the January 2023 or later Exchange Server security update (SU) installed.

In this scenario, when you try to view queue messages in [Queue Viewer](/exchange/mail-flow/queues/queue-viewer) on the management computer, Queue Viewer returns the following error message:

> Cannot bind parameter 'Filter' to the target. Exception setting "Filter": "Could not load file or assembly 'Microsoft.Exchange.ManagedLexRuntime.MPPGRuntime, Version=15.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35' or one of its dependencies. The system cannot find the file specified."

## Cause

The *Microsoft.Exchange.ManagedLexRuntime.MPPGRuntime.dll* file is missing on Exchange Server 2016 installations that have the January 2023 or later SU installed and only the Exchange Server 2016 management tools role.

## Resolution

To resolve this issue, restore the *Microsoft.Exchange.ManagedLexRuntime.MPPGRuntime.dll* file on the management computer. Follow these steps:

1. Find an Exchange Server installation that meets the following criteria:

   - Has the Exchange Server Mailbox role

   - Has the same [build](/exchange/new-features/build-numbers-and-release-dates) as the management computer (for example, Exchange Server 2016 CU 23 and January 2023 SU)

2. Copy the following file from the installation that you found in step 1 to the corresponding folder on the management computer:

   *%ExchangeInstallPath%\Bin\Microsoft.Exchange.ManagedLexRuntime.MPPGRuntime.dll*

3. Restart the management computer.
