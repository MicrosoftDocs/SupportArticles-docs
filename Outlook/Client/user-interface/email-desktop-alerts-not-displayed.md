---
title: Can't receive email desktop alerts
description: Describes an issue that prevents new email desktop alerts (toast notifications) from being displayed in Outlook 2016 or 2013. This issue Occurs when Outlook is running in Windows Server 2012 in a RemoteApp session.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2016
  - Outlook 2013
  - Windows Server 2012 R2 Standard
  - Windows Server 2012 Standard
search.appverid: MET150
ms.date: 10/30/2023
---
# Email desktop alerts (toast notifications) aren't displayed in Outlook on Windows Server 2012

_Original KB number:_ &nbsp; 3182782

## Symptoms

When you have Microsoft Outlook 2016 or Outlook 2013 running as a RemoteApp in Windows Server 2012, you don't receive new email desktop alerts (toast notifications) as expected.

## Cause

New email desktop alerts are created by explorer.exe. In a RemoteApp session, explorer.exe doesn't exist. Therefore, it can't create alerts.

## Status

Microsoft has confirmed that this is a problem in Outlook when it's running as a RemoteApp in Windows Server 2012.
