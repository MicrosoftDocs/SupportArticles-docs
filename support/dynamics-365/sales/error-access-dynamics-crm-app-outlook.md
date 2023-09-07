---
title: Error when you access the Microsoft Dynamics CRM App for Outlook
description: This article provides a resolution for the problem that occurs when you click the Dynamics CRM app for Outlook (anywhere the app is supported).
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# "This app is not available for your version of Microsoft Dynamics CRM" error when accessing the Microsoft Dynamics CRM App for Outlook

This article helps you resolve the problem that occurs when you click the Dynamics CRM app for Outlook (anywhere the app is supported).

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 3064263

## Symptoms

When you click the Dynamics CRM app for Outlook (anywhere the app is supported), you see the following message:

> This app is not available for your version of Microsoft Dynamics CRM.

## Cause

The Microsoft Dynamics CRM organization that you are attempting to connect to does not support the Dynamics CRM App for Outlook.

## Resolution

Your Microsoft Dynamics CRM Online organization has yet to be upgraded to the latest version. Try again at a later time. Or, your Exchange mailbox is currently configured for server-side synchronization with an outdated or unsupported version of CRM. Update your Exchange mailbox's server-side synchronization configuration to connect to an updated Microsoft Dynamics CRM Online organization.

## More information

For the list of requirements to use the CRM app for Outlook, see [Deploy Dynamics 365 App for Outlook](/previous-versions/dynamicscrm-2016/administering-dynamics-365/dn946901(v=crm.8)).
