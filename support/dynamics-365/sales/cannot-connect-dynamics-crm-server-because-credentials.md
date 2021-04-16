---
title: Cannot connect to Dynamics CRM server because credentials authentication
description: Provides a solution to an error that occurs when you try to configure the Microsoft Dynamics CRM Client for Outlook with a Dynamics CRM Online organization.
ms.reviewer: chanson
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Cannot connect to Microsoft Dynamics CRM server because we cannot authenticate your credentials

This article provides a solution to an error that occurs when you try to configure the Microsoft Dynamics CRM Client for Outlook with a Dynamics CRM Online organization.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 2666080

## Symptoms

When you try to configure the Microsoft Dynamics CRM Client for Outlook with a Dynamics CRM Online organization, you get the following error:

> "Cannot connect to Microsoft Dynamics CRM server because we cannot authenticate your credentials. Check your connection or contact your administrator for more help."

In the configuration log, the following error is shown:

> Error| Error connecting to URL: `https://disco.crm.dynamics.com/XRMServices/2011/Discovery.svc` Exception: Microsoft.Crm.CrmException: Logon failed because credentials are invalid --->  
Microsoft.Crm.Passport.IdCrl.IdCrlException: GetAuthState() - Request Status:  
at Microsoft.Crm.Passport.IdCrl.OnlineServicesFederationLogOnManager.LogonOrgId(String policy, String partner, LOGON_FLAG logonFlag)  
at Microsoft.Crm.Passport.IdCrl.OnlineServicesFederationLogOnManager.Logon(String userName, String password, String partner, String policy, String& memberName)  
at Microsoft.Crm.Outlook.ClientAuth.PassportAuthProvider\`1.SignIn()  
--- End of inner exception stack trace ---  
at Microsoft.Crm.Outlook.ClientAuth.ClientAuthProvidersFactory\`1.RetrieveUserCredentialsAndSignIn(Uri endPoint, Credential credentials, Form parentWindow, Boolean retryOnError, IClientOrganizationContext context)  
at Microsoft.Crm.Outlook.ClientAuth.ClientAuthProvidersFactory\`1.SignIn(Uri endPoint, Credential credentials, AuthUIMode uiMode, IClientOrganizationContext context, Form parentWindow, Boolean retryOnError)  
at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo.DeploymentInfo.LoadOrganizations(AuthUIMode uiMode, Form parentWindow, Credential credentials)  
at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo.InternalLoadOrganizations(OrganizationDetailCollection orgs, AuthUIMode uiMode, Form parentWindow)

## Cause

The cause of this issue is because of not having your Windows Live ID verified. When you sign up for a Windows Live ID and you aren't using a `@outlook.com` or a `@live.com` email address, you'll need to verify the e-mail address before it can be used to configure the Microsoft Dynamics CRM Client for Outlook.

## Resolution

After the creation of your Windows Live ID, an email is sent to the email address you created as your Windows Live ID. You'll need to sign in to that email account and select the link in the email to verify the email address. Once it's complete, you can continue the configuration of the Microsoft Dynamics CRM Client for Outlook.
