---
title: Exchange Server setup doesn't run as expected if you start it from PowerShell using Setup.exe
description: Exchange Server setup doesn't run as expected if you start it from PowerShell using Setup.exe
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: lusassl, v-six, v-kccross
manager: dcscontentpm
ms.custom: 
  - sap:Plan and Deploy\Exchange Install Issues, Cumulative or Security updates
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 11515
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
  - Exchange Server 2013
ms.date: 04/26/2026
---

# Exchange Server 2019 setup doesn't run as expected if you start it from PowerShell by using Setup.exe

## Summary

This article explains a known issue in which Exchange Server setup might not run the expected upgrade when you start Setup.exe from PowerShell or at the command prompt by using only the file name. It also provides the correct syntax to run Setup from the installation source.

## Symptoms

Consider the following scenario:

- You plan to run an unattended setup to upgrade Microsoft Exchange Server 2019, Microsoft Exchange Server 2016, or Microsoft Exchange Server 2013 from PowerShell or at the command prompt by using Setup.exe.
- You put the setup media on the D: drive.
- You start the unattended installation from PowerShell or command prompt as "`setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`" instead of "`.\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`" (PowerShell) or "`D:\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`" (PowerShell or command prompt).

In this situation, the Exchange Server Setup program starts, and it might indicate that it successfully completed. However, Exchange itself isn't updated.

## Cause

When you run a command in PowerShell or at the command prompt, the system first checks the paths in the System environment variable "Path" to verify the command being executed. Then, the system checks the current path in PowerShell or command prompt, unless you:

- Enter ".\" in front of the command or program you're executing in PowerShell, or
- Use the Tab key to automatically add the ".\" in front of the command or program you're running in PowerShell, or
- Use the full path to run setup.exe (for example "`D:\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`") in PowerShell or at the command prompt.

PowerShell finds and runs a setup.exe file located in `C:\Program Files\Microsoft\Exchange Server\V15\bin` instead of the setup.exe in the current path.

## Workaround

To run an upgrade, use "`.\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`" (PowerShell) or "`D:\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`" (PowerShell and at the command prompt) to start the command.
