---
title: HTTP Unauthorized to /_vti_bin/client.svc/sp.utilities.utility.SendEmail
description: Describes an issue where access is denied when you send an email to a SharePoint group. Provides a solution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto: 
  - SharePoint Server 2013
  - SharePoint Designer 2013
ms.date: 12/17/2023
---

# Access denied when you send an email to a SharePoint group  

## Symptoms  

SharePoint 2013 Workflows that attempt to send an email to a SharePoint group can fail with an Access Denied error if the membership of the SharePoint group is not set to Everyone.  

## Cause  

This occurs when the user starting the workflow is not part of the SharePoint group. The following is logged ULS and in the Workflow Status page:

```  
Retrying last request. Next attempt scheduled in less than one minute. Details of last request: HTTP Unauthorized to https://URL/_vti_bin/client.svc/sp.utilities.utility.SendEmail  

RequestorId: c4f61784-766a-e0af-0000-000000000000. Details: RequestorId: c4f61784-766a-e0af-0000-000000000000. Details: An unhandled exception occurred during the execution of the workflow instance. Exception details: System.ApplicationException: HTTP 401 {"Transfer-Encoding":["chunked"],"X-SharePointHealthScore":["0"],"SPClientServiceRequestDuration":["96"],"SPRequestGuid":["c4f61784-766a-e0af-bd84-218299c77930"],"request-id":["c4f61784-766a-e0af-bd84-218299c77930"],"X-FRAME-OPTIONS":["SAMEORIGIN"],"MicrosoftSharePointTeamServices":["15.0.0.4454"],"X-Content-Type-Options":["nosniff"],"X-MS-InvokeApp":["1; RequireReadOnly"],"Cache-Control":["max-age=0, private"],"Date":["Thu, 21 Feb 2013 14:15:02 GMT"],"P3P":["CP=\"ALL IND DSP COR ADM CONo CUR CUSo IVAo IVDo PSA PSD TAI TELo OUR SAMo CNT COM INT NAV ONL PHY PRE PUR UNI\""],"Server":["Microsoft-IIS\/7.5"],"WWW-Authenticate":["NTLM"],"X-AspNet-Version":["4.0.30319"],"X-Powered-By":["ASP.NET"]} at Microsoft.Activities.Hosting.Runtime.Subroutine.SubroutineChild.Execute(CodeActivityContext context) in d:\bt\98787\private\source\WF\Microsoft.Activities.Hosting\Microsoft\Activities\Hosting\Runtime\Subroutine.cs:line 282 at System.Activities.CodeActivity.InternalExecute(ActivityInstance instance, ActivityExecutor executor, BookmarkManager bookmarkManager) at System.Activities.Runtime.ActivityExecutor.ExecuteActivityWorkItem.ExecuteBody(ActivityExecutor executor, BookmarkManager bookmarkManager, Location resultLocation)  

Exception occured in scope Microsoft.SharePoint.Utilities.SPUtility.SendEmail. Exception=System.UnauthorizedAccessException: Access is denied. (Exception from HRESULT: 0x80070005 (E_ACCESSDENIED))      
 at Microsoft.SharePoint.SPGlobal.HandleUnauthorizedAccessException(UnauthorizedAccessException ex)      
 at Microsoft.SharePoint.Library.SPRequest.GetUsersDataAsSafeArray(String bstrUrl, UInt32 dwUsersScope, UInt32 dwUserCollectionFlags, String bstrValue, UInt32 dwValue, UInt32& pdwColCount, UInt32& pdwRowCount, Object& pvarDataSet)      
 at Microsoft.SharePoint.SPUserCollection.InitUsersCore(Boolean fCustomUsers, String[] strIdentifiers, SPUserCollectionFlags ucf)      
 at Microsoft.SharePoint.SPBaseCollection.GetEnumerator()      
 at Microsoft.SharePoint.Utilities.SPUtility.ResolveAddressesForEmail(SPWeb web, IEnumerable`1 addresses, AddressReader func)      
 at Microsoft.SharePoint.Utilities.SPUtility.SendEmail_Client(EmailProperties properties)      
 at Microsoft.SharePoint.ServerStub.Utilities.SPUtilityServerStub.InvokeStaticMethod(String methodName, ClientValueCollection xmlargs, ProxyContext proxyContext, Boolean& isVoid)      
 at Microsoft.SharePoint.Client.ServerStub.InvokeStaticMethodWithMonitoredScope(String methodName, ClientValueCollection args, ProxyContext proxyContext, Boolean& isVoid)  

Original error: System.UnauthorizedAccessException: Access is denied. (Exception from HRESULT: 0x80070005 (E_ACCESSDENIED))      
 at Microsoft.SharePoint.SPGlobal.HandleUnauthorizedAccessException(UnauthorizedAccessException ex)      
 at Microsoft.SharePoint.Library.SPRequest.GetUsersDataAsSafeArray(String bstrUrl, UInt32 dwUsersScope, UInt32 dwUserCollectionFlags, String bstrValue, UInt32 dwValue, UInt32& pdwColCount, UInt32& pdwRowCount, Object& pvarDataSet)      
 at Microsoft.SharePoint.SPUserCollection.InitUsersCore(Boolean fCustomUsers, String[] strIdentifiers, SPUserCollectionFlags ucf)      
 at Microsoft.SharePoint.SPBaseCollection.GetEnumerator()      
 at Microsoft.SharePoint.Utilities.SPUtility.ResolveAddressesForEmail(SPWeb web, IEnumerable`1 addresses, AddressReader func)      
 at Microsoft.SharePoint.Utilities.SPUtility.SendEmail_Client(EmailProperties properties)      
 at Microsoft.SharePoint.ServerStub.Utilities.SPUtilityServerStub.InvokeStaticMethod(String methodName, ClientValueCollection xmlargs, ProxyContext proxyContext, Boolean& isVoid)      
 at Microsoft.SharePoint.Client.ServerStub.InvokeStaticMethodWithMonitoredScope(String methodName, ClientValueCollection args, ProxyContext proxyContext, Boolean& isVoid)  

Error occurred while processing the inbound odata webservice call. Ex: System.UnauthorizedAccessException: Access is denied. (Exception from HRESULT: 0x80070005 (E_ACCESSDENIED))      
 at Microsoft.SharePoint.SPGlobal.HandleUnauthorizedAccessException(UnauthorizedAccessException ex)      
 at Microsoft.SharePoint.Library.SPRequest.GetUsersDataAsSafeArray(String bstrUrl, UInt32 dwUsersScope, UInt32 dwUserCollectionFlags, String bstrValue, UInt32 dwValue, UInt32& pdwColCount, UInt32& pdwRowCount, Object& pvarDataSet)      
 at Microsoft.SharePoint.SPUserCollection.InitUsersCore(Boolean fCustomUsers, String[] strIdentifiers, SPUserCollectionFlags ucf)      
 at Microsoft.SharePoint.SPBaseCollection.GetEnumerator()      
 at Microsoft.SharePoint.Utilities.SPUtility.ResolveAddressesForEmail(SPWeb web, IEnumerable`1 addresses, AddressReader func)      
 at Microsoft.SharePoint.Utilities.SPUtility.SendEmail_Client(EmailProperties properties)      
 at Microsoft.SharePoint.ServerStub.Utilities.SPUtilityServerStub.InvokeStaticMethod(String methodName, ClientValueCollection xmlargs, ProxyContext proxyContext, Boolean& isVoid)      
 at Microsoft.SharePoint.Client.ServerStub.InvokeStaticMethodWithMonitoredScope(String methodName, ClientValueCollection args, ProxyContext proxyContext, Boolean& isVoid)  
```

## Resolution  

There are a few solutions to this problem.

- Allow everybody to see the members of the SharePoint group.
- Remove the SharePoint group from the To or CC line of the email.
- Explicitly add the users to the To or CC line if the membership visibility cannot be changed for the SharePoint group.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
