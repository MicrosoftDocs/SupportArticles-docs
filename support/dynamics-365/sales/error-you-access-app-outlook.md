---
title: Error when you access the app for Outlook
description: This article provides a resolution for the problem that occurs when you click the Dynamics CRM app in Outlook (anywhere the app is supported).
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# "The language installed on your company's system isn't available on the app" error when accessing the Microsoft Dynamics CRM App for Outlook

This article helps you resolve the problem that occurs when you click the Dynamics CRM app in Outlook (anywhere the app is supported).

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 3064234

## Symptoms

When you click the Dynamics CRM app in Outlook (anywhere the app is supported), you see the following message:

> "The language installed on your company's system isn't available on the app.
Please contact your system administrator to set up a supported language."

## Cause

Your language in Microsoft Dynamics CRM is not supported by the Microsoft Dynamics CRM App for Outlook and there are not any available language packs enabled for supported languages.

## Resolution

A user with the System Administrator role needs to enable a supported language. Languages can be enabled by navigating to **Settings** > **Administration** > **Languages**. [Deploy Dynamics 365 App for Outlook](/previous-versions/dynamicscrm-2016/administering-dynamics-365/dn946901(v=crm.8)).
