---
title: Click here to view more hyperlink is missing
description: Describes an issue in which your email folders display only newer items and the Click here to view more on Microsoft Exchange hyperlink is missing.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: aruiz
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 10/30/2023
---
# Click here to view more on Microsoft Exchange hyperlink is missing in Outlook

_Original KB number:_ &nbsp; 2898376

## Symptoms

When you use Microsoft Outlook 2019, Outlook 2016, Outlook 2013, or Outlook for Microsoft 365 to connect to your Microsoft Exchange Server mailbox, your email folders display only newer items. Additionally, at the bottom of the list of items, the following message and hyperlink are missing:

> This message is shown in the following figure:

:::image type="content" source="media/click-here-to-view-more-on-microsoft-exchange-hyperlink-is-missing/error-details.jpg" alt-text="The screenshot for the error" border="false":::

## Cause

This issue occurs when the following conditions are true:

- The **Download Preferences** setting is configured for **Download Headers** or **Download Headers and Then Full Items**.

  :::image type="content" source="media/click-here-to-view-more-on-microsoft-exchange-hyperlink-is-missing/configure-download-preferences.jpg" alt-text="The screenshot for Download Preferences setting" border="false":::

- The **Mail to keep offline** setting is not set to **All**.

  :::image type="content" source="media/click-here-to-view-more-on-microsoft-exchange-hyperlink-is-missing/server-settings.jpg" alt-text="The screenshot for Server settings" border="false":::

This is a known limitation in Outlook 2019, Outlook 2016, Outlook 2013, and Outlook for Microsoft 365.

## Workaround

To work around this issue, change the **Download Preferences** setting to **Download Full Items**. To do this, follow these steps:

1. Start Outlook.
2. On the **Send/Receive** tab, select **Download Preferences**, and then select **Download Full Items**.

   :::image type="content" source="media/click-here-to-view-more-on-microsoft-exchange-hyperlink-is-missing/download-preferences-settings.png" alt-text="Screenshot of Download Preferences" border="false":::

## More information

For more information about the **Mail to keep offline** setting, see [Only a subset of your Exchange mailbox items is synchronized in Outlook](/outlook/troubleshoot/user-interface/only-subset-items-synchronized).
