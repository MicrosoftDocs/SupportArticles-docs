---
title: Error 2147209462 logged in mailbox record
description: Solves an UnknownIncomingEmailIntegrationError that occurs when the corresponding Queue record in Dynamics 365 is owned by a team that doesn't have any security roles assigned.
ms.reviewer: 
ms.date: 11/27/2024
ms.custom: sap:Email and Exchange Synchronization
---
# Error code -2147209462 occurs in Microsoft Dynamics 365 mailbox record

This article helps you resolve an error that occurs when the corresponding Queue record in Microsoft Dynamics 365 is owned by a team that doesn't have any security roles assigned.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4500778

## Symptoms

The following alert is logged in the user's Dynamics 365 mailbox record:

> An unknown error occurred while receiving email through the mailbox "Your mailbox is now connected to Dynamics 365". The owner of the associated email server profile [Mailbox Name] has been notified. The system will try to receive email again later.  
> **Email Server Error Code:** Exchange server returned UnknownIncomingEmailIntegrationError -2147209462 exception.

## Cause

This error is logged if the corresponding Queue record in Dynamics 365 is owned by a team that doesn't have any security roles assigned.

## Resolution

> [!NOTE]
> You need to sign in to your Microsoft Dynamics 365 organization as a user with the "System Administrator" role to manage security roles and mailbox settings.

To fix this issue, follow these steps:

1. In Dynamics 365, go to **Settings** > **Email Configuration** > **Mailboxes**.
1. Select the mailbox record and select the value in the **Regarding** lookup to open the corresponding Queue record.
1. Select the **Owner** field to verify the owner of this Queue record has a security role assigned.
1. Select the **Manage Roles** button and assign a security role with sufficient access.
