---
title: 800703fa Illegal operation attempted on a registry key that has been marked for deletion error in SharePoint
description: Discusses an issue in which you receive a 800703fa Illegal operation attempted on a registry key that has been marked for deletion error message in SharePoint 2013 or SharePoint 2010. Provides a resolution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto: 
  - SharePoint Server 2013
  - SharePoint Server 2010
ms.date: 12/17/2023
---

# "800703fa Illegal operation attempted on a registry key" error

## Symptom

An operation in Microsoft SharePoint 2013 or Microsoft SharePoint 2010 fails, and you see the following COMException error message logged in ULS in SharePoint LogViewer:  

```
[System.Runtime.InteropServices.COMException (0x800703FA): Retrieving the COM class factory for component with CLSID {<GUID>} failed due to the following error: 800703fa Illegal operation attempted on a registry key that has been marked for deletion.  
```

This error may occur in several different scenarios. For example, this error may occur in scenarios in which you see the following log entries:  

```
11/03/2015 20:09:45.83 w3wp.exe (0x1A24) 0x46CC SharePoint Portal Server Microfeeds ada0j Unexpected
MicroBlogList.GetMicroBlogPostsForRePopulation http://mysite/personal/12345 permanent failure
Exception:
[System.Runtime.InteropServices.COMException (0x800703FA): Retrieving the COM class factory for component with CLSID
{BDEADF26-C265-11D0-BCED-00A0C90AB50F} failed due to the following error: 800703fa Illegal operation attempted on a registry key that has been marked for deletion. (Exception from HRESULT: 0x800703FA).
at Microsoft.SharePoint.Library.SPRequest..ctor()
at Microsoft.SharePoint.SPGlobal.CreateSPRequestAndSetIdentity(...)
at Microsoft.SharePoint.SPRequestManager.GetContextRequest(SPRequestAuthenticationMode authenticationMode)
at Microsoft.SharePoint.Administration.SPFarm.get_RequestAny()
at Microsoft.SharePoint.SPSecurity.GetCurrentUserTokenNoApplicationPrincipalDelegated(SPWebApplication webApp, Uri siteUrl)
at Microsoft.SharePoint.SPSecurity.GetCurrentUserToken()
at Microsoft.SharePoint.SPSecurity.EnsureOriginatingUserToken()
at Microsoft.SharePoint.SPSecurity.RunWithElevatedPrivileges(WaitCallback secureCode, Object param)
at Microsoft.SharePoint.SPSecurity.RunWithElevatedPrivileges(CodeToRunElevated secureCode)
at Microsoft.Office.Server.UserProfiles.SPS2SAppContext.GetClientContext(...)
at Microsoft.Office.Server.UserProfiles.SPS2SAppExecutionContextBase.get_ClientContext()
at Microsoft.Office.Server.Microfeed.SPMicrofeedStore.Query(...)
at Microsoft.Office.Server.Microfeed.MicroBlogList.ExecuteRepopulationCamlQuery(...)
at Microsoft.Office.Server.Microfeed.MicroBlogList.GetMicroBlogPostsForRePopulation...)]
```

```
Handling an exception. Exception details: System.Runtime.InteropServices.COMException (0x800703FA): Retrieving the COM class factory for component with CLSID {BDEADF26-C265-11D0-BCED-00A0C90AB50F} failed due to the following error: 800703fa Illegal operation attempted on a registry key that has been marked for deletion. (Exception from HRESULT: 0x800703FA).  
at Microsoft.SharePoint.Library.SPRequest..ctor()  
at Microsoft.SharePoint.SPGlobal.CreateSPRequestAndSetIdentity(...)  
at Microsoft.SharePoint.SPRequestManager.GetContextRequest(SPRequestAuthenticationMode authenticationMode)  
at Microsoft.SharePoint.Administration.SPFarm.get_RequestAuthAny()  
at Microsoft.SharePoint.Administration.SPAcl`1.CalculatePermissions()  
at Microsoft.SharePoint.Administration.SPIisWebServiceApplication.CheckAccess(SPIisWebServiceApplicationRights rights)  
at Microsoft.SharePoint.Taxonomy.MetadataWebServiceApplication.DoesUserHavePermissions(...)  
at Microsoft.SharePoint.Taxonomy.MetadataWebServiceApplication.GetChangedTermSets(...)  
at SyncInvokeGetChangedTermSets(Object , Object[] , Object[] )  
at System.ServiceModel.Dispatcher.SyncMethodInvoker.Invoke(Object instance, Object[] inputs, Object[]& outputs)  
at System.ServiceModel.Dispatcher.DispatchOperationRuntime.InvokeBegin(MessageRpc& rpc)  
at System.ServiceModel.Dispatcher.ImmutableDispatchRuntime.ProcessMessage5(MessageRpc& rpc)  
at System.ServiceModel.Dispatcher.ImmutableDispatchRuntime.ProcessMessage31(MessageRpc& rpc)  
at System.ServiceModel.Dispatcher.MessageRpc.Process(Boolean isOperationContextSet)
```

## Cause

This problem typically occurs after an administrator uses a service account to log on to the server for an interactive session, and then logs off. For example, an administrator may log on to a Web Front End (WFE) server by using the farm account, and then log off. This activity forces the registry keys to be unloaded in the profile of that account. This condition makes the keys unavailable for future use.  

## Resolution

To resolve this problem, use either of the following methods.  

### Method 1

Do not log on to the server for interactive sessions by using a service account.  

### Method 2

Disable the related Windows User Profile Service feature. To do this, follow these steps:  

1. Open the Group Policy editor (Gpedit.msc) on the affected server.
2. Open the UserProfiles folder in the following path:  

   **Computer Configuration** > **Administrative Templates** > **System** > **UserProfiles**

3. Locate the **Do not forcefully unload the user registry at user logoff** setting.
4. Change the setting to **Enabled**.

## More Information

For more information, see the following MSDN Distributed Services Support Team Blog article:  

[A COM+ application may stop working on Windows Server 2008 when the identity user logs off](https://softnovation.wordpress.com/2015/06/18/a-com-application-may-stop-working-on-windows-server-2008-when-the-identity-user-logs-off/)

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
