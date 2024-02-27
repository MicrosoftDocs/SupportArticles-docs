---
title: Manage the Google sign-in prompt
description: Describes how administrators can disable the Google account sign-in prompt that appears when users work in Outlook 2016 for Mac.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Mac
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2016 for Mac
search.appverid: MET150
ms.date: 01/30/2024
---
# Manage the Google sign-in prompt in Outlook 2016 for Mac

_Original KB number:_ &nbsp; 4340460

## Notification

When you use Outlook 2016 for Mac version 16.13 (180513) or a later version, you are prompted to sign in to your Google account.

:::image type="content" source="media/manage-the-google-sign-in-prompt-in-outlook-2016/google-in-outlook.png" alt-text="Screenshot of prompting to sign in the Google account." border="false":::

## Option to disable notification

To turn off this prompt, set the Outlook **googlePromoTriggeredPref** PLIST value to **TRUE**. To do this, follow these steps:

1. On your Mac, select **Finder** > **Applications** > **Utilities** > **Terminal**.

   :::image type="content" source="media/manage-the-google-sign-in-prompt-in-outlook-2016/finder-in-mac.png" alt-text="Screenshot to select the Finder item in the Mac toolbar.":::

2. Type the following command, and then press Return:

    ```console
    defaults write com.microsoft.Outlook googlePromoTriggeredPref -bool TRUE
    ```
