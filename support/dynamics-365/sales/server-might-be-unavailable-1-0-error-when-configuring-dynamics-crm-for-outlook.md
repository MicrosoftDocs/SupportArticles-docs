---
title: The server might be unavailable error when configuring Dynamics CRM for Outlook
description: When you try to configure the Microsoft Dynamics CRM for Outlook client, you receive an error that states the server might be unavailable. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# "The server might be unavailable {1}{0}" error when trying to configure Microsoft Dynamics CRM for Outlook

This article provides a resolution for the issue that you can't configure the Microsoft Dynamics CRM for Outlook client due to the "The server might be unavailable. {1}{0}" error.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 2736267

## Symptoms

When you configure the Microsoft Dynamics CRM for Outlook client, you receive the following error message:

> There is a problem communicating with the Microsoft Dynamics CRM server. The server might be unavailable. {1}{0}

When you try to open Credential Manager in the Control Panel, you receive the following error message.

> Unable to save credentials. To save credentials in the vault, check your computer configuration.
>
> Error Code: 0x80070520
>
> Error Message: A Specified login session does not exist. It may already have been terminated.

## Cause

This can occur if the Credential Manager was disabled either via Group Policy or directly in the registry:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa`

ValueName: **DisableCredMan**

Value Data: **1**

## Resolution

Changing the value Data from **1** to **0**, or removing the Value Name entirely will allow the Outlook client to configure correctly as well as allowing the successful opening of the Credential Manager.

## More information

Below is an example error from the log file:

> *DateTime*| Info| Error connecting to URL: {0} Exception: {1}| `https://contoso.contoso.com/XRMServices/2011/Organization.svc`, Microsoft.Crm.CrmException: Server was unable to process request.  
 at Microsoft.Crm.CredentialManager.WriteCredentials(Uri target, Credential userCredentials, Boolean allowPhysicalStore)  
 at Microsoft.Crm.Outlook.ClientAuth.ClientAuthProvider\`1.set_Credentials(Credential value)  
 at Microsoft.Crm.Outlook.ClientAuth.ClientAuthUtility.CopyAuthenticationContext[TService1,TService2](IClientAuthProvider\`1 authenticatedProvider, IClientAuthProvider\`1 nonAuthenticatedProvider)  
 at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo\`1.DeploymentInfo\`1.LoadOrganizations(AuthUIMode uiMode, Control parentWindow, IClientAuthProvider\`1 authenticatedProvider)  
 at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo\`1.InternalLoadOrganizations(DataCollection\`1 orgs, AuthUIMode uiMode, Control parentWindow)
