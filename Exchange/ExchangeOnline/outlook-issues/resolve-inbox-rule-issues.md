---
title: Resolve issues with Inbox rules in Outlook
description: Provides steps to diagnose various Inbox rule issues in Microsoft Outlook or Outlook on the web.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom:
  - Exchange Online
  - CSSTroubleshoot
  - CI 184229
ms.reviewer: mhaque, meerak, v-trisshores
appliesto:
  - Exchange Online
  - Outlook on the web
  - Outlook for Microsoft 365
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
search.appverid: MET150
ms.date: 01/24/2024
---

# Resolve issues with Inbox rules in Outlook

If you encounter an issue that's related to Inbox rules in Microsoft Outlook or Outlook on the web, select the applicable issue from the following list:

- [Rule to redirect email messages doesn't work](#rule-to-redirect-email-messages-doesnt-work)

- [Rule to forward email messages doesn't work](#rule-to-forward-email-messages-doesnt-work)

- [Rule to forward new or updated meeting requests doesn't work](#rule-to-forward-new-or-updated-meeting-requests-doesnt-work)

- [Rule to forward message disposition notifications or delivery receipts doesn't work](#rule-to-forward-message-disposition-notifications-or-delivery-receipts-doesnt-work)

- [Rule to forward or redirect automatic replies doesn't work](#rule-to-forward-or-redirect-automatic-replies-doesnt-work)

- [All mailbox rules don't work](#all-mailbox-rules-dont-work)

## Rule to redirect email messages doesn't work

To diagnose and fix the issue, use the following steps. After you complete each step, check whether the issue is fixed. If the issue isn't fixed, go to the next step.

1. Check whether mailbox forwarding is enabled by running the following commands:

   ```PowerShell
   Connect-ExchangeOnline
   Get-Mailbox <user ID> | FL ForwardingAddress,ForwardingSmtpAddress,DeliverToMailboxAndForward
   ```
  
   If a forwarding address is set and the `DeliverToMailboxAndForward` parameter is enabled, Inbox rules that redirect messages won't work. This behavior is by design.
  
   To work around the issue, run the following command to disable [forwarding from the mailbox](/powershell/module/exchange/set-mailbox#-delivertomailboxandforward):
  
   ```PowerShell
   Set-Mailbox <user ID> -DeliverToMailboxAndForward $False
   ```

   For more information, see [Inbox rule to redirect messages doesn't work if forwarding is set up on a mailbox](/exchange/troubleshoot/email-delivery/inbox-redirect-rule-not-working).

2. Check whether the number of redirect recipients for the Inbox rule exceeds the Microsoft [Exchange Online limit](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits#journal-transport-and-inbox-rule-limits-1) of ten. For information about how to work around the issue, see [Inbox rule to forward messages doesn't work in Microsoft 365](/exchange/troubleshoot/email-delivery/inbox-rule-to-forward-messages-not-work).

3. Check whether the mailbox is in a [remote domain](/exchange/mail-flow-best-practices/remote-domains/remote-domains) and whether automatic forwarding is disabled for the remote domain. Run the following command:

   ```PowerShell
   Get-RemoteDomain | Where {$_.AutoForwardEnabled -eq $False}
   ```

   If the mailbox domain matches one of the listed domains, Inbox rules that redirect messages won't work. This behavior is by design. To work around the issue, use the [Set-RemoteDomain](/powershell/module/exchange/set-remotedomain#-autoforwardenabled) cmdlet to enable automatic forwarding for the remote domain.

## Rule to forward email messages doesn't work

Check whether the outbound spam filter disables automatic forwarding to external recipients. If so, rules that forward email messages to external recipients won't work and trigger non-delivery reports. This behavior is by design. For more information, see [Control automatic external email forwarding in Microsoft 365](/microsoft-365/security/office-365-security/outbound-spam-policies-external-email-forwarding).

## Rule to forward new or updated meeting requests doesn't work

If an incoming message is a new or updated meeting request, and its sensitivity level is set to **Private**, Inbox rules that forward the message won't work. This behavior is by design.

## Rule to forward message disposition notifications or delivery receipts doesn't work

If an incoming message is a [delivery report](/exchange/mail-flow/mail-routing/recipient-resolution#delivery-report-redirection-for-groups), such as a message disposition notification (MDN) or delivery receipt (DR), Inbox rules that forward the message won't work. This behavior is by design.

## Rule to forward or redirect automatic replies doesn't work

If an incoming message is an automatic reply, Inbox rules that forward or redirect the message won't work. This behavior is by design. Automatic replies have a [X-MS-Exchange-Inbox-Rules-Loop](https://techcommunity.microsoft.com/t5/exchange-team-blog/loop-prevention-in-exchange-online-demystified/ba-p/2312258#toc-hId-209339157) header that limits to one the number of times that a message can be automatically redirected, forwarded, or replied to.

## All mailbox rules don't work

To diagnose the mailbox issue, use the following steps. If step 1 doesn't determine the cause of the issue, go to step 2.

1. Check whether the mailbox is a journaling mailbox. Inbox rules don't work for a mailbox that's designated as a `JournalingReportNdrTo` mailbox. This behavior is by design. For more information, see [Transport and mailbox rules in Exchange Online don't work as expected](https://support.microsoft.com/topic/transport-and-mailbox-rules-in-exchange-online-or-on-premises-exchange-server-don-t-work-as-expected-8729e935-4b04-f849-5998-0a5074d594e8).

   This behavior also applies to any distribution group mailbox that's designated as a `JournalingReportNdrTo` mailbox. For example, forwarding rules that send email messages to group members don't work for a group mailbox that's designated as a `JournalingReportNdrTo` mailbox.

2. Check whether the mailbox has a Microsoft 365 F1 license. Inbox rules don't work for a mailbox that has an F1 license. This behavior is by design. For more information, see [Available plans for Exchange Online](/office365/servicedescriptions/exchange-online-service-description/exchange-online-service-description#available-plans-for-exchange-online).
