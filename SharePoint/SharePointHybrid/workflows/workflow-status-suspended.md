---
title: Status of SharePoint 2013 workflow returns an internal status of Suspended
description: Fixes an issue in which the status of a SharePoint 2013 workflow returns an internal status of Suspended or the workflow doesn't complete when the list workflow is run at the Style Library.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- SharePoint Online
- SharePoint Server 2013
---

# A SharePoint 2013 workflow in SharePoint Online doesn't complete when the list workflow is run at the Style Library

## Problem

When you run a Microsoft SharePoint 2013 workflow that's associated with the Style Library in Microsoft SharePoint Online, you experience the following behavior:

- The status of the workflow returns an internal status of **Suspended**.
- The workflow doesn't complete.

## Solution/Workaround

To work around this issue, disable automatic updating of the workflow status to the current stage name. To do this, follow these steps:

1. Open the affected workflow in Microsoft SharePoint Designer 2013.
1. On the Workflow Settings page for the workflow, clear the **Automatically update the workflow status to the current stage name** check box.

   ![Uncheck automatically update option in Workflow settings page](./media/workflow-status-suspended/workflow.png)

1. Save the workflow, and then and publish it to the SharePoint website.
1. Run the workflow again.

## More information

This error occurs because the Style Library list requires you to check out items. You expect that the "update status" action within the workflow will perform this operation. However, it does not.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
