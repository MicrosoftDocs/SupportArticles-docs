---
title: Outlook client configuration fails with error
description: This article provides a resolution for the problem that occurs when you configure the Microsoft Dynamics CRM Client for Microsoft Office Outlook and connect to an OnPremise deployment.
ms.reviewer: henningp, chanson
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Microsoft Dynamics CRM 2011 Outlook client configuration fails with error (The specified Microsoft Dynamics CRM server address (URL) is not responding)

This article helps you resolve the problem that occurs when you configure the Microsoft Dynamics CRM Client for Microsoft Office Outlook and connect to an OnPremise deployment.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2498357

## Symptoms

Unable to configure Microsoft Dynamics CRM Clients for Outlook. Configuration fails with the following error:

> The specified Microsoft Dynamics CRM server address (URL) is not responding. Ask your administrator to verify that the server is turned on, and then try again.

## Cause

Microsoft Dynamics CRM 2011 utilizes WCF endpoints for client communications. The WCF endpoints cannot support more than one HTTPS binding.

If the CRM website has more than one binding, CRM Outlook clients will fail to configure.

## Resolution

Open IIS Manager and limit the CRM Website to one http or one https binding.

1. Click **Start**, click **Run** and Type *inetmgr*.
2. Expand Sites and click on the Microsoft Dynamics CRM website.
3. In the **Actions Pane** click on **Bindings**.
4. In the Site Bindings window, ensure that you only have one http or one https binding type. If you have multiple bindings, they need to be removed.

> [!NOTE]
> The binding that should remain is the binding that is defined in the Deployment Manager. To check the urls open Deployment Manager, right-click on **Microsoft Dynamics CRM** and choose **Properties**, click the **Web Address** tab.

> [!NOTE]
> If IFD is used the Certificate matching your IFD settings should be kept.

## More information

Platform tracing reveals information similar to this:

> Error| Exception: Metadata contains a reference that cannot be resolved: 'https://\<ServerName>/\<OrgName>/XRMServices/2011/Organization.svc?wsdl'. at System.ServiceModel.Description.MetadataExchangeClient.MetadataRetriever.Retrieve(TimeoutHelper timeoutHelper)
 at System.ServiceModel.Description.MetadataExchangeClient.ResolveNext(ResolveCallState resolveCallState)
 at System.ServiceModel.Description.MetadataExchangeClient.GetMetadata(MetadataRetriever retriever)
 at System.ServiceModel.Description.MetadataExchangeClient.GetMetadata(Uri address, MetadataExchangeClientMode mode)
 at Microsoft.Xrm.Sdk.Client.ServiceMetadataUtility.RetrieveServiceEndpoints(Type contractType, Uri serviceUri)
 at Microsoft.Xrm.Sdk.Client.ServiceConfiguration`1..ctor(Uri serviceUri)
 at Microsoft.Xrm.Sdk.Client.OrganizationServiceConfiguration..ctor(Uri serviceUri)
 at Microsoft.Xrm.Sdk.Client.ServiceConfigurationFactory.CreateConfiguration[TService](Uri serviceUri)
 at Microsoft.Crm.Outlook.ClientAuth.ClientAuthProvidersFactory`1.GetAuthProvider(Uri endPoint, Credential credentials, AuthUIMode uiMode, Uri webEndPoint, IClientOrganizationContext context)
 at Microsoft.Crm.Application.Outlook.Config.ServerInfo.LoadUserId()
 at Microsoft.Crm.Application.Outlook.Config.ServerInfo.Initialize(Uri discoveryUri, OrganizationDetail selectedOrg, String displayName, Boolean isPrimary)
 at Microsoft.Crm.Application.Outlook.Config.ServerForm.LoadDataToServerInfo()
 at Microsoft.Crm.Application.Outlook.Config.ServerForm.\<InitializeBackgroundWorkers>b__2(Object sender, DoWorkEventArgs e)
 at System.ComponentModel.BackgroundWorker.OnDoWork(DoWorkEventArgs e)
 at System.ComponentModel.BackgroundWorker.WorkerThreadStart(Object argument)
