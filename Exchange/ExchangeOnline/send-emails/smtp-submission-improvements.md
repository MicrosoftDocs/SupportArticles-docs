---
title: Changes in message store and throttling for concurrent connections
description: Outgoing messages to be stored in the Sent Item folder, contributing to the mailbox size. Also, a limit is added for concurrent connections.
author: simonxjx
audience: ITPro
ms.service: exchange-online
ms.topic: article
ms.author: v-six
manager: dcscontentpm
localization_priority: Normal
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Exchange Online
---

# Changes in message store and throttling for concurrent connections

## Summary

This article describes improvements that are being made to the SMTP Authenticated Submission client protocol that will be rolled out beginning September 1, 2018.

This protocol is used by applications, services, and devices to automatically send email messages. 

## Changes being implemented

### Messages stored in the Sent Items folder

Email messages that are sent out will be stored in the Sent Item folder of the mailbox that is used. This behavior lets the user determine which email messages are sent by a multifunction device, and makes it easier to troubleshoot issues.

> [!NOTE]
> Be aware that the Sent Items folder contributes to the mailbox size. If the mailbox gets full, sending email messages will be blocked. For a mailbox that sends a high volume of email messages, the retention policy for the Sent Items folder should be set to empty the folder before the mailbox becomes full.

Depending on the application or device that sends email messages, you may experience one of the following errors if the mailbox becomes full:
     
**554 5.2.2 mailbox full; STOREDRV.Submission.Exception:QuotaExceededException.MapiExceptionShutoffQuotaExceeded**         

**554 5.2.2 mailbox full; STOREDRV.Submission.Exception:QuotaExceededException.MapiExceptionQuotaExceeded** 
    
### New throttling limit for concurrent connections that submit messages

The service has various limits to prevent abuse and to ensure fair use. An additional limit is being added. Under the new limit, up to three concurrent connections are allowed to send email messages at the same time. If an application tries to send more than three messages at the same time by using multiple connections, each connection will receive the following error message:
     
**432 4.3.2 STOREDRV.ClientSubmit; sender thread limit exceeded**     

Additional throttling limits for the SMTP Authentication protocol are: 
- 30 messages per minute    
- Recipient rate limit of 10,000 recipients per day
 
Exceeding these limits causes the following error:  

**554 5.2.0 STOREDRV.Submission.Exception:SubmissionQuotaExceededException**     

This change for concurrent connections will better protect the service from large bursts of email messages that are sent by automated systems within a short time period. This change will not affect most SMTP Authenticated** **Submission users who only send from one email client or multifunction device for a given mailbox. 

In case any application or device is throttled, the application or device should be designed to retry submitting messages to make sure that the messages get sent. This change will just result in a small delay to any messages that are throttled. 
If you cannot accept this change, you have several options: 
 
- Use a different mailbox for each application or device.    
- If an application sends messages such as newsletters, batching can be used. Or, you can send messages to a distribution list instead of to individual recipients because this is much more efficient and avoids throttling.    
- If timing is very important (for example, for an alert system that generates multiple alerts at the same time), use of a third-party email delivery service may be necessary in extreme cases.    

## New behavior when submitting messages

These changes to the protocol will cause messages to take a new route through our service. Therefore, minor changes to submission behavior could occur because some printers and devices send messages that don’t fully comply with the industry standard for email, RFC 5322.

For example, submission behavior could change if the Reply or Mail From address isn't surrounded by angle brackets ("<" and ">") or if the sender display name contains an invalid character, such as the at sign (@), that isn't surrounded by quotation marks. Printers or devices that don't fully adhere to the RFC standard can generate sending errors. 

This can often be fixed by updating the settings on the device or printer by adding angle brackets ("<" and ">") around the Reply or Mail From address. 

Additionally, messages might arrive at the recipient with a different display name than they did before the change. Messages that are sent by using SMTP Authenticated Submission protocol will now behave in the same way as other submission protocols in Office 365, such as the protocol that is used when emails are sent by using Outlook on the web. As a result, the sender’s Office 365 display name will now be shown as part of the **From** address. 

To change the sender’s display name that message recipients will see, you can change the Display Name setting on the sender’s mailbox to the desired display name. 

## Reference

For more information about the change, see the following Microsoft Exchange Team Blog article: 
 
[Changes coming to the SMTP Authenticated Submission client protocol](https://blogs.technet.microsoft.com/exchange/2018/04/20/changes-coming-to-the-smtp-authenticated-submission-client-protocol/)