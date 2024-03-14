---
title: A copied SharePoint Online workflow is linked to the source workflow
description: A SharePoint Online workflow that was copied and pasted from a Workflows Site Object in SharePoint Designer is linked to the source workflow, so when you change or delete one of these workflows, both are changed or removed.
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
  - SharePoint Online
ms.date: 12/17/2023
---

# A SharePoint Online workflow that was copied and pasted from a Workflows Site Object in SharePoint Designer is linked to the source workflow

## Problem

Consider the following scenario:

- You're using SharePoint Designer 2013 with a workflow that's either the SharePoint 2010 or the SharePoint 2013 workflow platform type.
- You highlight a workflow in the **Workflows** section of **Site Objects**, and then you use the Ctrl+C and Ctrl+V keyboard shortcuts to copy and paste a workflow.
- Two workflows now exist in the **Workflows** section of **Site Objects**, and both have the same name.

In this scenario, when you change or delete one of these workflows, both workflows are changed or removed.

## Solution

To resolve this problem, don't copy and paste from the **Workflows** section of **Site Objects** by using keyboard shortcuts on any workflow. If a workflow is a **Reusable Workflow**, use the ribbon to **Copy & Modify** the workflow.

If you're using SharePoint Designer 2013, open the workflow, and then copy and paste the actions from one workflow to another. 

### Remove the linked workflow

To remove the additional linked workflow, follow the steps for the appropriate version of SharePoint.

#### For SharePoint 2010 workflows

Delete the additional .xml file that was created when the workflow was copied and pasted. To do this, follow these steps:

1. Sign in to the affected site by using SharePoint Designer 2013.
1. Click **All Files**, and then click **Workflows**.

   > [!NOTE]
   > Globally Reusable workflows are located in _catalogs/wfpub.

1. Click the affected workflow in the list of workflows.
1. Select the additional .xml file that has a format similar to **wfconfig_copy(1).xml**, and then click **Delete** on the ribbon.

> [!NOTE]
> When you select the .xml file for the workflow, don't click the file name because this opens the **Workflow Settings** page.

#### For SharePoint 2013 workflows

1. Create a blank workflow.
1. Copy the contents of the affected workflow, and then paste the contents to the blank workflow.
1. Delete the original workflow.

For more information about copy-and-paste support of workflow contents in SharePoint Designer 2013, go to [Copy-and-Paste support in SharePoint Designer 2013](/archive/blogs/sharepointdesigner/copy-and-paste-support-in-sharepoint-designer-2013).

## More information

In this scenario, even though it seems that you have created two separate workflows, the workflows are actually the same and are incomplete. This issue occurs because the Ctrl+C and Ctrl+V keyboard shortcuts aren't supported in the **Workflows** section of **Site Objects** for SharePoint workflows. This functionality is available only for a reusable workflow by using the **Copy & Modify** button in the SharePoint Designer ribbon.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).