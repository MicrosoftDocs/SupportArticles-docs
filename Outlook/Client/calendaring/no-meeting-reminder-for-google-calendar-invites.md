---
title: Outlook doesn't show a reminder for a Google Calendar event invitation
description: Describes an issue in which Outlook doesn't show a reminder for a Google Calendar event invitation.
author: v-trisshores
ms.author: v-trisshores
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gbratton, hugopanao, laurentc, meerak
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2019
  - Outlook 2016
  - Outlook LTSC 2021
search.appverid: MET150
ms.date: 10/12/2022
---
# Outlook doesn't show a reminder for Google Calendar event invitation

## Symptoms

When you receive a Google Calendar event invitation in Outlook, the **Reminder** setting in the Outlook meeting displays "None".

## Cause

The sender of the Google Calendar event used the default notification time. In this scenario, Google Calendar doesn't add an event reminder in the ICS file attached to the invite email.

Outlook adds the event to your calendar based on the information in the invite ICS file.

> [!NOTE]
> Although the Google Calendar default notification time is typically 30-minutes, the issue occurs for any default notification time. The issue also occurs if there are multiple default notification times.

## Workaround

In the following examples, Google Calendar successfully adds a reminder. Senders of Google Calendar event invites can use these techniques to add a reminder to external invites.

- The default Google Calendar event notification time is 30-minutes but a Google Calendar user manually changes the notification time to 25-minutes. The Google Calendar invite will contain a 25-minute reminder entry in the ICS file. When Outlook adds the event to your calendar, the new meeting will have a 25-minute reminder.

- A Google Calendar user keeps the default event notification time but manually adds another notification with a different time. The Google Calendar invite will contain both reminder times in the ICS file. When Outlook adds the event to your calendar, the new meeting will use the shorter of the two reminder times.

If a reminder isn't set in a Google Calendar invitation that you receive in Outlook, you can set a reminder manually in Outlook.

## More Information

To check for an event reminder in an invite ICS file, open the ICS file in a text editor and look for a [VALARM](https://www.rfc-editor.org/rfc/rfc9074.html#section-7.2) entry. Google Calendar event invites that have no notification/reminder have no ICS VALARM entry. The following example VALARM entry specifies a 30-minute reminder:

```text
BEGIN:VALARM
ACTION:DISPLAY
DESCRIPTION:This is an event reminder
TRIGGER:-P0DT0H30M0S
END:VALARM
```
