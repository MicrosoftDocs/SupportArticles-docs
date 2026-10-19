---
title: StoreDriverRules and "Message is deleted by mailboxrules" for delegate meeting invitations in Exchange Online
description: Restore missing delegate meeting invitations that don't reach an Outlook delegate by checking hidden inbox rules and rebuilding the mailbox owner's delegate configuration.
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
ms.date: 10/07/2026
ms.service: exchange-online
ai-usage: ai-assisted
---

# Restore missing delegate meeting invitations

## Summary

Restore missing delegate meeting invitations in Outlook when message trace reports `StoreDriverRules` and `Message is deleted by mailboxrules`. Check the mailbox owner's hidden inbox rules, and remove and re-add the affected delegate to rebuild the meeting-request delivery configuration.

## Symptoms

- A current delegate doesn't receive meeting requests for the mailbox owner.
- A former delegate continues to receive meeting requests.
- Message trace reports `StoreDriverRules` and `Message is deleted by mailboxrules`.

## Cause

Outlook creates a hidden inbox rule on the mailbox owner's mailbox when you add a delegate and choose who receives meeting requests and responses. If the rule still targets a removed delegate, or if it's set to delete the owner's copy of the message, the mailbox rule deletes the meeting request instead of delivering it. In that case, message trace reports `StoreDriverRules` and `Message is deleted by mailboxrules`.

## Resolution

Use these steps when meeting invitations don't reach the current delegate or continue to reach a former delegate.

1. In the Exchange admin center, run a message trace for an affected meeting request and confirm that a mailbox rule processed the message.
1. Review the mailbox owner's inbox rules, including hidden rules.

   ```powershell
   Get-InboxRule -Mailbox owner@contoso.com -IncludeHidden
   ```

   For syntax and parameter details, see [Get-InboxRule](/powershell/module/exchangepowershell/get-inboxrule).

1. In Outlook, sign in as the mailbox owner.
1. Open the delegate settings, remove the affected delegate, and save the change.
1. Add the delegate again and choose who should receive meeting requests and responses.

Recreating the delegate relationship rebuilds its meeting-request delivery configuration. For delegate options, see [Allow someone to manage your mail and calendar in Outlook](https://support.microsoft.com/en-us/outlook/sharing/about-delegates-allow-someone-to-manage-your-mail-and-calendar-in-outlook).

### Verify the resolution

Send a new meeting request to the mailbox owner. Confirm that the current delegate receives it and that a removed delegate doesn't. Run another message trace if delivery still fails.

## More information

- [Reset corrupt Outlook delegate permissions](fix-corrupt-delegate-permissions.md)
