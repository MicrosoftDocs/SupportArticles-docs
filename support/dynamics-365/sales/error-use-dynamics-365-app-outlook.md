---
title: business unit is disabled when you use Dynamics 365 App for Outlook
description: This article provides a resolution for the problem that occurs when you attempt to use the Dynamics 365 App for Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# "The business unit is disabled. Please contact your administrator to enable it" error occurs in Dynamics 365 App for Outlook

This article helps you resolve the problem that occurs when you attempt to use the Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 4555672

## Symptoms

When attempting to use the Dynamics 365 App for Outlook, you see the following message:

> The business unit is disabled. Please contact your administrator to enable it.

## Cause

The business unit to which your user belongs in Microsoft Dynamics CRM is disabled.

## Resolution

Verify your user's business unit is enabled.

1. Access Dynamics 365 as a user with the System Administrator role.
1. Navigate to **Settings** -> **Security**.
1. Click **Users**, select the impacted user.
1. View the Organization Information section to identify the selected business unit of the user.
1. Navigate to **Settings** -> **Security** again.
1. Click **Business Units** and then change the view to **Inactive Business Units**.
1. If you see the user's business unit as inactive, either enable it or update the user to be in a different business unit that is active.
1. Try to open the Dynamics 365 App for Outlook again.
