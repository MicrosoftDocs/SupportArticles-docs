---
title: Publishing approval workflow doesn't automatically start
description: A Publishing Approval workflow doesn't start automatically with the error The workflow could not update the item, possibly because one or more columns for the item require a different type of information.
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
  - SharePoint Online
  - SharePoint Server
ms.date: 12/17/2023
---

# Publishing Approval workflow doesn't automatically start in SharePoint Online or in SharePoint Server on-premises

## Problem

A Publishing Approval workflow that uses the Microsoft SharePoint 2010 Workflow platform doesn't start automatically in SharePoint Online or in an on-premises installation of SharePoint Server. On the Workflow Status page, you receive the following error message:

```asciidoc
The workflow could not update the item, possibly because one or more columns for the item require a different type of information.

An error occurred in Page Approval.
```

For the on-premises installation of SharePoint Server, the Unified Logging System (ULS) log contains the following information:

```asciidoc
System.NullReferenceException: Object reference not set to an instance of an object. 
at Microsoft.SharePoint.Workflow.SPWinOEWSSService.GetWebForWorkflow
(SPWorkflow wf, SPWorkflowUserContext runAsUser) 
at Microsoft.SharePoint.Workflow.SPWinOEWSSService.get_Web() 
at Microsoft.SharePoint.Workflow.SPWinOEWSSService.GetWebForListItemService() 
at Microsoft.SharePoint.Workflow.SPWinOEWSSService.UpdateModerationStatus
(Guid id, Guid listId, SPItemKey itemKey, 
SPModerationStatusType newModerationStatus, String comments) 
at Microsoft.Office.Workflow.Actions.SetTaskProcessItemModerationStatus.DoUpdae
(ActivityExecutionContext context) 
at Microsoft.SharePoint.WorkflowActions.WaitForDocumentUnlockActivity.Execute
(ActivityExecutionContext executionContext) 
at Microsoft.Office.Workflow.Actions.SetTaskProcessItemModerationStatus.Execute
(ActivityExecutionContext context) 
at System.Workflow.ComponentModel.ActivityExecutor`1.Execute
(T activity, ActivityExecutionContext executionContext) 
at System.Workflow.ComponentModel.ActivityExecutorOperation.Run
(IWorkflowCoreRuntime workflowCoreRuntime) 
at System.Workflow.Runtime.Scheduler.Run()
```

## Solution

To resolve this issue, use SharePoint Designer 2013 to publish the globally reusable workflow from the root of the site collection. To do this, follow these steps:

1. Use SharePoint Designer 2013 to sign in to the affected site.
1. On the **Site Objects** menu, click **Workflows**.
1. In the list of workflows, click the affected workflow.
1. On the **WORKFLOW SETTINGS** tab on the ribbon, click **Publish**.

## More information

This issue may occur if the user account that created the site collection or that started the Publishing Approval workflow feature was removed from the site collection.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
