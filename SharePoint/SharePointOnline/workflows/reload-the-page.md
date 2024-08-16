---
title: SharePoint 2013 Workflow Error “To try again, reload the page and then start the workflow”
description: Describes how to troubleshoot an error about Workflows.
author: helenclu
ms.reviewer: salarson
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Workflows and Automation\Workflow 2013
  - CSSTroubleshoot
  - CI 151596
ms.author: luche
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# SharePoint 2013 Workflow Error: "To try again, reload the page and then start the workflow"

## Symptoms

When starting a SharePoint 2013 Workflow, you encounter the following error message displayed in an alert:

> Something went wrong. To try again, reload the page and then start the workflow.

If you select Settings (the gear icon), and then **Site Settings** > **Workflow Settings** > **Workflow Health**, the status shows as suspended:

:::image type="content" source="./media/reload-the-page/workflow-suspended.png" alt-text="Screenshot of the Workflow Health page showing the workflow status as suspended.":::

## Cause

This error occurs if SharePoint 2013 Workflows are in a suspended state for the current SharePoint site because one or more workflows exceed some limits.

## Resolution

You can remove the current SharePoint site's suspension by removing SharePoint 2013 Workflows that have exceeded their limits. Use the Workflow Settings page, or delete workflows using SharePoint Designer.

The cleanup process isn't instant. It takes time and the Workflow Health switches to a **Connected** status when it's done:

:::image type="content" source="./media/reload-the-page/workflow-connected.png" alt-text="Screenshot of the Workflow Health page showing workflow status as connected.":::

We recommend removing SharePoint 2013 Workflows by using the Workflow Settings page.

You can identify the workflows to be removed by using the **ShowScopeDebugInfo()** function.

### How to run the ShowScopeDebugInfo() Function

1. On the site that is having the Workflow problem, select Settings (the gear icon), and then select **Site Settings** > **Workflow Settings** > **Workflow Health**.
    - You can also access Workflow Health from a URL. Example URL: `https://contoso.sharepoint.com/sites/test/_layouts/15/WorkflowServiceHealth.aspx` - in this example, replace *contoso* with your domain, and *test* with the name of the SharePoint site.
1. Open the Developer tools from the browser (Microsoft Edge or Google Chrome is recommended).
    - For Microsoft Edge, press the F12 key to toggle open Developer Tools.
    - For Google Chrome, press Shift+CTRL+J to open Developer Tools.
1. Select **Console**.
1. Type the following function name: *ShowScopeDebugInfo()*
    - After typing *ShowScopeDebugInfo()*, press Enter. It executes a JavaScript function that prints the data in background.
    - **Note** The Workflow Service Health page needs to be refreshed to get updated data from **ShowScopeDebugInfo**. The information returned by **ShowScopeDebugInfo** isn't real time. There's a slight delay until the results are updated.

    :::image type="content" source="./media/reload-the-page/workflow-health.png" alt-text="Screenshot of the Workflow Health page showing workflow status details.":::

    **Sample output:**

    ```output
    {
      "SupportDocument": "https://go.microsoft.com/fwlink/?linkid=847765",
      "ScopePath": "/spo/ec63b09b-9748-47ba-9018-beeadd405204/f19089ae-d6c6-4feb-be0b-ff4de40a04fc/88890858-ae38-407a-b1e7-152c7cff6fe5",
      "WorkflowEndpoint": "spo-dm3-001.workflow.windows.net",
      "WorkflowAppId": "i:0i.t|ms.sp.ext|5958c314-3699-407a-b142-2d459b5161c4@72f988bf-86f1-41af-91ab-2d7cd011db47",
      "IsThrottled": false,
      "ThrottledUntil": "",
      "ActiveMessageCount": "965436",
      "StatusDetails": "MaxTopicSize",
      "ScopeSizeInBytes": "6447069028",
      "MaxScopeSizeInBytes": "6442450944",
      "CorrelationFilterCount": "1851",
      "MaxCorrelationFilterCount": "100000",
      "ScopeUsageInfoAggregatedByWorkflow": [
        {
          "workflowName": "87effe93-5c6a-474d-8a72-0ef451ff0100",
          "workflowDisplayName": "ANewWF",
          "sizeInBytes": 0,
          "correlationFilterCount": 0
        },
        {
          "workflowName": "df26aa85-85a7-4466-a273-1775c9da38bb",
          "workflowDisplayName": "Neat2013ListWorkflow",
          "sizeInBytes": 52591272,
          "correlationFilterCount": 1827
        },
        {
          "workflowName": "fc7a63c5-ff72-42e5-87fd-3f2944f8a6ef",
          "workflowDisplayName": "Spec_Document_Approval",
          "sizeInBytes": 277327,
          "correlationFilterCount": 24
        }
      ]
    }
    ```

1. Take note of **StatusDetails**, in the output. If **MaxTopicSize** and **MaxCorrelationFilter** are present, it indicates the current SharePoint site suspended all SharePoint 2013 workflows. The Workflow Service Health page displays:

    **Workflows are suspended**

1. Once a Workflow or Workflows are removed, a cleanup process is started. You can track the progress by refreshing the Workflow Service Health page and executing the ShowScopeDebugInfo function. **ActiveMessageCount**, **ScopeSizeInBytes**, and **CorrelationFilterCount** will go down, depending on which limit was exceeded.  **ActiveMessageCount** is the slowest and might take days to clear up, but it isn’t blocking. Once the core of the cleanup background job is done, the Workflow Service Health page will no longer display **Workflows are suspended**, and the **StatusDetails** will no longer have a value.

If you can't fix the issue by removing workflows, you might opt to open a support request. If you choose to open a support request, gather some additional information about the workflow health by using the **ShowScopeDebugInfo()** function. For more information about the **ShowScopeDebugInfo()** function, see [Gather SharePoint 2013 Workflow troubleshooting data with ShowScopeDebugInfo](./gather-workflow-data.md).
