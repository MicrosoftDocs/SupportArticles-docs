---
title: Azure Batch task is stuck in the Running state
description: Provides the cause and some suggestions for an issue where an Azure Batch task is stuck in the Running state without any errors.
ms.date: 04/19/2023
ms.reviewer: biny, v-weizhu
ms.service: batch
---
# Azure Batch task is stuck in the Running state

This article provides the cause and some suggestions for an issue where an Azure Batch task is stuck in the **Running** state.

## Symptoms

An Azure Batch task gets stuck in the **Running** state for a long time, but there's no error.

If you run it again, the task execution is completed successfully and quickly. Other tasks in the same node run well.

## Cause

Since the task is being executed and there is no error, it's an application issue in most cases.

## Recommended steps

1. Azure Batch doesn't monitor the application running by the task, so there are no detailed application logs. To understand where the task is stuck, add more detailed application logs and output them to stdout when the task is running. 

1. Compare the logs of a normal task and the stuck task to find the gap.  

1. Implement [Azure Batch Insights](https://github.com/Azure/batch-insights) to monitor the CPU and memory usage of the Batch node to identify if there are any performance issues.  

1. Capture the dump file when the issue occurs to analyze where the application is stuck.

1. Batch automatically captures and writes stdout and stderr for the task into the *stdout.txt* and *stderr.txt* files in the task directory. If there's no stderr or stdout when the task is stuck, and you have identified that there's no application issue, contact Microsoft support.

    When you contact Microsoft support, you need to:

    - Collect the [Batch node agent log files](/azure/batch/batch-pool-node-error-checking#node-agent-log-files) for the node and upload them via the Azure portal, Batch Explorer, or an [API](/rest/api/batchservice/compute-node/upload-batch-service-logs).
    - Keep the Batch node that runs the stuck task if you can.  

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
