---
title: ErrorInternalServerTransientError error
description: Provides a solution to the ErrorInternalServerTransientError error that occurs in Dynamics 365 mailbox.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# ErrorInternalServerTransientError error appears in Microsoft Dynamics 365 mailbox

This article provides a solution to an error that occurs in Microsoft Dynamics 365 mailbox.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4471977

## Symptoms

The following alert appears within a Dynamics 365 mailbox record:

> "An unexpected error occurred while receiving email. Mailbox [Mailbox Name] didn't synchronize. The owner of the associated email server profile [Profile Name] has been notified.  
Email Server Error Code: ErrorInternalServerTransientError"

## Cause

This message may appear if Server-Side Synchronization attempted to retrieve emails but received an error. It's typically a temporary issue and the emails will be retrieved successfully on the next synchronization cycle (typically 15 minutes).

## Resolution

If this message doesn't persist on the next synchronization cycle (typically 15 minutes), this message can be ignored. If this message persists and email isn't being retrieved by Server-Side Synchronization, you can contact Microsoft Support. There may be an issue with your email server, so you can first verify you can send and receive email successfully with your email service.
