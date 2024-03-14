---
title: AADSTS65005 error when you try to sign in to Microsoft Cloud services
description: Describes an error that occurs when you try to sign in to or authenticate to one of the Microsoft Cloud Services by using a company app such as Microsoft 365, Intune, Dynamics, Power BI, or Azure.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
localization_priority: Normal
search.appverid: 
  - MET150
appliesto: 
  - Azure Active Directory
  - Microsoft Intune
ms.date: 03/31/2022
---

# "AADSTS65005" error when you try to sign in to Microsoft Cloud services

## Symptoms

When you use a company app to sign in to or authenticate to one of the Microsoft Cloud Services, such as Microsoft 365, Microsoft Intune, Microsoft Dynamics, Microsoft Power BI, or Microsoft Azure, or Microsoft Entra ID Federated Gallery Apps, you receive the following error message:

> AADSTS65005: The client application has requested access to resource. This request has failed because the client has not specified this resource in its requiredResourceAccess list.  

## Cause

This issue occurs because the company's app may not be registered with Microsoft Entra ID, or it may not have the correct permissions applied. 

## Resolution

To fix this issue, use one of the following resources, depending on the services that you are trying to access:

- [Microsoft 365: Manually register your app with Microsoft Entra ID so that it can access Microsoft 365 APIs](/graph/auth-register-app-v2)       
- [Dynamics CRM: Register application for Dynamics CRM](/powerapps/developer/data-platform/walkthrough-register-app-azure-active-directory)    
-  [Problems signing in to a gallery application configured for federated single sign-on](/azure/active-directory/application-sign-in-problem-federated-sso-gallery?/?WT.mc_id=DMC_AAD_Manage_Apps_Troubleshooting_Nav#no-resource-in-requiredresourceaccess-list)     

## More Information

For more information about how to register your app with Microsoft Entra ID, see the following Microsoft website:

[Integrating applications with Microsoft Entra ID](/azure/active-directory/develop/quickstart-register-app)
