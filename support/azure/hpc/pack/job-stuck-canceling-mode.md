---
title: HPC jobs are stuck in canceling mode, and new jobs don't start
description: Provides a solution for an issue where performance computing (HPC) jobs are stuck in canceling mode.
ms.date: 09/16/2022
ms.service: hpcpack
ms.reviewer: hclvteam, cargonz, v-weizhu
---
# HPC jobs are stuck in canceling mode, and new jobs don't start

This article provides a solution for issues with running jobs stuck in canceling mode, and new jobs can't turn into running status when an Azure SQL database is in use for an HPC PACK remote database.

## Symptoms

When you cancel the running jobs, they get stuck in canceling mode, and new jobs submitted are still in queue while there are compute nodes available to run the jobs. Restarting the nodes doesn't help.

Meanwhile, the platform as a service (PaaS) database is hitting 100%, and you see the following error message in the HPC scheduler log:

> The scheduler server is busy. It can not handle the client request now. Please try again later.

## Cause

This issue occurs because the head node is over-stressed because the PaaS database is hitting its performance limit.

## Resolution

To resolve this issue, increase the Database transaction unit (DTU) to a higher SKU for the scheduler database in Azure that matches your workload. The minimum initial DTU required for the HPC scheduler database is 100 DTU.

## References

For more information, see [Step 1: Prepare the Remote Databases](/powershell/high-performance-computing/step-1-prepare-the-remote-database-servers).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
