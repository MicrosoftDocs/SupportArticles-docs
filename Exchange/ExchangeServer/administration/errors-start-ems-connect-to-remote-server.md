---
title: Errors when you start EMS
description: Exchange Management Shell and remote PowerShell fail to launch after the July 2017 security update KB4025333 for Windows Server is installed.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: robwhal, v-six
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2016 Enterprise Edition
  - Exchange Online
ms.date: 01/24/2024
---
# Error (Method not found or Can't generate Export-Module) in Exchange Management Shell and remote PowerShell

_Original KB number:_ &nbsp; 4037313

## Symptoms

You may meet the following issues when you use Microsoft Exchange Server 2016 and Exchange Online after the [July 2017 security update KB4025333 for Windows Server](https://support.microsoft.com/help/4025333/windows-8-update-kb4025333) is installed.

### Issue 1

When you open the Exchange Management Shell, you receive the following message in the Exchange Management Shell:

> WARNING: Can't generate Export-Module for the current session using Import-PSSession.

### Issue 2

When you try to use Windows PowerShell to connect to a remote Exchange Server 2016 or Exchange Online, you receive the following error message in Windows PowerShell:

> Import-PSSession: Method not found: 'System.String System.Management.Auomation.CommandMetadata.EscapeBlockComment(System.String)'

## Cause

These issues occur because [KB 3000850](https://support.microsoft.com/help/3000850) isn't applied. The July 2017 security update has a dependency on KB 3000850.

## Workaround

To work around this issue, install KB 3000850 to resolve the missing dependency.
