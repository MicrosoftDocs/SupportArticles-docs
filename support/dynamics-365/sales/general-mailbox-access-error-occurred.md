---
title: A general mailbox access error occurred
description: Provides a solution to the 0x80004005 error that occurs when you attempt to test and enable a mailbox in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# A general mailbox access error occurred while receiving email error appears when testing and enabling a mailbox in Microsoft Dynamics 365

This article provides a solution to an error that occurs when you attempt to test and enable a mailbox in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4092736

## Symptoms

When you attempt to test and enable a mailbox in Microsoft Dynamics 365, you receive the following error:

> "A general mailbox access error occurred while receiving email. Mailbox \<Mailbox Name> didn't synchronize. The owner of the associated email server profile \<Profile Name> has been notified.  
**Email Server Error Code:**  Socket returned exception TimedOut."

If you select the **Details** section, you may also see more details such as the following text:

> "Error : System.Net.Sockets.SocketException (0x80004005): A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond \<IP Address>\<Port>  
   at System.Net.Sockets.TcpClient.Connect(String hostname, Int32 port)  
   at Microsoft.Crm.Asynchronous.EmailConnector.Pop3Client.Connect()"

## Cause

This error can occur if the port values within the Advanced section of the email server profile aren't correct.

## Resolution

1. Navigate to **Settings**, **Email Configuration**, and then select **Email Server Profiles**.
2. Open the Email Server Profile that is used by the mailbox meeting this error.

    > [!NOTE]
    > You can also select the name of the Email Server Profile within the error message. It appears as a hyperlink which will open the correct Email Server Profile record.

3. Select **Advanced**.
4. Verify the **Incoming Port** and **Outgoing Port** values and then select **Save**.

    > [!NOTE]
    > Refer to the documentation from your email provider for the correct ports to use when connecting to the SMTP service. For [Gmail](https://support.google.com/mail/answer/7104828), the incoming POP3 port is 995 and outgoing SMTP port is 587.

5. Select **Mailboxes** and then select the mailbox that received the error.
6. Select the **Test & Enable Mailboxes** button.
7. After the tests complete, open the mailbox record and view the **Alerts** section if the results don't appear as Success.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
