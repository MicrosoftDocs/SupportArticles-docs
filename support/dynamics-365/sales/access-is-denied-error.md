---
title: Access is denied when connecting CRM for Outlook
description: Provides a solution to an authentication error that occurs when you try to connect Microsoft Dynamics CRM for Office Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Access is denied error when you try to connect Microsoft Dynamics CRM for Office Outlook

This article provides a solution to an error that occurs when you try to connect Microsoft Dynamics CRM for Office Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2015, Microsoft Dynamics CRM 2013  
_Original KB number:_ &nbsp; 3088205

## Symptoms

When you try to connect Microsoft Dynamics CRM for Office Outlook with an On-Premises CRM organization, and don't include the organization name in the Claims-Based Authentication URL, you receive the following error message:

> "Cannot connect to Microsoft Dynamics CRM server because we cannot authenticate your credentials.
>
> Check your connection or contact your administrator for more help."

## Cause

Microsoft Dynamics CRM for Office Outlook was unable to authenticate you because the organization name wasn't included in the URL.

## Resolution

Provide the organization name as part of the Claims-Based Authentication URL when configuring the Microsoft Dynamics CRM for Office Outlook client.

Example URL Format: `https://<crmservername>.<domain>.<domainsuffix>/<orgname>`  
Example URL: `https://crmserver.contoso.com/contoso`

> [!NOTE]
> If you have your Microsoft Dynamics CRM organization configured as an Internet Facing Deployment (IFD), you can also access via your IFD URL which includes the organization name:
>
> Example IFD URL Format: `https://<orgname>.<domain>.<domainsuffix>`  
> Example IFD URL: `https://contoso.contoso.com`

## More information

When you select **Details**, the following additional information appears and is also available in the log file:

> Access is denied.
>
> Server stack trace:  
 at System.ServiceModel.Channels.ServiceChannel.ThrowIfFaultUnderstood(Message reply, MessageFault fault, String action, MessageVersion version, FaultConverter faultConverter)  
 at System.ServiceModel.Channels.ServiceChannel.HandleReply(ProxyOperationRuntime operation, ProxyRpc& rpc)  
 at System.ServiceModel.Channels.ServiceChannel.Call(String action, Boolean oneway, ProxyOperationRuntime operation, Object[] ins, Object[] outs, TimeSpan timeout)  
 at System.ServiceModel.Channels.ServiceChannelProxy.InvokeService(IMethodCallMessage methodCall, ProxyOperationRuntime operation)  
 at System.ServiceModel.Channels.ServiceChannelProxy.Invoke(IMessage message)
>
> Exception rethrown at [0]:  
 at System.Windows.Forms.Control.MarshaledInvoke(Control caller, Delegate method, Object[] args, Boolean synchronous)  
 at System.Windows.Forms.Control.Invoke(Delegate method, Object[] args)  
 at System.Windows.Forms.Control.Invoke(Delegate method)  
 at Microsoft.Crm.Outlook.ClientAuth.ClientAuthProvider\`1.RetrieveUserCredentialsAndSignIn(Control parentWindow, Boolean retryOnError, IClientOrganizationContext context)  
 at Microsoft.Crm.Outlook.ClientAuth.ClientAuthProvider\`1.SignIn(AuthUIMode uiMode, IClientOrganizationContext context, Control parentWindow, Boolean retryOnError)  
 at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo\`1.DeploymentInfo\`1.LoadOrganizationsInternal(AuthUIMode uiMode, Control parentWindow)  
 at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo\`1.DeploymentInfo\`1.LoadOrganizations(AuthUIMode uiMode, Control parentWindow, IClientAuthProvider\`1 authenticatedProvider)  
 at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo\`1.InternalLoadOrganizations(DataCollection\`1 orgs, AuthUIMode uiMode, Control parentWindow)
