---
title: SharePoint workflow timer job is stuck at Pausing
description: Describes an issue in which the SharePoint workflow timer job is stuck in Pausing status because of a bad workflow instance.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - SharePoint Server 2016
  - SharePoint Server 2013
  - SharePoint Server 2010
ms.date: 12/17/2023
---

# SharePoint workflow timer job is stuck at "Pausing"  

## Symptoms  

In SharePoint Central Administration, a workflow timer job shows the status as "Pausing." As a result, you experience the following issues:   

- Approvals of tasks don't complete.
- Workflows can't run after a pause.
- Random processing of workflows occurs.
- Workflows don't function over extended periods of time.

## Cause  

The most likely cause is a bad workflow instance.

## Resolution  

To fix the issue, first determine whether it's caused by a workflow definition that was introduced in the system or by a bad workflow instance. After you verify that, work with the workflow owner to decide whether the workflow can be terminated or deleted.

### Step 1: Restrict servers that run the workflow timer job (optional but highly recommended)  

To diagnose the issue quickly, consider stopping the Microsoft SharePoint Foundation Workflow Timer Service on all servers except one.

### Step 2: Set ULS logging level to VerboseEx  

In the SharePoint Management shell, run the following command:

```powershell
Set-SPLogLevel -TraceSeverity VerboseEx  
```  

**Note** This may cause performance issues on the farm. We recommend that you restrict the duration to the minimum and reset the ULS logging level to the default value after the behavior has been reproduced by using [Clear-SPLogLevel](/powershell/module/sharepoint-server/clear-sploglevel).

If the performance impact prevents full VerboseEx tracing, set the logging level for all categories to **Verbose** and the logging level for "Legacy Workflow Infrastructure" (or "Workflow Infrastructure" in SharePoint 2010) and "Timer" categories to **VerboseEx**. To do this, run the following commands in the SharePoint Management shell:

```powershell
Set-SPLogLevel -TraceSeverity Verbose   
Set-SPLogLevel -TraceSeverity VerboseEx -Identity "Legacy Workflow Infrastructure"  
Set-SPLogLevel -TraceSeverity VerboseEx -Identity "Timer"  
```  

### Step 3: Clear configuration cache  

Clear the configuration cache on all servers where the workflow timer job is stuck and on the servers where Microsoft SharePoint Foundation Workflow Timer Service is started.  

### Step 4: Wait until the issue occurs again and collect ULS logs  

After the configuration cache is cleared, the status of workflow timer job will change from "Pausing" to "Paused" and then "Running." Wait until the issue occurs—it usually takes ten minutes. You may also see that the workflow timer job starts on another server if the job can run on that server.

Check the ULS logs every five minutes to see whether the issue was reproduced, and the timer job is stuck. The issue is displayed in the ULS logs before the timer job status becomes "Pausing." If no new entries for the "Timer Job job-workflow" are created In ULS logs, the timer job is stuck. When this occurs, filter the ULS logs by using the following condition and check the time of the last entry:   

```
 Name  Contains  Timer Job job-workflow
```   

### Step 5: Examine ULS logs  


1. Open ULS logs in ULS Viewer, and then apply the following filters:
   ```   
   Name  Contains  job-workflow  
   EventID  Contains  ahk8y
   ```     
2. Find the last workflow that was being processed. Mostly likely, this is the workflow instance that caused the issue. Here is an example:

   ```
   SharePoint Foundation Legacy Workflow Infrastructure ahk8y Verbose In RunWorkflowElev(), begin processing events for instance: bb7e3f4f-74ac-43f7-a31e-faa7e900843e      8329f59d-0342-20c3-fa1a-56f9161ded9f
   ```       
3. Clear all filters, and then apply the following filter:

   Correlation  Equals  *\<Correlation_ID>*  And  
   Message  Contains proc_GetWorkflowAssociations And  
   [EventID  Contains b6p4  Or  
   EventID  Contains tzkv  ]  

   In the example, the Correlation ID is 8329f59d-0342-20c3-fa1a-56f9161ded9f.     
4. Locate the last occurrences of events **b6p4** and **tzkv**, and then find the ListId, SiteId, ItemId and WebId. Here is an example:

   ```     
   05/25/2017 12:28:43.27 OWSTIMER.EXE (0x9318) 0x6DF0 SharePoint Foundation Database b6p4 VerboseEx SqlCommand: ; EXEC proc_getworkflowassociations '8dd5c889-47a6-4798-93ef-8652609278f4', 'j3952987-5ca6-4eae-8530-13e83acf1bb0', 'e22969ea-f883-4e99-8cbd-4b799a884d2d', 'm82r99b0-ff01-4448-9907-e2cbbbca0586', @contenttypeid, @RequestGuid OUTPUT 8329f59d-0342-20c3-fa1a-56f9161ded9f   
   05/25/2017 12:28:43.27 OWSTIMER.EXE (0x9318) 0x6DF0 SharePoint Foundation Database tzkv Verbose SqlCommand: 'proc_GetWorkflowAssociations' CommandType: StoredProcedure CommandTimeout: 0 Parameter: '@RETURN_VALUE' Type: Int Size: 0 Direction: ReturnValue Value: Parameter: '@SiteId' Type: UniqueIdentifier Size: 0 Direction: Input Value: '8dd5c889-47a6-4798-93ef-8652609278f4' Parameter: '@WebId' Type: UniqueIdentifier Size: 0 Direction: Input Value: 'j3952987-5ca6-4eae-8530-13e83acf1bb0' Parameter: '@Id' Type: UniqueIdentifier Size: 0 Direction: Input Value: 'e22969ea-f883-4e99-8cbd-4b799a884d2d' Parameter: '@ListId' Type: UniqueIdentifier Size: 0 Direction: Input Value: 'm82r99b0-ff01-4448-9907-e2cbbbca0586' Parameter: '@ContentTypeId' Type: VarBinary Size: 512 Direction: Input Value: Parameter: '@RequestGuid' Type: UniqueIdentifier Size: 0 Direction: Input Value: '8329f59d-0342-20c3-fa1a-56f9161ded9f' 8329f59d-0342-20c3-fa1a-56f9161ded9f
   ```     

   In the example, the ListId is *m82r99b0-ff01-4448-9907-e2cbbbca0586*, the SiteId is *8dd5c889-47a6-4798-93ef-8652609278f4*, the ItemId is *e22969ea-f883-4e99-8cbd-4b799a884d2d*, and the WebId is *j3952987-5ca6-4eae-8530-13e83acf1bb0*.       

### Step 6: Identify the workflow  

In the SharePoint Management shell, run the following commands to find the web URL and the list title:

```   
 $web= (Get-SPSite -Identity <SiteId> |Get-SPWeb -Identity <WebId>)   
 $list = $web.Lists.GetList("<ListId>", $true)  
 $list.ParentWeb   
 $list.Title
```

**Note** *SiteId*, *WebId*, and *ListId* are placeholders for the SiteId, WebId, and ListId that were found in Step 5.

Go to the list and find the item by using ItemId. You can also create a temporary view on the list and filter it by ITEMID. The problematic workflow is associated with the item. Go to the workflow setting of the item. If the item has multiple workflows running on it, click the **status** column of the problematic workflow to view the workflow history page.   

### Step 7: Terminate the workflow  

Examine the workflow history to identify what is wrong. Then you can terminate the workflow or delete the item.

Sometimes you may not identify the workflow or item in Step 6. In such cases, make sure that you are viewing the correct list and inspect all other pieces of data. Also check recycle bins.

If you still can't find the item or workflow, it is possible that the item was deleted but the workflow instance is still running. In this case, run the following commands in SharePoint Management Shell to cancel the workflow:   

```  
$web = Get-SPWeb <WebURL>  
```  

```  
#Pass the workflow Instance Id from the ahk8y event  
$WorkflowInstanceID = <WorkflowInstanceID>  
$workflowId =  [GUID]$WorkflowInstanceID  
$workflow = New-Object Microsoft.SharePoint.Workflow.SPWorkflow($web, $workflowId);  
[Microsoft.SharePoint.Workflow.SPWorkflowManager]::CancelWorkflow($workflow)
```

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).