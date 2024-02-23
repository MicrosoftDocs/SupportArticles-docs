---
title: Operation cannot be performed error
description: This article fixes an issue in which you receive an error when a delegate creates a Skype or Teams meeting in Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: benwinz, aruiz, gbratton, gabesl
appliesto: 
  - Outlook 2016
search.appverid: MET150
ms.date: 10/30/2023
---
# The operation cannot be performed because the message has been changed error when a delegate creates a Skype or Teams meeting in Outlook

_Original KB number:_ &nbsp; 4502145

## Symptoms

Consider the following scenario:

- You are working in Cached mode in Microsoft Outlook.
- You are granted delegate permission for another user's calendar.
- In the other user's calendar, you create a meeting request, and then add users to the meeting through **Scheduling Assistant**.
- You enter meeting details into the request, and you wait for the request to be autosaved to the **Drafts** folder.
- You add Skype or Teams meeting by selecting **New Skype Meeting** or **New Teams Meeting** on the ribbon.
- You select **Send** to send the meeting invitation after the draft was potentially opened for several hours.

In this scenario, you receive an error message that resembles the following:

> Changes to the meeting cannot be saved. The meeting has been updated by another person. Close and reopen the meeting, and then make your updates. The operation cannot be performed because the message has been changed.

:::image type="content" source="media/operation-cannot-be-performed-error/error-details.png" alt-text="Screenshot of the Changes cannot be saved error details." border="false":::

Additionally, you may notice that the meeting isn't displayed on the delegator's calendar. However, the meeting invitation is successfully delivered to the attendees.

> [!NOTE]
> Using third-party conferencing add-ins instead of the native **New Skype Meeting** and **New Teams Meeting** commands could also cause this issue to occur.

## Cause

The message is not saved because of a  conflict between the meeting information that is stored in memory and the meeting information that is in the local cached copy. Outlook has a built-in feature to automatically save messages to **Drafts** after three minutes.

Outlook splits meeting processing into two parts:

- Saving the meeting
- Sending the meeting invitation

In this situation, sending the meeting is successful, but saving the meeting fails.

## Workaround

To work around this problem, avoid saving the meeting before you send it. You should also turn off the Outlook Autosave feature or increase the delay time before messages are autosaved.

To set the Autosave feature, follow these steps:

1. Go to **File** > **Options** > **Mail**.
2. In the **Save Messages** section, either clear the **Automatically save** check box or increase the amount of delay time before items are autosaved into **Drafts**.

The value range for **AutoSave** is from **1** to **99** minutes. Consider increasing the value to 10 minutes or more to allow more time to change the meeting contents.

:::image type="content" source="media/operation-cannot-be-performed-error/automatically-save-checkbox.png" alt-text="Screenshot of Mail settings in Outlook Options." border="false":::

Additionally, delegates can consider using Outlook on the Web (OWA) to create meetings. OWA is not affected by this problem.

## Status

A fix for this problem is available in service build **15.20.2730.00** and later versions. You can use the Connection Status dialog box to verify the service version. For more information, see [Description of the Connection Status dialog in Outlook](https://support.microsoft.com/help/2737188).

This problem is caused by Exchange Based Assistants (EBAs) in the service that write changes to the meeting item. This creates a conflict resolution issue. The current fix is to skip all notifications on meeting drafts so that no EBA or ItemAssistant can change the meeting draft. When the meeting is updated from draft to non-draft, the notification to EBAs and ItemAssistants makes changes to the meeting item. This solution will delay the EBAs and prevent the error from occurring for about 1.5 hours after you save the meeting. To avoid the conflict and the error, send the meeting invitation within 1.5 hours of saving the meeting item.

The Outlook Teams is working on a long-term solution that will prevent unexpected EBA property edits targeted to end of year 2020.
