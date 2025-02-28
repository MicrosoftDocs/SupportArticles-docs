---
title: Azure Synapse Analytics Apache Spark pools diagnostic logs
description: Lists the Apache Spark diagnostic logs that's collected during troubleshooting by Microsoft Support.
ms.date: 05/27/2021
author: genlin
ms.author: genli
ms.service: azure-diagnostics-support
ms.reviewer: 
ms.custom: sap:Job Execution and Performance
---
# Apache Spark diagnostic logs in Azure Synapse Analytics

To troubleshoot issues that are related to Apache Spark pools in the Azure Synapse Analytics workspace, Microsoft Support and the Azure Synapse Analytics engineering team can view and download diagnostic logs that are associated with your Apache Spark pools. Microsoft may access or make temporary copies of the log data to help resolve your support incident.

## Logs collected for troubleshooting

The following tables list the log data that will be collected to troubleshoot your support incident. Additionally, you may be asked to provide the same types of data from your Apache Spark pools by using Synapse Studio.

|  Type |  Description |
|---|---|
| Apache Spark Driver Logs  |The Spark driver program is a critical process that's used to negotiate resources with cluster manager and to schedule the job execution. Driver logs contain details about how the job was run and the resources that were used. This information is critical for troubleshooting the Spark application.   |
|  Apache Spark Executor Logs |Spark Executors are worker nodes-related processes that are in charge of running individual tasks in a given Spark job. They are started at the beginning of a Spark application, and typically run for the entire lifetime of an application. After Spark Executors run the task, they send the results to the driver application. Executor logs contain details about how the individual tasks of your application performed, and whether any of them failed.   |
|  Apache Spark Event Logs | Spark Event logs contain execution-related and performance-related metrics of all the executors. They also contain the list of scheduler stages and tasks, and the execution environment information. |

[!INCLUDE [Azure Help Support](../../../../includes/azure-help-support.md)]
