---
title: GeneralOutgoingEmailServerError
description: provides a solution to an error that occurs when using Gmail to send email from Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# "Smtp server returned GeneralOutgoingEmailServerError GeneralFailure exception" warning is logged when using Gmail to send email from Microsoft Dynamics 365

This article provides a solution to an error that occurs when using Gmail to send email from Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4341507

## Symptoms

When using Gmail to send email from Dynamics 365, emails aren't sent and appear in a Pending Send status. If you open the mailbox record in Dynamics 365 and select Alerts, you see the following warning:

> "An unexpected error occurred while sending the email message [Email Subject] through the mailbox [Mailbox Name]. The owner of the associated email server profile [Email Server Profile name] has been notified. The system will try to send the message again later.  
>
> **Email Server Error Code:** Smtp server returned GeneralOutgoingEmailServerError GeneralFailure exception."

## Cause

This message may be logged if you exceed the number of emails that Gmail allows you to send from a single mailbox.

## Resolution

For more information about sending limits from Gmail, see [Gmail sending limits in Google Workspace](https://support.google.com/a/answer/166852).

If you need to send bulk emails, a solution such as Dynamics 365 for Marketing or another solution designed for sending large numbers of emails should be used.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
