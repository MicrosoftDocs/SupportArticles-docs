---
title: Unable to delete completed SharePoint 2013 workflow tasks
description: Fixes an issue in which you can't delete a completed workflow that uses the SharePoint 2013 Workflow Platform Type and uses workflow tasks.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Workflows and Automation\Workflow 2013
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
  - SharePoint Server
ms.date: 12/17/2023
---

# Completed tasks aren't deleted for a workflow using the SharePoint 2013 Workflow Platform Type

## Problem

Consider the following scenario:

- In SharePoint Online or SharePoint Server, you have a workflow that uses the SharePoint 2013 Workflow Platform Type.
- The workflow uses the **Assign a Task** or **Start a task** action.

However, after the workflow is completed, the completed task isn't deleted as expected.

## Solution

This is the expected behavior for workflows that use the SharePoint 2013 Workflow Platform Type. Completed workflow tasks aren't deleted. Incomplete workflow tasks are deleted by default unless you change the **PreserveIncompleteTasks** setting to **Yes** for the properties of the task in SharePoint Designer 2013. Workflows that use the SharePoint 2010 Workflow Platform Type delete both completed and incomplete tasks by default.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
