---
title: Alert appears in the user's Dynamics 365 mailbox record
description: This article provides a resolution for the problem that occurs when an email sent to a Dynamics 365 mailbox is not created as an email activity record.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# "UnknownIncomingEmailIntegrationError -2147218677 exception" error appears in Dynamics 365 mailbox alert

This article helps you resolve the problem that occurs when an email sent to a Dynamics 365 mailbox is not created as an email activity record.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4556408

## Symptoms

An email sent to a Dynamics 365 mailbox is not created as an email activity record and the following message appears as an alert in the user's Dynamics 365 mailbox record:

> An unknown error occurred while receiving email through the mailbox [Mailbox Name]. The owner of the associated email server profile [Profile Name] has been notified. The system will try to receive email again later.  
**Email Server Error Code:**  Exchange server returned UnknownIncomingEmailIntegrationError -2147218677 exception.

## Cause

This error occurs if there was an invalid email address included on the To or Cc line of the email.

## Resolution

Review the email message that encountered this error and verify all email addresses on the To and Cc lines are [valid email addresses](https://tools.ietf.org/html/rfc5322#section-3.4.1).
