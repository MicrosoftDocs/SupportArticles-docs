---
title: People Picker field embedded in Office documents does not show Add People dialog box in SharePoint 2013
description: Discusses a problem in which the embedded People Picker field in Office documents does not show the Add People dialog box in SharePoint 2013.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Microsoft SharePoint
ms.date: 12/17/2023
---

# People Picker field embedded in Office documents does not show "Add People" dialog box

## Symptom   

Consider the following scenario:   

- You are using Office files, such as Word documents or InfoPath forms, that have an embedded People Picker field in the Office Information Panel.    
- Clients connect to a Microsoft SharePoint site by using an "https" address.   
- A proxy server or load balancer exists between clients and the SharePoint 2010 or SharePoint 2013 servers. SSL is terminated at the proxy server or load balancer.     

In this scenario, when the files are opened in the client application, the embedded People Picker fields do not show any visible results. Also, network traces show an "http 500" error for an https request that is sent to the SharePoint site in the following path: 

```
/_vti_bin/spclaimproviderwebservice.https.svc
```

When this problem occurs, the Event Viewer on the SharePoint web front-end server may show an event that resembles the following entry:  

```
Log Name: Application  
Source: System.ServiceModel 4.0.0.0  
Date: <Date and Time>  
Event ID: 3  
Task Category: WebHost  
Level: Error  
User: <Service account>  
Computer: <FQDN>  
Description:  
WebHost failed to process a request.  
 Sender Information: System.ServiceModel.ServiceHostingEnvironment+HostingManager/57709411  
 Exception: System.ServiceModel.ServiceActivationException: The service '/_vti_bin/spclaimproviderwebservice.https.svc' cannot be activated due to an exception during compilation. The exception message is: Could not find a base address that matches scheme https for the endpoint with binding BasicHttpBinding. Registered base address schemes are [http]..  
 ---> System.InvalidOperationException: Could not find a base address that matches scheme https for the endpoint with binding BasicHttpBinding. Registered base address schemes are [http].  
 at System.ServiceModel.ServiceHostBase.MakeAbsoluteUri(Uri relativeOrAbsoluteUri, Binding binding, UriSchemeKeyedCollection baseAddresses)  
 at System.ServiceModel.Description.ConfigLoader.LoadServiceDescription(ServiceHostBase host, ServiceDescription description, ServiceElement serviceElement, Action`1 addBaseAddress, Boolean skipHost)  
 at System.ServiceModel.ServiceHostBase.ApplyConfiguration()  
 at System.ServiceModel.ServiceHostBase.InitializeDescription(UriSchemeKeyedCollection baseAddresses)  
 at System.ServiceModel.ServiceHost..ctor(Type serviceType, Uri[] baseAddresses)  
 at System.ServiceModel.Activation.ServiceHostFactory.CreateServiceHost(Type serviceType, Uri[] baseAddresses)  
 at System.ServiceModel.Activation.ServiceHostFactory.CreateServiceHost(String constructorString, Uri[] baseAddresses)  
 at System.ServiceModel.ServiceHostingEnvironment.HostingManager.CreateService(String normalizedVirtualPath, EventTraceActivity eventTraceActivity)  
 at System.ServiceModel.ServiceHostingEnvironment.HostingManager.ActivateService(ServiceActivationInfo serviceActivationInfo, EventTraceActivity eventTraceActivity)  
 at System.ServiceModel.ServiceHostingEnvironment.HostingManager.EnsureServiceAvailable(String normalizedVirtualPath, EventTraceActivity eventTraceActivity)  
 --- End of inner exception stack trace ---  
 at System.ServiceModel.ServiceHostingEnvironment.HostingManager.EnsureServiceAvailable(String normalizedVirtualPath, EventTraceActivity eventTraceActivity)  
 at System.ServiceModel.ServiceHostingEnvironment.EnsureServiceAvailableFast(String relativeVirtualPath, EventTraceActivity eventTraceActivity)  
 Process Name: w3wp  
 Process ID: <PID> ULS logs from the SharePoint server may contain entries that resemble the following:  

<Date and Time> w3wp.exe SharePoint Foundation Runtime fx7n Medium Cannot find factory type for service at /  
_vti_bin/spclaimproviderwebservice.https.svc   
```

## Cause   

This problem occurs because SharePoint uses different web services for websites, depending on whether the sites have "http" or "https" addresses. If the website uses "http," the expected web service address is spclaimproviderwebservice.svc . If the website uses "https," the expected web service address is spclaimproviderwebservice.https.svc .  

In this scenario, the user browses to an "https" address, but SSL is terminated on the proxy server or load balancer. Because SharePoint web front-end servers are receiving http requests, they expect the web service request path to be for the http version of the service. That is, they expect /_vti_bin/spclaimproviderwebservice.svc instead of /_vti_bin/spclaimproviderwebservice.https.svc.

Therefore, /_vti_bin/spclaimproviderwebservice.https.svc requests for the SSL web service cause the http 500 error.  

## Resolution

To resolve this problem, use one of the following methods.  

### Method A  
Add an iRule at the load balancer or within Internet Information Services (IIS) so that requests for the https site that include the spclaimproviderwebservice.https.svc path change to http and spclaimproviderwebservice.svc  before the request is forwarded to the SharePoint web front-end (WFE) server role.  

### Method B  

Adjust the website topology so that SSL is terminated on the SharePoint servers instead of on the proxy server or load balancer.  

## More Information   

For Method A, the following logic is confirmed to resolve this problem:  

IIS rule:   

```  
<rule name="SpClaimProviderWebService" stopProcessing="true">  
< match url="^(.*)spclaimproviderwebservice.https.svc$" />  
< action type="Rewrite" url="{R:1}spclaimproviderwebservice.svc" />  
< /rule>  
```  

F5/NLB Rule:   
```
when HTTP_REQUEST {  
if { [[string tolower] [HTTP::path]] contains "spclaimproviderwebservice.https.svc"} {  
HTTP::path [string map {.https ""} [HTTP::path]]  
}  
}  
```

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
