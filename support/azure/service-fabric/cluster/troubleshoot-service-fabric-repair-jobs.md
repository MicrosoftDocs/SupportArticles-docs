---
title: Troubleshoot repair jobs that aren't approved by using Service Fabric Explorer
description: This article provides guidance on troubleshooting repair jobs that aren't being approved in a Service Fabric cluster using Service Fabric Explorer (SFX). It explains the concepts of repair tasks and repair jobs, their states, and how to analyze them through SFX.
ms.topic: troubleshooting-general
ms.author: jarrettr
ms.reviewer: ashukumar, v-ryanberg
ms.editor: v-gsitser
ms.service: azure-service-fabric
services: service-fabric
ms.date: 01/20/2026
# Customer intent: As a Service Fabric customer, I want to analyze the reason why a repair job is stuck using Service Fabric Explorer.
---

# Troubleshoot repair jobs that aren't approved by using Service Fabric Explorer

## Summary

This article provides guidance on troubleshooting repair jobs that aren't approved in an Azure Service Fabric cluster by using Service Fabric Explorer (SFX). It explains the concepts of repair tasks and repair jobs, their states, and how to analyze them by using SFX.

## Repair task overview 

Service Fabric processes any operation initiated from the scale set that targets virtual machines (VMs) as a repair task derived from the job it receives. The Infrastructure Service creates a repair task for each job and adds details like the update type, targeted update domain (UD), and document incarnation number. These jobs start with UD0 and progress sequentially through UD1, UD2, and so on within the Service Fabric cluster. If a domain update is required, the Infrastructure Service generates separate repair tasks for each UD. For example, in a cluster with five UDs, the Infrastructure Service creates five distinct repair tasks. These tasks run one after another, UD by UD, and you can track their progress in SFX. 

- **Repair Manager** - Defines and implements a safe workflow for performing repairs by coordinating between the Repair Requestor, Repair Executor, and itself to ensure safe and consistent repair actions. 

- **Infrastructure Service** –  Responsible for managing and orchestrating infrastructure-level operations, like updates and repairs, ensuring the health and stability of the Service Fabric cluster.

### Repair job and repair task  

A repair job refers to an Azure‑initiated maintenance operation that provides essential details like the job ID, repair type, targeted update domain, document incarnation number, node‑impact information, and additional metadata. Service Fabric then creates a repair task by combining details including: 

- *Repair type*, which indicates the repair category, like **Tenant** or **Platform**, and whether the operation is a maintenance action or an update. 
- *Target UD*, which refers to the update domain that the repair job is targeting at that time.
- *Document incarnation number*, which is a monotonically increasing version identifier for the update document received by Service Fabric from Azure.

These elements are then combined in the following format: 

`Azure/repair type/repair job/update domain/document incarnation number` 

For example: `Azure/TenantUpdate/addfb79e-1e8c-42c8-a967-b0e2e0afd6b4/0/110` 

The resulting entity is the *repair task*, which is used within the Service Fabric context. In contrast, the repair job is recognized outside Service Fabric components. 

## Repair task states and their ownership 

### Created 

In the Created state, the Repair Manager accepts and stores the repair request. The task then waits for a Repair Executor to claim it. The requestor can cancel the task during this stage without any restrictions. The Repair Manager has ownership in this state. 

* Claimed 

Once the task is Claimed, the Repair Executor (RE) takes ownership but doesn't specify the repair's impact. The requestor still retains the ability to cancel the task at this stage. The repair executor has ownership in this state. 

* Preparing 

In the Preparing state, the Repair Executor specifies the impact, and the Repair Manager prepares the environment, such as deactivating nodes. If the task is cancelled now, it skips execution and moves directly to restoring. Operator also has the option to force approval, bypassing certain safety checks. Repair Manager has ownership in this state. 

* Approved 

When the task reaches Approved, the Repair Manager has completed all preparations and approved execution. The Repair Executor should move the task to Executing before starting the repair. Cancellation at this point requires cooperation from the executor, which should support cancellation if possible. Repair Executor has ownership in this state. 

* Executing 

During Executing, the Repair Executor is actively performing the repair. The executor must finish all disruptive actions before reporting completion. Cancellation now requires executor cooperation and should only be acknowledged when it is safe to do so. Repair executor has ownership in this state. 

* Restoring 

Once the repair is complete, the task enters Restoring, where the Repair Manager restores the environment, such as reactivating nodes. At this stage, the task cannot be cancelled. Repair Manager has ownership in this state. 

* Completed 

Finally, in the Completed state, the task is finished, and no further state changes occur. The final status may be Succeeded, Cancelled, interrupted (with details), or Failed (with details).

## Analysis from Service Fabric Explorer For stuck repair task 

### Infrastructure Jobs view 

To view jobs that have been submitted to Service Fabric for approval, navigate to the **Infrastructure Jobs** tab under cluster view. Each entry includes a **Job ID**, which remains consistent across Service Fabric and outside service fabric. The **Acknowledgement Status** indicates whether the job has been approved by Service Fabric: 

- **WaitingForAcknowledgement** means the job is still pending approval. 
- **Acknowledged** confirms that the job has been approved by Service Fabric. 

This view represents perspective of the job. Jobs will only appear here when they are present in the received document. In addition to the **Job ID** and **Acknowledgement Status**, the **Impact Types** section displays the nature of the job’s impact. The **Current Repair Task** section shows which repair task is actively running for the job approval on the Service Fabric side. By selecting **All Repair Tasks**, you can view the status of every repair task associated with the current job.

<center>
![Infrastructure Job view][Image1]
</center>

### Repair Jobs and health check view 

To view individual and all repair tasks associated with a cluster, go to the Repair Jobs tab. This section displays both pending repair tasks and those that have been completed or cancelled. For pending tasks, you can see their current state. A repair task is not yet approved by Service Fabric if its state is Created, Claimed, or Preparing. Once a repair task transitions to the Approved state, it is considered approved by Service Fabric, and the approval is then forwarded to the Repair Executor for the corresponding job. 


<center>
![Repair task view][Image2]
</center>

If a repair task is stuck in the Preparing state, there are two possible reasons: It could be stuck in either a Health Check or a Safety Check. Unhealthy entity in the cluster, including customer applications as well as system applications can cause the health check to not be green. To determine if it's stuck in a Health Check, first verify whether Preparing or Restoring Health Check is enabled—based on the state where the task is stuck. In the Repair Task view, expanding the task will show the Health Check status, indicating whether it is enabled. 


<center>
![Health check view][Image3]
</center>

If enabled, the Repair Task History will show that the Health Check started but did not complete, confirming that the task is stuck in the Health Check phase—as illustrated in the screenshot above. 

### Safety check view 

A repair task can get stuck in the Safety Check phase only if it has an impact on any node. This can be confirmed by checking the Impact section in the Repair Task view, as shown in the previous screenshot. If node impact is present, you can identify which Safety Check is causing the delay by inspecting each impacted node individually. Click on the node from the Node List, and in the Safety Check section, you’ll see the specific check where the task is stuck. The Repair Task ID is also displayed here, indicating which repair task is responsible for the node deactivation and safety check—this is illustrated in the screenshot below. In the screenshot below, the repair task is stuck in the EnsureSeedNodeQuorum safety check. 


<center>
![Safety check view][Image4]
</center>

If there are no errors in Infrastructure Service (IS) related to a repair task and the task has entered the Executing state, it means the job’s acknowledgment status is 'Acknowledged' for Impact Start. Similarly, if the repair task transitions to the Completed state, it indicates that the job’s acknowledgment status is 'Acknowledged' for Impact End.

<center>
![Repair task executing view][Image5]
</center>

All completed or cancelled repair tasks for the cluster can be viewed by clicking on the Completed Repair Tasks section. This provides a comprehensive list of repair tasks that have either successfully finished or were terminated. 


<center>
![Completed repair task view][Image6]
</center>

### Infrastructure service and repair Manager Service Health check 

To check the health of the Infrastructure Service or Repair Manager Service, select the service from the list and open the Health Evaluation tab. This tab shows whether the service is healthy, in a warning state, or in an error state, along with details of any warnings or errors. 

<center>
![Infrastructure service health view][Image7]
</center>

<center>
![RepairManager service health view][Image8]
</center>

### Job throttling status for Infrastructure Service 

To check if any job is being throttled for a specific Infrastructure Service, select the service and open the Health Evaluation tab and select All. Look for health events related to job throttling. If a job is throttled, the tab will display the job ID along with the reason for throttling. 

<center>
![Job throttling Is view][Image9]
</center>


[Image1]:./media/cluster-infrastructure-job-view.png
[Image2]:./media/repair-task-view.png
[Image3]:./media/cluster-health-check.png
[Image4]:./media/safety-check-view.png
[Image5]:./media/cluster-repair-task-executing.png
[Image6]:./media/completed-repair-task-view.png
[Image7]:./media/cluster-infrastructure-service-health.png
[Image8]:./media/cluster-repairmanager-service-health.png
[Image9]:./media/cluster-job-throttling-status.png