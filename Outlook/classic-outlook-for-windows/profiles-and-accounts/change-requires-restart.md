---
title: Exchange Online admin makes a change that requires users to restart Outlook
description: Discusses a message that tells users to restart Outlook, but doesn't explain why. The message is prompted by a configuration change by the administrator.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: pedrocorreia, v-kccross
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

# Users have to restart Outlook after Exchange Online administrator makes a change

## Summary

This article explains that users of Microsoft classic Outlook for Windows might receive a message to restart Outlook because changes are made by the Microsoft Exchange Online administrator. The message is associated with Event ID 67. The article recommends that administrators correlate the event with the audit log to identify the cause of the message.

## Symptoms

While users work in classic Outlook for Windows, they receive the following message:

> The Microsoft Exchange administrator has made a change that requires you quit and restart Outlook.

After they receive this message, users should select **OK** to dismiss the message window, and then manually restart Outlook. Outlook doesn't automatically restart.

## Cause

This message window might appear for multiple reasons. However, when this issue occurs, Event 67 is recorded in Event Viewer.

To access Event 67, use the following steps:

1. On the affected user's computer, select the **Start** menu or press the Windows logo key on the keyboard.
1. Type **Event Viewer**, and then select it in the search results.
1. Select **Windows Logs** > **Application**.
1. In the **Event ID** column, find and select **Event ID 67**.

   The **General** and **Details** tabs in the **Properties** pane provide information about the event.

   ![Event ID 67 shown in Event Viewer.](media/change-requires-restart/event-67.png)

## Resolution

To identify the changes that might cause the message to appear in Outlook, correlate the details that are provided in Event 67 with the information that's available in the administrator audit log.
