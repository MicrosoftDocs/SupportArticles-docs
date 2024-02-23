---
title: Cannot get child of ADObjectId error
description: Describes an issue that prevents the Edge Transport server role from being installed on a domain-joined computer that's running Exchange Server 2016 or Exchange Server 2013. A workaround is provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: suku, dpaul, meerak, v-six
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2019
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
ms.date: 01/24/2024
---
# Error when you install the Edge Transport server role on a domain-joined Exchange server: Cannot get child of ADObjectId

_Original KB number:_ &nbsp; 3205799

## Symptoms

This issue occurs in a Microsoft Exchange Server 2016 environment with Cumulative Update 2 or later update installed, or in an Exchange Server 2013 environment with Cumulative Update 14 or later installed. When setup fails, you see the following error in the Setup log:

> Error:
> The following error was generated when "$error.Clear(); new-ExchangeServer" was run: "System.ArgumentNullException: Value cannot be null.  
Parameter name: Cannot get child of ADObjectId: this is a GUID based ADObjectId.

## Workaround

To work around this issue, use one of the following methods:

- Run setup again using the setup UI. Running setup from PowerShell might not allow you to work around the problem at this time.
- Unjoin the server from the domain, install the Edge Transport server role, and then rejoin the domain.

## More information

Setup of the Edge Transport server role will never fail if the `Setup.exe /PrepareAD` command isn't run.  

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in **Applies to**.
