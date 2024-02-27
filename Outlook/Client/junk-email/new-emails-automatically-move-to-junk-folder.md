---
title: New emails automatically move to Junk folder
description: Resolves an issue in which new email messages move to the Junk folder in Microsoft Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Microsoft Outlook 2010
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# New email messages automatically move to the Junk folder in Microsoft Outlook

_Original KB number:_ &nbsp; 2961409

## Symptom

Consider the following scenario:

- You have a Samsung mobile device that is using the default mail application.
- The **spam addresses** feature on the device contains entries.
- You run Microsoft Outlook 2010 or a later version.

In this scenario, intermittently, new email messages automatically move to a folder that is named either **Junk** or **Unwanted**.

> [!NOTE]
> This issue occurs even though you didn't create the **Junk** folder or the **Unwanted** folder in your mailbox.

## Resolution

To resolve this issue, follow these steps:

1. On the mobile device, start the email app.
2. Press the Menu key, select **Settings**, and then select **General Settings**.
3. Select **Spam addresses**, and then remove any addresses that should not be there. For example, remove your corporate domain.
