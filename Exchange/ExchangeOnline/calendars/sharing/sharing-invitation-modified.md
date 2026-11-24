---
title: Calendar sharing invitation has no Accept button or returns WrongObjectTypeException
description: Troubleshoot calendar sharing invitations that become ordinary email or lose sharing metadata because a mail flow rule or service modifies the message.
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
ms.date: 11/24/2026
ms.service: exchange-online
ai-usage: ai-assisted
---

# Calendar sharing invitation has no Accept button or returns WrongObjectTypeException

## Summary

This article describes how to check mail processing when a calendar sharing invitation arrives without an **Accept** button, appears as an ordinary email message, or can't be accepted. This issue can affect internal and external invitations. The article also covers delegate meeting requests that lose on-behalf-of information.

## Symptoms

- The receiver gets the invitation but can't add it to the calendar.
- The invitation has no **Accept** button or other sharing controls.
- A delegate receives a meeting request as an attendee rather than on behalf of the calendar owner.
- Diagnostic evidence contains the following error:

  ```text
  Microsoft.Exchange.Data.Storage.WrongObjectTypeException:
  The object was bound to a wrong object type.
  ObjectClass = IPM.Note, Intended Type = Microsoft.Exchange.Data.Storage.SharingMessageItem.
  ```

## Cause

A branding service, disclaimer, mail flow rule, inbox rule, connector, or third-party message-processing service might have modified the invitation. If the message class changes from `IPM.Sharing` to `IPM.Note`, the message is no longer a valid sharing invitation. Removing or modifying `sharing_metadata.xml` can also invalidate the sharing data.

## Resolution

1. Compare a newly sent invitation with the message that the receiver got. Record the sender, the receiver, the send time, and the message identifiers.
1. Review the message route and the rules that processed the message. Use [Get-TransportRule](/powershell/module/exchangepowershell/get-transportrule) and [Get-InboxRule](/powershell/module/exchangepowershell/get-inboxrule) to inspect the rules:

   ```powershell
   Get-TransportRule
   Get-InboxRule -Mailbox "receiver@contoso.com" -IncludeHidden
   ```

1. For external invitations, review message processing in both organizations. Check services that add disclaimers, branding, or security transformations.
1. Work with the responsible administrator or service provider to correct the specific transformation that changes the sharing metadata or the message class. Don't disable security controls broadly.
1. Ask the owner to send a new sharing invitation.
1. Confirm that the invitation offers **Accept** and that the receiver can accept it and open the intended calendar.

If the message remains intact but external acceptance fails, see [Troubleshoot external sharing invitation failures](external-sharing-invitation-fails.md).

If the symptom persists, [contact Microsoft Support](/microsoft-365/admin/get-help-support). Provide the original and delivered invitations with the support request. Don't post raw messages or headers publicly.

### Delegate meeting invitations lose on-behalf-of information

A delegate can receive a meeting request as an attendee rather than on behalf of the owner if message processing changes the required headers. Calendar permissions can be correct even though message headers changed.

1. Check whether message processing removes `X-MS-Exchange-MessageSentRepresentingType`. Preserve `X-MS-Exchange-Inbox-Rules-Loop` when present.
1. Correct the message processing that changes the headers.
1. Send a new meeting request, and confirm that the delegate receives it with the intended on-behalf-of information.

If you can't identify the transformation or the symptom persists, [contact Microsoft Support](/microsoft-365/admin/get-help-support). Provide the original and delivered messages with the support request. Don't post raw messages or headers publicly.
