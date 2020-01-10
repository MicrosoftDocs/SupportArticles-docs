---
title: Office Web Apps 2013 and VMWare
description: This article describes some issues that occur occur when installing Office Web Apps 2013 or Office Online Server on a nonsystem Drive by using VMWare, and provide solutions.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: arhinesm
ms.custom: CSSTroubleshoot
appliesto:
- Office Online Server
---

# Office Web Apps 2013 and VMWare

This article was written by [Tom Schauer](https://social.technet.microsoft.com/profile/Tom+Schauer+-+MSFT), Technical Specialist.

Several issues occur when installing Office Web Apps 2013 or Office Online Server on a nonsystem Drive by using VMWare. The problem lies in setting the Office Web Apps CacheLocation or RenderingCacheLocation to a nonsystem drive location with the HotAdd/HotPlug capability in VMWare.

There are numerous possible symptoms for this issue, most visibly when viewing/editing documents. For example, you might see the following error in the SharePoint Unified Logging Service (ULS) logs.

Here is one example (with the ULS entry) of the unusual behavior you are seeing:

**"Microsoft Word Web App"**

**"Sorry, there was a problem and we can't open this document.  If this happens again, try opening the document in Microsoft Word."**

![word-web-app-error](./media/office-web-apps-and-vmware/error-message-dialog.jpg)

Here is an example of what you are seeing in the ULS logs:

```adoc
03/14/2014 14:02:40.53 w3wp.exe (UTMSSP01:0x1620) 0x0BB8 SharePoint Foundation General ai1wu Medium System.IO.FileNotFoundException: The system cannot find the file specified. (Exception from HRESULT: 0x80070002), StackTrace:    at Microsoft.SharePoint.SPWeb.GetList(String strUrl)     at Microsoft.SharePoint.SPWeb.get_SiteAssetsLibrary()     at Microsoft.SharePoint.Utilities.SPWOPIHost.GetHomeUrlForFile(SPFile file, Boolean isAttachment)     at Microsoft.SharePoint.SoapServer.Wopi.RunCheckFile(HttpContext context, CommonRequestData requestData, CommonResponseData responseData)     at Microsoft.SharePoint.SoapServer.Wopi.ProcessRequestCore(HttpContext context, CommonRequestData requestData, CommonResponseData responseData)     at Microsoft.SharePoint.SoapServer.Wopi.ProcessRequest(HttpContext context)     at System.Web.HttpApplication.CallHandlerExecutionStep.System.Web.HttpApplication.IExecutionStep.Execute()     at System.Web.HttpApplication.ExecuteStep(IExecutionStep step, Boolean& completedSynchronously)     at System.Web.HttpApplication.PipelineStepManager.ResumeSteps(Exception error)     at System.Web.HttpApplication.BeginProcessRequestNotification(HttpContext context, AsyncCallback cb)     at System.Web.HttpRuntime.ProcessRequestNotificationPrivate(IIS7WorkerRequest wr, HttpContext context)     at System.Web.Hosting.PipelineRuntime.ProcessRequestNotificationHelper(IntPtr rootedObjectsPointer, IntPtr nativeRequestContext, IntPtr moduleData, Int32 flags)     at System.Web.Hosting.PipelineRuntime.ProcessRequestNotification(IntPtr rootedObjectsPointer, IntPtr nativeRequestContext, IntPtr moduleData, Int32 flags)     at System.Web.Hosting.UnsafeIISMethods.MgdIndicateCompletion(IntPtr pHandler, RequestNotificationStatus& notificationStatus)     at System.Web.Hosting.UnsafeIISMethods.MgdIndicateCompletion(IntPtr pHandler, RequestNotificationStatus& notificationStatus)     at System.Web.Hosting.PipelineRuntime.ProcessRequestNotificationHelper(IntPtr rootedObjectsPointer, IntPtr nativeRequestContext, IntPtr moduleData, Int32 flags)     at System.Web.Hosting.PipelineRuntime.ProcessRequestNotification(IntPtr rootedObjectsPointer, IntPtr nativeRequestContext, IntPtr moduleData, Int32 flags) 33bd837e-42a2-4d46-89cf-e992045d4964
```

## Resolution

The most reliable resolution is to uninstall Office Web Apps or Office Online Server, then reinstall (on the drive C), apply updates and rebuild the farm.

You can also use the method that is provided in the following article to work around the issue:

[Disabling the HotAdd/HotPlug capability in ESXi 5.x and ESXi/ESX 4.x virtual machines (1012225)](https://kb.vmware.com/selfservice/microsites/search.do?cmd=displayKC&docType=kc&docTypeID=DT_KB_1_1&externalId=1012225)


