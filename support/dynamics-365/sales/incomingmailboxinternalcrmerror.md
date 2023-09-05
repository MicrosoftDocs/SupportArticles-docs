---
title: IncomingMailboxInternalCrmError
description: Provides a solution to an error that occurs in a Dynamics 365 mailbox record.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# "IncomingMailboxInternalCrmError" information level message appears in Microsoft Dynamics 365

This article provides a solution to an error that occurs within a Dynamics 365 mailbox record.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4471948

## Symptoms

The following information level alert appears within a Dynamics 365 mailbox record:

> "An internal Microsoft Dynamics 365 error occurred while receiving email through the mailbox [Mailbox Name]. The owner of the associated email server profile [Profile Name] has been notified. The system will try to receive email again later.  
Email Server Error Code: IncomingMailboxInternalCrmError"

## Cause

This message may appear if Server-Side Synchronization attempted to retrieve emails but met an internal error. It's typically a temporary issue and the emails will be retrieved successfully on the next synchronization cycle (typically 15 minutes).

## Resolution

If this message doesn't persist on the next synchronization cycle (typically 15 minutes), this warning can be ignored. If this message persists and email isn't being retrieved by Server-Side Synchronization, you can contact Microsoft Support.
