---
title: Error when you search Outlook in Microsoft Dynamics 365 App
description: This article provides a resolution for the problem that occurs when you attempt to search in Microsoft Dynamics 365 App for Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# "We can't open this app" error occurs when you attempt to search in the Microsoft Dynamics 365 App for Outlook

This article helps you resolve the problem that occurs when you attempt to search in Microsoft Dynamics 365 App for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 4309329

## Symptoms

When attempting to search in Microsoft Dynamics 365 App for Outlook, you encounter the following error:

> "We can't open this app  
The app URL wasn't found or you need permissions to open it. Please check the URL and try again, or contact your system administrator."

## Cause

This error can occur if your security role does not have access to the Dynamics 365 App for Outlook app module.

## Resolution

To fix this issue, follow these steps:

1. A user with the System Administrator role in Microsoft Dynamics 365 needs to complete the steps in the following article:

   [Provide security role access](/dynamics365/outlook-app/deploy-dynamics-365-app-for-outlook#provide-security-role-access)

2. After the steps are completed, close and reopen Outlook.
