---
title: AADSTS65005 error when you try to sign in to Microsoft Cloud services
description: Describes an error that occurs when you try to sign in to or authenticate to one of the Microsoft Cloud Services by using a company app such as Office 365, Intune, Dynamics, Power BI, or Azure.
author: lucciz
ms.author: v-zolu
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: office 365
ms.custom: CSSTroubleshoot
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Azure Active Directory
- Microsoft Intune
---

# "AADSTS65005" error when you try to sign in to Microsoft Cloud services

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

When you use a company app to sign in to or authenticate to one of the Microsoft Cloud Services, such as Microsoft Office 365, Microsoft Intune, Microsoft Dynamics, Microsoft Power BI, or Microsoft Azure, or Azure Active Directory (Azure AD) Federated Gallery Apps, you receive the following error message:

> AADSTS65005: The client application has requested access to resource. This request has failed because the client has not specified this resource in its requiredResourceAccess list.  

## Cause

This issue occurs because the company's app may not be registered with Azure AD, or it may not have the correct permissions applied. 

## Resolution

To fix this issue, use one of the following resources, depending on the services that you are trying to access:

- [Office 365: Manually register your app with Azure AD so that it can access Office 365 APIs](/graph/auth-register-app-v2)       
- [Dynamics CRM: Register application for Dynamics CRM](/powerapps/developer/data-platform/walkthrough-register-app-azure-active-directory)    
-  [Problems signing in to a gallery application configured for federated single sign-on](/azure/active-directory/application-sign-in-problem-federated-sso-gallery?/?WT.mc_id=DMC_AAD_Manage_Apps_Troubleshooting_Nav#no-resource-in-requiredresourceaccess-list)     

## More Information

For more information about how to register your app with Azure Active Directory, see the following Microsoft website:

[Integrating applications with Azure Active Directory](/azure/active-directory/develop/quickstart-register-app)