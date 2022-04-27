---
title: Chat issues in Teams meeting
description: Fixes some meeting chat issues when you join a Teams meeting. For example, the Chat icon is missing and you can't see the meeting chat history.
author: v-charloz
ms.author: v-chazhang
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 154689
  - CSSTroubleshoot
ms.reviewer: sylviebo; meerak
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 3/31/2022
---

# Chat issues in Teams meeting

## Symptoms

As an attendee in a Microsoft Teams meeting, you might experience one of the following issues when you try to access the meeting chat:

- The **Chat** icon is missing.
- When you select the **Chat** icon, you see the following error message:
    > The Administrator has disabled the Chat
- You can't see the meeting chat history.

## Cause

These issues can have any of the following causes.

**Cause 1**: The **Allow chat in meetings** setting is disabled in the meeting policy that's assigned to you.

**Cause 2**: The number of attendees in the meeting exceeds 1,000 (is the maximum number that's supported for chat).

**Cause 3**: You were added to the meeting as an attendee by using a meeting link such as one that's shared in a forwarded meeting invitation. However, you were not added to the original invitation. In this scenario, attendees will have access to chats, files, notes, and other meeting content only during the meeting, and will lose access to them after the meeting ends. If this is a recurring meeting, then attendees will also not have access to the meeting chat in subsequent meetings.

## Resolution

To make sure that this isn't a transient issue, leave and rejoin the meeting. If the issue persists, try the following resolutions.

**Resolution 1**: Enable the **Allow chat in meetings** setting.

Meeting policies are enabled and configured by Teams administrators. To update the meeting policy that's assigned to you, an administrator should follow these steps:

1. In the **Microsoft Teams admin center**, select **Users**.
1. Select your name from the list of users, select **Policies**, and then select the meeting policy that's assigned to you.
1. In the **Participants & guests** section for the **Allow chat in meetings** setting, select **Enabled** from the drop-down list.

The administrator can check and update the setting for other users who have been assigned the same meeting policy. To get a list of those users, follow these steps:

1. In the **Microsoft Teams admin center**, select **Users**.
1. To the right of the Search bar, select the **Filter** icon.
1. Select **Meeting policy** and the policy that was updated to enable chat in meetings.
1. Select **Apply**. A list of users who have been assigned the policy is displayed.

> [!NOTE]
> If you're using Teams for Education, use [policy packages](/microsoftteams/policy-packages-edu) or the [Teams for Education policy wizard](/microsoftteams/easy-policy-setup-edu?tabs=students%2Cstudent-settings) to manage meeting policies.

**Resolution 2**: The meeting organizer should make sure that the number of attendees in the meeting is less than the maximum limit. For more information, see [Limits and specifications for Microsoft Teams](/microsoftteams/limits-specifications-teams#meetings-and-calls).

**Resolution 3**: To enable access to the chat after the meeting is over, the meeting organizer should add the attendee to the original meeting invitation or to the original recurring meeting series, as appropriate.
