---
title: Fix NDR error 550 5.7.1 in Exchange Online
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: v-six
audience: Admin
ms.topic: troubleshooting
f1.keywords:
- CSH
ms.custom: 
  - sap:Mail Flow
  - Exchange Online
  - CSSTroubleshoot
  - CI 167832
search.appverid:
- BCS160
- MOE150
- MET150
ms.assetid: da1ff375-f88f-4a3e-b81f-06cdb6ecae3c
description: Learn how to fix email issues for error code 5.7.1 (and also 5.7.0 to 5.7.999) in Exchange Online (the recipient is configured to reject email from the sender).
---

# Fix NDR error "550 5.7.1" in Exchange Online

> [!IMPORTANT]
> Mail flow rules are now available in the new Exchange admin center. [Try it now](https://admin.exchange.microsoft.com/#/transportrules)!

It's frustrating when you get an error after sending an email message. This topic describes what you can do if you see error code 5.7.1 in a non-delivery report (also known as an NDR, bounce message, delivery status notification, or DSN). This information also applies to error codes 5.7.0 through 5.7.999.

|&nbsp;|&nbsp;|&nbsp;|&nbsp;|
|---|---|---|---|
|:::image type="icon" source="media/email-user-icon.png":::|[I got this bounce message. How do I fix this issue?](#i-got-this-bounce-message-how-do-i-fix-this-issue)|:::image type="icon" source="media/email-admin-icon.png":::|[I'm an email admin. How can I fix this issue?](#im-an-email-admin-how-can-i-fix-this-issue)|

This information also applies to error codes 5.7.0 through 5.7.999 in Exchange Online and Microsoft 365 or Office 365. There can be several causes for dsn error code 5.7.1, for which solutions are provided later in this topic.

## Why did I get this bounce message?

Typically, this error indicates a security setting in your organization or the recipient's organization is preventing your message from reaching the recipient. For example:

- You don't have permission to send to the recipient.
- The recipient is a group, and you don't have permission to send to the group or one of its subgroups.
- You don't have permission to send email through an email server that's between you and the recipient.
- Your message was routed to the wrong email server.

## I got this bounce message. How do I fix this issue?

Typically, you can't fix the problem yourself. You'll need the recipient or the recipient's email admin to fix the configuration on their end. However, here are some steps that you can try:

- **If the recipient is external (outside of your organization)**: Contact the recipient (by phone, in person, etc.) and ask them to tell their email admin about your email delivery problem. Their email admin might need to reconfigure the recipient's mailbox so it accepts email from you.

- **If the recipient is an internal group**: You might not have permission to send to the group or to one of its subgroups. In this case, the NDR will include the names of the restricted groups that you don't have permission to send to. Ask the owner of the restricted group to grant you permission to send messages to the group. If you don't know the group's owner, you can find it in Outlook or Outlook on the web (formerly known as Outlook Web App) by doing the following steps:

  - **Outlook**: Select the NDR, double-click the group name on the **To** line, and then choose **Contact**.
  - **Outlook on the web**: Select the NDR, choose the group name on the **To** line, and then choose **Owner**.

- **If you're sending to a large distribution group**: Groups with more than 5,000 members have the following restrictions automatically applied to them:
  - Messages sent to the group require approval by a moderator.
  - Large messages can't be sent to the group. However, senders of large messages will receive a different NDR. For more information about large messages, see [Distribution group limits](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits#distribution-group-limits).

  To resolve the issue, join the group, or ask the group's owner or moderator to approve your message. Refer them to the [I'm the owner of a restricted group. What can I do?](#im-the-owner-of-a-restricted-group-what-can-i-do) section later in this topic.

If none of the previous steps apply or solve your issue, contact the recipient's email administrator, and refer them to the [I'm an email admin. How can I fix this issue?](#im-an-email-admin-how-can-i-fix-this-issue) section later in this topic.

### I'm the owner of a restricted group. What can I do?

If a message sender received this NDR when they attempted to send a message to your group, and you want them to successfully send messages to your group, try one of the following steps:

- **Remove the sender restriction**: Change your group settings to unblock the sender in one of the following ways:
  - Add the sender to the group's allowed senders list. Note that you must create a [mail contact](/exchange/recipients-in-exchange-online/manage-mail-contacts) or a [mail user](/exchange/recipients-in-exchange-online/manage-mail-users) to represent the external sender in your organization.
  - If the sender is restricted because they're external (outside your organization), configure the group to accept messages from external senders.
  - If you've configured a mail flow rule (also known as a transport rule) to restrict certain senders or groups of senders, you can modify the rule to accept messages from the sender.

- **Restrictions on large groups**: Groups with more than 5,000 members have the following restrictions automatically applied:
  - Messages sent to the group require approval by a moderator.
  - Large messages can't be sent to the group (but you'll receive a different NDR from this one if that's the issue). See [Exchange Online Limits](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits).

   To resolve the issue for the sender, approve their message, or add them to the group.

- **Managing distribution groups**
  - [Configure moderated recipients in Exchange Online](/exchange/recipients-in-exchange-online/moderated-recipients-exo/configure-moderated-recipients-exo)
  - [Create and manage distribution groups in Exchange Online](/exchange/recipients-in-exchange-online/manage-distribution-groups/manage-distribution-groups)

## I'm an email admin. How can I fix this issue?

### The sender is external (outside your organization)

If only this recipient is having difficulty accepting messages from external senders, configure the recipient or your email servers to accept messages from external or anonymous senders.

### The recipient is a public folder in your Exchange Online organization

When the recipient is a mail-enabled public folder in your Exchange Online organization, an external sender will receive an NDR with the following error code:

`Remote Server returned '<xxxxxxxx> #5.7.1 smtp;550 5.7.1 RESOLVER.RST.AuthRequired; authentication required [Stage: CreateMessage]'`

To configure the public folder to accept messages from external senders, follow these steps:

#### EAC

1. Open the Exchange admin center (EAC). For more information, see [Exchange admin center in Exchange Online](/Exchange/exchange-admin-center).

2. Go to **Public folders** \> **Public folders**.

3. Choose a public folder from the list, and then click **Edit** :::image type="icon" source="media/edit-icon.png":::.

   :::image type="content" source="media/fix-error-code-550-5-7-1-in-exchange-online/editing-a-public-folder.png" alt-text="The screen on which the details of a public folder can be edited.":::

4. Click **Mail flow settings**.

5. Under **Message Delivery Restrictions** \> **Accept messages from**, perform the following tasks:
   - Clear the check box for **Require that all senders are authenticated**.
   - Select **All senders**.

   :::image type="content" source="media/fix-error-code-550-5-7-1-in-exchange-online/allow-all-senders-public-folder.png" alt-text="The screen on which the users configure all the senders to send messages to the public folder.":::

6. Click **Save**.

### The sender is external and their source IP address is on Microsoft's blocklist

In this case, the NDR the sender receives would include information in the **Diagnostics for administrators** section similar to the following information:

`5.7.1 Service unavailable; Client host [xxx.xxx.xxx.xxx] blocked using Blocklist 1; To request removal from this list please forward this message to delist@microsoft.com`

To remove the restriction on the sender's source email system, forward the NDR message to delist@microsoft.com. Also see [Use the delist portal to remove yourself from the blocked senders list](/microsoft-365/security/office-365-security/use-the-delist-portal-to-remove-yourself-from-the-office-365-blocked-senders-lis).

### Your domain isn't fully enrolled in Microsoft 365 or Office 365

If your domain isn't fully enrolled in Microsoft 365 or Office 365, try the following steps:

- Verify your domain appears as **Healthy** in the [Microsoft 365 admin center](https://admin.microsoft.com) at **Settings** \> **Domains**.
- For information about adding your domain to Microsoft 365 or Office 365, see [Add a domain to Microsoft 365](/microsoft-365/admin/setup/add-domain).
- To troubleshoot domain verification issues, see [Troubleshoot domain verification issues in Office 365](https://support.microsoft.com/topic/troubleshoot-domain-verification-issues-in-office-365-c99845be-aa0f-3438-63e6-b09ee71deaeb).

### Your domain's MX record has a problem

If you have an incorrect MX record, try the following steps:

1. Check the sender and recipient domains for incorrect or stale MX records by using the **Advanced diagnostics** \> **Exchange Online** test in Microsoft Support and Recovery Assistant. For more information about the Support and Recovery Assistant, see [About Microsoft Support and Recovery Assistant](https://support.microsoft.com/office/e90bb691-c2a7-4697-a94f-88836856c72f).

2. Check with your domain registrar or DNS hosting service to verify the MX record for your domain is correct. The MX record for a domain that's enrolled in Exchange Online uses the syntax  `_\<domain\ >_.mail.protection.outlook.com` or `_\<domain\ >_.subdomain.mx.microsoft`

3. Verify **Inbound SMTP Email** and **Outbound SMTP Email** at **Office 365** \> **Mail Flow Configuration** in the [Microsoft Remote Connectivity Analyzer](https://testconnectivity.microsoft.com/tests/o365).

4. Verify you have only one MX record configured for your domain. Microsoft doesn't support using more than one MX record for a domain that's enrolled in Exchange Online.

### Your domain's SPF record has a problem

The Sender Policy Framework (SPF) record for your domain might be incomplete, and might not include all email sources for your domain. For more information, see [Set up SPF to help prevent spoofing](/microsoft-365/security/office-365-security/set-up-spf-in-office-365-to-help-prevent-spoofing).

### Hybrid configuration issues

- If your domain is part of a hybrid deployment between on-premises Exchange and Exchange Online, the Hybrid Configuration Wizard should automatically configure the required connectors for mail flow. Even so, you can use the steps in this section to verify the connector settings.
  1. Open the Microsoft 365 admin center at <https://portal.microsoftonline.com>, and click **Admin** \> **Exchange**.

  2. In the Exchange admin center, click **Mail Flow** \> **Connectors**. Select the connector that's used for hybrid, and choose **Edit**. Verify the following information:

     - **Delivery**: If **Route mail through smart hosts** is selected, confirm the correct IP address or FQDN is specified. If **MX record associated with the recipient domain** is selected, confirm the MX record for the domain points to the correct mail server.

       You can test your MX record and your ability to send mail from your Exchange Online organization by using the **Outbound SMTP Email** test in the [Microsoft Remote Connectivity Analyzer](https://testconnectivity.microsoft.com/tests/o365).

     - **Scope**: If you need to route inbound internet mail to your on-premises Exchange organization, **Domains** need to include all email domains that are used in your on-premises organization. You can use the value asterisk (\*) to also route all outbound internet mail through the on-premises organization.

  If the connectors are configured incorrectly, your Exchange administrator needs to rerun the Hybrid Configuration Wizard in the on-premises Exchange organization.

- If you disable an on-premises Active Directory account, you'll get the following error message:

  > Your message couldn't be delivered to the recipient because you don't have permission to send to it.
Ask the recipient's email admin to add you to the accept list for the recipient.
For more information, see DSN 5.7.129 Errors in Exchange Online and Microsoft 365 or Office 365.

  To cease all communication with the Exchange Online mailbox, you need to **delete** the on-premises user account instead of disabling it.

  Another solution would be to remove the license, but then you would need to create a mail flow rule (also known as a transport rule) to prevent the user from receiving email messages. Otherwise, the user would continue to receive messages for about 30 days after removal of the license.

  Consider this scenario as part of the workflow for disabling a user on Exchange Online.

## Still need help?

[:::image type="icon" source="media/community-forum-icon.png":::](https://answers.microsoft.com/)

[:::image type="icon" source="media/create-service-request-icon.png":::](https://admin.microsoft.com/AdminPortal/Home#/support)

[:::image type="icon" source="media/call-support-icon.png":::](/microsoft-365/Admin/contact-support-for-business-products)

## See also

[Email non-delivery reports in Exchange Online](non-delivery-reports-in-exchange-online.md)
