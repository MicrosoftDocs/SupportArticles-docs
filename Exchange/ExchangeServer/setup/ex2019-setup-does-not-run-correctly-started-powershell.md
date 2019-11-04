---
title: Exchange Server 2019 setup does not run as expected if started from PowerShell using Setup.exe
description: Exchange Server 2019 setup does not run as expected if started from PowerShell using Setup.exe
author: TobyTu
audience: ITPro
ms.service: exchange-setup
ms.topic: article
ms.author: chris.mcgurk
manager: dcscontentpm
localization_priority: Normal
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Exchange Server 2019
---

# Exchange Server 2019 setup does not run as expected if started from PowerShell using Setup.exe

## Symptoms

Consider the following scenario:

- You plan to run an unattended setup to upgrade Microsoft Exchange Server 2019 from PowerShell using Setup.exe
- The setup media is located on D: drive
- The unattended installation is started from PowerShell as "`setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`" instead of "`.\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`"

In this situation, the Exchange Server 2019 Setup program starts, and may indicate that it completed successfully. However, the program isn't updated, and still shows the original version before you try the upgrade.

## Cause

When you run a command in PowerShell, the paths in the System environment variable "Path" are first checked to verify the command being executed, before the current path in PowerShell is checked, unless:

- “.\” is entered in front of the command or program being executed, or
- the Tab key is used to automatically add the “.\” in front of the command or program being executed

A setup.exe file located in `C:\Program Files\Microsoft\Exchange Server\V15\bin` is found and executed by PowerShell, instead of the setup.exe in the current path.

## Workaround

If you use PowerShell to run an upgrade, use "`.\setup.exe /m:upgrade /IAcceptExchangeServerLicenseTerms`" to start the command.
