---
title: Strange characters in Outlook email text
description: Provide a workaround to an issue in which recipients receive messages with a mix of characters in various languages in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.reviwer: gabesl
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
  - CI 124779
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2016
ms.date: 01/30/2024
---

# Strange characters are displayed in meeting requests, read receipts, and IRM messages

## Symptoms

In Microsoft Outlook and Outlook for Microsoft 365, some recipients receive email messages that contain a mix of characters in various languages in the text body. The messages may take some time to load.

This issue can occur in the following media:

- Read Receipts
- Email Recalls
- Meeting Requests
- IRM email messages

## Cause

A beta Windows Unicode UTF-8 support setting is enabled by the sender. Outlook doesn't support this setting.

## Workaround

To prevent this issue from occurring on newly created items, the sender must follow these steps:

1. Open the system **Settings** window. To do this, select the **Settings** button in the notification area of the Taskbar.
2. Select **Time & Language**.
3. Select **Language**.
4. Under **Related settings**, select **Administrative language settings**.
5. In the **Language for non-Unicode programs** area, select **Change system locale**.
6. Clear the **Beta: Use Unicode for UTF-8 worldwide language support** check box.
7. Restart the computer.
