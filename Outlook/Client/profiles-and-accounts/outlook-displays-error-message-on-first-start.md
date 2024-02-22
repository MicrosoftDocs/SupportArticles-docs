---
title: Outlook displays an error message on first start
description: Provides a resolution for when you see an error message the first time you start Outlook.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: CSSTroubleshoot
appliesto:
- Outlook for Microsoft 365
- Outlook 2021
- Outlook 2019
- Outlook 2016
- Exchange Online
- Windows 11
- Windows 10
author: cloud-writer
ms.author: meerak
search.appverid: MET150
ms.reviewer: pedrocorreia, gbratton
ms.date: 10/30/2023
---
# Outlook displays an error message on first start

## Symptoms

After you successfully add your Microsoft Exchange email account to Microsoft Outlook, and start Outlook for the first time, the following error message is displayed:

> An unexpected error has occurred.

## Cause

This error occurs if your Windows user profile contains a unicode character as shown in the following screenshot:

:::image type="content" source="media/outlook-displays-error-message-on-first-start/unicode-characters-in-user-profile-name.png" alt-text="Screenshot of the path to a Windows user profile name that has unicode characters." border="false":::

If your Windows device is AzureAD-joined and you sign in to Windows with your AzureAD account, your Windows user profile will be built with your AzureAD display name. If your AzureAD display name includes a unicode character, it will be used in your Windows user profile name as well.

## Resolution

To resolve this issue, change your regional settings.

1. Open **Control Panel**, and select **Change date, time, or number formats**.
1. In the **Region** dialog box on the **Administrative** tab, select **Change system locale**.
1. In the **Region Settings** dialog box, select the check box for **Beta: Use Unicode UTF-8 for worldwide language support**.

    :::image type="content" source="media/outlook-displays-error-message-on-first-start/region-settings-dialog.png" alt-text="Screenshot of the Region Settings dialog box with the check box for Beta: Use Unicode UTF-8 for worldwide language support selected." border="true":::

1. Select **OK** and when prompted, restart Windows.
1. Open Outlook. It should start without displaying the error message.
1. Open the **Region Settings** dialog box again, uncheck the check box for **Beta: Use Unicode UTF-8 for worldwide language support** and restart your computer.
<br> This step is recommended to avoid potential compatibility issues between the beta option and the applications installed on your computer.
