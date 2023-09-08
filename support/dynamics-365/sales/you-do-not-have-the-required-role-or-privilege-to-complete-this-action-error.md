---
title: You don't have the required role or privilege to complete this action error
description: You can't use Microsoft Dynamics 365 App for Outlook due to the error - You don't have the required role or privilege to complete this action. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# You don't have the required role or privilege to complete this action error in Microsoft Dynamics 365 App for Outlook

This article provides a resolution for the issue that you can't use the Microsoft Dynamics 365 App for Outlook due to the **You don't have the required role or privilege to complete this action** error.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4557523

## Symptoms

When attempting to use the Microsoft Dynamics 365 App for Outlook, you see the following message:

> You don't have the required role or privilege to complete this action. Please contact your administrator to get necessary access.

## Cause

No roles are assigned to your user record in Microsoft Dynamics 365.

## Resolution

Verify your user is enabled and assigned a security role:

1. Access Microsoft Dynamics 365 as a user with the System Administrator role.
2. Navigate to **Settings** and then select **Security**.
3. Select **Users**.
4. Select your user and select **Manage Roles**.
5. Select the **Dynamics 365 App for Outlook User** security role and then select **OK**.
6. Try to open Microsoft Dynamics 365 App for Outlook again.
