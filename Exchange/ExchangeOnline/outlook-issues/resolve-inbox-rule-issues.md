---
title: Diagnose Outlook Inbox rules that aren't working
description: Provides steps to diagnose various Inbox rule issues in Microsoft Outlook or Outlook on the web.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Client Connectivity
  - Exchange Online
  - CSSTroubleshoot
  - CI 184229
  - CI 190063
ms.reviewer: benwinz, meerak, v-trisshores
appliesto:
  - Exchange Online
  - Outlook on the web
  - Outlook for Microsoft 365
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
search.appverid: MET150
ms.date: 05/31/2024
---

# Diagnose Outlook Inbox rules that aren't working

If you encounter an issue that's related to [Inbox rules](https://support.microsoft.com/office/manage-email-messages-by-using-rules-c24f5dea-9465-4df4-ad17-a50704d66c59) in Microsoft Outlook or Outlook on the web, select the applicable issue from the table of contents (TOC) at the top of this article.

## Rule to forward or redirect email messages doesn't work

To diagnose and fix this issue, follow these steps. After you complete each step, check whether the issue is fixed.

1. Run the following cmdlet in [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) to check whether [mailbox forwarding](/exchange/recipients/user-mailboxes/email-forwarding) is enabled on the mailbox that has the Inbox rule:

   ```PowerShell
   Get-Mailbox <user ID> | FL ForwardingAddress,ForwardingSmtpAddress,DeliverToMailboxAndForward
   ```

   Mailbox forwarding is enabled if a forwarding address is set and the [DeliverToMailboxAndForward](/powershell/module/exchange/set-mailbox#-delivertomailboxandforward) parameter value is `True`. If mailbox forwarding is enabled, Inbox rules that redirect messages won't work. This behavior is by design.

   To enable Inbox rules that redirect messages, mailbox forwarding must be disabled. To disable mailbox forwarding, run the following cmdlet in Exchange Online PowerShell:

   ```PowerShell
   Set-Mailbox <user ID> -DeliverToMailboxAndForward $False
   ```

2. Check whether the number of individual recipients in the forward or redirect Inbox rule exceeds the [Exchange Online limit](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits#journal-transport-and-inbox-rule-limits-1) of 10. If so, follow these steps to reduce the number of individual recipients in the rule:

   1. Create a [distribution group](/microsoft-365/admin/setup/create-distribution-lists) or a [Microsoft 365 Group](/microsoft-365/admin/create-groups/create-groups)
   2. Add the individual recipients to the group.
   3. Set the group as the recipient in the forward or redirect Inbox rule.

3. Run the following PowerShell cmdlet in Exchange Online PowerShell to check whether the mailbox is in a [remote domain](/exchange/mail-flow-best-practices/remote-domains/remote-domains) that has automatic forwarding disabled:

   ```PowerShell
   Get-RemoteDomain | Where {$_.AutoForwardEnabled -eq $False}
   ```

   If the mailbox domain matches one of the listed domains, Inbox rules that redirect messages won't work. This behavior is by design. To work around the issue, use the [Set-RemoteDomain](/powershell/module/exchange/set-remotedomain#-autoforwardenabled) cmdlet to enable automatic forwarding for the remote domain.

4. Check whether the outbound spam filter disables automatic forwarding to external recipients. If so, rules that forward email messages to external recipients won't work and will trigger nondelivery reports. This behavior is by design. For more information, see [Control automatic external email forwarding in Microsoft 365](/microsoft-365/security/office-365-security/outbound-spam-policies-external-email-forwarding).

5. Check whether the Inbox rule is configured to forward or redirect messages back to the original sender. Inbox rules won't forward or redirect messages to the original sender. If your Inbox rule forwards or redirects to multiple mailboxes, including the original sender, all recipients except the original sender will receive the forwarded or redirected messages. This behavior is by design.

6. Check whether the incoming message has already been forwarded or redirected by another Inbox rule. To prevent endless looping, messages that are forwarded or redirected by an Inbox rule include an [X-MS-Exchange-Inbox-Rules-Loop](https://techcommunity.microsoft.com/t5/exchange-team-blog/loop-prevention-in-exchange-online-demystified/ba-p/2312258#toc-hId-209339157) header that limits the number of times that a message can be automatically redirected, forwarded, or replied to. The [Exchange Online limit](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits#journal-transport-and-inbox-rule-limits) is one time. This behavior is by design.

[Back to top](#diagnose-outlook-inbox-rules-that-arent-working)

## Rule to forward new or updated meeting requests doesn't work

If an incoming message is a new or updated meeting request, and its sensitivity level is set to **Private**, Inbox rules that forward the message won't work. This behavior is by design.

[Back to top](#diagnose-outlook-inbox-rules-that-arent-working)

## Rule to forward message disposition notifications or delivery receipts doesn't work

If an incoming message is a [delivery report](/exchange/mail-flow/mail-routing/recipient-resolution#delivery-report-redirection-for-groups), such as a message disposition notification (MDN) or delivery receipt (DR), Inbox rules that forward the message won't work. This behavior is by design.

[Back to top](#diagnose-outlook-inbox-rules-that-arent-working)

## Rule to forward or redirect automatic replies doesn't work

If an incoming message is an automatic reply, Inbox rules that forward or redirect the message won't work. To prevent endless looping, messages that are forwarded or redirected by using Inbox rules include an X-MS-Exchange-Inbox-Rules-Loop header that limits the number of times that a message can be automatically redirected, forwarded, or replied to. The [Exchange Online limit](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits#journal-transport-and-inbox-rule-limits) is one time.

[Back to top](#diagnose-outlook-inbox-rules-that-arent-working)

## No mailbox rules work

To diagnose the mailbox issue,  follow these steps:

1. Check whether the mailbox is a journaling mailbox. Inbox rules won't work for a mailbox that's designated as a `JournalingReportNdrTo` mailbox. This behavior is by design. For more information, see [Transport and mailbox rules in Exchange Online don't work as expected](https://support.microsoft.com/topic/transport-and-mailbox-rules-in-exchange-online-or-on-premises-exchange-server-don-t-work-as-expected-8729e935-4b04-f849-5998-0a5074d594e8).

   This behavior also applies to any distribution group mailbox that's designated as a journaling mailbox. For example, forwarding rules that send email messages to group members won't work on a group mailbox that's designated as a journaling mailbox.

2. Check whether the mailbox has a Microsoft 365 F1 license. Inbox rules won't work for a mailbox that has an [F1 license](/office365/servicedescriptions/exchange-online-service-description/exchange-online-service-description#available-plans-for-exchange-online). This behavior is by design.

[Back to top](#diagnose-outlook-inbox-rules-that-arent-working)
