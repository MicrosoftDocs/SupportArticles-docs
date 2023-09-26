---
title: Crm.80040216. An unexpected error occurred while synchronizing item
description: Provides a solution to the error code 80040216 that occurs within a Dynamics 365 mailbox record.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# "Crm.80040216. An unexpected error occurred" error appears in Microsoft Dynamics 365 mailbox

This article provides a solution to an error that occurs within a Dynamics 365 mailbox record.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4477141

## Symptoms

The following alert appears within a Dynamics 365 mailbox record:

> "An error occurred while synchronizing the item [Item Name] from Microsoft Dynamics 365 for the mailbox [Mailbox Name].
>
> Email Server Error Code: Crm.80040216. An unexpected error occurred. "

## Cause

This message may appear if Server-Side Synchronization attempted to synchronize an item with Microsoft Exchange but met an error. It's typically a temporary issue and the item will be retrieved successfully on the next synchronization cycle (typically 15 minutes).

## Resolution

If this message doesn't persist on the next synchronization cycle (typically 15 minutes), this message can be ignored. If this message persists and the mentioned item isn't being synchronized by Server-Side Synchronization, you can contact Microsoft Support.
