---
title: Can't access calendar in Outlook Web App
description: Fixes an issue in which users receive an error when they access the calendar in Outlook Web App in an Exchange Server environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Can't access the calendar in Outlook Web App in an Exchange Server environment

_Original KB number:_ &nbsp; 2780262

## Symptoms

When users try to access the calendar in Outlook Web App in an Exchange Server 2010, Exchange Server 2013, or Exchange Server 2016 environment, the users receive the following error message:

> The item you tried to access no longer exists.  
> The item wasn't found. You or a delegate might have moved or deleted it using another computer or a mobile phone.

> [!NOTE]
> This issue affects all users in the environment.

## Cause

This issue occurs because the default calendar sharing policy is missing.

## Resolution

To resolve this issue, follow these steps:

- Run the following command to create a new calendar sharing policy:

    ```powershell
    New-SharingPolicy "Default Sharing Policy" -Enabled $true -Domains *:CalendarSharingFreeBusySimple -Default $true
    ```

- Open Internet Information Services (IIS) Manager, and then recycle the MSExchangeOWAAppPool and MSExchangeOWACalendarAppPool application pools.
