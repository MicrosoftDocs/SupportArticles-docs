---
title: A general mailbox access error occurred while receiving email
description: Resolves the Socket returned exception TimedOut (0x80004005) error that occurs when you test and enable a mailbox in Microsoft Dynamics 365.
ms.reviewer: 
ms.date: 12/25/2024
ms.custom: sap:Email and Exchange Synchronization
---
# "A general mailbox access error occurred while receiving email" error when testing and enabling a mailbox

This article provides a solution to an error that occurs when you test and enable a mailbox in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4092736

## Symptoms

When you try to [test and enable a mailbox](/power-platform/admin/connect-exchange-online#test-the-configuration-of-mailboxes) in Dynamics 365, you receive the following error message:

> A general mailbox access error occurred while receiving email. Mailbox \<Mailbox Name> didn't synchronize. The owner of the associated email server profile \<Profile Name> has been notified.  
> **Email Server Error Code:**  Socket returned exception TimedOut.

If you select the **Details** section, you might also see more details that resemble the following text:

> Error: System.Net.Sockets.SocketException (0x80004005): A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond \<IP Address>\<Port>  
   at System.Net.Sockets.TcpClient.Connect(String hostname, Int32 port)  
   at Microsoft.Crm.Asynchronous.EmailConnector.Pop3Client.Connect()

## Cause

This error can occur if the port values within the **Advanced** section of the email server profile aren't correct.

## Resolution

1. Sign in to the Dynamics 365 web application as a user with the "System Administrator" role.
1. Navigate to **Settings** > **Email Configuration**, and then select **Email Server Profiles**.
1. Open the email server profile used by the mailbox that received the error.

    > [!NOTE]
    > You can also select the name of the email server profile within the error message. It appears as a hyperlink that will open the correct email server profile record.

1. Select **Advanced**.
1. Verify that both the **Incoming Port** and **Outgoing Port** values are correct according to your email provider's documentation, and then select **Save**.

    > [!NOTE]
    > For example, for [Gmail](https://support.google.com/mail/answer/7104828), the incoming POP3 port is 995, and the outgoing SMTP port is 587.

1. Select **Mailboxes**, and then select the mailbox that received the error.
1. Select the **Test & Enable Mailboxes** button.
1. After the test is complete, verify that the results appear as **Success**. Otherwise, [review the Alerts section](/power-platform/admin/monitor-email-processing-errors#view-alerts) of your mailbox record for any alerts.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
