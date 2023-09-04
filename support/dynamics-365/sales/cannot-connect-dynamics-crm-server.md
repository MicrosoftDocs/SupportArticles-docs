---
title: Cannot connect to Dynamics CRM server or value cannot be null
description: Provides a solution to an error that occurs when you try to connect Microsoft Dynamics CRM 2013 for Microsoft Office Outlook to CRM Online.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Cannot connect to Microsoft Dynamics CRM server error occurs when you try to connect Microsoft Dynamics CRM 2013 for Microsoft Office Outlook to CRM Online

This article provides a solution to an error that occurs when you try to connect Microsoft Dynamics CRM 2013 for Microsoft Office Outlook to CRM Online.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 3089686

## Symptoms

When you try to connect Microsoft Dynamics CRM 2013 for Microsoft Office Outlook (Outlook Client) to a CRM Online organization, you receive the following error:

> "Cannot connect to Microsoft Dynamics CRM server because we cannot authenticate your credentials. Check your connection or contact your administrator for more help."

When you select **Details**, you see the following additional details:

> Value cannot be null.  
Parameter name: path1  
 at System.IO.Path.Combine(String path1, String path2)  
 at Microsoft.Crm.Passport.IdCrl.FederationLogOnManager..ctor(String environment)  
 at Microsoft.Crm.Outlook.ClientAuth.PassportAuthProvider\`1.GetLogonManager()  
 at Microsoft.Crm.Outlook.ClientAuth.PassportAuthProvider\`1.SignIn()  
 at Microsoft.Crm.Outlook.ClientAuth.ClientAuthProvidersFactory\`1.SignIn(Uri endPoint, Credential credentials, AuthUIMode uiMode, IClientOrganizationContext context, Form parentWindow, Boolean retryOnError)  
 at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo.DeploymentInfo.LoadOrganizations(AuthUIMode uiMode, Form parentWindow, Credential credentials)  
 at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo.InternalLoadOrganizations(OrganizationDetailCollection orgs, AuthUIMode uiMode, Form parentWindow)

## Cause

The Microsoft Online Services Sign-in Assistant isn't installed or the correct username and password aren't provided. If the issue is caused by incorrect username or password, it could be the credentials that are cached in the Windows Credential Manager.

## Resolution

If the Microsoft Online Services Sign-in Assistant isn't installed, install it using the appropriate link below. After the install, close and reopen the Microsoft Dynamics CRM for Microsoft Office Outlook Configuration Wizard.

If the Microsoft Online Services Sign-in Assistant is already installed, and you still receive this error, select **OK** and you should see a prompt for your username and password. If the username and password are already populated, it indicates the credentials were cached. Reenter the correct username and password to make sure incorrect credentials aren't being used.

> [!NOTE]
> To view if credentials are stored in the Windows Credential Manager, select the **Start** menu in Windows and type Credential Manager. In the Generic Credentials area you may see credentials that start with Microsoft_CRM. If you have changed your password or are using a different user account, these stored credentials may not be correct. These credentials can be removed which will prevent the Microsoft Dynamics CRM for Microsoft Office Outlook from using them when you try to connect.
>
> If your CRM Online organization has already been updated to the 2015 Update (7.0 or later), you can use [Microsoft Dynamics CRM 2015 for Microsoft Office Outlook](https://www.microsoft.com/download/details.aspx?id=45015) that doesn't rely on the Microsoft Online Services Sign-in Assistant.

## More information

If the Microsoft Online Services Sign-in Assistant isn't installed, the log file contains the following error:

> 19:23:00| Error| Error connecting to URL: `https://disco.crm.dynamics.com/XRMServices/2011/Discovery.svc` Exception: System.DllNotFoundException: The Microsoft Online Services Sign-in Assistant is not installed. 32-bit: `https://g.microsoftonline.com/0BX00en/500` 64-bit: `https://g.microsoftonline.com/0BX00en/501`
