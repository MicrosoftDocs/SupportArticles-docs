---
title: Email cannot be received for the mailbox
description: Resolves the email server error code InvalidIncomingEmailServerProfileConfiguration HostNotFound when you test and enable a mailbox in Microsoft Dynamics 365.
ms.reviewer: 
ms.date: 04/17/2025
ms.custom: sap:Email and Exchange Synchronization
---
# "The email server location or the incoming email port specified is incorrect" error in Dynamics 365

This article provides a solution to an error that occurs when you try to test and enable a mailbox in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4463808

## Symptoms

When you try to [test and enable a mailbox](/power-platform/admin/connect-exchange-online#test-the-configuration-of-mailboxes) in Dynamics 365, you receive the following error:

> Email cannot be received for the mailbox \<mailbox name\> because the email server location or the incoming email port specified in the associated email server profile \<profile name\> is incorrect. The mailbox didn't synchronize. The owner of the email server profile has been notified.
>
> **Email Server Error Code**: Socket returned exception InvalidIncomingEmailServerProfileConfiguration HostNotFound.

If you select **Details**, the following additional information appears:

> ActivityId: \<GUID>  
\>Error : System.Net.Sockets.SocketException (0x80004005): No such host is known  
   at System.Net.Dns.GetAddrInfo(String name)  
   at System.Net.Dns.InternalGetHostByName(String hostName, Boolean includeIPv6)  
   at System.Net.Dns.GetHostAddresses(String hostNameOrAddress)  
   at System.Net.Sockets.TcpClient.Connect(String hostname, Int32 port)  
   at Microsoft.Crm.Asynchronous.EmailConnector.Pop3Client.Connect()

## Cause

This error can occur if the server location or port in the email server profile is incorrect.

## Resolution

> [!NOTE]
> To manage security roles and mailbox settings, you need to sign in to your Dynamics 365 organization as a user with the "System Administrator" role.

1. Navigate to **Settings** > **Email Configuration**, and then select **Email Server Profiles**.  

2. Open the email server profile used by the mailbox experiencing this error.

    > [!TIP]
    > You can also select the name of the email server profile in the error message. It appears as a hyperlink that will open the correct email server profile record.

3. Verify that the **Incoming Server Location** value is correct.

    > [!NOTE]
    > Refer to the documentation from your email provider for the correct addresses. For example, for [Gmail](https://support.google.com/mail/answer/7104828), use `pop.gmail.com` as the incoming server location and `smtp.gmail.com` as the outgoing server location.

4. Select **Advanced**.
5. Verify that the **Incoming Port** value is correct, and then select **Save**.

    > [!NOTE]
    > Refer to the documentation from your email provider for the correct ports when connecting to the SMTP service. For [Gmail](https://support.google.com/mail/answer/7104828), use port 995 for incoming POP3 connections and port 587 for outgoing SMTP connections.

6. Select **Mailboxes**, and then select the mailbox that received the error.
7. Select the **Test & Enable Mailboxes** button.
8. After the test is complete, open the mailbox record and [view the Alerts](/power-platform/admin/monitor-email-processing-errors#view-alerts) section if the results don't appear as **Success**.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
