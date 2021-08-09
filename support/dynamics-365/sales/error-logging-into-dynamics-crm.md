---
title: Error logging into Microsoft Dynamics CRM
description: Fix an issue in which you get can't log into Microsoft Dynamics CRM.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# "An error has occurred. Try this action again" error occurs when logging into Microsoft Dynamics CRM

This article helps you fix an issue in which you get can't log into Microsoft Dynamics CRM.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2016  
_Original KB number:_ &nbsp; 4467365

## SymptomsS

When logging into Microsoft Dynamics CRM, the following error is presented to the user.

> An error has occurred.  
> Try this action again. If the problem continues, check the Microsoft Dynamics CRM Community for solutions or contact your organization's Microsoft Dynamics CRM Administrator. Finally, you can contact Microsoft Support.

Enabling platform tracing and reviewing the trace logs after reproducing the error, administrators will see the following logged.

> Process: w3wp |Organization:00000000-0000-0000-0000-000000000000 |Thread:   19 |Category: Application |User: 00000000-0000-0000-0000-000000000000 |Level: Error |ReqId: \<ReqId> |ActivityId: \<ActivityId> | HttpApplication.RecordError  ilOffset = 0x41  
    at HttpApplication.RecordError(Exception error)  ilOffset = 0x41  
    at PipelineStepManager.ResumeSteps(Exception error)  ilOffset = 0xEE  
    at HttpApplication.BeginProcessRequestNotification(HttpContext context, AsyncCallback cb)  ilOffset = 0x31  
    at HttpRuntime.ProcessRequestNotificationPrivate(IIS7WorkerRequest wr, HttpContext context)  ilOffset = 0xB0  
    at PipelineRuntime.ProcessRequestNotificationHelper(IntPtr rootedObjectsPointer, IntPtr nativeRequestContext, IntPtr moduleData, Int32 flags)  ilOffset = 0x131  
    at PipelineRuntime.ProcessRequestNotification(IntPtr rootedObjectsPointer, IntPtr nativeRequestContext, IntPtr moduleData, Int32 flags)  ilOffset = 0x0  
    at UnsafeIISMethods.MgdIndicateCompletion(IntPtr pHandler, RequestNotificationStatus& notificationStatus)  ilOffset = 0xFFFFFFFF  
    at UnsafeIISMethods.MgdIndicateCompletion(IntPtr pHandler, RequestNotificationStatus& notificationStatus)  ilOffset = 0xFFFFFFFF  
    at PipelineRuntime.ProcessRequestNotificationHelper(IntPtr rootedObjectsPointer, IntPtr nativeRequestContext, IntPtr moduleData, Int32 flags)  ilOffset = 0x1E7  
    at PipelineRuntime.ProcessRequestNotification(IntPtr rootedObjectsPointer, IntPtr nativeRequestContext, IntPtr moduleData, Int32 flags)  ilOffset = 0x0  
> \>Request `https://ServerName.domain.com/CrmOrganizationName/default.aspx` failed with exception System.NullReferenceException: Object reference not set to an instance of an object.  
   at Microsoft.Crm.Application.Utility.Util.GetConfigurableThemeStyleParameters()  
   at Microsoft.Crm.Application.Utility.Util.GetConfigurableThemeStyleSheetUrl()  
   at Microsoft.Crm.Controls.Header..ctor(Boolean isControlHeader)  
   at Microsoft.Crm.Controls.BasicHeader..ctor()  
   at Microsoft.Crm.Application.Controls.AppHeader..ctor()  
   at ASP.default_aspx.__BuildControlcrmHeader()  
   at ASP.default_aspx.__BuildControlTree(default_aspx __ctrl)  
   at ASP.default_aspx.FrameworkInitialize()  
   at System.Web.UI.Page.ProcessRequest(Boolean includeStagesBeforeAsyncPoint, Boolean includeStagesAfterAsyncPoint)  
   at System.Web.UI.Page.ProcessRequest()  
   at System.Web.UI.Page.ProcessRequest(HttpContext context)  
   at System.Web.HttpApplication.CallHandlerExecutionStep.System.Web.HttpApplication.IExecutionStep.Execute()  
   at System.Web.HttpApplication.ExecuteStepImpl(IExecutionStep step)  
   at System.Web.HttpApplication.ExecuteStep(IExecutionStep step, Boolean& completedSynchronously)

## Cause

One possible cause for this error is that the `OrganizationBase` table in the `OrgName_MSCRM` database is missing theme information from the `DefaultThemeData` and the `HighContrastThemeData` columns.

Administrators can confirm this by running the following SQL query.

```sql
Select DefaultThemeData, HighContrastThemeData from OrganizationBase
```

If one or both of the above columns are blank, this is more than likely the cause of the problem.

A similar error may occur if the `ThemeBase` table is empty.

## Resolution

To resolve the error, SQL Server administrators must update the `OrganizationBase` table so that it reflects the default and/or high contrast theme information.

The following query will update the `OrganizationBase` table with the default out of the box theme data.

```sql
Update OrganizationBase set DefaultThemeData = 
'<theme themeId="f499443d-2082-4938-8842-e7ee62de9a23" updateTimeStamp="636054720539124867">
 <globallinkcolor>#1160B7</globallinkcolor>
 <selectedlinkeffect>#B1D6F0</selectedlinkeffect>
 <hoverlinkeffect>#D7EBF9</hoverlinkeffect>
 <navbarbackgroundcolor>#002050</navbarbackgroundcolor>
 <navbarshelfcolor>#DFE2E8</navbarshelfcolor>
 <headercolor>#1160B7</headercolor>
 <controlshade>#F3F1F1</controlshade>
 <controlborder>#CCCCCC</controlborder>
 <processcontrolcolor>#D24726</processcontrolcolor>
 <defaultentitycolor>#001CA5</defaultentitycolor>
 <defaultcustomentitycolor>#006551</defaultcustomentitycolor>
 <backgroundcolor>#FFFFFF</backgroundcolor>
 <logoid/>
 <logotooltip>Microsoft Dynamics CRM</logotooltip>
</theme>'

Update OrganizationBase set HighContrastThemeData =
'<theme themeId="f499443d-2082-4938-8842-e7ee62de9a23" updateTimeStamp="636054720539124867">
 <globallinkcolor>#1160B7</globallinkcolor>
 <selectedlinkeffect>#B1D6F0</selectedlinkeffect>
 <hoverlinkeffect>#D7EBF9</hoverlinkeffect>
 <navbarbackgroundcolor>#002050</navbarbackgroundcolor>
 <navbarshelfcolor>#DFE2E8</navbarshelfcolor>
 <headercolor>#1160B7</headercolor>
 <controlshade>#F3F1F1</controlshade>
 <controlborder>#CCCCCC</controlborder>
 <processcontrolcolor>#D24726</processcontrolcolor>
 <defaultentitycolor>#001CA5</defaultentitycolor>
 <defaultcustomentitycolor>#006551</defaultcustomentitycolor>
 <backgroundcolor>#FFFFFF</backgroundcolor>
 <logoid/>
 <logotooltip>Microsoft Dynamics CRM</logotooltip>
</theme>'
```

> [!NOTE]
> The above themeid's in both SQL update statements are not unique to your organization. These are the default ID's for any out of the box Microsoft Dynamics CRM themes.
