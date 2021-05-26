---
title: Azure Synapse Analytics Apache Spark pools diagnostic logs
description: Lists the Apache Spark diagnostic logs that's collected during troubleshooting by Microsoft Support.
ms.date: 05/26/2021
author: genlin
ms.author: genli
ms.service: synapse-analytics
ms.prod-support-area-path: 
ms.reviewer: 
---
# Apache Spark diagnostic logs in Azure Synapse Analytics

To troubleshoot issues that are related to Apache Spark pools in Azure Synapse Analytics workspace, Microsoft Support and the Azure Synapse Analytics engineering team can view and download diagnostic logs that are associated with your Apache Spark pools. Microsoft may access or make temporary copies of the data to help resolve your support incident.

## Logs collected for troubleshooting

The following tables list what data will be collected and available to Microsoft Support. Additionally, you may be asked to provide the same types of data from your Apache Spark pools using Synapse Studio.

|  Type |  Description |
|---|---|
| Apache Spark Driver Logs  |Spark driver program is critical process used for negotiation resources with cluster manager and scheduling the job execution. Driver logs would contain details on how the job got executed and resource used, that are critical for troubleshooting Spark application.   |
|  Apache Spark Executor Logs |Spark Executors are worker nodes’ processes in charge of running individual tasks in a given Spark job. They're launched at the beginning of a Spark application and typically run for the entire lifetime of an application. Once they have run the task, they send the results to the driver application. Executor logs would contain details on how the individual tasks of your application performed and whether any of them failed.   |
|  Apache Spark Event Logs | Spark Event logs would contain execution and performance related metrics of all the executors, the list of scheduler stages/tasks and the execution environment information. |
