---
title: Fix issues with printers, scanners, and LOB apps that send email using Microsoft 365
ms.date: 01/24/2024
ms.localizationpriority: medium
description: Fix issues with printers, scanners, and line of business applications that use Microsoft 365 or Office 365 to send email.
ms.topic: troubleshooting
author: cloud-writer
ms.author: meerak
ms.assetid: c75542a8-c792-42c0-a8c5-291df987512d
ms.reviewer: v-six
ms.collection:
- exchange-online
- M365-email-calendar
search.appverid:
- BCS160
- MET150
- MOE150
f1.keywords:
- CSH
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - CI 167832
manager: dcscontentpm
---

# Fix issues with printers, scanners, and LOB apps that send email using Microsoft 365

Email clients provide actionable error messages when something goes wrong. Sending email from devices and applications is less easy to fix, and you might not get clear information to help you. This article can help you troubleshoot, and it uses printer configurations as examples.

 **As a first step to fixing any problems, check your configuration**. See [How to set up a multifunction device or application to send email using Microsoft 365 or Office 365](/exchange/mail-flow-best-practices/how-to-set-up-a-multifunction-device-or-application-to-send-email-using-microsoft-365-or-office-365) for detailed information about the configuration options.

## My printer is already configured for email, but I don't know which configuration option it uses

The following list describes the available configuration options:

1. **SMTP AUTH client submission (recommended)**
   - Your printer is connected to the server named smtp.office365.com.
   - You entered an email address and password for Microsoft 365 or Office 365 account/mailbox that the printer uses.
   - The printer can send email to people inside and outside your organization.

   :::image type="content" source="media/fix-issues-with-printers-scanners-and-lob-applications-that-send-email-using-off/multifunction-printer-connects to-m365.png" alt-text="Shows how a multifunction printer connects to Microsoft 365 or Office 365 using SMTP client submission.":::

2. **Direct send**
   - Your printer is connected to a Microsoft 365 or Office 365 server whose name ends with mail.protection.outlook.com.
   - There's no connector in Microsoft 365 or Office 365 for mail sent from your on-premises organization to Microsoft 365 or Office 365.
   - The printer can send email only to people in your organization; the printer can't send email to recipients outside your organization.

   :::image type="content" source="media/fix-issues-with-printers-scanners-and-lob-applications-that-send-email-using-off/multifunction-printer-uses-mx-endpoint.png" alt-text="Shows how a multifunction printer uses your Microsoft 365 or Office 365 MX endpoint to send email directly to recipients in your organization only.":::

3. **Microsoft 365 or Office 365 SMTP relay**
   - Your printer is connected to a Microsoft 365 or Office 365 server whose name ends with mail.protection.outlook.com.
   - You've configured a connector in Microsoft 365 or Office 365 for mail sent from your on-premises organization to Microsoft 365 or Office 365.
   - The printer can send email to people inside and outside your organization.

   :::image type="content" source="media/fix-issues-with-printers-scanners-and-lob-applications-that-send-email-using-off/multifunction-printer-uses-smtp-relay.png" alt-text="Shows how a multifunction printer connects to Microsoft 365 or Office 365 using SMTP relay.":::

## Fix issues with SMTP AUTH client submission
<a name="TroubleshootSMTP"> </a>

### I set up my printer for SMTP AUTH client submission, but it still can't send email

1. Check the settings that were entered directly into the printer:

   |Printer setting|Value|
   |---|---|
   |Server/smart host|smtp.office365.com|
   |Port|Port 587 (recommended) or port 25|
   |TLS/StartTLS|Enabled|
   |Username/email address and password|Sign in credentials of Microsoft 365 or Office 365 mailbox the printer uses|

2. If your printer didn't require a password for the username/email address that you entered, then your printer is trying to send email without logging on to Microsoft 365 or Office 365. SMTP AUTH client submission requires your printer to sign in to Microsoft 365 or Office 365. Direct send and Microsoft 365 or Office 365 SMTP relay don't require a logon; consider one of these options instead.

3. Your printer or application must send email from the same email address that you entered as logon credentials during email setup. If the printer or application wants to send email from another account, the login account should have **Send As** permission for that account. Otherwise, the result is an error similar to:

   > 5.7.60 SMTP; Client does not have permissions to send as this sender.

   For example, if you entered login credentials for `sales@contoso.com` in your printer or application settings, but the printer tries to send email from `salesperson1@contoso.com`, then `sales@contoso.com` should have **Send As** permission for `salesperson1@contoso.com`. Otherwise, this configuration isn't supported. For this scenario, use Microsoft 365 or Office 365 SMTP relay instead.

4. Test the username and password by logging on to Outlook on the web, and try to send a test email to make sure the account isn't blocked. If the user is blocked, see, [Remove blocked users from the Restricted Users portal](/microsoft-365/security/office-365-security/removing-user-from-restricted-users-portal-after-spam).

5. Next, test that you can connect to Microsoft 365 or Office 365 from your network by doing the following steps:

   1. Follow the instructions to [install the Telnet Client tool](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771275(v=ws.10)) on a computer on the same network as the device or application.

   2. Run the tool from the command line by typing **telnet**.

   3. Type **open smtp.office365.com 587** (or substitute **25** for **587** if you're using that port setting instead).

   4. If you connected successfully to an Office 365 server, expect to receive a response line similar to the following response:

      > 220 BY1PR10CA0041.outlook.office365.com Microsoft ESMTP MAIL Service ready at Mon, 1 Jun 2015 12:00:00 +0000

   5. If you can't connect to Microsoft 365 or Office 365, your network firewall or Internet Service Provider (ISP) might have blocked port 587 or 25. Fix this issue so you can send email from your printer.

6. If none of these issues apply to your device, it might not meet requirements for Transport Layer Security (TLS) encryption.

   Recently, we started rejecting a percentage of connections to smtp.office365.com that uses TLS1.0/1.1 for SMTP AUTH.

   Your device must support TLS version 1.2 or above. Update the firmware on the device or try one of the other configuration options where TLS is optional. If you need to utilize TLS 1.0/1.1 for SMTP AUTH to retain legacy clients and devices, you must opt-in by:

   - Set the AllowLegacyTLSClients parameter on the Set-TransportConfig cmdlet to True. Or from Exchange admin center, go to Settings > Mail Flow and (under Security) check "Turn on use of legacy TLS clients" and click on Save.
   - Legacy clients and devices need to be configured to submit to the new endpoint smtp-legacy.office365.com.

To learn more, see [New opt-in endpoint available for SMTP AUTH clients still needing legacy TLS](https://techcommunity.microsoft.com/t5/exchange-team-blog/new-opt-in-endpoint-available-for-smtp-auth-clients-still/ba-p/2659652)

For more information about TLS, see [How Exchange Online uses TLS to secure email connections](/microsoft-365/compliance/exchange-online-uses-tls-to-secure-email-connections).

### I receive an authentication error when my device tries to send email

This error can be caused by a number of issues:

1. Make sure that you entered the correct username and password.
2. Try logging into Outlook on the web with the printer's username and password. Send an email to make sure that the mailbox is active and has not been blocked for sending spam.
3. Check that your device or application supports TLS version 1.2 or above. The best way to check is by upgrading the firmware on the device or updating the application to the latest version. Contact the device manufacturer to confirm that it supports TLS version 1.2 or above.

### Error: Authentication unsuccessful

If you receive one of the following errors:

- 535 5.7.3 Authentication unsuccessful
- 5.7.57 Client not authenticated to send mail

There are a few things you should check:

1. Use [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) to verify that authenticated SMTP submission (also known as SMTP AUTH) is enabled on the licensed mailbox that the printer or application is using to connect to Microsoft 365 or Office 365:

   In [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell), replace \<EmailAddress\> with the email address and run the following command:

   ```powershell
   Get-CASMailbox -Identity <EmailAddress> | Format-List SmtpClientAuthenticationDisabled
   ```

   If the value is True, replace \<EmailAddress\> with the email address and run the following command to enable it:

   ```powershell
   Set-CASMailbox -Identity <EmailAddress> -SmtpClientAuthenticationDisabled $false
   ```

2. Disable Multi-Factor Authentication (MFA) on the licensed mailbox that's being used:
   - In the Microsoft 365 admin center, in the left navigation menu, choose **Users** > **Active users**.
   - On the Active users page, choose **Multi-Factor Authentication**.
   - On the multi-factor authentication page, select the user and disable the Multi-Factor Authentication status.

3. Disable the [Azure Security Defaults](/azure/active-directory/fundamentals/concept-fundamentals-security-defaults) by toggling the **Enable Security Defaults** to **No**:

   > [!CAUTION]
   > Don't do this step unless you understand the risks that are involved.

   - Sign in to the Azure portal as a Security administrator, Conditional Access administrator, or Global administrator.
   - Browse to **Microsoft Entra ID** \> **Properties**.
   - Select **Manage security defaults**.
   - Set the **Enable security defaults** toggle to **No**.
   - Select **Save**.

4. Exclude the user from a [Conditional Access policy](/azure/active-directory/conditional-access/overview) that [blocks Legacy Authentication](/azure/active-directory/conditional-access/block-legacy-authentication):
   - Sign in to the Azure portal as a Security administrator, Conditional Access administrator, or Global administrator.
   - Browse to **Microsoft Entra ID** \> **Security** \> **Conditional Access**.
   - In the policy that blocks Legacy Authentication, exclude the mailbox being used under **Users and Groups** > **Exclude**.
   - Select **Save**.

### Error: 5.7.60 SMTP; Client does not have permissions to send as this sender

This error indicates that the device is trying to send an email from an address that doesn't match the logon credentials. An example would be if your entered login credentials for sales@contoso.com in your application settings but the application tries to send emails from salesperson1@contoso.com. If your application or printer behaves this way, use Microsoft 365 or Office 365 SMTP relay because SMTP client submission does not support this scenario.

### Error: Client was not authenticated to send anonymous mail during MAIL FROM

This error indicates that your printer connects to the SMTP client submission endpoint (smtp.office365.com). However, your printer must also logon to a mailbox to send a message. This error occurs when you have not entered mailbox logon credentials in the printer's settings. If there is no option to enter credentials, this printer does not support SMTP client submission; use either direct send or Microsoft 365 or Office 365 SMTP relay instead. See [How to set up a multifunction device or application to send email using Microsoft 365 or Office 365](/exchange/mail-flow-best-practices/how-to-set-up-a-multifunction-device-or-application-to-send-email-using-microsoft-365-or-office-365).

### Error: 550 5.1.8 Bad outbound sender

This error indicates that the device is trying to send an email from a Microsoft 365 or Office 365 mailbox that is on a spam block list. For help, see [Remove blocked users from the Restricted Users portal](/microsoft-365/security/office-365-security/removing-user-from-restricted-users-portal-after-spam).

### Error: 535 5.7.139 Authentication unsuccessful, federated STS service was unreachable.

This error related to federation gateway servers hosted on-premises by customers. We were unable to reach the configured server location and therefore could not authenticate the federated user.

### Error: 535 5.7.139 Authentication unsuccessful, the federated STS URL does not support HTTPS.

This error related to federation gateway servers hosted on-premises by customers.  We were unable to establish the required secure connection with the server and therefore could not authenticate the federated user. **Note:** This may be due to the deprecation of TLS1.0 and TLS1.1 which is occurring in 2022. You need to make sure your servers are able to use TLS1.2. You can find more information here: [Preparing for TLS 1.2 in Office 365 and Office 365 GCC](/microsoft-365/compliance/prepare-tls-1.2-in-office-365).

## Fix issues with direct send
<a name="Troubleshootdirectsend"> </a>

### I set up my printer for direct send and it's not sending email - or - My device was sending email using direct send, but it stopped working

This can be caused by a number of issues.

1. A common reason for issues with direct send is a blocked IP address. If antispam tools detect outbound spam from your organization, your IP address can be blocked by a spam block list. Check whether your IP address is on a block list by using a third-party service, such as MXToolbox or WhatIsMyIPAddress. Follow up with the organization that added your IP address to their block list. Microsoft 365 and Office 365 use block lists to protect our service. For help, see [Remove blocked users from the Restricted Users portal](/microsoft-365/security/office-365-security/removing-user-from-restricted-users-portal-after-spam).

2. To rule out a problem with your device, send a test email to check your connection to Microsoft 365 or Office 365. To send a test email, follow these steps in the article, [Use Telnet to Test SMTP Communication](/exchange/mail-flow/test-smtp-telnet). If you can't connect to Microsoft 365 or Office 365, your network or ISP might have blocked communication using port 25. If you can't reverse this, use SMTP client submission instead.

### Client was not authenticated to send anonymous mail during MAIL FROM error

This indicates that you are connecting to the SMTP client submission endpoint (smtp.office365.com), which can't be used for direct send. For direct send, use the MX endpoint for your Microsoft 365 or Office 365 organization, which ends with "mail.protection.outlook.com." You can find your MX endpoint by following the steps in [Option 2: Send mail directly from your printer or application to Microsoft 365 or Office 365 (direct send)](/exchange/mail-flow-best-practices/how-to-set-up-a-multifunction-device-or-application-to-send-email-using-microsoft-365-or-office-365#option-2-send-mail-directly-from-your-printer-or-application-to-microsoft-365-or-office-365-direct-send).

### My emails are not sent to recipients who are not in my organization

This is by design. Direct send allows email to be sent only to recipients in your organization that are hosted in Microsoft 365 or Office 365. If you need to send to external recipients, use SMTP client submission or Microsoft 365 or Office 365 SMTP relay.

### The MX endpoint is too long for the printer setting box. Can I use an IP address instead?

It's not possible to use an IP address in place of an MX endpoint. This could result in your not being able to send messages in the future. If the MX endpoint is too long, consider using SMTP client submission, which has a shorter endpoint (smtp.office365.com).

### Emails from my device are marked as junk by Microsoft 365 or Office 365

For direct send, we recommend using a device that sends from a static IP address. This allows you to set up a Sender Policy Framework (SPF) record to help prevent emails being marked as spam. Check that your SPF record is set up with your static IP address. A network or ISP change could change your static IP address. Update your SPF record to reflect this change. If you aren't sending from your own static IP address, consider SMTP client submission instead.

## Fix issues with Microsoft 365 or Office 365 SMTP relay

### I set up my printer for Microsoft 365 or Office 365 SMTP relay but it's not sending email -or- My device was sending email using SMTP relay, but it stopped working

This can be caused by a number of issues.

1. A common reason for issues with Microsoft 365 or Office 365 SMTP relay is a blocked IP address. If antispam tools detect outbound spam from your organization, your IP address can be blocked by a spam block list. Check whether your IP address is on a block list by using a third-party service, such as MXToolbox or WhatIsMyIPAddress. Follow up with the organization that added your IP address to their block list. Microsoft 365 and Office 365 use block lists to protect our service. For help, see [Remove blocked users from the Restricted Users portal](/microsoft-365/security/office-365-security/removing-user-from-restricted-users-portal-after-spam).

2. To rule out a problem with your device, send a test email to check your connection to Microsoft 365 or Office 365. To send a test email, follow these steps in the article, [Use Telnet to Test SMTP Communication](/exchange/mail-flow/test-smtp-telnet). If you can't connect to Microsoft 365 or Office 365, your network or ISP might have blocked communication using port 25. If you can't reverse this, use SMTP client submission instead.

### Emails are no longer being sent to external recipients

Network or ISP changes might change your static IP address. This results in your connector not identifying and relaying your messages to external recipients. Update your connector and your SPF record with the new IP address. Follow the steps in [Option 3: Configure a connector to send mail using Microsoft 365 or Office 365 SMTP relay](/exchange/mail-flow-best-practices/how-to-set-up-a-multifunction-device-or-application-to-send-email-using-microsoft-365-or-office-365#option-3-configure-a-connector-to-send-mail-using-microsoft-365-or-office-365-smtp-relay) to edit your existing connector settings.

### 5.7.64 TenantAttribution; Relay Access Denied or 4.4.62 Mail sent to the wrong Office 365 region

This error indicates that email sent from your application or device is not correctly [attributed](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-message-attribution/ba-p/749143) to your tenant. A common cause of this issue is a change in your dedicated and static IP address or a change in the certificate used by your application or device. Update the inbound connector with the new IP address or new certificate information.

### Email from my device is marked as junk by Microsoft 365 or Office 365

Microsoft 365 or Office 365 SMTP relay requires your device to send email from a static IP address. Check that your SPF record is set up with your static IP address. A network or ISP change could change your static IP address. Update your SPF record to reflect this change. If you aren't sending from your own static IP address, consider SMTP client submission instead.

## Run diagnostic to setup applications or devices sending email using Microsoft 365

> [!NOTE]
> This feature requires a Microsoft 365 administrator account.

If you still need help to fix issues with applications or devices sending email using Microsoft 365, you can run an automated diagnostic.

To run the diagnostic check, select the following button:

> [!div class="nextstepaction"]
> [Run Tests: Send email using Microsoft 365](https://aka.ms/smtprelay)

A flyout page opens in the Microsoft 365 admin center. Select the appropriate option that you are looking for, eg. new setup or troubleshooting existing setup.
