---
Title: The Exchange administrator made a change that requires users to restart Outlook
description: Describes a message received by users that tells them to restart Outlook, but doesn't tell them why. The message is prompted by a configuration change made by the administrator.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: Pedro Correia, v-kccross
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
appliesto:
- Exchange Online
- Outlook 2024
- Outlook 2021
- Outlook 2019
- Outlook 2016
ms.date: 01/16/2026
---

## Summary

This article explains that users of classic Outlook for Windows might receive a message to restart Outlook due to changes made by the Exchange administrator. The message is associated with Event 67 and recommends that administrators correlate this event with the audit log to identify the cause of the message.

## Symptoms

While working in classic Outlook for Windows, users might receive the following message:

> The Microsoft Exchange administrator has made a change that requires you quit and restart Outlook.

Users should select **OK** to dismiss the message and then manually restart Outlook. Outlook doesn't automatically restart.

## Cause

There is no single cause for this specific dialog to appear. However, when it does occur, Event 67 is recorded in the Event Viewer.

To access Event 67, use the following steps.

1. On the affected user's computer, select the **Start** menu or press the **Windows** key on the keyboard.
1. Type **Event Viewer** in the search bar and select it from the search results.
1. Select **Windows Logs** > **Application**.
1. In the **Event ID** column, find and select **Event ID 67**.

   The **General** and **Details** tabs in the **Properties** pane provide information about the event.

   ![A screenshot of Event 67 in the Event Viewer.](media/change-requires-restart/event-67.png)

## Resolution

Correlate the details provided in Event 67 with the information in the administrator audit log to identify the changes that might have caused the message to display in Outlook.
