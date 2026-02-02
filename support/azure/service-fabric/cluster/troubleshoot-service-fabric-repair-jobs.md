---
title: Troubleshoot unapproved repair jobs using Service Fabric Explorer
description: Learn how to troubleshoot stuck repair jobs in Azure Service Fabric clusters using Service Fabric Explorer. Analyze repair task states, safety checks, and health checks to resolve approval issues.
ms.topic: troubleshooting-general
ms.author: jarrettr
ms.reviewer: ashukumar, v-ryanberg
ms.editor: v-gsitser
ms.service: azure-service-fabric
services: service-fabric
ms.date: 01/20/2026
# Customer intent: As a Service Fabric customer, I want to analyze the reason why a repair job is stuck using Service Fabric Explorer.
---

# Troubleshoot unapproved repair jobs using Service Fabric Explorer

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

### Claimed 

Once the task is Claimed, the Repair Executor takes ownership but doesn't specify the repair's impact. The requestor still retains the ability to cancel the task at this stage. The Repair Executor has ownership in this state. 

### Preparing 

In the Preparing state, the Repair Executor specifies the impact and the Repair Manager prepares the environment (like deactivating nodes). If the task is cancelled now, it skips executing and moves directly to restoring. The Operator also has the option to force approval and bypass certain safety checks. The Repair Manager has ownership in this state. 

### Approved 

When the task reaches the Approved state, the Repair Manager has completed all preparations and approved execution. The Repair Executor moves the task to the Executing state before starting the repair. Cancellation at this point requires cooperation from the Repair Executor who has ownership in this state. 

### Executing 

During the Executing state, the Repair Executor performs the repair. The Repair Executor must finish all potentially disruptive actions before reporting completion. Cancellation now requires Repair Executor cooperation and should only be acknowledged when it's safe to do so. The Repair Executor has ownership in this state. 

### Restoring 

Once the repair is complete, the task enters the Restoring state, where the Repair Manager restores the environment (like reactivating nodes). At this stage, the task can't be cancelled. The Repair Manager has ownership in this state. 

### Completed 

Finally, in the Completed state, the task is finished and no further state changes occur. The final status is one of the following states: Succeeded, Cancelled, Interrupted (with details), or Failed (with details).

## Using Service Fabric Explorer for troubleshooting a stuck repair task 

### Infrastructure Jobs view 

To view jobs that Service Fabric receives for approval, go to the **Infrastructure Jobs** tab in the cluster view. Each entry includes a **Job ID** which stays the same across and outside of Service Fabric. The **Acknowledgement Status** shows whether Service Fabric approves the job with one of the following states: 

- **WaitingForAcknowledgement** - The job is still waiting for approval. 
- **Acknowledged** - Service Fabric approves the job. 

Jobs only appear here when they're present in the received document. In addition to the **Job ID** and **Acknowledgement Status**, the **Impact Types** section displays the nature of the job’s impact. The **Current Repair Task** section shows which repair task is actively running for job approval on the Service Fabric side. By selecting **All Repair Tasks**, you can view the status of every repair task associated with the current job.

:::image type="content" source="media/troubleshoot-service-fabric-repair-jobs/cluster-infrastructure-job-view.png" alt-text="Screenshot of the Infrastructure Jobs tab in Service Fabric Explorer showing job ID, acknowledgement status, and impact types." lightbox="media/troubleshoot-service-fabric-repair-jobs/cluster-infrastructure-job-view.png":::

### Repair Jobs and Health Check view 

To view individual and all repair tasks associated with a cluster, go to the **Repair Jobs** tab. This displays pending repair tasks, completed repair tasks, or cancelled repair tasks. You can also see the state for any pending task. 

If a repair task state is Created, Claimed, or Preparing, it's not yet approved by Service Fabric. Once a repair task transitions to the Approved state, it's considered approved and is then forwarded to the Repair Executor for the corresponding job. 

:::image type="content" source="media/troubleshoot-service-fabric-repair-jobs/repair-task-view.png" alt-text="Screenshot of the Repair Jobs tab in Service Fabric Explorer showing repair task states." lightbox="media/troubleshoot-service-fabric-repair-jobs/repair-task-view.png":::

If a repair task gets stuck in the Preparing state, it's either stuck in a health check or a safety check. An unhealthy entity in the cluster (including customer applications as well as system applications) can cause the health check to fail. To determine if the task is stuck in a health check, first verify whether **Preparing** or **Restoring Health Check** is enabled based on the state where the task is stuck. In the **Repair Task** view, expanding the task shows the health check status, indicating if it's enabled. 

:::image type="content" source="media/troubleshoot-service-fabric-repair-jobs/cluster-health-check.png" alt-text="Screenshot of an expanded repair task showing health check status and preparing health check details." lightbox="media/troubleshoot-service-fabric-repair-jobs/cluster-health-check.png":::

If enabled, **Repair Task History** shows that the health check started but didn't complete, confirming that the task is stuck in the Health Check phase. 

### Safety Check view 

A repair task can get stuck in the Safety Check phase only if it has an impact on any node. This can be verified by checking the **Impact** section in the **Repair Task** view. If a node impact is present, you can identify which Safety Check is causing the delay by inspecting each impacted node individually. Select the node from the **Node List**. In the **Safety Check** section, you’ll see the specific check where the task is stuck. The **Repair Task ID** is also displayed here, indicating which repair task is responsible for the node deactivation and safety check. 

For example, in the following screenshot, the repair task is stuck in the **EnsureSeedNodeQuorum** safety check. 

:::image type="content" source="media/troubleshoot-service-fabric-repair-jobs/safety-check-view.png" alt-text="Screenshot of the Safety Check view in Service Fabric Explorer showing the specific check where the task is stuck." lightbox="media/troubleshoot-service-fabric-repair-jobs/safety-check-view.png":::

If there are no errors in **Infrastructure Service** related to a repair task and the task has entered the Executing state, it means the job’s acknowledgment status is Acknowledged for Impact Start. Similarly, if the repair task transitions to the Completed state, it indicates that the job’s acknowledgment status is Acknowledged for Impact End.

:::image type="content" source="media/troubleshoot-service-fabric-repair-jobs/cluster-repair-task-executing.png" alt-text="Screenshot of a repair task in the Executing state with job acknowledgment status Acknowledged for Impact Start." lightbox="media/troubleshoot-service-fabric-repair-jobs/cluster-repair-task-executing.png":::

All completed or cancelled repair tasks for the cluster can be viewed by selecting **Completed Repair Tasks**. This provides a comprehensive list of repair tasks that have either successfully finished or were terminated. 

:::image type="content" source="media/troubleshoot-service-fabric-repair-jobs/completed-repair-task-view.png" alt-text="Screenshot of the Completed Repair Task view in Service Fabric Explorer." lightbox="media/troubleshoot-service-fabric-repair-jobs/completed-repair-task-view.png":::

### Infrastructure Service and Repair Manager Service health check 

To check the health of the Infrastructure Service or Repair Manager Service, select the service from the list and select **Health Evaluation**. This view shows whether the service is healthy, in a Warning state, or in an Error state, along with further details. 

:::image type="content" source="media/troubleshoot-service-fabric-repair-jobs/cluster-infrastructure-service-health.png" alt-text="Screenshot of the Infrastructure Service Health view in Service Fabric Explorer." lightbox="media/troubleshoot-service-fabric-repair-jobs/cluster-infrastructure-service-health.png":::

:::image type="content" source="media/troubleshoot-service-fabric-repair-jobs/cluster-repairmanager-service-health.png" alt-text="Screenshot of the Repair Manager Service Health view in Service Fabric Explorer." lightbox="media/troubleshoot-service-fabric-repair-jobs/cluster-repairmanager-service-health.png":::

### Job throttling status for Infrastructure Service 

To check if any job is being throttled for a specific Infrastructure Service, select the service > **Health Evaluation** > **All**. Look for health events related to job throttling. If a job is throttled, the job ID along with the reason for throttling is displayed. 

:::image type="content" source="media/troubleshoot-service-fabric-repair-jobs/cluster-job-throttling-status.png" alt-text="Screenshot of the Job throttling view in Service Fabric Explorer." lightbox="media/troubleshoot-service-fabric-repair-jobs/cluster-job-throttling-status.png":::