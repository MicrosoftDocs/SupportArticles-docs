---
title: SharePoint Designer 2013 shows empty wfpub library
description: You can't add a globally reusable workflow (such as Approval - SharePoint 2010) to a SharePoint list or library, and the wfpub library is empty.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - SharePoint Designer 2013
ms.date: 12/17/2023
---

# SharePoint Designer 2013 shows empty wfpub library  

## Symptoms  

In a Microsoft SharePoint site collection, you can't add a globally reusable workflow (such as "Approval - SharePoint 2010") to a list or library. 

Deactivating and then reactivating the site collection feature **Workflows** doesn't resolve the issue. Additionally, you see that the wfpub library is empty and the wfpub icon may be a regular folder icon instead of a catalog icon when you follow these steps:   

1. Open the root website of the site collection in SharePoint Designer 2013.
2. Under **Site Objects**, select **All Files** > **_catalogs** > **wfpub**.   
   :::image type="content" source="media/shows-empty-wfpub-library/wfpub-folder.png" alt-text="Screenshot of the wfpub folder under SharePoint site objects." border="false":::       

## Resolution  

To resolve this issue, follow these steps:    

1. Open the root website of the site collection in SharePoint Designer 2013.    
2. Under **Site Objects**, select **Workflows**.    
3. In the **New** section of the **Workflows** ribbon, select **Reusable Workflow**.    
4. On the **Create Reusable Workflow** form, enter the name **Repair2010**. For **Platform Type**, select **SharePoint 2010 Workflow**, and then select **OK**.   
   :::image type="content" source="media/shows-empty-wfpub-library/create-reusable-workflow.png" alt-text="Screenshot of the Create Reusable Workflow form when Workflow name is set to Repair2010 and Platform Type is set to SharePoint 2010 Workflow.":::     
5. Add a single "Log to history list" action to "Step 1" of the workflow.
   
   :::image type="content" source="media/shows-empty-wfpub-library/log-to-history-list.png" alt-text="Screenshot shows Log your workflow name to the workflow history list is added under Step 1.":::     
1. In the **Save** section of the **Workflow** ribbon, select **Publish**.    
1. In the **Manage** section of the **Workflow** ribbon, select **Publish Globally**. In the confirmation dialog box that appears, select **OK**.    
1. In a web browser, locate the root website of the site collection, and then access **Site Settings **> **Site Collection Features**. Then, toggle the **Workflows** feature:
   - If the feature is Activated, click **Deactivate**. Then, select **Activate**.     
   - If the feature is Deactivated, select **Activate**.       

The issue is now resolved. You can safely remove the Repair2010 workflow from the site collection through SharePoint Designer 2013: Open the site collection in SharePoint Designer, go to **Site Objects** > **Workflows**, select **Repair2010**, and then select **Delete**.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
