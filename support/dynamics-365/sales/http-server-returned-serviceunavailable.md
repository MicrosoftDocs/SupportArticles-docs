---
title: Http server returned ServiceUnavailable
description: Provides a solution to the ServiceUnavailable exception that occurs within a Microsoft Dynamics 365 mailbox record.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Http server returned ServiceUnavailable exception warning level message appears in Microsoft Dynamics 365

This article provides a solution to an error that occurs within a Microsoft Dynamics 365 mailbox record.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4471949

## Symptoms

The following warning level alert appears within a Dynamics 365 mailbox record:

> "An error occurred in receiving email for the mailbox [Mailbox Name] while connecting to the email server. The owner of the associated email server profile [Profile Name] has been notified. The system will try to receive email again later.  
Email Server Error Code: Http server returned ServiceUnavailable exception"

## Cause

This message may appear if Server-Side Synchronization attempted to retrieve emails but received a 503 (Service Unavailable) error. It's typically a temporary issue and the emails will be retrieved successfully on the next synchronization cycle (typically 15 minutes).

## Resolution

If this message doesn't persist on the next synchronization cycle (typically 15 minutes), this warning can be ignored. If this message persists and email isn't being retrieved by Server-Side Synchronization, you can contact Microsoft Support. There may be an issue with your email server so you can first verify you can send and receive email successfully with your email service.
