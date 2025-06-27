---
title: Outlook for Mac 2011 doesn't connect to Exchange Online
description: Fixes an issue in which you can't use Outlook 2011 for Mac to connect to your Exchange Online account in Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Client Connectivity
  - Exchange Online
  - CSSTroubleshoot
  - CI 162524
ms.reviewer: v-six
appliesto: 
- Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Outlook for Mac 2011 doesn't connect to Exchange Online

_Original KB number:_ &nbsp; 2725168

## Problem

When you use Microsoft Outlook 2011 for Mac to connect to your Microsoft Exchange Online account in Microsoft 365, your email server settings aren't automatically set for Exchange Online. So, you try to manually set Outlook 2011 for Mac to connect to Exchange Online. However, the set fails, and you can't access your Exchange Online account by using Outlook 2011 for Mac.

## Cause

This problem occurs if Microsoft Exchange Web Services (EWS) is turned off in Exchange Online.

## Solution

To fix this issue, enable EWS in Exchange Online. To do this, follow these steps:

1. Connect to Exchange Online by using remote PowerShell. For info about how to do this, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. Enable EWS in Exchange Online. To do this, run one of the following cmdlets, as appropriate for your situation:
   - For a single user

        ```powershell
        Set-CASMailbox -EwsAllowOutlook $true -Identity "ONLINE USERNAME"
        ```

   - For the whole organization

        ```powershell
        Get-Mailbox | Set-CASMailbox -EwsAllowOutlook $true
        ```

## More information

EWS includes the following web services:

- Autodiscover
- Availability
- Messaging records management
- Notification
- Synchronization
- Exchange data service

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
