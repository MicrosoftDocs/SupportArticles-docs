---
title: Outlook displays "This information service is not installed on your computer" error message
description: This article provides a resolution for the error message about the information service that is displayed when trying to start Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: aruiz, twalker
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Outlook 2013
  - Outlook 2010
  - Outlook 2007
ms.date: 01/30/2024
---
# Outlook displays "This information service is not installed on your computer" error message

_Original KB number:_ &nbsp; 2772566

## Symptoms

When you start Office Outlook 2007, Outlook 2010, or Outlook 2013, you see the following error:

> This information service is not installed on your computer.

## Cause

You or your administrator installed Office or Outlook without the Exchange Server provider.

## Resolution

To resolve this issue, you or your administrator should make sure that the Exchange Server component is installed. To make sure that the correct component is installed, follow these steps:

1. In Windows, search for and start **Add or Remove Programs**.
2. Click **Microsoft Office** and then click **Change**.
3. Use the **Add or Remove Features** option.
4. Navigate to **Microsoft Outlook**, **Outlook Messaging Components**, **Outlook Mapi Service Providers**, and make sure that the **Microsoft Exchange Server** component is set to **Run from my computer**.
5. Click **Continue** to complete setup.
