---
title: Warning appears when viewing Alerts for a mailbox
description: ErrorIrresolvableConflict occurs when viewing alerts for a mailbox in Microsoft Dynamics 365. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Warning appears when viewing alerts for a mailbox in Microsoft Dynamics 365

This article provides a resolution for the issue that an **ErrorIrresolvableConflict** warning occurs when you view alerts for a mailbox in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365, Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4470093

## Symptoms

When viewing alerts for a mailbox in Microsoft Dynamics 365, you see the following warning:

> Appointments, contacts, and tasks for the mailbox [Mailbox Name] couldn't be synchronized. The owner of the associated email server profile [Profile Name] has been notified. The system will try again later.

The following additional details are also included:

> Error : Exchange Error Code: ErrorIrresolvableConflict
>
> Exchange Error Message : The operation can't be performed because the item is out of date. Reload the item and try again. Exchange Error Details: System.Collections.Generic.Dictionary`2[System.String,System.String]"

## Cause

This warning may appear if Server-Side Sync attempted to update an item in Microsoft Exchange and an **ErrorIrresolvableConflict** message was returned by the Exchange server. This is typically a temporary issue and the item will be updated successfully during the next synchronization cycle.

For more information on Microsoft Exchange error codes such as **ErrorIrresolvableConflict**, see [ResponseCode](/exchange/client-developer/web-service-reference/responsecode).

## Resolution

If this message does not persist on the next synchronization cycle (typically 15 minutes), this warning can be ignored. If this message persists, you can contact Microsoft Support.
