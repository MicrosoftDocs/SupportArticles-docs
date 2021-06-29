---
title: Gather SharePoint 2013 Workflow troubleshooting data with ShowScopeDebugInfo
description: Describes how to get troubleshooting information about Workflows.
author: salarson
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.custom: 
- CSSTroubleshoot
- CI 151719
ms.author: v-matham
appliesto:
- SharePoint Online
---

# Gather SharePoint 2013 Workflow troubleshooting data with ShowScopeDebugInfo


The ShowScopeDebugInfo() function provides an easier way to troubleshoot common problems with SharePoint 2013 Workflows, and provide support agents additional information if you are having issues with Workflows.

## How to run the ShowScopeDebugInfo() Function

1. On the site that is having the Workflow problem, select Settings (the gear icon), and then select **Site Settings** > **Workflow Settings** > **Workflow Health**.
    - You can also access Workflow Health from a URL. Example URL: `https://contoso.sharepoint.com/sites/test/_layouts/15/WorkflowServiceHealth.aspx` - in this example, replace *contoso* with your domain, and *test* with the name of the SharePoint site.
1. Open the Developer tools from the browser (Edge or Google Chrome is recommended).
    - For Microsoft Edge, press the F12 key.
    - For Google Chrome, press Shift + CTRL + J.

1. Select **Console**.
1. Type the following function name: *ShowScopeDebugInfo()*
    - After typing *ShowScopeDebugInfo()* press Enter, and it will execute a JavaScript function which prints the data in background.
    - **Note**: The Workflow Service Health page will need to be refreshed to get updated data from ShowScopeDebugInfo. The information returned by ShowScopeDebugInfo is not real time. There is a slight delay until the results are updated.

**Sample output**:
```
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

## How to read the results

<table>
<tr><th>Label</th><th>Definition</th></tr>
<tr><td><b>SupportDocument</b></td><td>SharePoint 2013 Workflow public documentation to help workflow authors avoid common problematic Workflow designs and common errors.</td></tr>
<tr><td><b>ScopePath</b></td><td>Required information to engage SharePoint 2013 Workflow feature owners.</td></tr>
<tr><td><b>WorkflowEndpoint</b></td><td>Required information to engage SharePoint 2013 Workflow feature owners.</td></tr>
<tr><td><b>WorkflowAppId</b></td><td>Required information to engage SharePoint 2013 Workflow feature owners.</td></tr>
<tr><td><b>IsThrottled</b></td><td>Indicates if the Azure Workflow Service is throttling the current SharePoint site's SharePoint 2013 workflows. Throttling is per SharePoint site, and is evaluated every 10-minutes. If all the SharePoint 2013 Workflow instances exceed the dynamic throttling limit, the Azure Workflow Service will throttle all SharePoint 2013 Workflow instances for a minimum of 5 minutes, and Workflow Instances will resume during the next 10-minute processing window.</td></tr>
<tr><td><b>ThrottledUntil</b></td><td>If <b>IsThrottled</b> is true, then <b>ThrottledUntil</b> will contain a UTC date and time to indicate when the throttling will expire.</td></tr>
<tr><td><b>ActiveMessageCount</b></td><td>Represents the ServiceBus Subscription <a href="https://docs.microsoft.com/azure/service-bus-messaging/message-counters">ActiveMessageCount</a>. As SharePoint 2013 Workflow instances are initiated, Messages are queued in Azure ServiceBus and these Messages are processed by the Azure Workflow Service backend. If SharePoint 2013 Workflow instances are processing slowly, it’s frequently due to throttling and/or a large Azure ServiceBus queue, as indicated by the ActiveMessageCount.</td></tr>
<tr><td><b>StatusDetails</b></td><td>Indicates the reason the current SharePoint site's SharePoint 2013 Workflows are not progressing and why it isn’t possible to start SharePoint 2013 Workflow instances manually or automatically. Currently <b>MaxTopicSize</b> and <b>MaxCorrelationFilter</b> are included to indicate which limit was exceeded.</td></tr>
<tr><td><b>ScopeSizeInBytes</b></td><td>Represents a SharePoint site's SharePoint 2013 Workflow storage in the Azure Workflow Service. The Azure Workflow Service uses Azure Service Bus and Azure SQL to enable SharePoint 2013 Workflows. Each SharePoint site is allocated 6 GB. The Azure Workflow Service is the cloud version of the on-premise Workflow Manager. If <b>ScopeSizeInBytes</b> exceeded <b>MaxScopeSizeInBytes</b> the <b>StatusDetails</b> will indicate <b>MaxTopicSize</b>. This means the limit was exceeded and SharePoint 2013 Workflow instances won’t start when triggered manually or by creating and editing data in SharePoint Online. It's possible to figure out which SharePoint 2013 Workflow is using the most space by examining <b>ScopeUsageInfoAggregatedByWorkflow</b>. <b>ScopeUsageInfoAggregatedByWorkflow</b> isn't real time but relatively up to date. Each SharePoint 2013 Workflow contains <b>sizeInBytes</b> and could be used as a guide for identifying which SharePoint 2013 Workflow to remove from a SharePoint List or Library. By removing a SharePoint 2013 Workflow from a List or Library's <b>Workflow Settings</b> page, a cleanup process is initiated, and once completed, the SharePoint site's Workflow will resume processing. The <b>StatusDetails</b> column will no longer contain <b>MaxTopicSize</b> and <b>copeSizeInBytes</b> will be smaller than <b>MaxScopeSizeInBytes</b>. It will be possible to start SharePoint 2013 Workflows.</td></tr>
<tr><td><b>MaxScopeSizeInBytes</b></td><td>Represents the maximum storage allocated in Azure Workflow Service for the current SharePoint site.</td></tr>
<tr><td><b>CorrelationFilterCount</b></td><td>Represents the Azure Workflow Service current usage of Azure ServiceBus <a href="https://docs.microsoft.com/azure/service-bus-messaging/topic-filters">Correlation Filters</a>. When a simple SharePoint 2013 Workflow is started manually or by creating or editing data in SharePoint Online, 2 Correlation Filters are used, per Workflow Instance. As a SharePoint 2013 Workflow becomes more complex, more Correlation Filters are used. Actions like <i>Wait for Field to Change</i> or <i>Wait for Change in List</i> use up Correlation Filters.

<b>MaxCorrelationFilterCount</b> represents the maximum Correlation Filter limit at 100,000. If the simplest SharePoint 2013 Workflow is created, that means there is a maximum of 50,000 active Workflow instances per SharePoint site. However, it's unlikely you can reach 50,000 Workflow instances since most Workflows use more than the default 2 Correlation Filters necessary to start a Workflow instance. Once a Workflow instance completes, the Correlation Filter count is decreased making room for more Workflow Instances. 

If <b>CorrelationFilterCount</b> is greater than <b>MaxCorrelationFilterCount</b>, the <b>StatusDetails</b> will contain **MaxCorrelationFilter**. It won’t be possible to start Workflow instances. The same behavior described in **ScopeSizeInBytes** will happen when **CorrelationFilterCount** exceeds **MaxCorrelationFilterCount**. Also, the same solution is possible. Use the **ScopeUsageInfoAggregatedByWorkflow** and find the Workflow with the highest **correlationFilterCount** and consider removing it from the SharePoint List or Library, using the **Workflow Settings** page. If a SharePoint 2013 Workflow is deleted using SharePoint Designer, it will delete the Workflow logic and the Workflow will need to be recreated. It’s best to remove the Workflow using the **Workflows Settings** page and then adjust the Workflow logic based on the recommendations found [here](https://go.microsoft.com/fwlink/?linkid=847765).</td></tr>
<tr><td><b>MaxCorrelationFilterCount</b></td><td>Represents the Correlation Filter count allocated in Azure Workflow Service for the current SharePoint site.</td></tr>
<tr><td><b>ScopeUsageInfoAggregatedByWorkflow</b></td><td>Contains the current SharePoint site's SharePoint 2013 Workflows. Each Workflow contains the following data: workflowName, workflowDisplayName, sizeInBytes, and correlationFilterCount. The data in <b>ScopeUsageInfoAggregatedByWorkflow</b> isn't updated in real time. It’s a snapshot that is frequently updated.

<b>workflowName</b> maps to the <a href="https://docs.microsoft.com/dotnet/api/microsoft.sharepoint.workflowservices.workflowsubscription.id">WorkflowSubscription.Id</a>.

<b>workflowDisplayName</b> maps to <a href="https://docs.microsoft.com/dotnet/api/microsoft.sharepoint.workflowservices.workflowsubscription.name">WorkflowSubscription.Name</a>.  This is the SharePoint 2013 Workflow's name in the SharePoint UX. This name can be different from the one found in SharePoint Designer.

<b>sizeInBytes</b> is the Workflows storage usage, which is aggregated into <b>ScopeSizeInBytes</b>.

<b>correlationFilterCount</b> is the Workflows Correlation Filter usage, which is aggregated into <b>CorrelationFilterCount</b>.</td></tr></table>