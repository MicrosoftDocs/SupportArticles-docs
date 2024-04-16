---
title: The server address (URL) is not valid error
description: This article provides a resolution for the problem that occurs when you attempt to connect Microsoft Dynamics CRM for Outlook to your Microsoft Dynamics CRM Online instance.
ms.reviewer: dmartens
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# "The server address (URL) is not valid" error when you configure Microsoft Dynamics CRM for Outlook

This article provides a resolution for the problem that occurs when you attempt to connect Microsoft Dynamics CRM for Outlook to your Microsoft Dynamics CRM Online instance.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2015, Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 3048775

## Symptoms

You attempt to connect Microsoft Dynamics CRM for Outlook to your Microsoft Dynamics CRM Online instance but encounter the following error message:

> The server address (URL) is not valid

## Cause

Microsoft Dynamics CRM for Outlook is attempting to use your domain credentials to connect with Microsoft Dynamics CRM.

## Resolution

If you want to authenticate as a different account, you will need to uncheck the **Connect automatically with my current credentials** checkbox. If this checkbox is not visible, either select CRM Online again from the dropdown list or type your Microsoft Dynamics CRM Online URL. You can also copy and paste the URL from your web browser.

If you are still encountering issues connecting CRM for Outlook to your CRM Online organization, a diagnostic tool is available to help diagnose the issue: [CRM for Outlook Configuration Diagnostic](/outlook/troubleshoot/performance/how-to-scan-outlook-by-using-microsoft-support-and-recovery-assistant).

## More information

If you click **Details** or view the log file, you see the following error:

```console
Client configuration failed with the exception : The HTTP request is unauthorized with client authentication scheme 'Anonymous'. The authentication header received from the server was 'Bearer authorization_uri=https://login.windows.net/common/oauth2/authorize'.
Server stack trace:
 at System.ServiceModel.Channels.HttpChannelUtilities.ValidateAuthentication(HttpWebRequest request, HttpWebResponse response, WebException responseException, HttpChannelFactory`1 factory)
 at System.ServiceModel.Channels.HttpChannelUtilities.ValidateRequestReplyResponse(HttpWebRequest request, HttpWebResponse response, HttpChannelFactory`1 factory, WebException responseException, ChannelBinding channelBinding)
 at System.ServiceModel.Channels.HttpChannelFactory`1.HttpRequestChannel.HttpChannelRequest.WaitForReply(TimeSpan timeout)
 at System.ServiceModel.Channels.RequestChannel.Request(Message message, TimeSpan timeout)
 at System.ServiceModel.Dispatcher.RequestChannelBinder.Request(Message message, TimeSpan timeout)
 at System.ServiceModel.Channels.ServiceChannel.Call(String action, Boolean oneway, ProxyOperationRuntime operation, Object[] ins, Object[] outs, TimeSpan timeout)
 at System.ServiceModel.Channels.ServiceChannelProxy.InvokeService(IMethodCallMessage methodCall, ProxyOperationRuntime operation)
 at System.ServiceModel.Channels.ServiceChannelProxy.Invoke(IMessage message)

Exception rethrown at [0]:
 at System.Runtime.Remoting.Proxies.RealProxy.HandleReturnMessage(IMessage reqMsg, IMessage retMsg)
 at System.Runtime.Remoting.Proxies.RealProxy.PrivateInvoke(MessageData& msgData, Int32 type)
 at Microsoft.Xrm.Sdk.Discovery.IDiscoveryService.Execute(DiscoveryRequest request)
 at Microsoft.Xrm.Sdk.WebServiceClient.DiscoveryWebProxyClient.<>c__DisplayClass1.<ExecuteCore>b__0()
 at Microsoft.Xrm.Sdk.WebServiceClient.WebProxyClient`1.ExecuteAction[TResult](Func`1 action)
 at Microsoft.Xrm.Sdk.WebServiceClient.DiscoveryWebProxyClient.ExecuteCore(DiscoveryRequest request)
 at Microsoft.Xrm.Sdk.WebServiceClient.DiscoveryWebProxyClient.Execute(DiscoveryRequest request)
 at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo`1.DeploymentInfo`1.RequestOrganizationDetailsFromDiscovery(IDiscoveryService proxy, EndpointAccessType endpointAccessType)
 at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo`1.DeploymentInfo`1.LoadOrganizationsInternal(AuthUIMode uiMode, Control parentWindow)
 at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo`1.DeploymentInfo`1.LoadFederatedOrganizations(AuthUIMode uiMode, Control parentWindow)
 at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo`1.LoadFederatedOrgs(DataCollection`1 orgs)
 at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo`1.LoadOrganizations(AuthUIMode uiMode, Control parentWindow)
 at Microsoft.Crm.Application.Outlook.Config.ClientConfig.AddDeployment(DeploymentsDeployment[] deployments, AuthUIMode uiMode)
 at Microsoft.Crm.Application.Outlook.Config.ClientConfig.AddDeployment_ReducedUI()
 at Microsoft.Crm.Application.Outlook.Config.ClientConfig.Run(Boolean runInsideOutlook)
```
