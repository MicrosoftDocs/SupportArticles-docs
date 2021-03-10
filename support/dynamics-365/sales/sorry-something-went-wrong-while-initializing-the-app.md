---
title: Something went wrong while initializing the app error when accessing Dynamics 365 App for Outlook
description: Sorry, something went wrong while initializing the app error occurs when accessing the Microsoft Dynamics 365 App for Outlook.
ms.reviewer:  
ms.topic: troubleshooting
ms.date: 
---
# "Something went wrong while initializing the app" error when accessing the Microsoft Dynamics 365 App for Outlook

This article provides a resolution for the **Sorry, something went wrong while initializing the app** error that may occur when you try to access the Microsoft Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 4078135

## Symptoms

When you select the Microsoft Dynamics 365 app in Outlook (anywhere the app is supported) and your Microsoft Dynamics 365 (online) instance is version 9.x, you see the following error message:

> Sorry, something went wrong while initializing the app. Please try again, or restart the app

When you select **View More**, you see the following more details:

> Error: AppforOutlookModule was not found, empty appId returned Trace: Error: AppforOutlookModule was not found, empty appId returned at ...

## Cause

This can occur if you have a custom Microsoft Dynamics 365 security role assigned and the role does not have access to the Microsoft Dynamics 365 App for Outlook app module.

## Resolution

If you are using a custom security role, refer to the following documentation for how to grant the role access to the Microsoft Dynamics 365 App for Outlook app module:  

[Provide security role access](/dynamics365/customer-engagement/outlook-app/deploy-dynamics-365-app-for-outlook#provide-security-role-access)

After verifying all required privileges, close and reopen Outlook.
