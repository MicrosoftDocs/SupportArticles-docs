---
title: OutgoingEmailAuthenticationError in mailbox alert
description: Sovles the OutgoingEmailAuthenticationError that's logged in Microsoft Dynamics 365 mailbox alert.
ms.reviewer: 
ms.date: 12/11/2024
ms.custom: sap:Email and Exchange Synchronization
---
# OutgoingEmailAuthenticationError is logged in Microsoft Dynamics 365 mailbox alert

This article provides a resolution for the **OutgoingEmailAuthenticationError** error that occurs in a Microsoft Dynamics 365 mailbox alert.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4533293

## Symptoms

When viewing [the Alerts area for a user's mailbox](/power-platform/admin/monitor-email-processing-errors#view-alerts), you might see the following error message:

> Email cannot be sent for mailbox "Your mailbox is now connected to Dynamics 365" because either a server certificate needed to connect to the email server could not be validated or the credentials used to send email are incorrect or do not provide access. Mailbox "Your mailbox is now connected to Dynamics 365" didn't synchronize. A notification about this is posted on the alerts wall for the owner of the email server profile [Profile Name].
>
> **Email Server Error Code:**  OutgoingEmailAuthenticationError

If you select **Details**, the following additional information appears:

> ActivityId: [GUID]  
> Error : MailKit.Security.AuthenticationException: 535: 5.7.8 Username and Password not accepted. Learn more at
5.7.8  `https://support.google.com/mail/?p=BadCredentials` x9sm13491053pgt.66 - gsmtp ---> MailKit.Net.Smtp.SmtpCommandException: 5.7.8 Username and Password not accepted. Learn more at
5.7.8  `https://support.google.com/mail/?p=BadCredentials` x9sm13491053pgt.66 - gsmtp  
--- End of inner exception stack trace ---  
   at MailKit.Net.Smtp.SmtpClient.\<AuthenticateAsync>d__65.MoveNext()  
--- End of stack trace from previous location where exception was thrown ---  
   at System.Runtime.ExceptionServices.ExceptionDispatchInfo.Throw()  
   at System.Runtime.CompilerServices.TaskAwaiter.HandleNonSuccessAndDebuggerNotification(Task task)  
   at MailKit.Net.Smtp.SmtpClient.Authenticate(Encoding encoding, ICredentials credentials, CancellationToken cancellationToken)  
   at MailKit.MailService.Authenticate(Encoding encoding, String userName, String password, ...

## Cause

This error can occur if you use a POP3/SMTP email server profile configured for Gmail.

## Resolution

Try following the steps from the Gmail Help article [Check Gmail through other email platforms](https://support.google.com/mail/answer/7126229?p=BadCredentials&visit_id=637425757915475978-2293973045&rd=2#cantsignin).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
