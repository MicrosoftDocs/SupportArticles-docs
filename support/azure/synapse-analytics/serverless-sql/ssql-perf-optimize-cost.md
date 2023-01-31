---
title: Manage your costs on Azure Synapse Analytics serverless SQL pool
description: FAQ for costs on Azure Synapse Analytics serverless SQL pool
ms.date: 01/31/2023
author: scott-epperly
ms.author: goventur
ms.reviewer: scepperl
---

# Manage your costs on Azure Synapse Analytics serverless SQL pool

_Applies to:_ &nbsp; Azure Synapse Analytics

The cost structure for Azure Synapse Analytics serverless SQL pools can sometimes be confusing as it's not based on compute size and runtime like many other services.  Use this guide to assist you with answers to the most frequently asked questions regarding your costs on serverless SQL pools.

| FAQ | Solution |
|--|--|
| **How are serverless SQL pools billed?** | Serverless SQL pools are billed based on the amount of *data processed* for the billing period.  Review [Cost management for serverless SQL pools](https://learn.microsoft.com/azure/synapse-analytics/sql/data-processed) to gain a detailed understanding of which activities are included in the "data processed" concept. |
| **How can I estimate my costs for serverless SQL pools?** | Use the [Synapse pricing calculator](https://azure.microsoft.com/pricing/details/synapse-analytics/) to estimate the cost of serverless SQL pools.<br>Select the **Data Warehousing** tab to see the costs for serverless SQL pools. |
| **How can I best reduce my costs on my serverless SQL pool?** | The most effective way to reduce the costs of your serverless SQL pools is to reduce the amount of data that needs to be processed by your workload.  The following articles offer guidance for optimizing your data lake to achieve optimal performance at the lowest cost:<br>- [Filter optimization](https://learn.microsoft.com/azure/synapse-analytics/sql/best-practices-serverless-sql-pool#filter-optimization)<br>- [Prepare files for querying](https://learn.microsoft.com/azure/synapse-analytics/sql/best-practices-serverless-sql-pool#prepare-files-for-querying)<br>- [Optimize repeating queries](https://learn.microsoft.com/azure/synapse-analytics/sql/best-practices-serverless-sql-pool#optimize-repeating-queries)|
| **How can the amount of data processed for a given query be bigger than the source data?** | Depending on the complexity of the query, it might perform multiple scans over the same data files, adding to the total data processed.<br><br>See **How can I best reduce costs?** in this table to learn techniques to reduce the amount of data processed. |
| **How can I apply cost limits to prevent overspending?** | The cost control feature in serverless SQL pool enables you to set the budget for the amount of data processed. You can set the budget in terabytes of data processed for a day, week, and month. At the same time, you can have one or more budgets set. To configure cost control for serverless SQL pools, you can use Azure Synapse Studio or T-SQL.<br><br>For more information, see [Configure cost control for serverless SQL pool](https://learn.microsoft.com/azure/synapse-analytics/sql/data-processed#cost-control).|
| **Why was my cost limit was exceeded?** | If a query exceeds the limit while it's executing, the query won't be terminated; therefore, the cost limit may be exceeded by the amount needed to complete the query.<br><br>See [Exceeding the limits defined in the cost control](https://learn.microsoft.com/azure/synapse-analytics/sql/data-processed#exceeding-the-limits-defined-in-the-cost-control). |