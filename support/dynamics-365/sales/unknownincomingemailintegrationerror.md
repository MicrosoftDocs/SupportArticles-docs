---
title: UnknownIncomingEmailIntegrationError
description: Provides a solution to the UnknownIncomingEmailIntegrationError error that occurs within a Dynamics 365 mailbox record.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# "UnknownIncomingEmailIntegrationError" error appears in Microsoft Dynamics 365 mailbox

This article provides a solution to an error that occurs within a Dynamics 365 mailbox record.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4471980

## Symptoms

The following alert appears within a Dynamics 365 mailbox record:

> "An unknown error occurred while receiving email. Mailbox Michael Dwyer didn't synchronize. The owner of the associated email server profile Microsoft Exchange Online has been notified.
>
> Email Server Error Code: UnknownIncomingEmailIntegrationError"

## Cause

This message may appear if Server-Side Synchronization attempted to retrieve emails but met an error. It's typically a temporary issue and the emails will be retrieved successfully on the next synchronization cycle (typically 15 minutes).

## Resolution

If this message doesn't persist on the next synchronization cycle (typically 15 minutes), this message can be ignored. If this message persists and email isn't being retrieved by Server-Side Synchronization, you can contact Microsoft Support. There may be an issue with your email server so you can first verify you can send and receive email successfully with your email service.
