---
title: Unable to open EMS on an Exchange Server Edge Transport server by using LaunchEMS command
description: This article provides a solution to an issue in which you're unable to open EMS on an Exchange Server Edge Transport server by using the LaunchEMS command. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:OWA  And Exchange Admin Center\Issues connecting to Exchange Management Shell
  - Exchange Server
  - CI 106819
  - CI 9823
  - CI 12236
  - CSSTroubleshoot
ms.reviewer: cmcgurk, EXOL_Triage, v-six, v-kccross
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
search.appverid: 
  - MET150
ms.date: 07/29/2026
---

# Can't open EMS on an Exchange Server Edge Transport server by using the LaunchEMS command

## Summary

This article describes an issue in which the Exchange Management Shell (EMS) doesn't open on an Exchange Server Edge Transport server when you use the `LaunchEMS` command. The issue occurs because the `LaunchEMS` command isn't created during the Edge Transport role installation. To access EMS on the Transport server, run `exshell.psc1` and then `exchange.ps1` from a command prompt.

## Symptoms

Consider the following scenario:

- You install the Microsoft Exchange Server Edge Transport role on Windows Server 2019 Core.
- You try to use the `LaunchEMS` command to open the Exchange Management Shell.

In this scenario, the Exchange Management Shell doesn't open. However, the command works on an Exchange Server Mailbox server.

## Cause

This issue occurs because the `LaunchEMS` command isn't created on the Exchange Server Edge Transport servers during installation.

## Resolution

To fix this issue on an Exchange Server Edge Transport server, open the Exchange Management Shell by running the following commands in the given order at the command prompt:

```console
exshell.psc1
```

```console
exchange.ps1
```
