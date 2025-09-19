---
title: Click here to view more on Microsoft Exchange hyperlink is missing
description: Provides a workaround for an issue in which email folders display only newer items and the Click-here-to-view-more-on-Microsoft-Exchange hyperlink is missing.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sending, Receiving, Synchronizing, or viewing email\Other
  - Outlook for Windows
  - CSSTroubleshoot
  - CI 1674
ms.reviewer: aruiz, meerak, v-shorestris
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook for Microsoft 365
search.appverid: MET150
ms.date: 10/19/2024
---

# "Click here to view more on Microsoft Exchange" hyperlink is missing

_Original KB number:_ &nbsp; 2898376

## Symptoms

When you use Microsoft Outlook to connect to a mailbox in Microsoft Exchange Server, one or more email folders display only newer items.

Also, the message and hyperlink that are shown in the following screenshot don't appear at the bottom of the item list.

:::image type="content" source="media/click-here-to-view-more-on-microsoft-exchange-hyperlink-is-missing/missing-message-hyperlink.png" border="true" alt-text="Screenshot of the missing message and hyperlink." lightbox="media/click-here-to-view-more-on-microsoft-exchange-hyperlink-is-missing/missing-message-hyperlink-lrg.png":::

## Cause

The cause of the issue depends on the mailbox or folder that you connect to.

### Cause 1: Your mailbox

The issue occurs if both the following conditions are true:

- In the **Send/Receive** tab, the value of the **Download Preferences** setting isn't **Download Full Items**. For example, in the following screenshot, the value is **Download Headers and Then Full Items**.

   :::image type="content" source="media/click-here-to-view-more-on-microsoft-exchange-hyperlink-is-missing/download-preferences-settings.png" border="true" alt-text="Screenshot of the Download Preferences setting.":::

- In the **Exchange Account Settings** window, the value of the **Download email for the past** setting isn't **All**. For example, in the following screenshot, the value is **3 months**.

   :::image type="content" source="media/click-here-to-view-more-on-microsoft-exchange-hyperlink-is-missing/offline-settings.png" border="true" alt-text="Screenshot of the Exchange Account Settings window.":::

   **Note**: In some versions of Outlook, the **Download email for the past** setting is named **Mail to keep offline**. For more information about the setting, see [Only a subset of your Exchange mailbox items is synchronized in Outlook](/outlook/troubleshoot/user-interface/only-subset-items-synchronized).

### Cause 2: Shared or delegate folder

If you view a shared or delegate folder in another mailbox, Outlook doesn't show any server-side items if Outlook uses [Cached Exchange Mode](https://support.microsoft.com/office/turn-on-cached-exchange-mode-7885af08-9a60-4ec3-850a-e221c1ed0c1c#ID0EDJ).

**Note**: In this context, a delegate folder is a folder that you access as a delegate.

## Workaround

Select one of the following workarounds, depending on the cause.

### Workaround for Cause 1

On the **Send/Receive** tab in Outlook, select **Download Preferences**, and then select **Download Full Items**.

> [!NOTE]
> The **Click here to view more on Microsoft Exchange** hyperlink appears only if both the following conditions are true:
> - The **Download Preferences** value is **Download Full Items**.
> - The **Download email for the past** (or **Mail to keep offline**) setting causes Outlook not to download all folder items from the server.

### Workaround for Cause 2

In an Outlook search, use the **Current Folder** scope to find server-side items.
