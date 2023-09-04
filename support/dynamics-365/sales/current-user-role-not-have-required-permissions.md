---
title: User role doesn't have required permissions
description: Fixes an issue in which you can't open Microsoft Dynamics 365 App for Outlook if your Dynamics 365 security role doesn't have access to the app module.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-client-outlook
---
# "We are unable to show Dynamics 365 App for Outlook because current user role does not have required permissions" error occurs in Microsoft Dynamics 365 App for Outlook

This article helps you fix an issue in which you can't open Microsoft Dynamics 365 App for Outlook if your Dynamics 365 security role doesn't have access to the app module.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 4229661

## Symptoms

When you open the Microsoft Dynamics 365 App for Outlook, you see the following error:

> We're sorry  
> We are unable to show Dynamics 365 App for Outlook because current user role does not have required permissions. Please contact your administrator to have required security role assigned to the Dynamics 365 App for Outlook solution.

If you click **Show more**, the additional details include the following info:

> Error: Don't have permissions to retrieve AppforOutlookModule id  
> Trace: Error: Don't have permissions to retrieve AppforOutlookModule id at new ...

## Cause

This error appears if your Dynamics 365 security role doesn't have access to the app module used by the Dynamics 365 App for Outlook.

## Resolution

Verify your Dynamics 365 security role has sufficient access to load the app module used by the Dynamics 365 App for Outlook.

1. Verify your security role has access to the Dynamics 365 App for Outlook app module:

    [Provide security role access](/dynamics365/outlook-app/deploy-dynamics-365-app-for-outlook#provide-security-role-access)

    > [!IMPORTANT]
    > Custom security roles do not have access to the Dynamics 365 app module by default. The steps in the article referenced above are required.

2. Refer to the following documentation for the required privileges to use the App for Outlook:

    [A privilege error occurs when attempting to use Dynamics 365 App for Outlook](https://support.microsoft.com/help/4563997)

3. After verifying all required privileges, close and reopen Outlook.
