---
title: UnknownIncomingEmailIntegrationError 2147220970 exception
description: UnknownIncomingEmailIntegrationError -2147220970 exception occurs in Microsoft Dynamics 365. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# UnknownIncomingEmailIntegrationError -2147220970 exception appears in Microsoft Dynamics 365

This article provides a resolution for the **UnknownIncomingEmailIntegrationError -2147220970** exception that occurs in a Microsoft Dynamics 365 mailbox record.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4471947

## Symptoms

The following warning level alert appears within a Microsoft Dynamics 365 mailbox record:

> An unknown error occurred while receiving email through the mailbox [Mailbox Name]. The owner of the associated email server profile [Profile Name] has been notified. The system will try to receive email again later.  
Email Server Error Code: Exchange server returned UnknownIncomingEmailIntegrationError -2147220970 exception.

## Cause

This warning may appear if Server-Side Synchronization attempted to retrieve emails but encountered an unexpected error. This is typically a temporary issue and the emails will be retrieved successfully on the next synchronization cycle (typically 15 minutes).

## Resolution

If this message does not persist on the next synchronization cycle (typically 15 minutes), this warning can be ignored. If this message persists, you can contact Microsoft Support.
