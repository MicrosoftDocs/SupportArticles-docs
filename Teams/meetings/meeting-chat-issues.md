---
title: Chat issues in Teams meeting
description: Fixes some meeting chat issues when you join a Teams meeting. For example, the Chat icon is missing and you can't see the meeting chat history.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 154689
  - CI 183376
  - CSSTroubleshoot
ms.reviewer: sylviebo, meerak
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 10/26/2023
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

**Cause 1**: In the meeting policy that's assigned to you, the **Meeting chat** setting is set to **Off for everyone**.

**Cause 2**: The number of attendees in the meeting exceeds 1,000, which is the maximum number that's supported for chat.

**Cause 3**: You were added to the meeting as an attendee by using a meeting link such as one that's shared in a forwarded meeting invitation. However, you were not added to the original invitation. In this scenario, attendees will have access to chats, files, notes, and other meeting content only during the meeting, and will lose access to them after the meeting ends. If this is a recurring meeting, then attendees will also not have access to the meeting chat in subsequent meetings.

## Resolution

To make sure that this isn't a transient issue, leave and rejoin the meeting. If the issue persists, try the following resolutions.

**Resolution 1**: Update the **Meeting chat** setting in the meeting policy

Meeting policies are enabled and configured by Teams administrators. To update the meeting policy that's assigned to you, an administrator should follow these steps:

1. In the **Microsoft Teams admin center**, select **Meetings** > **Meeting policies**.
1. Select the meeting policy that's assigned to you.
1. Navigate to the **Meeting engagement** section.
1. Set **Meeting chat** to **On for everyone** or **On for everyone but anonymous users**.
1. Select **Save**.

> [!NOTE]
> If you're using Teams for Education, use [policy packages](/microsoftteams/policy-packages-edu) or the [Teams for Education policy wizard](/microsoftteams/easy-policy-setup-edu?tabs=students%2Cstudent-settings) to manage meeting policies.

**Resolution 2**: The meeting organizer should make sure that the number of attendees in the meeting is less than the maximum limit. For more information, see [Limits and specifications for Microsoft Teams](/microsoftteams/limits-specifications-teams#meetings-and-calls).

**Resolution 3**: To enable access to the chat after the meeting is over, the meeting organizer should add the attendee to the original meeting invitation or to the original recurring meeting series, as appropriate.
