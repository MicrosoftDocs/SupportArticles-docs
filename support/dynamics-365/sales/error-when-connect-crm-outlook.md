---
title: Error when connecting CRM for Outlook
description: Provides a solution to an error that occurs when you try to connect Microsoft Dynamics CRM 2013 for Microsoft Office Outlook to a CRM Online 2015 organization.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# Error occurs when you try to connect Microsoft Dynamics CRM 2013 for Microsoft Office Outlook to a CRM Online 2015 organization

This article provides a solution to an error that occurs when you try to connect Microsoft Dynamics CRM 2013 for Microsoft Office Outlook to a CRM Online 2015 organization.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online, Microsoft CRM client for Microsoft Office Outlook  
_Original KB number:_ &nbsp; 3089572

## Symptoms

When you attempt to connect Microsoft Dynamics CRM 2013 for Microsoft Office Outlook to a CRM Online 2015 organization, you receive the following error:

> "There is a problem communicating with the Microsoft Dynamics CRM server. The server might be unavailable. Try again later. If the problem persists, contact your system administrator."

## Cause

You typed the URL for your CRM Online organization instead of selecting CRM Online from the drop-down list.

## Resolution

Instead of typing the URL, select CRM Online from the drop-down list.

> [!NOTE]
> It's also possible to enter the Discovery Service URL (ex. `https://disco.crm.dynamics.com`). You can locate your Discovery Service URL within the Microsoft Dynamics CRM web application by selecting **Settings** | **Customization** | **Developer Resources**.

If you're still meeting issues connecting CRM for Outlook to your CRM Online organization, [a diagnostic tool](https://support.microsoft.com/office/e90bb691-c2a7-4697-a94f-88836856c72f) is available to help diagnose the issue.

## More information

The following error can be found in the log file:

> 12:56:39| Error| Error connecting to URL: `https://.crm.dynamics.com/XRMServices/2011/Discovery.svc` Exception: System.InvalidOperationException: Metadata contains a reference that cannot be resolved: `https://crmserviceability.crm.dynamics.com/_common/error/errorhandler.aspx?BackUri=&ErrorCode=&Parm0`=
> 12:56:39| Error| Error connecting to URL: `https://.crm.dynamics.com/XRMServices/2011/Discovery.svc` Exception: System.InvalidOperationException: Metadata contains a reference that cannot be resolved: `https://crmserviceability.crm.dynamics.com/_common/error/errorhandler.aspx?BackUri=&ErrorCode=&Parm0`=
details: The service '/XRMServices/2011/Discovery.svc' cannot be activated due to an exception during compilation. The exception message is: Could not load file or assembly 'Microsoft.Crm.Site.Services, Version=7.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35' or one of its dependencies. The system cannot find the file specified..&RequestUri=/XRMServices/2011/Discovery.svc?wsdl&user_lcid=1025'. ---> System.Xml.XmlException: CData elements not valid at top level of an XML document. Line 1, position 3.  
> at System.Xml.XmlExceptionHelper.ThrowXmlException(XmlDictionaryReader reader, XmlException exception)  
> at System.Xml.XmlUTF8TextReader.Read()  
> at System.ServiceModel.Description.MetadataExchangeClient.MetadataLocationRetriever.GetXmlReader(HttpWebResponse response, Int64 maxMessageSize, XmlDictionaryReaderQuotas readerQuotas)  
> at System.ServiceModel.Description.MetadataExchangeClient.MetadataLocationRetriever.DownloadMetadata(TimeoutHelper timeoutHelper)  
> at System.ServiceModel.Description.MetadataExchangeClient.MetadataRetriever.Retrieve(TimeoutHelper timeoutHelper)
> --- End of inner exception stack trace ---  
> at System.ServiceModel.Description.MetadataExchangeClient.MetadataRetriever.Retrieve(TimeoutHelper timeoutHelper)  
> at System.ServiceModel.Description.MetadataExchangeClient.ResolveNext(ResolveCallState resolveCallState)  
> at System.ServiceModel.Description.MetadataExchangeClient.GetMetadata(MetadataRetriever retriever)  
> at System.ServiceModel.Description.MetadataExchangeClient.GetMetadata(Uri address, MetadataExchangeClientMode mode)  
> at Microsoft.Xrm.Sdk.Client.ServiceMetadataUtility.RetrieveServiceEndpointMetadata(Type contractType, Uri serviceUri, Boolean checkForSecondary)  
> at Microsoft.Xrm.Sdk.Client.ServiceConfiguration`1..ctor(Uri serviceUri, Boolean checkForSecondary)  
> at Microsoft.Xrm.Sdk.Client.ServiceConfigurationFactory.CreateConfiguration[TService](Uri serviceUri, Boolean enableProxyTypes, Assembly assembly)  
> at Microsoft.Xrm.Sdk.Client.ServiceConfigurationFactory.CreateConfiguration[TService](Uri serviceUri)  
> at Microsoft.Crm.Outlook.ClientAuth.ClientAuthProvidersFactory\`1.GetAuthProviderForDeployment(Uri endPoint, Credential credentials, Uri webEndPoint)  
> at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo.DeploymentInfo.ValidateAuthProvider()  
> at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo.SortAndValidateDeployments()  
> 12:56:39| Error| Exception : Metadata contains a reference that cannot be resolved: `https://crmserviceability.crm.dynamics.com/_common/error/errorhandler.aspx?BackUri=&ErrorCode=&Parm0`=
details: The service '/XRMServices/2011/Discovery.svc' cannot be activated due to an exception during compilation. The exception message is: Could not load file or assembly 'Microsoft.Crm.Site.Services, Version=7.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35' or one of its dependencies. The system cannot find the file specified..&RequestUri=/XRMServices/2011/Discovery.svc?wsdl&user_lcid=1025'. at Microsoft.Crm.Application.Outlook.Config.DeploymentsInfo.LoadOrganizations(AuthUIMode uiMode, Form parentWindow)  
> at Microsoft.Crm.Application.Outlook.Config.ServerForm.LoadOrganizationsInternal(Boolean forceUI, String deploymentUrl)
> at Microsoft.Crm.Application.Outlook.Config.ServerForm.<>c__DisplayClass17.\<LoadOrganizations>b__10()  
> at Microsoft.ExceptionHelper.ExceptionFilter.TryFilter[TEx](Action body, Predicate\`1 filter, Action\`1 catchClause)  
> at Microsoft.Crm.Application.Outlook.Config.ServerForm.LoadOrganizations(Boolean forceUI)  
> at Microsoft.Crm.Application.Outlook.Config.ServerForm.\<InitializeBackgroundWorkers>b__0(Object sender, DoWorkEventArgs e)
> at System.ComponentModel.BackgroundWorker.OnDoWork(DoWorkEventArgs e)  
> at System.ComponentModel.BackgroundWorker.WorkerThreadStart(Object argument)  
> 12:56:39| Error| Exception : CData elements not valid at top level of an XML document. Line 1, position 3. at System.Xml.XmlExceptionHelper.ThrowXmlException(XmlDictionaryReader reader, XmlException exception)  
> at System.Xml.XmlUTF8TextReader.Read()  
> at System.ServiceModel.Description.MetadataExchangeClient.MetadataLocationRetriever.GetXmlReader(HttpWebResponse response, Int64 maxMessageSize, XmlDictionaryReaderQuotas readerQuotas)  
> at System.ServiceModel.Description.MetadataExchangeClient.MetadataLocationRetriever.DownloadMetadata(TimeoutHelper timeoutHelper)  
> at System.ServiceModel.Description.MetadataExchangeClient.MetadataRetriever.Retrieve(TimeoutHelper timeoutHelper)
