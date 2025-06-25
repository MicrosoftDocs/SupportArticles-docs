---
title: Message storage and concurrent connection throttling for SMTP Authenticated Submission
description: Describes the throttling limits for concurrent connections.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.custom: 
  - sap:Mail Flow
  - Exchange Online
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
ms.date: 06/21/2025
ms.reviewer: richfaj; arindamt
---
# Message storage and concurrent connection throttling for SMTP Authenticated Submission

The SMTP Authenticated Submission client protocol is used by applications, services, and devices to automatically send email messages.

Email messages that are sent are stored in the Sent Items folder of the mailbox that is used. This behavior lets the user determine which email messages are sent by a multifunction device, and makes it easier to troubleshoot issues.

> [!NOTE]
> The Sent Items folder contributes to the mailbox size. If the mailbox becomes full, it is blocked from sending email messages. For a mailbox that sends a high volume of email messages, set the retention policy for the Sent Items folder to empty the folder before the mailbox becomes full.

Depending on the application or device that sends email messages, you might see one of the following errors if the mailbox becomes full:

> 554 5.2.2 mailbox full; STOREDRV.Submission.Exception:QuotaExceededException.MapiExceptionShutoffQuotaExceeded
> 554 5.2.2 mailbox full; STOREDRV.Submission.Exception:QuotaExceededException.MapiExceptionQuotaExceeded

## Throttling limit for concurrent connections that submit messages

The Exchange Online service has various limits to prevent abuse and to ensure fair use. Up to three concurrent connections are allowed to send email messages at the same time. If an application tries to send more than three messages at the same time by using multiple connections, each connection will receive the following error message:

> 432 4.3.2 Concurrent connections limit exceeded.

Additional throttling limits for the SMTP Authentication protocol are:

- 30 messages per minute
- Recipient rate limit of 10,000 recipients per day

If the mailbox exceeds the per minute limit, then email delivery delays occur. Any excess in message submissions is throttled and successively carried over to the following minutes.

Exceeding the per day limit generates the following error message:

  > 554 5.2.0 STOREDRV.Submission.Exception:SubmissionQuotaExceededException

For more information, see [sending limits in Exchange Online](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits).

These limits for concurrent connections protect the service from large bursts of email messages that are sent by automated systems within a short time period. They don't affect most SMTP Authenticated Submission users who only send email messages from one email client or multifunction device for a given mailbox.

If an application or device is throttled, the application or device should be designed to retry submitting messages to make sure that the messages get sent. This change will only result in a small delay to the messages that are throttled.

If these limits don't work for your environment, use one of the following options:

- Use a different mailbox for each application or device.
- If an application sends messages such as newsletters, use batching to send them. Or, send messages to a distribution list instead of individual recipients to increase efficiency and avoid throttling.
- If timing is very important (for example, for an alert system that generates multiple alerts at the same time), use a third-party email delivery service if necessary.
