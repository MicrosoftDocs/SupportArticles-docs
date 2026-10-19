---
title: The operation cannot be performed because the item has changed error in Outlook for Exchange Online delegate meetings
description: Fix the Outlook item-changed error that appears when a delegate saves and later sends a Teams or Skype meeting from another user's calendar.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.reviewer: shanefe, v-kccross
ms.custom: 
  - sap:Calendaring\Calendar Permission
  - Exchange Online
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
  - Outlook on the web
  - Outlook for Windows
  - New Outlook for Windows
  - Outlook for Mac
ms.date: 10/07/2026
ms.service: exchange-online
ai-usage: ai-assisted
---

# Resolve the Item has changed error for delegate meetings

## Summary

Resolves the Outlook error "The operation cannot be performed because the item has changed" when a delegate saves and later sends a Teams or Skype meeting from another user's calendar. Update Office and re-create and send the meeting without leaving it open as a draft.

## Symptoms

- Outlook says, `The operation cannot be performed because the item has changed`.
- Outlook says that another person updated the meeting and asks the delegate to close and reopen it.
- The error occurs after a delegate saves a Teams or Skype meeting as a draft in the mailbox owner's calendar.

## Cause

This issue can occur in classic Outlook for Windows when a delegate creates a meeting in another user's calendar and leaves the meeting in Drafts before sending it.

## Resolution

1. Update Office to the latest available build.
1. Close the affected meeting without sending it.
1. Reopen the mailbox owner's calendar and create the meeting again.
1. Add the attendees and online meeting details, and then send the meeting without leaving it open as a draft.

Microsoft implemented a service fix for this issue. For the affected scenario and status, see [The operation cannot be performed because the message has been changed](https://support.microsoft.com/en-us/support/known-issues/the-operation-cannot-be-performed-because-the-message-has-been-changed).

### Verify the resolution

Create and send a new meeting from the mailbox owner's calendar. Confirm that Outlook sends it without an item-changed error and that an attendee receives the invitation.

## More information

- [Restore missing delegate meeting invitations](fix-delegate-invites.md)
- [Resolve Full Access and delegate conflicts](fix-full-access-delegate-conflicts.md)
