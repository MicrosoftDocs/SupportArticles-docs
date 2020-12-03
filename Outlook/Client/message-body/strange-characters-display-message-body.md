---
title: Strange characters are displayed in meeting requests, read receipts, and IRM messages
description: Provide a workaround to an issue in which recipients receive messages with a mix of characters in various languages in Outlook.
author: TobyTu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: gabesl
ms.custom: 
<<<<<<< HEAD
=======
- Outlook for Windows
>>>>>>> 9636ec41e46ab2dc8905e73867dbca8a174def74
- CSSTroubleshoot
- CI 124779
appliesto:
- Outlook for Microsoft 365
- Outlook 2016
---

# Strange characters are displayed in meeting requests, read receipts, and IRM messages

## Symptoms

<<<<<<< HEAD
In Microsoft Outlook and Outlook for Microsoft 365, some recipients may receive email messages with a mix of characters in various languages in the text body. The messages may take a while to load.

:::image type="content" source="media/strange-characters-display-message-body/garbled-body.png" alt-text="Screenshot of garbled-body garbled body.":::

It may happen with:
=======
In Microsoft Outlook and Outlook for Microsoft 365, some recipients receive email messages that contain a mix of characters in various languages in the text body. The messages may take some time to load.

:::image type="content" source="media/strange-characters-display-message-body/garbled-body.png" alt-text="Screenshot of garbled-body garbled body.":::

This issue can occur in the following media:
>>>>>>> 9636ec41e46ab2dc8905e73867dbca8a174def74

- Read Receipts
- Email Recalls
- Meeting Requests
- IRM email messages

## Cause

A beta Windows Unicode UTF-8 support setting is enabled by the sender. Outlook doesn't support this setting.

## Workaround

<<<<<<< HEAD
To prevent this from happening on newly created items, follow these steps:

1. In Windows, hold the **Windows** key + **R** to open the **Run** prompt.
2. Type in **intl.cpl** and press **Enter**.
3. Navigate to **Administrative** > **Change system local…**.
4. Uncheck **Beta: Use Unicode for UTF-8 worldwide language support**.
5. Restart the computer.
=======
To prevent this issue from occurring on newly created items, the sender must follow these steps:

1. Open the system **Settings** window. To do this, select the **Settings** button in the notification area of the Taskbar.
2. Select **Time & Language**.
3. Select **Language**.
4. Under **Related settings**, select **Administrative language settings**.
5. In the **Language for non-Unicode programs** area, select **Change system locale**.
6. Clear the **Beta: Use Unicode for UTF-8 worldwide language support** check box.
7. Restart the computer.
>>>>>>> 9636ec41e46ab2dc8905e73867dbca8a174def74
