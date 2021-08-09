---
title: Cannot connect to Microsoft Dynamics CRM server error when connecting Dynamics CRM for Outlook
description: You may receive the Cannot connect to Microsoft Dynamics CRM server because we cannot authenticate your credentials error when connecting Microsoft Dynamics CRM for Microsoft Office Outlook. Provides a resolution.
ms.reviewer:  
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Cannot connect to Microsoft Dynamics CRM server error when trying to connect Microsoft Dynamics CRM for Microsoft Office Outlook

This article provides a resolution for the **Cannot connect to Microsoft Dynamics CRM server because we cannot authenticate your credentials** error that may occur when you try to connect Microsoft Dynamics CRM for Microsoft Office Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 3089574

## Symptoms

When you attempt to connect Microsoft Dynamics CRM for Microsoft Office Outlook to a CRM on-premises organization, you encounter the following error:

> Cannot connect to Microsoft Dynamics CRM server because we cannot authenticate your credentials. Check your connection or contact your administrator for more help.

## Cause

The username and password you provided are not correct.

## Resolution

Make sure the username and password you provided are correct. Verify you can access the same URL with your web browser and the same username and password. If you cannot access the Microsoft Dynamics CRM web application with the same username and password, contact your Microsoft Dynamics CRM administrator.

If you are still encountering issues connecting Microsoft Dynamics CRM for Outlook to your Microsoft Dynamics CRM Online organization, a diagnostic tool is available to help diagnose the issue:

[Microsoft Support and Recovery Assistant](/outlook/troubleshoot/performance/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant)

## More information

The following error can be found in the log file:

> *Time*| Info| Error connecting to URL: {0} Exception: {1}| `https://contoso.contoso.com/XRMServices/2011/Organization.svc`, System.ServiceModel.FaultException: The server was unable to process the request due to an internal error. For more information about the error, either turn on IncludeExceptionDetailInFaults (either from ServiceBehaviorAttribute or from the \<serviceDebug> configuration behavior) on the server in order to send the exception information back to the client, or turn on tracing as per the Microsoft .NET Framework SDK documentation and inspect the server trace logs.  
 at System.Windows.Forms.Control.MarshaledInvoke(Control caller, Delegate method, Object[] args, Boolean synchronous)  
 at System.Windows.Forms.Control.Invoke(Delegate method, Object[] args)  
 at System.Windows.Forms.Control.Invoke(Delegate method)  
 at Microsoft.Crm.Outlook.ClientAuth.ClientAuthProvider\`1.RetrieveUserCredentialsAndSignIn(Control parentWindow, Boolean retryOnError, IClientOrganizationContext context)  
 at Microsoft.Crm.Outlook.ClientAuth.ClientAuthProvider\`1.SignIn(AuthUIMode uiMode, IClientOrganizationContext context, Control parentWindow, Boolean retryOnError)  
 at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo\`1.DeploymentInfo\`1.LoadOrganizationsInternal(AuthUIMode uiMode, Control parentWindow)  
 at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo\`1.DeploymentInfo\`1.LoadOrganizations(AuthUIMode uiMode, Control parentWindow, IClientAuthProvider\`1 authenticatedProvider)  
 at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo\`1.InternalLoadOrganizations(DataCollection`1 orgs, AuthUIMode uiMode, Control parentWindow)
