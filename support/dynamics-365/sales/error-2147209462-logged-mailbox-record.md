---
title: Error 2147209462 logged in mailbox record
description: This article provides a resolution for the problem that occurs when the corresponding Queue record in Dynamics 365 is owned by a team that does not have any security roles assigned.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Error code -2147209462 logged in Microsoft Dynamics 365 mailbox record

This article helps you resolve the problem that occurs when the corresponding Queue record in Microsoft Dynamics 365 is owned by a team that does not have any security roles assigned.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4500778

## Symptoms

The following alert is logged within the mailbox record for a Dynamics 365 mailbox:

> An unknown error occurred while receiving email through the mailbox "Your mailbox is now connected to Dynamics 365". The owner of the associated email server profile [Mailbox Name] has been notified. The system will try to receive email again later.  
**Email Server Error Code:** Exchange server returned UnknownIncomingEmailIntegrationError -2147209462 exception.

## Cause

This error is logged if the corresponding Queue record in Dynamics 365 is owned by a team that does not have any security roles assigned.

## Resolution

To fix this issue, follow these steps:

1. Within the mailbox record in Dynamics 365, click the value in the **Regarding** lookup to open the corresponding Queue record.
2. Verify the **Owner** of this Queue record has a security role assigned.
3. You can do this by clicking on the value in the **Owner** field to open the owner record.
4. Click the **Manage Roles** button and assign a security role with sufficient access.
