---
title: OutgoingEmailAuthenticationError error in mailbox alert
description: OutgoingEmailAuthenticationError error appears in Microsoft Dynamics 365 mailbox alert. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# OutgoingEmailAuthenticationError error shows in Microsoft Dynamics 365 mailbox alert

This article provides a resolution for the **OutgoingEmailAuthenticationError** error that occurs in a Microsoft Dynamics 365 mailbox alert.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4533293

## Symptoms

An alert with a message like the following appears in a Microsoft Dynamics 365 mailbox:

> "Email cannot be sent for mailbox "Your mailbox is now connected to Dynamics 365" because either a server certificate needed to connect to the email server could not be validated or the credentials used to send email are incorrect or do not provide access. Mailbox "Your mailbox is now connected to Dynamics 365" didn't synchronize. A notification about this is posted on the alerts wall for the owner of the email server profile [Profile Name].
>
> **Email Server Error Code:**  OutgoingEmailAuthenticationError"

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

This error can occur if you are using a POP3/SMTP email server profile configured for Gmail.

## Resolution

Try following the steps from the Gmail article [Check Gmail through other email platforms](https://support.google.com/mail/answer/7126229?p=BadCredentials&visit_id=637425757915475978-2293973045&rd=2#cantsignin).

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
