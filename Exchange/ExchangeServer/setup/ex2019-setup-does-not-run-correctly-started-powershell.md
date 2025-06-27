---
title: Exchange Server 2019 setup does not run as expected if started from PowerShell using Setup.exe
description: Exchange Server 2019 setup does not run as expected if started from PowerShell using Setup.exe
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: lusassl, v-six
manager: dcscontentpm
ms.custom: 
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
ms.date: 01/24/2024
---

# Exchange Server 2019 setup does not run as expected if started from PowerShell using Setup.exe

## Symptoms

Consider the following scenario:

- You plan to run an unattended setup to upgrade Microsoft Exchange Server 2019, Microsoft Exchange Server 2016, or Microsoft Exchange Server 2013 from PowerShell or command prompt using Setup.exe
- The setup media is located on D: drive
- The unattended installation is started from PowerShell or command prompt as "`setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`" instead of "`.\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`" (PowerShell) or "`D:\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`" (PowerShell or command prompt).

In this situation, the Exchange Server Setup program starts, and may indicate that it's successfully completed. However, Exchange itself isn't updated.

## Cause

When you run a command in PowerShell or command prompt, the paths in the System environment variable "Path" are first checked to verify the command being executed, before the current path in PowerShell or command prompt is checked, unless:

- ".\" is entered in front of the command or program being executed in PowerShell, or
- the Tab key is used to automatically add the ".\" in front of the command or program being executed in PowerShell, or
- the full path is used to run the setup.exe (for example "`D:\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`") in PowerShell or command prompt.

A setup.exe file located in `C:\Program Files\Microsoft\Exchange Server\V15\bin` is found and executed by PowerShell, instead of the setup.exe in the current path.

## Workaround

If you run an upgrade, use "`.\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`" (PowerShell) or "`D:\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`" (PowerShell and command prompt) to start the command.
