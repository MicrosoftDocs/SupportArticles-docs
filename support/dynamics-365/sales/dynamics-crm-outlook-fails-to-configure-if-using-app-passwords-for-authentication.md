---
title: Cannot set up CRM Outlook using App Passwords for authentication
description: It seems that Microsoft Dynamics CRM Outlook Client fails to configure if you are using App Passwords for authentication.
ms.reviewer: 
ms.topic: article
ms.date: 
---
# Microsoft Dynamics CRM Outlook Client fails to configure if you are using App Passwords for authentication

This article introduces an issue that **There is a problem communicating with the Microsoft Dynamics CRM server** this error may occur when you try to set up Microsoft Dynamics CRM for Office Outlook by using App Passwords for authentication.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2013  
_Original KB number:_ &nbsp; 2933267

## Symptoms

When you attempt to configure Microsoft Dynamics CRM for Office Outlook by using App Passwords for authentication, you receive the following error message:

> There is a problem communicating with the Microsoft Dynamics CRM server. The server might be unavailable. Try again later. If the problem persists, contact your system administrator.

## Cause

Multi-factor authentication is only supported with Microsoft Dynamics CRM for Office Outlook 2015 and later. For more information, see [Enable multi-factor authentication through OAuth](/previous-versions/dynamicscrm-2016/administering-dynamics-365/hh699760(v=crm.8)).

## More information

If you view the error details, the following stack trace appears:

> The remote server returned an error: (400) Bad Request.  
at System.Net.HttpWebRequest.GetResponse()  
at Microsoft.Crm.Outlook.ClientAuth.ClaimsBasedAuthProvider\`1.MakeHttpPostRequest(Uri postUri, String postData)  
at Microsoft.Crm.Outlook.ClientAuth.PassportAuthProvider\`1.SignIn()  
at Microsoft.Crm.Outlook.ClientAuth.ClientAuthProvidersFactory\`1.SignIn(Uri endPoint, Credential credentials, AuthUIMode uiMode, IClientOrganizationContext context, Form parentWindow, Boolean retryOnError)  
at Microsoft.Crm.Outlook.ClientAuth.ClientAuthProvidersFactory`1.GetAuthProvider(Uri endPoint, Credential credentials, AuthUIMode uiMode, Uri webEndPoint, IClientOrganizationContext context, Form parentWindow)  
at Microsoft.Crm.Application.Outlook.Config.ServerInfo.LoadUserId()  
at Microsoft.Crm.Application.Outlook.Config.ServerInfo.Initialize(Uri discoveryUri, OrganizationDetail selectedOrg, String displayName, Boolean isPrimary)  
at Microsoft.Crm.Application.Outlook.Config.ServerForm.LoadDataToServerInfo()  
at Microsoft.Crm.Application.Outlook.Config.ServerForm.\<InitializeBackgroundWorkers>b__2(Object sender, DoWorkEventArgs e)  
at System.ComponentModel.BackgroundWorker.OnDoWork(DoWorkEventArgs e)  
at System.ComponentModel.BackgroundWorker.WorkerThreadStart(Object argument)

For more information on the App Passwords feature available with Multi-Factor authentication, see the following articles:

- [Set up multi-factor authentication](/microsoft-365/admin/security-and-compliance/set-up-multi-factor-authentication)
- [Change your two-factor verification method and settings](/azure/active-directory/user-help/multi-factor-authentication-end-user-manage-settings)
