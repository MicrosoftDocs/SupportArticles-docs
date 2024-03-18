---
title: Requested registry access is not allowed error in SharePoint 2013 OOB workflow creation
description: Describes a resolution to a 'Requested registry access is not allowed' error when creating a SharePoint 2013 OOB workflow.
author: helenclu
ms.author: luche
ms.reviewer: 
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: Admin
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
appliesto: 
  - SharePoint Server 2013
ms.date: 12/17/2023
---

# "Requested registry access is not allowed" error in SharePoint 2013 OOB workflow creation

## Symptoms

You see the following error when you attempt to create a new out-of-the-box (OOB) workflow in SharePoint 2013 (Nov2017Cu):

> An unexpected error occurred.

The Unified Logging Service (ULS) will also display the following details (highlighted):

```output
02/06/2019 10:33:12.14 w3wp.exe (Servername:0x0A18) 0x3118 SharePoint Foundation General 8nca Medium Application error when access /_layouts/15/CstWrkflIP.aspx, <mark>Error=Requested registry access is not allowed. at Microsoft.Win32.RegistryKey.OpenSubKey(String name, Boolean writable) at Microsoft.Win32.Registry.GetValue</mark> (String keyName, String valueName, Object defaultValue) at Microsoft.Office.InfoPath.Server.Util.UrlManager.<>c__DisplayClass1.<OpenFileNameMap>b__0() at Microsoft.Office.Server.Security.SecurityContext.RunAsProcess(CodeToRunElevated secureCode) at Microsoft.Office.InfoPath.Server.Util.UrlManager.OpenFileNameMap() at Microsoft.Office.InfoPath.Server.Util.UrlManager..cctor() 4445bd9e-70b9-008f-6bc3-c842222bad98
```

> [!NOTE]
> See the **More information** section for a more complete display of the error in the ULS.

## Cause

The application pool account doesn't have the required permission to create the workflow.

## Resolution

To resolve this issue, try the following steps:

1. Add the application pool account of the web application to the groups WSS_WPG and WSS_Admin_WPG.
2. Apply read access to the following registry keys:

   - `HKEY_LOCAL_MACHINE\SOFTWARE\MICROSOFT\Office Server\15.0`
   - `HKLM\SOFTWARE\Microsoft\Shared Tools\Web Server Extensions\15.0\Secure`

3. Restart the server.

If the issue persists, contact [Microsoft Customer Service and Support](https://support.microsoft.com/contactus/?ws=support).

## More information

A more complete display of the ULS follows:

```output
02/06/2019 10:33:12.03 w3wp.exe (Servername: 0x0A18) 0x3118 SharePoint Foundation Workflow Services aighj Medium Can't find WorkflowServiceProxy or its service application proxy type name is null 4445bd9e-70b9-008f-6bc3-c842222bad98

02/06/2019 10:33:12.14 w3wp.exe (Servername:0x0A18) 0x3118 SharePoint Foundation General 8nca Medium Application error when access /_layouts/15/CstWrkflIP.aspx, <mark>Error=Requested registry access is not allowed. at Microsoft.Win32.RegistryKey.OpenSubKey(String name, Boolean writable) at Microsoft.Win32.Registry.GetValue</mark> (String keyName, String valueName, Object defaultValue) at Microsoft.Office.InfoPath.Server.Util.UrlManager.<>c__DisplayClass1.<OpenFileNameMap>b__0() at Microsoft.Office.Server.Security.SecurityContext.RunAsProcess(CodeToRunElevated secureCode) at Microsoft.Office.InfoPath.Server.Util.UrlManager.OpenFileNameMap() at <mark>Microsoft.Office.InfoPath.Server</mark>.Util.UrlManager..cctor() 4445bd9e-70b9-008f-6bc3-c842222bad98

02/06/2019 10:33:12.14 w3wp.exe (Servername: 0x0A18) 0x3118 SharePoint Foundation Runtime 6616 Critical Requested registry access is not allowed. 4445bd9e-70b9-008f-6bc3-c842222bad98
02/06/2019 10:33:12.14 w3wp.exe (Servername: 0x0A18) 0x3118 SharePoint Foundation General ajlz0 High Getting Error Message for Exception System.TypeInitializationException: The type initializer for 'Microsoft.Office.InfoPath.Server.Util.UrlManager' threw an exception. ---> System.Security.SecurityException: Requested registry access is not allowed. at Microsoft.Win32.RegistryKey.OpenSubKey(String name, Boolean writable) at Microsoft.Win32.Registry.GetValue(String keyName, String valueName, Object defaultValue) at Microsoft.Office.InfoPath.Server.Util.UrlManager.<>c__DisplayClass1.<OpenFileNameMap>b__0() at Microsoft.Office.Server.Security.SecurityContext.RunAsProcess(CodeToRunElevated secureCode) at Microsoft.Office.InfoPath.Server.Util.UrlManager.OpenFileNameMap() at Microsoft.Office.InfoPath.Server.Util.UrlManager..cctor() --- End of inner exception stack trace --- at Microsoft.Office.InfoPath.Server.Util.UrlManager.GetConverterGeneratedFilePath(ConverterGeneratedFile file, Document document) at Microsoft.Office.InfoPath.Server.SolutionLifetime.ScriptIncludes.RenderCssLinksToHeader(Control ctrl, Document document, Boolean ribbonEnabled, Boolean isDisplayMode) at Microsoft.Office.InfoPath.Server.Controls.XmlFormView.TryToAddCssLinksToHeader() at Microsoft.Office.InfoPath.Server.Controls.XmlFormView.OnDataBindHelper() at Microsoft.Office.InfoPath.Server.Controls.XmlFormView.OnDataBinding(EventArgs e) at System.Web.UI.WebControls.WebParts.Part.DataBind() at System.Web.UI.Control.DataBindChildren() at System.Web.UI.Control.DataBind(Boolean raiseOnDataBinding) at System.Web.UI.Control.DataBindChildren() at System.Web.UI.Control.DataBind(Boolean raiseOnDataBinding) at System.Web.UI.Control.DataBindChildren() at System.Web.UI.Control.DataBind(Boolean raiseOnDataBinding) at System.Web.UI.Control.DataBindChildren() at System.Web.UI.Control.DataBind(Boolean raiseOnDataBinding) at System.Web.UI.Control.DataBindChildren() at System.Web.UI.Control.DataBind(Boolean raiseOnDataBinding) at System.Web.UI.Control.DataBindChildren() at System.Web.UI.Control.DataBind(Boolean raiseOnDataBinding) at <mark>Microsoft.Office.Workflow.CstWrkflIPPage.LoadFromWorkflowTemplate(EventArgs ea)</mark> at Microsoft.Office.Workflow.CstWrkflIPPage.OnLoad(EventArgs ea) at System.Web.UI.Control.LoadRecursive() at System.Web.UI.Page.ProcessRequestMain(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint) at System.Web.UI.Page.ProcessRequest(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint) at System.Web.UI.Page.ProcessRequest() at System.Web.UI.Page.ProcessRequest(HttpContext context) at System.Web.HttpApplication.CallHandlerExecutionStep.System.Web.HttpApplication.IExecutionStep.Execute() at System.Web.HttpApplication.ExecuteStep(IExecutionStep step, Boolean& completedSynchronously) 4445bd9e-70b9-008f-6bc3-c842222bad98
```

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
