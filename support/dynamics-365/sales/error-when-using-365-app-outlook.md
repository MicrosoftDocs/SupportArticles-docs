---
title: Error when using 365 App for Outlook
description: Fixes an issue that occurs when you try to use the Dynamics 365 App for Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Your profile is either disabled or you are not configured to any business unit error occurs in Microsoft Dynamics 365 App for Outlook

This article provides a solution to an error that occurs when you try to use the Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 4555670

## Symptoms

When attempting to use the Dynamics 365 App for Outlook, you see the following message:

> "Your profile is either disabled or you are not configured to any business unit. Please contact your administrator to complete your profile setup."

## Cause

Your Microsoft Dynamics 365 user is disabled.

## Resolution

Verify your user is enabled.

1. Access Dynamics 365 as a user with the System Administrator role.
2. Navigate to **Settings** -> **Security**.
3. Select **Users**, and then change the view to Disabled users.
4. If you see your user as disabled, then enable it.
5. Try to open the Dynamics 365 App for Outlook again.
