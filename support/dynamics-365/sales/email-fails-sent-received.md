---
title: Email fails to be sent or received
description: Provides solutions to errors that occur when Server-Side Synchronization is configured with Gmail.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Email fails to be sent or received when Server-Side Synchronization is configured with Gmail

This article provides solutions to errors that occur when Server-Side Synchronization is configured with Gmail.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2013, Microsoft Dynamics CRM 2015, Microsoft Dynamics CRM 2016, Microsoft Dynamics CRM 2016 Service Pack 1  
_Original KB number:_ &nbsp; 3185281

## Symptoms

If Microsoft Dynamics CRM is configured to use Server-Side Synchronization with Gmail, you may receive one of the following error messages:

> Email cannot be received for the mailbox \<Mailbox Name>. Make sure that the credentials specified in the mailbox are correct and have sufficient permissions for receiving email. Then, enable the mailbox for email processing.

> An unknown error occurred while sending the email message "Test Message". Mailbox \<Mailbox Name> didn't synchronize. The owner of the associated email server profile \<Email Server Profile Name> has been notified.

## Cause

The errors occur for one of the following reasons:

- Cause 1

    The email address, username, or password in the mailbox record in Microsoft Dynamics CRM aren't correct.

- Cause 2

    The correct port isn't configured within the Email Server Profile record in Microsoft Dynamics CRM.

- Cause 3

    POP isn't enabled on your Gmail mailbox.

- Cause 4

    A setting in Gmail is preventing Server-Side Sync from authenticating to the Gmail mailbox.

## Resolution

- Resolution 1

    Verify the values of the Email Address, Username, and Password fields in the mailbox record in Microsoft Dynamics CRM.

- Resolution 2

    Open the Email Server Profile and then select **Advanced**. Set the Incoming Port to 995 and the Outgoing Port to 587.

- Resolution 3

    Follow the Gmail instructions for [enabling POP](https://support.google.com/mail/answer/7104828).

- Resolution 4

    Check your Gmail mailbox for an email about a blocked sign-in attempt. The message will include steps for how to unblock access. After following the steps, try testing and enabling the mailbox in CRM again.

If the issue still occurs, see [Troubleshoot sign-in problems](https://support.google.com/mail/answer/7126229?&ref_topic=3397501&rd=1#cantsignin), which includes additional steps that may be necessary to enable email access from an app.

## More information

The details section of the Alert may include the following text:

> "Error : System.Net.Mail.SmtpException: Syntax error, command unrecognized. The server response was:  
 at System.Net.Mail.SmtpConnection.ConnectAndHandshakeAsyncResult.End(IAsyncResult result)  
 at System.Net.Mail.SmtpClient.ConnectCallback(IAsyncResult result)"

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
