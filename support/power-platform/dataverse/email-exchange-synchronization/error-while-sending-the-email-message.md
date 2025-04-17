---
title: An unknown error occurred while sending the email message
description: Provides a solution to an error that occurs when you test and enable a mailbox in Microsoft Dynamics 365.
ms.reviewer: 
ms.date: 04/17/2025
ms.custom: sap:Email and Exchange Synchronization
---
# "An unknown error occurred while sending the email message" when testing a mailbox in Dynamics 365

This article provides a solution to an error that occurs when you try to test and enable a mailbox in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4092733

## Symptoms

When you try to [test and enable a mailbox](/power-platform/admin/connect-exchange-online#test-the-configuration-of-mailboxes) in Microsoft Dynamics 365, you receive the following error:

> An unknown error occurred while sending the email message "Your mailbox is now connected to Dynamics 365". Mailbox \<Mailbox Name> didn't synchronize. The owner of the associated email server profile \<Profile Name> has been notified.

If you select the **Details** section, you might find the following details:

> Error : System.Net.Mail.SmtpException: Syntax error, command unrecognized. The server response was:  
> at System.Net.Mail.SmtpConnection.ConnectAndHandshakeAsyncResult.End(IAsyncResult result)  
> at System.Net.Mail.SmtpTransport.EndGetConnection(IAsyncResult result)  
> at System.Net.Mail.SmtpClient.ConnectCallback(IAsyncResult result)

## Cause

This error can occur if the **Outgoing Port** value in the **Advanced** section of the email server profile isn't correct.

## Resolution

To fix this issue, follow these steps:

1. Sign in to your Dynamics 365 organization with a user account that has the "System Administrator" role.
1. Navigate to **Settings** > **Email Configuration**, and then select **Email Server Profiles**.

1. Open the email server profile that's used by the mailbox receiving this error.

    > [!NOTE]
    > You can also select the name of the email server profile in the error message. It appears as a hyperlink that will open the correct email server profile record.

1. Select **Advanced**.
1. Correct the **Outgoing Port** value and then select **Save**.

    > [!NOTE]
    > Refer to the documentation from your email provider for the correct ports when connecting to the SMTP service. For example, for [Gmail](https://support.google.com/mail/answer/7104828), use port 587 for TLS/STARTTLS connections.

1. Select **Mailboxes**, and then select the mailbox that received the error.
1. Select the **Test & Enable Mailboxes** button.

1. After the test is complete, open the mailbox record and view the **Alerts** section if the results don't appear as **Success**.
