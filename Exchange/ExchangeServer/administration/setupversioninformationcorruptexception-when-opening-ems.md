---
title: SetupVersionInformationCorruptException if opening EMS
description: The SetupVersionInformationCorruptException error occurs when you open Exchange Management Shell (EMS) in Exchange Server 2016. Provides workarounds to solve this issue.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: jasonsla, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
search.appverid: MET150
---
# SetupVersionInformationCorruptException error when you open Exchange Management Shell

_Original KB number:_ &nbsp; 4056663

## Symptoms

When you open EMS, you receive the following error message:

> [SetupVersionInformationCorruptException]Unable to determine the installed file version from the registry key

## Cause

This issue can occur after you uninstall PowerShell 2.0. When you uninstall PowerShell 2.0, the uninstall process also removes the following registry key that EMS uses to determine whether PowerShell is installed:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\1\PowerShellEngine`

## Workaround 1 - Import the registry key

1. Download the [PowerShellEngine registry key](https://gallery.technet.microsoft.com/Exchange-2016-CU1-7c843cb0#content).
2. Import the registry key into the server.

## Workaround 2 - Reinstall PowerShell 2.0

To install PowerShell 2.0, see [Installing the Windows PowerShell 2.0 Engine](/powershell/scripting/windows-powershell/install/installing-the-windows-powershell-2.0-engine).

## Status

Microsoft is working to resolve this problem and will post more information in this article when the information becomes available.
