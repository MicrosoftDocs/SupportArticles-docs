---
title: Troubleshoot Windows PowerShell issues for Exchange Online
description: Describes how to troubleshoot issues that may occur when you try to use Windows PowerShell cmdlets for Exchange Online in Office 365.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Online
- CSSTroubleshoot
ms.reviewer: jhayes
appliesto:
- Exchange Online
search.appverid: MET150
---
# How to troubleshoot Windows PowerShell issues that affect Exchange Online for Office 365

_Original KB number:_ &nbsp; 2570535

## Summary

This article describes how to troubleshoot Windows PowerShell issues that affect Microsoft Exchange Online for Microsoft Office 365.

## Resolution

Windows PowerShell is a command-line interface that's used to run administrative commands on Windows operating systems and server products. Windows PowerShell 2.0 includes Remote Windows PowerShell functionality.

Remote Windows PowerShell lets users run Windows PowerShell cmdlets on other computers or web services. This functionality relies on the Windows Remote Management service to connect to web services and to download the available cmdlets, based on the user who is currently logged in. Office 365 lets admins connect to Exchange Online by using Exchange Online remote PowerShell.

To connect to Exchange Online, you must have the following tools:

- Windows PowerShell 2.0
- Windows Remote Management 2.0 (also known as WinRM)
- Background Intelligent Transfer Service (BITS) 4.0

The Windows Management Framework installs all these tools.

For more information about how to connect to Exchange Online by using remote PowerShell, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

### Troubleshoot the Windows PowerShell connection to Exchange Online

To troubleshoot the Windows PowerShell connection to Exchange Online issues, see the following articles:

- ["WinRM client cannot process the request" error when you connect to Exchange Online through remote Windows PowerShell](./winrm-cannot-process-request.md)
- [https://docs.microsoft.com/en-us/exchange/troubleshoot/administration/access-denied-connect-powershell](./access-denied-connect-powershell.md)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).