---
title: Error while sending the email message
description: Provides a solution to an error that occurs when you test and enable a mailbox.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# An unknown error occurred while sending the email message error appears when testing and enabling a mailbox in Microsoft Dynamics 365

This article provides a solution to an error that occurs when you try to test and enable a mailbox in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4092733

## Symptoms

When you attempt to test and enable a mailbox in Microsoft Dynamics 365, you receive the following error:

> "An unknown error occurred while sending the email message "Your mailbox is now connected to Dynamics 365". Mailbox \<Mailbox Name> didn't synchronize. The owner of the associated email server profile \<Profile Name> has been notified."

If you select the **Details** section, you may also see more details such as the following text:

> "Error : System.Net.Mail.SmtpException: Syntax error, command unrecognized. The server response was:  
   at System.Net.Mail.SmtpConnection.ConnectAndHandshakeAsyncResult.End(IAsyncResult result)  
   at System.Net.Mail.SmtpTransport.EndGetConnection(IAsyncResult result)  
   at System.Net.Mail.SmtpClient.ConnectCallback(IAsyncResult result)"

## Cause

This error can occur if the Outgoing Port value within the Advanced section of the email server profile isn't correct.

## Resolution

To fix this issue, follow these steps:

1. Navigate to **Settings**, **Email Configuration**, and then select **Email Server Profiles**.
2. Open the Email Server Profile that is used by the mailbox meeting this error.

    > [!NOTE]
    > You can also select the name of the Email Server Profile within the error message. It appears as a hyperlink which will open the correct Email Server Profile record.

3. Select **Advanced**.
4. Correct the **Outgoing Port** value and then select **Save**.

    > [!NOTE]
    > Refer to the documentation from your email provider for the correct ports to use when connecting to the SMTP service. For [Gmail](https://support.google.com/mail/answer/7104828) the port is 587.

5. Select **Mailboxes** and then select the mailbox that received the error.
6. Select the **Test & Enable Mailboxes** button.
7. After the tests complete, open the mailbox record and view the **Alerts** section if the results don't appear as Success.
