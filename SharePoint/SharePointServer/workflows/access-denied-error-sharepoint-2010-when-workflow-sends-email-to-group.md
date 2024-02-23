---
title: Access Denied error when a SharePoint 2010 workflow sends an email to a group
ms.author: luche
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: Admin
ms.topic: troubleshooting
ms.custom: CSSTroubleshoot
search.appverid: 
  - SPO160
  - MET150
ms.assetid: 
description: Describes how to resolve an 'Access Denied' error when a SharePoint 2010 workflow sends an email to a group
appliesto: 
  - SharePoint Server 2019
  - SharePoint Server 2016
  - SharePoint Server 2013
  - SharePoint Server 2010
  - SharePoint Designer 2013
  - SharePoint Designer 2010
ms.date: 12/17/2023
---
# "Access Denied" error when a SharePoint 2010 workflow sends an email to a group

## Symptoms
When a SharePoint 2010 workflow sends an email to a SharePoint group which contains multiple valid users, it fails to complete and you receive an "Access Denied" error.

## Cause
This error might be caused when the owner of the SharePoint group to which Workflow is attempting to send the email falls under one of the following scenarios:
- The group owner has an invalid account or the account no longer exists in SharePoint site.
- The group owner doesn't have full control or has limited permission to the SharePoint site. 

## Resolution
To resolve this issue, update the SharePoint group owner to a user who has full control or full permissions to the site.

## More information
The Universal Logging System (ULS) will display output similar to what follows:

```
Exception occurred in scope Microsoft.SharePoint.Utilities.SPUtility.SendEmail. Exception=System.UnauthorizedAccessException: Access is denied. (Exception from HRESULT: 0x80070005 (E_ACCESSDENIED))    
 at Microsoft.SharePoint.SPGlobal.HandleUnauthorizedAccessException(UnauthorizedAccessException ex)    
 at Microsoft.SharePoint.Library.SPRequest.GetUsersDataAsSafeArray(String bstrUrl, UInt32 dwUsersScope, UInt32 dwUserCollectionFlags, String bstrValue, UInt32 dwValue, UInt32& pdwColCount, UInt32& pdwRowCount, Object& pvarDataSet)    
 at Microsoft.SharePoint.SPUserCollection.InitUsersCore(Boolean fCustomUsers, String[] strIdentifiers, SPUserCollectionFlags ucf)    
 at Microsoft.SharePoint.SPUserCollection.Undirty()    
 at Microsoft.SharePoint.SPBaseCollection.GetEnumerator()    
 at Microsoft.SharePoint.Utilities.SPUtility.ResolveAddressesForEmail(SPWeb web, IEnumerable`1 addresses, AddressReader func)    
 at Microsoft.SharePoint.Utilities.SPUtility.SendEmail_Client(EmailProperties properties)    
 at Microsoft.SharePoint.ServerStub.Utilities.SPUtilityServerStub.InvokeStaticMethod(String methodName, ClientValueCollection xmlargs, ProxyContext proxyContext, Boolean& isVoid)    
 at Microsoft.SharePoint.Client.ServerStub.InvokeStaticMethodWithMonitoredScope(String methodName, ClientValueCollection args, ProxyContext proxyContext, Boolean& isVoid)

Original error: System.UnauthorizedAccessException: Access is denied. (Exception from HRESULT: 0x80070005 (E_ACCESSDENIED))    
 at Microsoft.SharePoint.SPGlobal.HandleUnauthorizedAccessException(UnauthorizedAccessException ex)    
 at Microsoft.SharePoint.Library.SPRequest.GetUsersDataAsSafeArray(String bstrUrl, UInt32 dwUsersScope, UInt32 dwUserCollectionFlags, String bstrValue, UInt32 dwValue, UInt32& pdwColCount, UInt32& pdwRowCount, Object& pvarDataSet)    
 at Microsoft.SharePoint.SPUserCollection.InitUsersCore(Boolean fCustomUsers, String[] strIdentifiers, SPUserCollectionFlags ucf)    
 at Microsoft.SharePoint.SPUserCollection.Undirty()    
 at Microsoft.SharePoint.SPBaseCollection.GetEnumerator()    
 at Microsoft.SharePoint.Utilities.SPUtility.ResolveAddressesForEmail(SPWeb web, IEnumerable`1 addresses, AddressReader func)    
 at Microsoft.SharePoint.Utilities.SPUtility.SendEmail_Client(EmailProperties properties)    
 at Microsoft.SharePoint.ServerStub.Utilities.SPUtilityServerStub.InvokeStaticMethod(String methodName, ClientValueCollection xmlargs, ProxyContext proxyContext, Boolean& isVoid)    
 at Microsoft.SharePoint.Client.ServerStub.InvokeStaticMethodWithMonitoredScope(String methodName, ClientValueCollection args, ProxyContext proxyContext, Boolean& isVoid)

```

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
