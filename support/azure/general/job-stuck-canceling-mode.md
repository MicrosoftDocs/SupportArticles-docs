---
title: HPC jobs are stuck in canceling mode and new jobs don't start
description: Provides a solution for an issue where performance computing (HPC) jobs are stuck in canceling mode.
ms.date: 09/16/2022
author: AmandaAZ
ms.author: v-weizhu
ms.service: azure-common-issues-support
ms.reviewer: hclvteam
---
# HPC jobs are stuck in canceling mode and new jobs don't start

This article provides a solution for issues where performance computing (HPC) jobs are stuck in canceling mode and new jobs are in queued state.

## Symptoms

You have an HPC cluster that's created with Microsoft HPC Pack 2016. The cluster has one single head node and five compute nodes in Azure. When you cancel running jobs, they're stuck. In this case, when you submit new jobs, they are in queued state even though enough compute nodes are online. Restarting all nodes doesn't help.

## Cause

This issue occurs because the scheduler service is busy.

## Resolution

To resolve this issue, increase the Database transaction unit (DTU) to 200 for the scheduler database in Azure.

To change the DTU to 200, go to the Azure SQL database in the Azure portal, select **Settings** > **Configure**, and then adjust the DTU to 200.

:::image type="content" source="media/job-stuck-canceling-mode/adjust-dtus-azure-sql-database.png" alt-text="Screenshot that shows how to adjust Database transaction unit in Azure portal." lightbox="media/job-stuck-canceling-mode/adjust-dtus-azure-sql-database.png":::

After that, you'll see that the **Pricing tier** has been changed to **Standard S4: 200 DTUs**.

:::image type="content" source="media/job-stuck-canceling-mode/pricing-tier-standard-s4-200-dtus.png" alt-text="Screenshot of the Pricing tier value." lightbox="media/job-stuck-canceling-mode/pricing-tier-standard-s4-200-dtus.png":::

When you change the DTU to 200, the compute size should be at least changed to S4. The following table shows the resources available for a single database at each service tier and compute size:

**Standard service tier (continued)**

| **Compute size** | **S4** | **S6** | **S7** | **S9** | **S12** |
| :--- |---:| ---:|---:|---:|---:|
| Max DTUs | 200 | 400 | 800 | 1600 | 3000 |
| Included storage (GB)| 250 | 250 | 250 | 250 | 250 |
| Max storage (GB) | 1024 | 1024 | 1024 | 1024 | 1024 |
| Max in-memory OLTP storage (GB) | N/A | N/A | N/A | N/A |N/A |
| Max concurrent workers | 400 | 800 | 1600 | 3200 |6000 |
| Max concurrent sessions |4800 | 9600 | 19200 | 30000 |30000 |



## Database transaction unit

A DTU can be defined as horse power for Azure SQL. Microsoft currently offers Azure SQL DB in two models, the DTU model and the vCore model. The DTU model is based on the Database Transaction Unit, and is a blended mix of CPU, I/O and memory (RAM) capabilities based on a benchmark OLTP workload called ASDB. The vCore model is based on the number of virtual CPU cores you require, and this can be scaled up as your workload increases. The DTU model works well if you have pricing constraints or have a fairly stable workload. It's also scalable, as you're able to upgrade the tier or grade of your Azure DB in the future. However, in the DTU model CPU capabilities and storage capabilities are closely coupled.

For HPC scheduler databases, the minimum initial DTU is 100. The following table is the minimum initial DTUs required for each HPC databases. We recommend that you always set it higher than 100 depending on the workload of the HPC server. For more information, see the "Azure SQL Databases" section in [Step 1: Prepare the Remote Databases](/powershell/high-performance-computing/step-1-prepare-the-remote-database-servers).

|HPC database|	Initial DTUs|
|--|--|
|Cluster management|	>= 20|
|Job scheduling	|>= 100|
|Reporting|	>= 20|
|Diagnostics|	>= 10|
|Monitoring|	>= 20|



## References

- [Compare vCore and DTU-based purchasing models of Azure SQL Database](/azure/azure-sql/database/purchasing-models)

- [Resource limits for single databases using the DTU purchasing model - Azure SQL Database](/azure/azure-sql/database/resource-limits-dtu-single-databases)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]



