---
title: Chat issues in Teams meeting
description: Fixes some chat issues when you join a Teams meeting. For example, the Chat icon is missing and you can't access the chat history.
author: v-charloz
ms.author: v-chazhang
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting 
ms.service: msteams
localization_priority: Normal
ms.custom: 
- CI 154689
- CSSTroubleshoot
ms.reviewer: sylviebo; meerak
appliesto:
- Microsoft Teams
search.appverid: 
- MET150
---

# Chat issues in Teams meeting

## Symptoms

You may experience one of the following chat issues when you join a Microsoft Teams meeting:

- The **Chat** icon is missing.
- You receive the "Administrator has disabled chat for this user" error message.
- You can't access the chat history.

## Cause

These issues may occur because of one of the following causes.

**Cause 1**: The **Allow chat in meetings** meeting policy is disabled.

**Cause 2**: The number of people in a meeting exceeds the maximum limit: 1000.

**Cause 3**: Meeting participants who were added to a meeting via a meeting link (such as a meeting forward), and were not added to the original meeting invite will only have access to chats, files, notes, and other meeting content during the meeting, but lose access once the meeting ends. In addition, if this meeting is part of a recurrence, the user may not have access to the chat after the meeting.

## Resolution

To ensure that it isn't a transient issue, leave the meeting and rejoin the meeting to see if the issue is fixed. If the issue still persists, check the following resolutions that correspond to the causes. You may need to try all the three resolutions before the issue is fixed.

**Resolution 1**: Administrators can enabled and configure the policy setting in the Microsoft Teams admin center by following the steps:

1. In **Microsoft Teams admin center**, select **Users**.
1. Select the user, select **Policies** and then select the meeting policy assigned to the user.
1. In the **Participants & guests** page, change **Allow chat in meetings** to **Enabled**.

To view other users that have been assigned this meeting policy:

1. In **Microsoft Teams admin center**, select **Users**.
1. On the right of the Search bar, select the **Filter** icon.
1. Select **Meeting policy** and the name of the policy that was changed above.
1. Select **Apply**. A list of users with this policy is displayed.

Teams for Education users, refer to the [policy packages](/microsoftteams/policy-packages-edu) or the [Teams for Education policy wizard](/microsoftteams/easy-policy-setup-edu?tabs=students%2Cstudent-settings) to manage meeting policies.

**Resolution 2**: Make sure the number of people in a meeting is under the limit. For more information, see [Limits and specifications for Microsoft Teams](/microsoftteams/limits-specifications-teams#meetings-and-calls).

**Resolution 3**: To enable access to the chat, meeting organizer should invite the user to the meeting series.
