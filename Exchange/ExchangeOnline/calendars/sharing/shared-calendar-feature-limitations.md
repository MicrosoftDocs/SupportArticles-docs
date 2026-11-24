---
title: Shared calendar cancellation edits, delayed sending, or automatic acceptance don't work
description: Understand modern shared calendar limitations for cancellation edits, delayed sending, automatic acceptance, offline settings, and private meeting invitations.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.reviewer: shanefe, v-kccross
ms.custom:
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
search.appverid:
  - MET150
appliesto:
  - Exchange Online
  - Outlook for Windows
ms.date: 11/24/2026
ms.service: exchange-online
ai-usage: ai-assisted
---

# Shared calendar cancellation edits, delayed sending, or automatic acceptance don't work

## Summary

Some shared calendar operations differ from personal calendar operations or legacy behavior. This article describes these limitations and how to work around them. Check the limitations before you change permissions or rebuild a sharing relationship.

## Symptoms

- You can't change the subject or time while canceling a shared calendar meeting.
- A delayed send setting isn't honored.
- Automatic accept or decline settings aren't honored.
- A shared calendar improvements setting changed offline reverts after reconnection.
- A delegate doesn't receive an invitation marked **Private**.

## Cause

- Cancellation edits, delayed sending, automatic acceptance, and offline setting changes might occur when tThe modern shared calendar workflow doesn't support every legacy client behavior.
- Private invitations aren't forwarded to a delegate when a message marked **Private** isn't forwarded or redirected by Inbox rules. Message sensitivity affects message forwarding independently of calendar folder permissions.

## Resolution

### Subject or time can't be changed during cancellation

Don't rely on changing the meeting subject or time as part of the cancellation operation. Cancel the intended meeting without those edits. If a replacement meeting is needed, create it separately after confirming the cancellation.

Check the owner's calendar and intended cancellation notification to verify that the cancellation completed.

### Delayed sending isn't honored

Don't rely on delayed-send settings to schedule delivery of a shared-calendar meeting operation. Perform the operation when you're ready for it to be sent.

Use a nonsensitive test request to confirm delivery when the operation is performed. Immediate delivery is expected but even if that happens it doesn't demonstrate a delayed send capability.

### Automatic acceptance or decline isn't honored

Don't assume that the automatic processing settings for a personal calendar will process the shared calendar workflow. Have the owner or authorized delegate review and respond to meeting requests. Don't treat resource mailbox booking policies as equivalent to user calendar settings.

After the authorized user responds, confirm that the owner's event has the intended response state.

### A setting that changed offline is reverted

Reconnect classic Outlook before changing **Turn on shared calendar improvements**. Confirm the value after Outlook reconnects. If the intended setting persists, no further setting change is needed. Don't turn this setting off as a workaround for modern-sharing synchronization failures.

### Private meeting invitations aren't forwarded by Inbox rules

A message marked **Private** isn't forwarded or redirected by a recipient's Inbox rules. The owner can receive the invitation without the delegate receiving a forwarded copy. This doesn't by itself show that calendar sharing or the delegate rule is corrupt.

For more information, see [Mark your email as Normal, Personal, Private, or Confidential in Outlook](https://support.microsoft.com/office/mark-your-email-as-normal-personal-private-or-confidential-in-outlook-4a76d05b-6c29-4a0d-9096-71784a6b12c1). Don't reset delegate permissions solely because a private invitation wasn't forwarded.

Compare an ordinary nonsensitive test request with a private test request. If only private messages aren't forwarded by an Inbox rule, that matches the documented sensitivity behavior and doesn't require a sharing repair. If ordinary invitations also fail, use [Restore missing delegate meeting invitations](../permissions/fix-delegate-invites.md) to resolve the issue.

### If the issue persists

If an operation still fails outside these limitations, [contact Microsoft Support](/microsoft-365/admin/get-help-support). Provide the owner and delegate identities, client build, exact operation and error, and test time with time zone. A missing organizer event or a cancellation that reappears requires investigation rather than being dismissed as a feature limitation.
