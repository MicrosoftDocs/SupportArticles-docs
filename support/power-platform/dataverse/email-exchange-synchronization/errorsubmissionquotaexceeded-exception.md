---
title: ErrorSubmissionQuotaExceeded exception
description: Provides a solution for an unknown outgoing email integration error that occurs in a Microsoft Dynamics 365 mailbox.
ms.reviewer: 
ms.date: 12/30/2024
ms.custom: sap:Email and Exchange Synchronization
---
# ErrorSubmissionQuotaExceeded exception occurs in Microsoft Dynamics 365 mailbox

This article provides a solution for an "unknown error occurred while sending the email message" error that occurs in a Microsoft Dynamics 365 mailbox.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4486353

## Symptoms

An email isn't sent from Dynamics 365 and you might see the following error message is logged in [the Alerts area for a user's mailbox](/power-platform/admin/monitor-email-processing-errors#view-alerts):

> An unknown error occurred while sending the email message [Email Subject] through the mailbox [Mailbox Name]. The owner of the associated email server profile Microsoft Exchange Online has been notified. The system will try to send the message again later.  
> **Email Server Error Code:** Exchange server returned UnknownOutgoingEmailIntegrationError ErrorSubmissionQuotaExceeded exception.

## Cause

The alert is logged because the message size exceeds [Exchange Online quota limits](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits#mailbox-folder-limits). For example, 10,000 emails within 24 hours.

## Resolution

To solve this issue, avoid exceeding the Exchange Online quota limits or use another email service that specializes in sending bulk email (for example, Dynamics 365 Customer Insights - Journeys.)

> [!NOTE]
> Exchange Online customers who need to send legitimate bulk commercial email (for example, customer newsletters) should use third-party providers that specialize in these services.
