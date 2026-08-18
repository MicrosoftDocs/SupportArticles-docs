---
title: Email message sent to a distribution group or Microsoft 365 Group isn't received by all the members
description: The article describes an issue in which email messages sent to a DL or Microsoft 365 Group is not received by all the members.
author: cloud-writer
ms.author: meerak
ms.reviewer: batre, v-kccross
manager: dcscontentpm
audience: Admin
ms.topic: troubleshooting
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - Exchange Online
  - CSSTroubleshoot
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 08/11/2026
ai-usage: ai-assisted
---

# Email sent to a distribution group or Microsoft 365 Group doesn't reach the members' inboxes

## Summary

This article helps administrators troubleshoot cases in which email messages sent to a distribution group (DL) or Microsoft 365 Group don't reach all group members. It explains the differences between distribution groups and Microsoft 365 Groups, how message delivery works for each group type, and how to verify group membership and subscription settings. The article also shows how to use mail flow diagnostics and mailbox rule checks to determine why messages weren't delivered to a member's inbox.

## Symptoms

You send an email to a distribution group or Microsoft 365 Group. You expect all members of the group to receive the email. But not all members of the group receive the email in their mailbox.

## Cause

This issue can occur for any of the following reasons:

- The recipient wasn't a member of the distribution group when the message was sent.
- Recent group membership changes haven't fully propagated.
- Mailbox rules move or delete the delivered message.
- Microsoft 365 Group members aren't subscribed to receive group messages in their inbox.

## Resolution

### Identify the type of group

First, identify if the group is a distribution group (DG) or a Microsoft 365 Group. To identify the type of group, use the Microsoft admin center or Exchange Online PowerShell. For more information about managing groups in Microsoft 365, see [Manage a group in Microsoft 365](/microsoft-365/admin/create-groups/manage-groups).

#### Identify the type of group by using the Microsoft admin center

1. Using an account that has sufficient permissions in your organization, sign in to the [Microsoft admin center](https://admin.cloud.microsoft/#/groups).
1. Select **Active Teams & Groups** under **Teams and Groups** and search for the group name.
   The **Type** is **Distribution list** for a Distribution Group and **Microsoft 365** for a Microsoft 365 Group.

#### Identify the type of group by using Exchange Online PowerShell

1. Using a work or school account that has [sufficient permissions](/exchange/permissions-exo/permissions-exo) in your organization, start a Windows PowerShell session and connect to Exchange Online. For instructions, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
1. Use the [Get-Recipient](/powershell/module/exchangepowershell/get-recipient) PowerShell cmdlet to identify the type of group as shown in the following example:

```powershell
Get-Recipient <GroupSMTPAddress> | ft DisplayName, RecipientTypeDetails, RecipientType
```

The `RecipientTypeDetails` value `GroupMailbox` indicates it's a Microsoft 365 Group. Other values for `RecipientTypeDetails`, such as `MailUniversalDistributionGroup`, indicate it's a Distribution Group.

### If the group is a distribution group (sometimes also called distribution list - DL)

When you investigate an issue where a distribution group member didn't receive an email, complete these tasks to resolve the issue.

#### Verify the recipient was a member of the group

Verify if the recipient was a member of the group when the email was sent. Exchange Online doesn't record a timestamp that shows when a recipient was added to a distribution group. Instead, you can verify the exact time a member was added by reviewing Microsoft Purview audit logs. If the group was recently created or the member was recently added, wait for at least an hour and then resend the message.

#### Run a mail flow diagnostic test

If the group was already created, and the member was already added, run a mail flow diagnostic test to [check email delivery](https://aka.ms/PillarEmailDelivery). You need to sign in with a work or school account that has the global administrator role to perform this step.

Example email diagnostic test

:::image type="content" source="media/member-did-not-receive-email-sent-group/email-delivery-troubleshooter.png" alt-text="The image displays a troubleshooting tool for email delivery issues, requesting user input to check emails sent within the last 10 days.":::

Example result

The following result is an example of the message trace. Your results will vary based on the issue.

:::image type="content" source="media/member-did-not-receive-email-sent-group/email-delivery-troubleshooter-result.png" alt-text="The image displays the result of the troubleshooter for email delivery issues, highlighting why email did not reach a member of distribution group.":::

In the preceding example, the message was delivered to `ProblemUser@contoso.com` and then it was moved to **Deleted Items**. The message might have been moved due to an inbox rule. To confirm this, check the rules for the mailbox.

To get a list of the rules in the mailbox, run the [Get-InboxRule](/powershell/module/exchangepowershell/get-inboxrule) PowerShell cmdlet as shown in the following example:

:::image type="content" source="media/member-did-not-receive-email-sent-group/get-inbox-rule.png" alt-text="The image displays a PowerShell cmdlet that retrieves rules in a mailbox rule that might be deleting emails sent to a distribution list (DL1).":::

In this example, the mailbox rule might be deleting emails sent to the distribution list `DL1`.

For information about checking the rules in your own inbox, see [Manage email messages by using rules in Outlook](https://support.microsoft.com/outlook/mail/manage-email-messages-by-using-rules-in-outlook).

### If the group is a Microsoft 365 Group

Email messages sent to a Microsoft 365 Group reach a member's Inbox only if the member subscribes to group emails. See [Join, leave, or follow Groups in Outlook](https://support.microsoft.com/Outlook/people/join-leave-or-follow-groups-in-outlook). Otherwise, the message is only in the group’s mailbox.

To check the members who subscribe to group email messages, run the [Get-UnifiedGroup](/powershell/module/exchangepowershell/get-unifiedgroup) and [Get-UnifiedGroupLinks](/powershell/module/exchangepowershell/get-unifiedgrouplinks) PowerShell cmdlets as shown in the following example:

```powershell
`Get-UnifiedGroup <group name> | Get-UnifiedGroupLinks -LinkType Subscribers`
```

To resubscribe all group members to receive messages that are sent to a Microsoft 365 group, run the following command in PowerShell:

```PowerShell
$group = "<address of Microsoft 365 group>"

Get-UnifiedGroupLinks $group -LinkType Member | % {Add-UnifiedGroupLinks -Identity $group -LinkType subscriber -Links $_.Guid.ToString() -Confirm:$false}
```

The group members who didn't receive messages earlier will only get the new messages that are sent to the group after you run the command. Older messages will remain in the group folder only.

The following example resubscribes all members of the group `testg@contoso.onmicrosoft.com` so that they receive messages in their Inbox:

```powershell
Get-UnifiedGroupLinks \$group -LinkType Member \| % {Add-UnifiedGroupLinks -Identity \$group
```
