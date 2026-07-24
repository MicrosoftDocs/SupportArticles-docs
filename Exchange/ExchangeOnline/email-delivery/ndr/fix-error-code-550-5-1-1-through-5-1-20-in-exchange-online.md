---
title: "Fix NDR 550 5.1.1 to 5.1.20 in Exchange Online"
description: Learn how to fix email issues for error code 5.1.1 through 5.1.20 in Exchange Online (the recipient doesn't exist or your Auto-Complete list entry for the recipient is bad).
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: v-six, arindamt
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
appliesto: 
  - Exchange Online
ms.date: 07/24/2026
ai-usage: ai-assisted
---

# Fix non-delivery report (NDR) error code 550 5.1.1 through 550 5.1.20 in Exchange Online

## Summary

This article explains how to troubleshoot Exchange Online NDR errors 550 5.1.1 through 550 5.1.20, which generally indicate that the recipient can't be found or that message routing information is invalid. Common causes include misspelled or outdated email addresses, corrupted Auto-Complete entries, forwarding rules that redirect messages to invalid recipients, compromised sender accounts, or recipient domain configuration issues. For administrators, troubleshooting focuses on verifying recipient and domain configuration, checking MX records and service health, and reviewing forwarding and mail flow rules that might redirect messages to nonexistent addresses.

This rest of this article describes what you can do if you see error codes 550 5.1.1 through 5.1.20 in a non-delivery report (also known as an NDR, bounce message, delivery status notification, or DSN).

|&nbsp;|&nbsp;|&nbsp;|&nbsp;|
|---|---|---|---|
|:::image type="icon" source="media/email-user-icon.png":::|[I got this bounce message. How do I fix it?](#i-got-this-bounce-message-how-do-i-fix-it)|:::image type="icon" source="media/email-admin-icon.png":::|[I'm an email admin. What can I do to fix this?](#im-an-email-admin-what-can-i-do-to-fix-this)|

## I got this bounce message. How do I fix it?

Here are some steps that you can try to fix the problem yourself.

If the steps in this section don't fix the problem for you, contact your email admin and refer them to the information in this article so they can try to resolve the issue for you.

### Solution 1: Confirm the recipient's email address

It sounds too simple, but the wrong email address is the most common issue that causes 5.1.x errors. Check for correct spelling and send the message again if you find an error in the email address.

To resend the message in Outlook, see [Resend an email message](https://support.microsoft.com/office/acd16ac4-c881-477d-b4aa-36168fa96088).

### Solution 2: Remove the recipient's email address from your Auto-Complete list

You might have an invalid entry in your Auto-Complete list (also known as the _nickname cache_) for the recipient. For example, the recipient might have been moved from an on-premises Exchange organization to Exchange Online, or vice versa. Although the recipient's email address is the same, other internal identifiers for the recipient might have changed, which breaks your cached entry for the recipient.

#### Fix your Auto-Complete list entries in Outlook

To remove invalid recipients or all recipients from your Auto-Complete list in Outlook, see [Remove AutoComplete list entries](/microsoft-365-apps/outlook/contacts/outlook-autocomplete-list#remove-autocomplete-list-entries-one-at-a-time).

#### Fix your Auto-Complete list entries in Outlook on the web

To remove recipients from your Auto-Complete list in Outlook on the web (formerly known as Outlook Web App), complete one of the following procedures:

##### Remove a single recipient from your Outlook on the web Auto-Complete list

1. In Outlook on the web, select **New mail**.

1. Start typing the recipient's name or email address in the **To** field until the recipient appears in the drop-down list.

   :::image type="content" source="media/fix-error-code-550-5-1-1-through-5-1-20-in-exchange-online/to-field.png" alt-text="Screenshot shows the Send Again option for an email message. In the Resend to field, the AutoComplete feature provides the email address for the recipient based on the first few letters typed of the recipient's name.":::

1. Use the Down Arrow and Up Arrow keys to select the recipient, and then press the Delete key.

### Solution 3: Confirm that the recipient isn't auto-forwarding messages from you to another (and likely, invalid) email address

Does the recipient's email address in your original message exactly match the recipient's email address in the NDR? Compare the recipient's email address in the NDR with the recipient's email address in the message in your **Sent Items** folder.

If the addresses don't match, contact the recipient (by phone, in person, and so on) and ask them if they configured an email rule that forwards incoming email messages from you to another destination. Their rule might try to send a copy of your message to a bad email address. If the recipient has such a rule, they need to correct the destination email address or remove the rule to prevent 5.1.x message delivery errors.

### Solution 4: Verify that your account isn't compromised

Did you send the original message? If not, a spammer or hacker might have inappropriately used your account to send the message.

Check your recent messages in the **Sent Items** folder for strange or unknown messages (messages that you didn't send). If you find any, your email account might be compromised.

If you believe that your account is compromised, follow these steps:

- Reset your password and scan your devices for malware. However, the hacker might have configured other settings on your mailbox (for example, created Inbox rules to auto-forward email messages or added additional mailbox delegates). So, follow the additional steps in [Responding to a compromised account](/defender-office-365/responding-to-a-compromised-email-account).

- Notify your email admin. Your admin needs to unblock your account before you can send email again.

### Solution 5: Confirm that the NDR is related to a message that you actually sent

If your **Sent** folder contains only messages that you know you sent, then the NDR you received could be a result of _backscatter_ (a useless NDR about a message you didn't send), and you can ignore it.

Typically, if a message can't be delivered, the recipient's email system uses the sender's email address in the **From** field to notify the sender in an NDR like this one. But what if the message was sent by a spammer who falsified the **From** address so it appears the message came from your email address? The resulting NDR that you receive is useless because it creates the false impression that you did something wrong. This type of useless NDR is called _backscatter_. It's annoying, but if this NDR is backscatter, your account isn't compromised.

Check your recent messages in the **Sent Items** folder for strange or unknown messages (messages that you didn't send). If you don't see any suspicious messages, it's likely that the NDR you received is backscatter. If you already changed your password and ran an anti-malware scan, you can ignore these backscatter NDRs.

To learn more, see [Backscatter in cloud organizations](/defender-office-365/anti-spam-backscatter-about).

## I'm an email admin. What can I do to fix this?

If the steps in the previous section don't solve the issue for the sender, the solution might be related to the way the user's Microsoft 365 or Office 365 account is set up. If you have a hybrid topology, the solution might also be related to the on-premises mail transfer agent. It might also be a problem with the recipient's domain configuration. Here are four solutions you can try. You might not need to try all of them to get the message sent successfully.

### Solution 1: Check the Microsoft 365 admin center for configuration problems or service-wide issues

For Microsoft 365 or Office 365 accounts, the Microsoft 365 admin center provides a central source for various tools, notifications, and information that you can use to troubleshoot this and other issues.

Open the [Microsoft 365 admin center](https://admin.microsoft.com), and from the **Home** page, complete the following steps:

1. Check the **Message Center** to see if your organization has a known configuration issue.

1. Select **Health** and then **Service health** to see if there's a current service issue in Microsoft 365 or Office 365 affecting the user's account.

1. Check the sender and recipient domains for incorrect or stale mail exchange (MX) resource records by running the [Mailflow Troubleshooter](/exchange/mail-flow-best-practices/troubleshoot-mail-flow) tool that's available within Microsoft 365 and Office 365.

If there's a problem with the recipient's domain, contact the recipient or the recipient's email administrator to let them know about the problem. They must resolve the issue to prevent NDR 5.1.x errors.

### Solution 2: Update stale MX records

Error code 5.1.1 can occur due to problems with the MX resource record for the recipient's domain. For example, the MX record might point to an old email server, or the MX record might be ambiguous due to a recent configuration change.

> [!NOTE]
> Updates to a domain's DNS records can take up to 72 hours to propagate to all DNS servers on the Internet.

If external senders (senders outside your organization) receive this NDR when they send message to recipients in your domain, try the following steps:

- The MX resource record for your domain might be incorrect. The MX record for an Exchange Online domain points to the email server (host) _\<domain\>_.mail.protection.outlook.com.

- Verify that you have only one MX record configured for your Exchange Online domain. Microsoft doesn't support using more than one MX record for domains enrolled in Exchange Online.

- Test your MX record and your ability to send email from your Exchange Online organization by using the **Inbound SMTP Email and Outbound SMTP Email Test** at [Microsoft Remote Connectivity Analyzer](https://testconnectivity.microsoft.com/tests/exo).

For more information, see [Add DNS records to connect your domain](/microsoft-365/admin/get-help-with-domains/create-dns-records-at-any-dns-hosting-provider) and [Set up SPF to help prevent spoofing](/microsoft-365/security/office-365-security/set-up-spf-in-office-365-to-help-prevent-spoofing).

### Solution 3: Update forwarding rules to remove incorrect email addresses

This NDR can occur due to a forwarded (unintended) recipient that's configured for the intended recipient. For example:

- A forwarding Inbox rule or delegate that the recipient configured in their own mailbox.

- A mail flow rule (also known as a transport rule) configured by an email admin that copies or forwards messages sent to the recipient to another invalid recipient.

For more information, see [Configure email forwarding for a mailbox](/exchange/recipients-in-exchange-online/manage-user-mailboxes/configure-email-forwarding).

## Still need help with error code 5.1.1 to 5.1.20?

[:::image type="icon" source="media/community-forum-icon.png":::](https://answers.microsoft.com/)

[:::image type="icon" source="media/create-service-request-icon.png":::](https://admin.microsoft.com/AdminPortal/Home#/support)

[:::image type="icon" source="media/call-support-icon.png":::](/microsoft-365/Admin/contact-support-for-business-products)

## See also

[Email non-delivery reports in Office 365](non-delivery-reports-in-exchange-online.md)
