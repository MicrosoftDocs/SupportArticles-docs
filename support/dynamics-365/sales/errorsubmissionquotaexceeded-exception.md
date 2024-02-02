---
title: ErrorSubmissionQuotaExceeded exception
description: Provides a solution to an unknown error that occurs in Microsoft Dynamics 365 mailbox.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# ErrorSubmissionQuotaExceeded exception appears in Microsoft Dynamics 365 mailbox

This article provides a solution to an error that occurs in Microsoft Dynamics 365 mailbox.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4486353

## Symptoms

Email isn't sent from Dynamics 365 and the following alert is found within the mailbox record:

> "An unknown error occurred while sending the email message [Email Subject] through the mailbox [Mailbox Name]. The owner of the associated email server profile Microsoft Exchange Online has been notified. The system will try to send the message again later.  
**Email Server Error Code:** Exchange server returned UnknownOutgoingEmailIntegrationError ErrorSubmissionQuotaExceeded exception."

## Cause

This error is logged if the mailbox has exceeded Exchange Online quota limits.

Example: 10,000 emails within 24 hours. For more information about Exchange Online sending limits, see [Sending limits](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits#sending-limits).

## Resolution

Avoid exceeding the Exchange Online quota limits or use another email service that specializes in sending bulk email (example: Dynamics 365 for Marketing). The following content is an excerpt from the [Exchange Online sending limit documentation](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits#sending-limits):

"Exchange Online customers who need to send legitimate bulk commercial email (for example, customer newsletters) should use third-party providers that specialize in these services."
