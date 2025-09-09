---
title: Status of SharePoint 2013 workflow returns an internal status of Suspended
description: Fixes an issue in which the status of a SharePoint 2013 workflow returns an internal status of Suspended or the workflow doesn't complete when the list workflow is run at the Style Library.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Workflows and Automation\Workflow 2013
  - CSSTroubleshoot
ms.author: meerak
appliesto: 
  - SharePoint Online
  - SharePoint Server 2013
ms.date: 12/17/2023
---

# A SharePoint 2013 workflow in SharePoint Online doesn't complete when the list workflow is run at the Style Library

## Problem

When you run a Microsoft SharePoint 2013 workflow that's associated with the Style Library in Microsoft SharePoint Online, you experience the following behavior:

- The status of the workflow returns an internal status of **Suspended**.
- The workflow doesn't complete.

## Solution/Workaround

To work around this issue, disable automatic updating of the workflow status to the current stage name by following these steps:

1. Open the affected workflow in Microsoft SharePoint Designer 2013.
1. On the Workflow Settings page for the workflow, clear the **Automatically update the workflow status to the current stage name** check box.

   :::image type="content" source="./media/workflow-status-suspended/workflow.png" alt-text="Screenshot that shows the option to uncheck the automatically update option on the Workflow settings page.":::

1. Save the workflow, and then and publish it to the SharePoint website.
1. Run the workflow again.

## More information

This error occurs because the Style Library list requires you to check out items. You expect that the "update status" action within the workflow performs this operation. However, it doesn't.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
