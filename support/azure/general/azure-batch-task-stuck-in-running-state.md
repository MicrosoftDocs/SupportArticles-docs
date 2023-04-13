---
title: Azure Batch task is stuck in Running state
description: Provides the cause and some suggestions for an issue where an Azure Batch task is stuck in Running state without any errors.
ms.date: 04/13/2023
author: AmandaAZ
ms.author: v-weizhu
ms.reviewer: biny
ms.service: batch
---
# Azure Batch task is stuck in Running state

This article provides the cause and some suggestions for an issue where an Azure Batch task is stuck in Running state.

## Symptoms

An Azure Batch task gets stuck in Running state for a long time but there's no error.

If you run it again, the task execution is completed successfully within a short time. Other tasks in the same node run well.

## Cause  

In most cases, this issue occurs due to application issues.

## Recommended steps

1. When the task is running, capture more detailed application logs and write them as standard output (stdout) to understand where the task is stuck.  

1. Compare the logs of a normal task and the stuck task to find out the gap.  

1. Implement [Batch insights](https://github.com/Azure/batch-insights) to monitor the CPU and memory usage to identify if there's any performance issue.  

1. Capture the dump file when the issue occurs to analyze where the application is stuck.

1. Batch automatically captures and writes stdout and stderr for the task into the stdout.txt and stderr.txt file in the task directory. If there's no stderr or stdout when the task is stuck and you have identified there's no application issue, contact Microsoft support.

    When you contact Microsoft support, perform the following actions:

    - Collect the [Batch node agent log files](/azure/batch/batch-pool-node-error-checking#node-agent-log-files).
    - Upload log files for a node via the Azure portal, Batch Explorer, or an [API](/rest/api/batchservice/compute-node/upload-batch-service-logs).
    - Keep the Batch node that runs the struck task if you can.  

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]