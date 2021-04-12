---
title: Error when configuring CRM 2011 Client
description: Provides a solution to an error that occurs when you configure Microsoft Dynamics CRM 2011 Client for Outlook.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Exception: System.ServiceModel.Security.SecurityAccessDeniedException: Access is denied. error when configuring the Microsoft Dynamics CRM 2011 Client for Outlook

This article provides a solution to an error that occurs when you configure Microsoft Dynamics CRM 2011 Client for Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2674807

## Symptoms

When you configure Microsoft Dynamics CRM 2011 Client for Outlook against Dynamics CRM Online on the Office 365 platform, you receive an error after successfully retrieving the organization:

> There is a problem communicating with the Microsoft Dynamics CRM server. The server might be unavailable. Try again later. If the problem persists, contact your system administrator."

> "Error connecting to URL: `https://disco.crm4.dynamics.com/XRMServices/2011/Discovery.svc` Exception: System.ServiceModel.Security.SecurityAccessDeniedException: Access is denied."

## Cause

It happens only when:

- Dynamics CRM Online is used on the Office 365 Platform
- The user name on Office 365 uses multi-byte characters, such as Japanese or Korean

## Resolution

Change the profile for the Office 365 user to English language.

## More information

> Platform Error  
> \====================================  
> 15:38:44| Error| Error connecting to URL: `https://disco.crm4.dynamics.com/XRMServices/2011/Discovery.svc` Exception: System.ServiceModel.Security.SecurityAccessDeniedException: Access is denied.  
Server stack trace:  
 at System.ServiceModel.Channels.ServiceChannel.ThrowIfFaultUnderstood(Message reply, MessageFault fault, String action, MessageVersion version, FaultConverter faultConverter)  
 at System.ServiceModel.Channels.ServiceChannel.HandleReply(ProxyOperationRuntime operation, ProxyRpc& rpc)  
 at System.ServiceModel.Channels.ServiceChannel.Call(String action, Boolean oneway, ProxyOperationRuntime operation, Object[] ins, Object[] outs, TimeSpan timeout)  
 at System.ServiceModel.Channels.ServiceChannelProxy.InvokeService(IMethodCallMessage methodCall, ProxyOperationRuntime operation)  
 at System.ServiceModel.Channels.ServiceChannelProxy.Invoke(IMessage message)  
>
> Exception rethrown at [0]:  
 at System.Runtime.Remoting.Proxies.RealProxy.HandleReturnMessage(IMessage reqMsg, IMessage retMsg)  
 at System.Runtime.Remoting.Proxies.RealProxy.PrivateInvoke(MessageData& msgData, Int32 type)  
 at Microsoft.Xrm.Sdk.Discovery.IDiscoveryService.Execute(DiscoveryRequest request)  
 at Microsoft.Xrm.Sdk.Client.DiscoveryServiceProxy.Execute(DiscoveryRequest request)  
 at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo.DeploymentInfo.LoadOrganizations(AuthUIMode uiMode, Form parentWindow, Credential credentials)  
 at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo.InternalLoadOrganizations(OrganizationDetailCollection orgs, AuthUIMode uiMode, Form parentWindow) 15:38:52|Warning| Client configuration failed with the exception : The remote server returned an error: (401) Unauthorized.  
 at System.Net.HttpWebRequest.GetResponse()
 at Microsoft.Crm.Outlook.ClientAuth.ClaimsBasedAuthProvider\`1.MakeHttpPostRequest(Uri postUri, String postData)  
 at Microsoft.Crm.Outlook.ClientAuth.ClaimsBasedAuthProvider\`1.SetBearerCookie(SignInResponseMessage signInResponseMessage)  
 at Microsoft.Crm.Outlook.ClientAuth.PassportAuthProvider\`1.SignIn()  
 at Microsoft.Crm.Outlook.ClientAuth.ClientAuthProvidersFactory\`1.SignIn(Uri endPoint, Credential credentials, AuthUIMode uiMode, IClientOrganizationContext context, Form parentWindow, Boolean retryOnError)  
 at Microsoft.Crm.Outlook.ClientAuth.ClientAuthProvidersFactory\`1.GetAuthProvider(Uri endPoint, Credential credentials, AuthUIMode uiMode, Uri webEndPoint, IClientOrganizationContext context, Form parentWindow)
 at Microsoft.Crm.Application.Outlook.Config.ServerInfo.LoadUserId()  
 at Microsoft.Crm.Application.Outlook.Config.ServerInfo.Initialize(Uri discoveryUri, OrganizationDetail selectedOrg, String displayName, Boolean isPrimary)
 at Microsoft.Crm.Application.Outlook.Config.ClientConfig.AddDeployment(DeploymentsDeployment[] deployments, AuthUIMode uiMode)  
 at Microsoft.Crm.Application.Outlook.Config.ClientConfig.AddDeployment_ReducedUI()  
 at Microsoft.Crm.Application.Outlook.Config.ClientConfig.Run(Boolean runInsideOutlook)
