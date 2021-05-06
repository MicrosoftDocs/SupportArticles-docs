---
title: Error occurs when setting Dynamics CRM for Outlook
description: This article provides a resolution to an error you may see when configuring the Microsoft Dynamics CRM Client for Microsoft Office Outlook.
ms.reviewer: jowells, chanson
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Cannot authenticate your credentials error when configuring the Microsoft Dynamics CRM for Outlook client 2011

This article provides a resolution for the issue that you can't configure Microsoft Dynamics CRM for Microsoft Office Outlook using the Configuration Wizard due to the **Cannot connect to Microsoft Dynamics CRM server because we cannot authenticate your credentials** error.

_Applies to:_ &nbsp; Microsoft CRM client for Microsoft Office Outlook, Microsoft Dynamics CRM 2011, Microsoft Business Solutions CRM Sales for Outlook  
_Original KB number:_ &nbsp; 2682528

## Symptoms

When trying to configure Microsoft Dynamics CRM for Outlook using the Configuration Wizard, you receive the following error:

> Cannot connect to Microsoft Dynamics CRM server because we cannot authenticate your credentials. Check your connection or contact your administrator for more help.

In the Microsoft Dynamics CRM Configuration log, (default location: C:\Users\\*\<username>*\AppData\Local\Microsoft\MSCRM\Logs\Crm50ClientConfig.log), you will see an error similar to the following:

> Error| Error connecting to URL: `https://dev.crm.dynamics.com/XRMServices/2011/Discovery.svc`  
Exception:  Microsoft.Crm.Passport.IdCrl.IdCrlException: InitializeEx()  
at Microsoft.Crm.Passport.IdCrl.FederationLogOnManager.Initialize(String environment)  
at Microsoft.Crm.Passport.IdCrl.FederationLogOnManager..ctor(String environment)  
at Microsoft.Crm.Outlook.ClientAuth.PassportAuthProvider\`1.GetLogonManager()  
at Microsoft.Crm.Outlook.ClientAuth.PassportAuthProvider\`1.SignIn()  
at Microsoft.Crm.Outlook.ClientAuth.ClientAuthProvidersFactory\`1.SignIn(Uri endPoint, Credential credentials, AuthUIMode uiMode, IClientOrganizationContext context, Form parentWindow, Boolean retryOnError)  
at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo.DeploymentInfo.LoadOrganizations(AuthUIMode uiMode, Form parentWindow, Credential credentials)  
at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo.InternalLoadOrganizations(OrganizationDetailCollection orgs, AuthUIMode uiMode, Form parentWindow)

## Cause

Windows Live ID Sign-in Assistant service is not running.

## Resolution

Start or restart the Windows Live ID Sign-In Assistant.

1. Select Windows button and within **Search programs and files** type *Services.msc*.
2. Locate Windows Live ID Sign-in Assistant and verify the Startup Type is set to Automatic.

3. If the Startup Type is not set to Automatic, do the following:
   1. Double-click on Windows Live ID Sign-in Assistant.
   2. Change Startup type to Automatic.
   3. Select **Start**.
   4. Select **OK**.

4. If the Startup Type is set to Automatic, verify the status is set to Started. If the status is not set to Started, then do the following:
   1. Select the Windows Live ID Sign-in Assistant.
   2. Right-click on it and go to **Start**.

5. If the Startup Type is set to Automatic and the status is set to Started, do the following:

   1. Select the Windows Live ID Sign-in Assistant.
   2. Right-click on it and go to Restart.

If you experience any errors when trying to start the Windows Live ID Sign-in Assistant, try uninstalling and reinstalling the service:

1. Point to the **Start** menu, select **Control Panel**, and select **Programs and Features**.
2. Find and right-click Windows Live ID Sign-in Assistant. Select **uninstall**.
3. Reinstall Windows Live ID Sign-in Assistant.
