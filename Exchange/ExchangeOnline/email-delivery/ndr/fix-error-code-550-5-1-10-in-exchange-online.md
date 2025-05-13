---
title: Fix NDR error 550 5.1.10 in Exchange Online
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
ms.assetid: 5a04a25a-a34f-476b-afc6-007fb92f86a1
description: Learn how to fix email issues for error code 550 5.1.10 in Exchange Online (invalid recipient or backscatter).
---

# Fix NDR error "550 5.1.10" in Exchange Online

> [!IMPORTANT]
> Mail flow rules are now available in the new Exchange admin center. [Try it now](https://admin.exchange.microsoft.com/#/transportrules)!

Problems sending and receiving email messages can be frustrating. If you get a non-delivery report (NDR), also called a bounce message, for error code 550 5.1.10, this article can help you fix the problem and get your message sent.

|&nbsp;|&nbsp;|&nbsp;|&nbsp;|
|---|---|---|---|
|:::image type="icon" source="media/email-user-icon.png":::|[I got this bounce message. How do I fix it?](#i-got-this-bounce-message-how-do-i-fix-it)|:::image type="icon" source="media/email-admin-icon.png":::|[I'm an email admin. How can I fix this issue?](#im-an-email-admin-how-can-i-fix-this-issue)|

## Why did I get this bounce message?

You received this NDR with error code 5.1.10 for one of the following reasons:

- The recipient's email address doesn't exist or couldn't be found. Go to the [I got this bounce message. How do I fix it?](#i-got-this-bounce-message-how-do-i-fix-it) section in this article.

Typically, if a message can't be delivered, the recipient's email system will use the sender's email address in the **From** field to notify the sender in an NDR like this one. But what if the message was sent by a spammer who falsified the **From** address so it appears the message came from your email address? The resulting NDR that you'll receive is useless because it creates the false impression that you did something wrong. This type of useless NDR is called _backscatter_. It's annoying, but if this NDR is backscatter, your account hasn't been compromised.

- A spammer sent a message to a non-existent recipient, and they falsified the **From** address so it appears the message was sent by your email address. The resulting bounce message that you get is called _backscatter_, and you can safely ignore or delete the bounce message.

  Backscatter itself is harmless, but if you're getting much of it, it's possible that your computer or device is infected with spam-sending malware. Consider running an anti-malware scan. Additionally, to help prevent spammers from impersonating you or others in your organization, ask your email admin to read this topic: [Set up SPF to help prevent spoofing](/microsoft-365/security/office-365-security/set-up-spf-in-office-365-to-help-prevent-spoofing).

## I got this bounce message. How do I fix it?

Here are some steps that you can try to fix the problem yourself.

If the steps in this section don't fix the problem for you, contact your email admin and refer them to the information in this article so they can try to resolve the issue for you.

### Verify recipient's email address and resend your message

#### Verify recipient's email address and resend your message in Outlook

1. Open the bounce message. In the **Report** tab, choose **Send Again**.

   :::image type="content" source="media/fix-error-code-550-5-1-10-in-exchange-online/send-again.png" alt-text="Screenshot shows the Report tab of a bounce message with the Send Again option and text in the body of the email message that says the message couldn't be delivered." border="false":::

   If your original message had an attachment larger than 10 MB, the **Send Again** option might not be available or might not work. Instead, resend the message from your **Sent Items** folder. For more information, see [Resend an email message](https://support.microsoft.com/office/acd16ac4-c881-477d-b4aa-36168fa96088).

2. In the new copy of your message, select the recipient's email address in the **To** box and then press the **Delete** key.

3. Remove the recipient's email address from the Auto-Complete list (a bad or outdated entry could be causing the problem):

   1. In the **To** box, start typing the recipient's email address until it appears in the Auto-Complete drop-down list as shown below.

      :::image type="content" source="media/fix-error-code-550-5-1-10-in-exchange-online/resend-to.png" alt-text="Screenshot shows the Send Again option for an email message. In the Resend to field, the AutoComplete feature provides the email address for the recipient based on the first few letters typed of the recipient's name." border="false":::

   2. Use the Down Arrow key to select the recipient from the Auto-Complete drop-down list and then press the Delete key or choose the **Delete** icon :::image type="icon" source="media/fix-error-code-550-5-1-10-in-exchange-online/delete-icon.png"::: to the right of the email address.

4. In the **To** box, continue typing the entire recipient email address. Be sure to spell the address correctly.

   :::image type="content" source="media/fix-error-code-550-5-1-10-in-exchange-online/autocomplete.png" alt-text="Screenshot shows the Send Again option for an email message. In the Resend to field, the recipient's address has been provided by the AutoComplete feature." border="false":::

   2. Use the Down Arrow key to select the recipient from the Auto-Complete drop-down list and then press the Delete key or choose the **Delete** icon to the right of the email address.

4. In the **To** box, continue typing the entire recipient email address. Be sure to spell the address correctly.

5. Click **Send**.

#### Verify recipient's email address and resend your message in Outlook on the web (formerly known as Outlook Web App)

1. Open the bounce message. In the reading pane, just below the message header information, choose **To send this message again, click here**.

   :::image type="content" source="media/fix-error-code-550-5-1-10-in-exchange-online/undeliverable-message.png" alt-text="Screenshot shows a portion of an Undeliverable bounce message with the option to send the message again." border="false":::

   If your original message had an attachment larger than 10 MB, the **Send Again** option might not be available or might not work. Instead, resend the message from your **Sent Items** folder.

2. On the **To** line of the new copy of your message, choose the **Delete** icon :::image type="icon" source="media/fix-error-code-550-5-1-10-in-exchange-online/delete-icon.png"::: to delete the recipient's email address.

   :::image type="content" source="media/fix-error-code-550-5-1-10-in-exchange-online/delete-option.png" alt-text="Screenshot shows the To line of an email message with the option to delete the recipient's email address." border="false":::
   If your original message had an attachment larger than 10 MB, the **Send Again** option might not be available or might not work. Instead, resend the message from your **Sent Items** folder.

2. On the **To** line of the new copy of your message, choose the **Delete** icon to delete the recipient's email address.

3. Remove the recipient's email address from the Auto-Complete list (a bad or outdated entry could be causing the problem):

   1. On the empty **To** line, start typing the recipient's name or email address until it appears in the Auto-Complete drop-down list.

      :::image type="content" source="media/fix-error-code-550-5-1-10-in-exchange-online/to-line.png" alt-text="Screenshot shows the To line of an email message with the option to delete the recipient's email address from the Auto-Complete list." border="false":::

   2. Use the Down Arrow key to select the recipient from the Auto-Complete list, and then press the Delete key. Or, hover over the recipient's name and click the **Delete** icon :::image type="icon" source="media/fix-error-code-550-5-1-10-in-exchange-online/delete-icon.png":::.
   2. Use the Down Arrow key to select the recipient from the Auto-Complete list, and then press the Delete key. Or, hover over the recipient's name and click the **Delete** icon.

4. On the **To** line, continue typing the recipient's entire email address. Be sure to spell the address correctly.

5. Click **Send**.

### Ask the recipient to check for broken forwarding rules or settings

Does the recipient's email address in your original message exactly match the recipient's email address in the NDR? Compare the recipient's email address in the NDR with the recipient's email address in the message in your **Sent Items** folder.

If the addresses don't match, contact the recipient (by phone, in person, etc.) and ask them if they've configured an email rule that forwards incoming email messages from you to another destination. Their rule could have tried to send a copy of your message to a bad email address. If the recipient has such a rule, they'll need to correct the destination email address or remove the rule in order to prevent 5.1.x message delivery errors.

Microsoft 365 and Office 365 support multiple ways to forward messages automatically. If the intended recipient of your message is using Microsoft 365 or Office 365, ask them to review the [Update, disable, or remove Inbox Rules forwarding](#update-disable-or-remove-inbox-rules-forwarding) and [Disable account forwarding](#disable-account-forwarding) sections below.

If the problem persists after performing these steps, ask the recipient to refer their email admin to the [I'm an email admin. How can I fix this issue?](#im-an-email-admin-how-can-i-fix-this-issue) section below.

#### Update, disable, or remove Inbox rules forwarding

1. In Microsoft 365 or Office 365, sign in to your user account.

2. Click the gear icon in the top-right corner to show the **Settings** pane.

3. Select **Your app settings** \> **Mail**.

    :::image type="content" source="media/fix-error-code-550-5-1-10-in-exchange-online/settings-pane.png" alt-text="Screenshot shows the Settings pane with the Mail option highlighted in the Your app settings section." border="false":::

4. From the **Options** navigation pane on the left, select **Mail** \> **Automatic processing** \> **Inbox and sweep rules**.

    :::image type="content" source="media/fix-error-code-550-5-1-10-in-exchange-online/inbox-rules.png" alt-text="Screenshot of the Inbox rules page." border="false":::

4. From the **Options** navigation pane on the left, select **Mail** \> **Automatic processing** \> **Inbox and sweep rules**.

5. Update, turn off, or delete any rules that might be forwarding the sender's message to a non-existent or broken email address.

#### Disable account forwarding

1. Sign in to your Microsoft 365 or Office 365 account, and from the same **Options** navigation as shown above, select **Mail** \> **Accounts** \> **Forwarding**.

    :::image type="content" source="media/fix-error-code-550-5-1-10-in-exchange-online/forwarding.png" alt-text="Screenshot shows the Forwarding option page with the Stop forwarding option selected." border="false":::

2. Select **Stop forwarding** and click **Save** to disable account forwarding.

## I'm an email admin. How can I fix this issue?

If the sender can't fix the issue themselves, the problem might be that an email system on the receiving side isn't configured correctly. If you're the email admin for the recipient, try one or more of the following fixes and then ask the sender to resend the message.

### Verify that the recipient exists and has an active license assigned

To verify that the recipient exists and has an active license assigned:

1. In the Microsoft 365 admin center, choose **Users** to go to the **Active users** page.

2. In the **Active users** \> **Filters** search field, type part of the recipient's name, and then press Enter to locate the recipient. If the recipient doesn't exist, then you must create a new mailbox or contact for this user. (For more information, see [Add users individually or in bulk](/microsoft-365/admin/add-users/add-users).) If the recipient does exist, make sure the recipient's username matches the email address the sender used.

   :::image type="content" source="media/fix-error-code-550-5-1-10-in-exchange-online/active-users.png" alt-text="Screenshot shows a section of the Active users page with a search term." border="false":::

3. If the user's mailbox is hosted in Exchange Online, click the user's record to review their details and verify that they've been assigned a valid license for email (for example, an Office 365 Enterprise E5 license).

   :::image type="content" source="media/fix-error-code-550-5-1-10-in-exchange-online/product-licenses.png" alt-text="Screenshot of user information. The Product licenses area shows that no products have been assigned for the user and the option to edit is available." border="false":::

4. If the user's mailbox is hosted in Exchange Online, but no license has been assigned, choose **Edit** and assign the user a license.

   :::image type="content" source="media/fix-error-code-550-5-1-10-in-exchange-online/assign-license.png" alt-text="Screenshot of a product license that's available." border="false":::

3. If the user's mailbox is hosted in Exchange Online, click the user's record to review their details and verify that they've been assigned a valid license for email (for example, an Office 365 Enterprise E5 license).

4. If the user's mailbox is hosted in Exchange Online, but no license has been assigned, choose **Edit** and assign the user a license.

### Fix or remove broken forwarding rules or settings

Microsoft 365 or Office 365 provides the following features for users and email admins to forward messages to another email address:

- Forwarding using Inbox rules (user)

- Account forwarding (user and email admin)

- Forwarding using mail flow rules (email admin)

Follow the steps below to fix the recipient's broken mail forwarding rule or settings.

#### Forwarding using Inbox rules (user)

The recipient might have an Inbox rule that is forwarding messages to a problematic email address. Inbox rules are available only to the user (or someone with delegated access to their account). See [Update, disable, or remove Inbox Rules forwarding](#update-disable-or-remove-inbox-rules-forwarding) for how the user, or their delegate, can change or remove a broken forwarding Inbox rule.

#### Account forwarding (user and email admin)

1. In the Microsoft 365 admin center, choose **Users**.

2. In the **Active users** \> **Filters** search field, type part of the recipient's name and then press Enter to locate the recipient. Click the user's record to view its details.

3. From the user's profile page, select **Mail Settings** \> **Email forwarding** \> **Edit**.

   :::image type="content" source="media/fix-error-code-550-5-1-10-in-exchange-online/user-profile.png" alt-text="Screenshot of the user profile page. Email forwarding is set to the value Applied and an edit option is available." border="false":::

4. Turn off **Email forwarding** and select **Save**.

   :::image type="content" source="media/fix-error-code-550-5-1-10-in-exchange-online/email-forwarding-off.png" alt-text="Screenshot of the Email forwarding setting that's turned off." border="false":::

4. Turn off **Email forwarding** and select **Save**.

#### Forwarding using mail flow rules (email admin)

Unlike Inbox rules that are associated with a user's mailbox, mail flow rules (also known as transport rules) are organization-wide settings and can only be created and edited by email admins.

1. In the Microsoft 365 Admin center, select **Admin centers** \> **Exchange**.

   :::image type="content" source="media/fix-error-code-550-5-1-10-in-exchange-online/microsoft-365-admin-center.png" alt-text="The Microsoft 365 Admin center home screen.":::

2. In the Exchange admin center (EAC), that is, New EAC or Classic EAC, go to **Mail flow** \> **Rules**.

3. Look for any redirect rules that might be forwarding the sender's message to another address. 
    - An example of a redirect rule in New EAC is the following image.

        :::image type="content" source="media/fix-error-code-550-5-1-10-in-exchange-online/redirect-rule-forwarding-sender-message.png" alt-text="The screen displaying a redirect rules that forwards sender's message to another address":::

    - An example of a redirect rule in Classic EAC is the following image.

         :::image type="content" source="media/fix-error-code-550-5-1-10-in-exchange-online/classic-eac-redirect-rule.png" alt-text="Screenshot of the Rules page in Classic Exchange admin center":::

2. In the Exchange admin center (EAC), that is, New EAC or Classic EAC, go to **Mail flow** \> **Rules**.

3. Look for any redirect rules that might be forwarding the sender's message to another address.
    - An example of a redirect rule in New EAC is the following image.

    - An example of a redirect rule in Classic EAC is the following image.

4. Update, turn off, or delete any suspect forwarding rules.

#### Update accepted domain settings

**Notes**:

- Message routing (especially in hybrid configurations) can be complex. Even if changing the accepted domain setting fixes the bounce message problem, it might not be right solution for you. In some cases, changing the accepted domain type might cause other unanticipated problems. Review [Manage accepted domains in Exchange Online](/exchange/mail-flow-best-practices/manage-accepted-domains/manage-accepted-domains) and then proceed with caution.
  - **If the accepted domain in Exchange Online is Authoritative**: The service looks for the recipient in the Exchange Online organization, and if the recipient isn't found, message delivery stops and the sender will receive this bounce message. On-premises users must be represented in the Exchange Online organization by mail contacts or mail users (created manually or by directory synchronization).
  - **If the accepted domain in Exchange Online is Internal Relay**: The service looks for the recipient in the Exchange Online organization, and if the recipient isn't found, the service relays the message to your on-premises Exchange Organization (assuming you've correctly set up the required connector to do so).

- When setting an accepted domain to Internal Relay, you must set up a corresponding Microsoft 365 or Office 365 connector to your on-premises environment. Failing to do so will break mail flow to your on-premises recipients. For more information about connectors, see [Configure mail flow using connectors](/exchange/mail-flow-best-practices/use-connectors-to-configure-mail-flow/use-connectors-to-configure-mail-flow).

**To change the Accepted Domain from Authoritative to Internal Relay**:

If you have a hybrid configuration with a Microsoft 365 or Office 365 connector configured to route messages to your on-premises environment, and you believe that Internal Relay is the correct setting for your domain, change the Accepted Domain from Authoritative to Internal Relay.

**New Exchange admin center (EAC)**:

1. Open the New Exchange admin center (EAC). For more information, see [Exchange admin center in Exchange Online](/exchange/exchange-admin-center).

2. Choose **Mail flow** \> **Accepted domains**. The **Accepted domains** screen appears.

3. Select a recipient's domain and double-click it.

   :::image type="content" source="media/fix-error-code-550-5-1-10-in-exchange-online/choose-recipient-domain.png" alt-text="Screenshot of the Accepted domains page in which the recipient domain is chosen.":::

   The accepted's domain details screen appears.

4. Click the radio button for **Internal Relay**.

   :::image type="content" source="media/fix-error-code-550-5-1-10-in-exchange-online/choosing-internal-relay.png" alt-text="The screen on which the domain value is set to Internal Relay.":::

5. Click **Save**.

#### Manually synchronize on-premises and Microsoft 365 or Office 365 directories

If you have a hybrid configuration and the recipient is located in the on-premises Exchange organization, it's possible that the recipient's email address isn't properly synchronized with Microsoft 365 or Office 365. Follow these steps to synchronize directories manually:

1. Log into the on-premises server that's running Microsoft Entra Connect Sync.
2. Open Windows PowerShell on the server and run the following commands:

   ```powershell
   Start-ADSyncSyncCycle -PolicyType Delta
   ```

When synchronization completes, repeat the steps in the [Verify that the recipient exists and has an active license assigned](#verify-that-the-recipient-exists-and-has-an-active-license-assigned) section to verify that the recipient address exists in Exchange Online.

## Verify the custom domain's mail exchanger (MX) record

If you have a custom domain (for example, contoso.com instead of contoso.onmicrosoft.com), it's possible that your domain's MX record isn't configured correctly.

1. In the Microsoft 365 Admin center, go to **Settings** \> **Domains**, and then select the recipient's domain.

   :::image type="content" source="media/fix-error-code-550-5-1-10-in-exchange-online/domains.png" alt-text="Screenshot shows admin center with the Domains option selected. Domain names are shown on the page along with the options to add or buy a domain." border="false":::

2. In the pop-out **Required DNS settings** pane, select **Check DNS**.

   :::image type="content" source="media/fix-error-code-550-5-1-10-in-exchange-online/dns-settings.png" alt-text="Screenshot of the Required DNS settings page and the Check DNS button is highlighted." border="false":::

2. In the pop-out **Required DNS settings** pane, select **Check DNS**.

3. Verify that there's only one MX record configured for the recipient's domain. Microsoft doesn't support using more than one MX record for a domain that's enrolled in Exchange Online.

4. If Microsoft 365 or Office 365 detects any issues with your Exchange Online DNS record settings, follow the recommended steps to fix them. You might be prompted to make the changes directly within the Microsoft 365 admin center. Otherwise, you must update the MX record from your DNS host provider's portal. For more information, see [Create DNS records at any DNS hosting provider](/microsoft-365/admin/get-help-with-domains/create-dns-records-at-any-dns-hosting-provider).

   > [!NOTE]
   > Typically, your domain's MX record should point to the Microsoft 365 or Office 365 fully qualified domain name: \<your domain\>.mail.protection.outlook.com or \<your domain>\.subdomain.mx.microsoft. DNS record updates usually propagate across the Internet in a few hours, but they can take up to 72 hours.

## Still need help with a 5.1.10 bounce message?

[:::image type="icon" source="media/community-forum-icon.png":::](https://answers.microsoft.com/)

[:::image type="icon" source="media/create-service-request-icon.png":::](https://admin.microsoft.com/AdminPortal/Home#/support)

[:::image type="icon" source="media/call-support-icon.png":::](/microsoft-365/Admin/contact-support-for-business-products)

## See also

[Email non-delivery reports in Exchange Online](non-delivery-reports-in-exchange-online.md)

[Backscatter in EOP](/microsoft-365/security/office-365-security/backscatter-messages-and-eop)

[Configure email forwarding for a mailbox](/exchange/recipients-in-exchange-online/manage-user-mailboxes/configure-email-forwarding)

[Synchronizing your directory with Microsoft 365 or Office 365 is easy](https://www.microsoft.com/microsoft-365/blog/2014/04/15/synchronizing-your-directory-with-office-365-is-easy/)

[Create DNS records at any DNS hosting provider](/microsoft-365/admin/get-help-with-domains/create-dns-records-at-any-dns-hosting-provider)

[Set up SPF to help prevent spoofing](/microsoft-365/security/office-365-security/set-up-spf-in-office-365-to-help-prevent-spoofing)
