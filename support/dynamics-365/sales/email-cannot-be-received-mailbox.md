---
title: Email cannot be received for the mailbox
description: Fix an issue that occurs when you try to test and enable a mailbox in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# "The email server location or the incoming email port specified in the associated email server profile [profile name] is incorrect" error occurs in Microsoft Dynamics 365

This article provides a solution to an error that occurs when you attempt to test and enable a mailbox in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4463808

## Symptoms

When you attempt to test and enable a mailbox in Microsoft Dynamics 365, you receive the following error:

> "Email cannot not be received for the mailbox [mailbox name] because the email server location or the incoming email port specified in the associated email server profile [profile name] is incorrect. The mailbox didn't synchronize. The owner of the email server profile has been notified.
>
> **Email Server Error Code**: Socket returned exception InvalidIncomingEmailServerProfileConfiguration HostNotFound."

If you select details, you see the following extra details:

> "ActivityId: \<GUID>  
\>Error : System.Net.Sockets.SocketException (0x80004005): No such host is known  
   at System.Net.Dns.GetAddrInfo(String name)  
   at System.Net.Dns.InternalGetHostByName(String hostName, Boolean includeIPv6)  
   at System.Net.Dns.GetHostAddresses(String hostNameOrAddress)  
   at System.Net.Sockets.TcpClient.Connect(String hostname, Int32 port)  
   at Microsoft.Crm.Asynchronous.EmailConnector.Pop3Client.Connect()"

## Cause

This error can occur if the server location or port in the email server profile aren't correct.

## Resolution

1. Navigate to **Settings**, **Email Configuration**, and then select **Email Server Profiles**.  

2. Open the Email Server Profile that is used by the mailbox meeting this error.

    > [!NOTE]
    > You can also select the name of the Email Server Profile within the error message. It appears as a hyperlink which will open the correct Email Server Profile record.

3. Verify the **Incoming Server Location** value.

    > [!NOTE]
    > Refer to the documentation from your email provider for the correct addresses. For [Gmail](https://support.google.com/mail/answer/7104828), the incoming server location would be `pop.gmail.com` and the outgoing server location would be `smtp.gmail.com`.

4. Select **Advanced**.  

5. Verify the **Incoming Port** value and then select **Save**.

    > [!NOTE]
    > Refer to the documentation from your email provider for the correct ports to use when connecting to the SMTP service. For [Gmail](https://support.google.com/mail/answer/7104828), the incoming POP3 port is 995 and outgoing SMTP port is 587.

6. Select **Mailboxes** and then select the mailbox that received the error.  

7. Select the **Test & Enable Mailboxes** button.  

8. After the tests complete, open the mailbox record and view the **Alerts** section if the results don't appear as Success.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
