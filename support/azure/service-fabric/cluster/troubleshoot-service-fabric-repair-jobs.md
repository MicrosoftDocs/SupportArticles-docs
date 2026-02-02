---
title: Troubleshoot unapproved repair jobs using Service Fabric Explorer
description: Learn how to troubleshoot stuck repair jobs in Azure Service Fabric clusters by using Service Fabric Explorer. Analyze repair task states, safety checks, and health checks to resolve approval issues.
ms.topic: troubleshooting-general
ms.author: jarrettr
ms.reviewer: ashukumar, v-ryanberg
ms.editor: v-gsitser
ms.service: azure-service-fabric
services: service-fabric
ms.custom: sap:Cluster related issues
ms.date: 01/20/2026
# Customer intent: As a Service Fabric customer, I want to use Service Fabric Explorer to analyze the reason why a repair job is stuck.
---

# Troubleshoot unapproved repair jobs by using Service Fabric Explorer

## Summary

This article provides guidance for how to use Service Fabric Explorer (SFX) to troubleshoot repair jobs that aren't approved in an Azure Service Fabric cluster. This article explains the concepts of repair tasks and repair jobs, their states, and how to analyze them by using SFX.

## Repair task overview 

*Service Fabric* processes any operation that's initiated from the scale set that targets virtual machines (VMs) as a repair task. This repair task is derived from the job that Service Fabric receives. 

The *Infrastructure Service* is responsible for managing and orchestrating infrastructure-level operations, such as updates and repairs, to make sure that the Service Fabric cluster is healthy and stable. It creates a repair task for each job, and adds details, such as the update type, targeted update domain (UD), and document incarnation number. The UD identification for these jobs starts at UD0, and progress sequentially through UD1, UD2, and so on, within the Service Fabric cluster. If a domain update is required, the Infrastructure Service generates separate repair tasks for each UD. For example, in a cluster of five UDs, the Infrastructure Service creates five distinct repair tasks. These tasks run one after another, UD by UD. You can track their progress in SFX. 

The *Repair Manager* defines and implements a safe workflow for performing repairs by coordinating between the *Repair Requestor*, *Repair Executor*, and itself to make sure that repair actions are safe and consistent. 

### Repair job and repair task  

A repair job refers to an Azure‑initiated maintenance operation that provides essential details, including:

- Job ID
- Repair type
- Targeted update domain
- Document incarnation number
- Node‑impact information
- Additional metadata

Service Fabric then creates a repair task by combining several details, including: 

- *Repair type* - Indicates the repair category, such as **Tenant** or **Platform**, and whether the operation is a maintenance action or an update. 
- *Target UD* - Refers to the update domain that the repair job is targeting at that time.
- *Document incarnation number* - A monotonically increasing version identifier for the update document that's received by Service Fabric from Azure.

These elements are then combined in the following format: 

    `Azure/repair type/repair job/update domain/document incarnation number` 

For example: `Azure/TenantUpdate/addfb79e-1e8c-42c8-a967-b0e2e0afd6b4/0/110`.

The resulting entity is the *repair task*. This entity is used within the Service Fabric context. In contrast, the repair job is recognized outside Service Fabric components. 

## Repair task states and their ownership 

### Created 

In the Created state, the Repair Manager accepts and stores the repair request. The task then waits for a Repair Executor to claim it. The requestor can cancel the task during this stage without any restrictions. The Repair Manager has ownership in this state. 

### Claimed 

After the task is claimed, the Repair Executor takes ownership but doesn't specify the repair's impact. The requestor still retains the ability to cancel the task at this stage. The Repair Executor has ownership in this state. 

### Preparing 

In the Preparing state, the Repair Executor specifies the impact, and the Repair Manager prepares the environment (for example, by deactivating nodes). If the task is canceled now, it stops running, and moves directly to restoring. Optionally, the Operator can force approval and bypass certain safety checks. The Repair Manager has ownership in this state. 

### Approved 

After the Repair Manager completes all preparations and approved execution, the task reaches the Approved state. The Repair Executor moves the task to the Executing state before starting the repair. Cancelation at this point requires cooperation from the Repair Executor. The Repair Executor has ownership in this state. 

### Executing 

During the Executing state, the Repair Executor performs the repair. The Repair Executor must finish all potentially disruptive actions before it can report completion. Cancelation now requires cooperation from the Repair Executor. The Repair Executor should acknowledge cancelation only when it's safe to do it. The Repair Executor has ownership in this state. 

### Restoring 

After the repair is finished, the task enters the Restoring state. The Repair Manager restores the environment (for example, by reactivating nodes). At this stage, the task can't be canceled. The Repair Manager has ownership in this state. 

### Completed 

Finally, in the Completed state, the task is finished, and no further state changes occur. The final status is one of the following states: Succeeded, Cancelled, Interrupted (with details), or Failed (with details).

## Using Service Fabric Explorer to troubleshoot a stuck repair task 

### Infrastructure Jobs view 

To view jobs that Service Fabric receives for approval, select **Infrastructure Jobs** in the cluster view. Each entry includes a **Job ID** that stays the same across and outside of Service Fabric. The **Acknowledgement Status** shows whether Service Fabric approves the job with one of the following states: 

- **WaitingForAcknowledgement** - The job is still waiting for approval. 
- **Acknowledged** - Service Fabric approves the job. 

Jobs appear here only if they exist in the received document. In addition to the **Job ID** and **Acknowledgement Status**, the **Impact Types** section displays the nature of the job’s impact. The **Current Repair Task** section shows which repair task is actively running for job approval on the Service Fabric side. By selecting **All Repair Tasks**, you can view the status of every repair task that's associated with the current job.

:::image type="content" source="media/troubleshoot-service-fabric-repair-jobs/cluster-infrastructure-job-view.png" alt-text="The Infrastructure Jobs view in Service Fabric Explorer showing job ID, acknowledgment status, and impact types." lightbox="media/troubleshoot-service-fabric-repair-jobs/cluster-infrastructure-job-view.png":::

### Repair Jobs and Health Checks view 

To view individual and all repair tasks that are associated with a cluster, select **Repair Jobs**. This selection displays pending, completed, and canceled repair tasks. You can also see the state of any pending task. 

If a repair task state is Created, Claimed, or Preparing, the task isn't yet approved by Service Fabric. After a repair task transitions to the Approved state, it's considered to be approved. It's then forwarded to the Repair Executor for the corresponding job. 

:::image type="content" source="media/troubleshoot-service-fabric-repair-jobs/repair-task-view.png" alt-text="Repair Jobs view in Service Fabric Explorer showing repair task states." lightbox="media/troubleshoot-service-fabric-repair-jobs/repair-task-view.png":::

If a repair task gets stuck in the Preparing state, this condition occurs in either a health check or a safety check. An unhealthy entity in the cluster (including customer applications and system applications) can cause the health check to fail. To determine whether the task is stuck in a health check, first verify whether **Preparing Health Check** or **Restoring Health Check** is enabled based on the state at which the task is stuck. In the **Repair Task** view, expand the task to show the health check status and whether the health check is enabled. 

:::image type="content" source="media/troubleshoot-service-fabric-repair-jobs/cluster-health-check.png" alt-text="Expanded repair task showing health check status and preparing health check details." lightbox="media/troubleshoot-service-fabric-repair-jobs/cluster-health-check.png":::

If the health check is enabled, **Repair Task History** shows that the health check started but didn't finish. This display confirms that the task is stuck in the Health Check phase.

### Safety Checks view 

A repair task can get stuck in the Safety Check phase only if it affects any node. To verify this condition, check the **Impact** section in the **Repair Task** view. If a node impact exists, you can identify which Safety Check is causing the delay by inspecting each affected node individually. Select the node from the **Node List**. The **Safety Checks** section indicates the specific check in which the task is stuck. The **Repair Task ID** is also displayed here. The ID indicates which repair task is responsible for the node deactivation and safety check. 

For example, in the following screenshot, the repair task is stuck in the **EnsureSeedNodeQuorum** safety check. 

:::image type="content" source="media/troubleshoot-service-fabric-repair-jobs/safety-check-view.png" alt-text="Safety Checks view in Service Fabric Explorer showing the specific check where the task is stuck." lightbox="media/troubleshoot-service-fabric-repair-jobs/safety-check-view.png":::

If **Infrastructure Service** shows no errors that are related to a repair task, and the task is in the Executing state, the job’s acknowledgment status is Acknowledged for Impact Start. Similarly, if the repair task transitions to the Completed state, the job’s acknowledgment status is Acknowledged for Impact End.

:::image type="content" source="media/troubleshoot-service-fabric-repair-jobs/cluster-repair-task-executing.png" alt-text="A repair task in the Executing state by having the job acknowledgment status of Acknowledged for Impact Start." lightbox="media/troubleshoot-service-fabric-repair-jobs/cluster-repair-task-executing.png":::

To view all completed or canceled repair tasks for the cluster, select **Completed Repair Tasks**. This selection provides a comprehensive list of repair tasks that either successfully finished or were terminated. 

:::image type="content" source="media/troubleshoot-service-fabric-repair-jobs/completed-repair-task-view.png" alt-text="Completed Repair Task view in Service Fabric Explorer." lightbox="media/troubleshoot-service-fabric-repair-jobs/completed-repair-task-view.png":::

### Infrastructure Service and Repair Manager Service health check 

To check the health of the Infrastructure Service or Repair Manager Service, select the service from the list, and then select **Health Evaluation**. This view shows whether the service is healthy, in a Warning state, or in an Error state, and shows additional details. 

:::image type="content" source="media/troubleshoot-service-fabric-repair-jobs/cluster-infrastructure-service-health.png" alt-text="Infrastructure Service Health view in Service Fabric Explorer." lightbox="media/troubleshoot-service-fabric-repair-jobs/cluster-infrastructure-service-health.png":::

:::image type="content" source="media/troubleshoot-service-fabric-repair-jobs/cluster-repair-manager-service-health.png" alt-text="Repair Manager Service Health view in Service Fabric Explorer." lightbox="media/troubleshoot-service-fabric-repair-jobs/cluster-repair-manager-service-health.png":::

### Job throttling status for Infrastructure Service 

To check whether any job is throttled for a specific Infrastructure Service, select the service, and then select **Health Evaluations** > **All**. Look for health events that are related to job throttling. If a job is throttled, the job ID is displayed together with an explanation about why it's throttled. 

:::image type="content" source="media/troubleshoot-service-fabric-repair-jobs/cluster-job-throttling-status.png" alt-text="The Health Evaluations view in Service Fabric Explorer." lightbox="media/troubleshoot-service-fabric-repair-jobs/cluster-job-throttling-status.png":::
