---
title: Object reference not set to an instance
description: Provides a solution to an error that occurs when you configure the Microsoft Dynamics CRM for Outlook client.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Object reference not set to an instance of an object error message displays when you configure the Microsoft Dynamics CRM for Outlook client

This article provides a solution to an error that occurs when you configure the Microsoft Dynamics CRM for Outlook client.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011, Dynamics CRM 2013, Microsoft Dynamics CRM 2013 Service Pack 1, Microsoft CRM client for Microsoft Office Outlook  
_Original KB number:_ &nbsp; 2986728

## Symptoms

When you configure the Microsoft Dynamics CRM 2011 or CRM 2013 for Outlook client to a Microsoft Dynamics CRM Online instance, you receive the following error message:

> Object reference not set to an instance of an object

After entering your credentials, choosing your organization, and selecting **OK**.

There's a problem communicating with the Microsoft Dynamics CRM server. The server might be unavailable. Try again later. If the problem still exists, contact your system administrator.

> Object reference not set to an instance of an object.

> at Microsoft.Crm.Passport.IdCrl.OnlineServicesFederationLogOnManager.GetBrowserClientAuthInfo(String redirectEndpoint, String partner, String policy, String& postData)

> at Microsoft.Crm.Outlook.ClientAuth.PassportAuthProvider`1.SignIn()

> at Microsoft.Crm.Outlook.ClientAuth.ClientAuthProvidersFactory`1.SignIn(Uri endPoint, Credential credentials, AuthUIMode uiMode, IClientOrganizationContext context, Form parentWindow, Boolean retryOnError)

> at Microsoft.Crm.Outlook.ClientAuth.ClientAuthProvidersFactory`1.GetAuthProvider(Uri endPoint, Credential credentials, AuthUIMode uiMode, Uri webEndPoint, IClientOrganizationContext context, Form parentWindow)

> at Microsoft.Crm.Application.Outlook.Config.ServerInfo.LoadUserId()

> at Microsoft.Crm.Application.Outlook.Config.ServerInfo.Initialize(Uri discoveryUri, OrganizationDetail selectedOrg, String displayName, Boolean isPrimary)

> at Microsoft.Crm.Application.Outlook.Config.ServerForm.LoadDataToServerInfo()

> at Microsoft.Crm.Application.Outlook.Config.ServerForm.\<InitializeBackgroundWorkers>b__2(Object sender, DoWorkEventArgs e)

> at System.ComponentModel.BackgroundWorker.OnDoWork(DoWorkEventArgs e)

> at System.ComponentModel.BackgroundWorker.WorkerThreadStart(Object argument)

## Cause

This issue occurs if you're using a version of the Microsoft Online Services Sign-in Assistant that is incompatible with Microsoft Dynamics CRM 2011 or Microsoft Dynamics CRM 2013. When configuring the Microsoft Dynamics CRM for Outlook client and connecting to a Microsoft Dynamics CRM Online instance, the only supported versions of the Microsoft Online Services Sign-in Assistant are 7.250.4259.0, 7.250.4287.0, and 7.250.4303.0.

## Resolution

To resolve this issue, follow the steps:

1. Select **Start**, type **appwiz.cpl**, and then press **Enter** to open the **Programs and Features** item in **Control Panel**.
2. Uninstall the Microsoft Online Services Sign-in Assistant if its version doesn't match 7.250.4259.0, 7.250.4287.0, or 7.250.4303.0.
3. [Download](https://download.microsoft.com/download/7/1/E/71EF1D05-A42C-4A1F-8162-96494B5E615C/msoidcli_32bit.msi) and reinstall version 7.250.4303.0 of the Microsoft Online Services Sign-in Assistant.
4. Restart your workstation and configure the Microsoft Dynamics CRM for Outlook client to verify the issue is resolved.
