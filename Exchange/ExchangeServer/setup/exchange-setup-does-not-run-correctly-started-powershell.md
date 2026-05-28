---
title: Exchange Server setup doesn't run as expected if you start it from PowerShell using setup.exe
description: Exchange Server setup doesn't run as expected if you start it from PowerShell using only the filename `setup.exe`.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: lusassl, v-six, v-kccross
manager: dcscontentpm
ms.custom: 
  - sap:Setup Issues
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
ms.date: 05/27/2026
---

# Exchange Server Setup doesn't run as expected if you start it from PowerShell by using `setup.exe`

## Summary

This article explains a known issue in which Exchange Server Setup might not run the expected upgrade when you start `setup.exe` in PowerShell or at a command prompt by using only the file name. The article also provides the correct syntax to run `setup.exe` from the installation source.

## Symptoms

Consider the following scenario:

- You plan to run an unattended setup to upgrade Microsoft Exchange Server in PowerShell or at a command prompt by using `setup.exe`.
- You put the setup media on drive D.
- You start the unattended installation in PowerShell or at command prompt as "`setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`" instead of "`.\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`" (PowerShell) or "`D:\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`" (PowerShell or command prompt).

In this situation, the Exchange Server Setup program starts, and it might indicate that it successfully finished. However, Exchange Server itself isn't updated.

## Cause

When you run a command in PowerShell or at a command prompt, the system first checks the paths in the "Path" System environment variable to verify the command that's being run. Then, the system checks the current path in PowerShell or the command prompt, unless you complete one of the following tasks:

- Enter ".\" in front of the command or program that you're running in PowerShell.
- Use the Tab key to automatically add the ".\" in front of the command or program that you're running in PowerShell.
- Use the full path to run `setup.exe` in PowerShell or at the command prompt. For example, you use the path, "`D:\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`."

PowerShell finds and runs a `setup.exe` file located in `C:\Program Files\Microsoft\Exchange Server\V15\bin` instead of the `setup.exe` in the current path.

## Resolution

To run an upgrade, use "`.\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`" (PowerShell) or "`D:\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`" (in PowerShell and at the command prompt) to start the command.
