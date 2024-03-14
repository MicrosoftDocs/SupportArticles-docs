---
title: Fix NDR error 550 5.1.1 through 5.1.20 in Exchange Online
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
ms.reviewer: v-six
audience: Admin
ms.topic: troubleshooting
ms.localizationpriority: high
f1.keywords:
- CSH
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - CI 167832
search.appverid:
- BCS160
- MOE150
- MET150
ms.assetid: 79e91ade-5c83-405b-a37d-d99c7d069b13
description: Learn how to fix email issues for error code 5.1.1 through 5.1.20 in Exchange Online (the recipient doesn't exist or your Auto-Complete list entry for the recipient is bad).
---

# Fix NDR error code "550 5.1.1" through "550 5.1.20" in Exchange Online

> [!IMPORTANT]
> Mail flow rules are now available in the new Exchange admin center. [Try it now](https://admin.exchange.microsoft.com/#/transportrules)!

It's frustrating when you get an error after sending an email message. This article describes what you can do if you see error codes 550 5.1.1 through 5.1.20 in a non-delivery report (also known as an NDR, bounce message, delivery status notification, or DSN).

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

You might have an invalid entry in your Auto-Complete list (also known as the _nickname cache_) for the recipient. For example, the recipient might have been moved from an on-premises Exchange organization to Exchange Online, or vice-versa. Although the recipient's email address is the same, other internal identifiers for the recipient might have changed, thus breaking your cached entry for the recipient.

#### Fix your Auto-Complete list entries in Outlook

To remove invalid recipients or all recipients from your Auto-Complete list in Outlook 2010 later, see [Manage suggested recipients in the To, Cc, and Bcc boxes with Auto-Complete](https://support.microsoft.com/office/dbe46e31-c098-4881-8cf7-66b037bce23e).

#### Fix your Auto-Complete list entries in Outlook on the web

To remove recipients from your Auto-Complete list in Outlook on the web (formerly known as Outlook Web App), do one of the following procedures:

##### Remove a single recipient from your Outlook on the web Auto-Complete list

1. In Outlook on the web, click **New mail**.

2. Start typing the recipient's name or email address in the **To** field until the recipient appears in the drop-down list.

   :::image type="content" source="media/fix-error-code-550-5-1-1-through-5-1-20-in-exchange-online/to-field.png" alt-text="Screenshot shows the Send Again option for an email message. In the Resend to field, the AutoComplete feature provides the email address for the recipient based on the first few letters typed of the recipient's name.":::

3. Use the Down Arrow and Up Arrow keys to select the recipient, and then press the Delete key.

##### Remove all recipients from your Outlook on the web Auto-Complete list**

You can only clear your Auto-Complete list in the light version of Outlook on the web. To open your mailbox in the light version of Outlook on the web, do either of the following steps:

- Open the mailbox in an older web browser that only supports the light version of Outlook on the web (for example, Internet Explorer 9).

- Configure your Outlook on the web settings to only use the light version of Outlook on the web (the change takes effect the next time you open the mailbox):

   1. In Outlook on the web, click **Settings** :::image type="icon" source="media/setting-icon.png":::.

   2. In the **Search all settings** box, type **light** and select **Outlook on the web version** in the results.

   3. In the page that opens, select **Use the light version of Outlook on the web**, and then click **Save**.

   4. Log off, close your web browser, and open the mailbox again in Outlook on the web.

After you open your mailbox in the light version of Outlook on the web, do the following steps to clear all entries from your Auto-Complete list:

1. Choose **Options** and verify that **Messaging** is selected.

2. In the **E-Mail Name Resolution** section, click **Clear Most Recent Recipients list**, and then click **OK** in the confirmation dialog box.

3. While you're still in **Options**, to return your mailbox to the full version of Outlook on the web, go to **Outlook version**, clear the check box for **Use the light version**, and then click **Save**.

4. Log off and close your web browser. The next time you open your mailbox in a supported web browser, you'll use the full version of Outlook on the web.

To remove invalid recipients or all recipients from your Auto-Complete list in Outlook 2010 later, see [Manage suggested recipients in the To, Cc, and Bcc boxes with Auto-Complete](https://support.microsoft.com/office/dbe46e31-c098-4881-8cf7-66b037bce23e).

### Solution 3: Confirm that the recipient isn't auto-forwarding messages from you to another (and likely, invalid) email address

Does the recipient's email address in your original message exactly match the recipient's email address in the NDR? Compare the recipient's email address in the NDR with the recipient's email address in the message in your **Sent Items** folder.

If the addresses don't match, contact the recipient (by phone, in person, etc.) and ask them if they've configured an email rule that forwards incoming email messages from you to another destination. Their rule could have tried to send a copy of your message to a bad email address. If the recipient has such a rule, they'll need to correct the destination email address or remove the rule in order to prevent 5.1.x message delivery errors.

### Solution 4: Verify that your account hasn't been compromised

Did you send the original message at all? If not, it's possible that a spammer or hacker inappropriately used your account to send the message.

Check your recent messages in the **Sent Items** folder for strange or unknown messages (messages that you didn't send). If you find any, it's possible that your email account was compromised.

If you believe that your account has been compromised, follow these steps:

- Reset your password and scan your devices for malware. However, the hacker might have configured other settings on your mailbox (for example, created Inbox rules to auto-forward email messages or added additional mailbox delegates). So, follow the additional steps in [How to determine whether your account has been compromised](/office365/troubleshoot/sign-In/determine-account-is-compromised).

- Notify your email admin. Your admin will need to unblock your account before you can send email again.

### Solution 5: Confirm that the NDR is related to a message that you actually sent

If your **Sent** folder contains only messages that you know you sent, then the NDR you received could be a result of _backscatter_ (a useless NDR about a message you didn't send), and you can ignore it.

Typically, if a message can't be delivered, the recipient's email system will use the sender's email address in the **From** field to notify the sender in an NDR like this one. But what if the message was sent by a spammer who falsified the **From** address so it appears the message came from your email address? The resulting NDR that you'll receive is useless because it creates the false impression that you did something wrong. This type of useless NDR is called _backscatter_. It's annoying, but if this NDR is backscatter, your account hasn't been compromised.

Check your recent messages in the **Sent Items** folder for strange or unknown messages (messages that you didn't send). If you don't see any suspicious messages, it's likely that the NDR you received is backscatter. If you've already changed your password and run an anti-malware scan, you can ignore these backscatter NDRs.

To learn more, see [Backscatter in EOP](/microsoft-365/security/office-365-security/backscatter-messages-and-eop).

## I'm an email admin. What can I do to fix this?

If the steps in the previous section don't solve the issue for the sender, the solution might be related to the way the user's Microsoft 365 or Office 365 account is set up. If you have a hybrid topology, the solution might also be related to the on-premises mail transfer agent. It might also be a problem with the recipient's domain configuration. Here are four solutions you can try. You might not need to try all of them to get the message sent successfully.

### Solution 1: Check the Microsoft 365 admin center for configuration problems or service-wide issues

For Microsoft 365 or Office 365 accounts, the Microsoft 365 admin center provides a central source for various tools, notifications, and information that you can use to troubleshoot this and other issues.

Open the [Microsoft 365 admin center](https://admin.microsoft.com), and from the **Home** page, do the following items:

1. Check the **Message Center** to see if your organization has a known configuration issue.

2. Go to **Health** \> **Service health** to see if there's a current service issue in Microsoft 365 or Office 365 affecting the user's account.

3. Check the sender and recipient domains for incorrect or stale mail exchange (MX) resource records by running the [Mailflow Troubleshooter](/exchange/mail-flow-best-practices/troubleshoot-mail-flow) tool that is available within Microsoft 365 and Office 365.

If there's a problem with the recipient's domain, contact the recipient or the recipient's email administrator to let them know about the problem. They'll have to resolve the issue in order to prevent NDR 5.1.x errors.

### Solution 2: Update stale MX records

Error code 5.1.1 can be caused by problems with the MX resource record for the recipient's domain. For example, the MX record might point to an old email server, or the MX record might be ambiguous due to a recent configuration change.

> [!NOTE]
> Updates to a domain's DNS records can take up to 72 hours to propagate to all DNS servers on the Internet.

If external senders (senders outside your organization) receive this NDR when they send message to recipients in your domain, try the following steps:

- The MX resource record for your domain might be incorrect. The MX record for an Exchange Online domain points to the email server (host) _\<domain\>_.mail.protection.outlook.com.

- Verify that you have only one MX record configured for your Exchange Online domain. We don't support using more than one MX record for domains enrolled in Exchange Online.

- Test your MX record and your ability to send email from your Exchange Online organization by using the **Verify MX Record and Outbound Connector Test** at **Office 365** \> **Mail Flow Configuration** in the Microsoft Remote Connectivity Analyzer.

For more information, see [Add DNS records to connect your domain](/microsoft-365/admin/get-help-with-domains/create-dns-records-at-any-dns-hosting-provider) and [Set up SPF to help prevent spoofing](/microsoft-365/security/office-365-security/set-up-spf-in-office-365-to-help-prevent-spoofing).

### Solution 3: Update forwarding rules to remove incorrect email addresses

This NDR might be caused by a forwarded (unintended) recipient that's configured for the intended recipient. For example:

- A forwarding Inbox rule or delegate that the recipient configured in their own mailbox.

- A mail flow rule (also known as a transport rule) configured by an email admin that copies or forwards messages sent to the recipient to another invalid recipient.

For more information, see [Configure email forwarding for a mailbox](/exchange/recipients-in-exchange-online/manage-user-mailboxes/configure-email-forwarding).

## Still need help with error code 5.1.1 to 5.1.20?

[:::image type="icon" source="media/community-forum-icon.png":::](https://answers.microsoft.com/)

[:::image type="icon" source="media/create-service-request-icon.png":::](https://admin.microsoft.com/AdminPortal/Home#/support)

[:::image type="icon" source="media/call-support-icon.png":::](/microsoft-365/Admin/contact-support-for-business-products)

## See also

[Email non-delivery reports in Office 365](non-delivery-reports-in-exchange-online.md)
