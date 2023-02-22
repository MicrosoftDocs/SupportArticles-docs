---
title: Manage cost structure for Azure Synapse Analytics serverless SQL pools
description: This article discusses frequently asked questions about the cost of Azure Synapse Analytics serverless SQL pools.
ms.date: 02/21/2023
author: scott-epperly
ms.author: goventur
ms.reviewer: scepperl
---

# Manage costs for Azure Synapse Analytics serverless SQL pool

_Applies to:_ &nbsp; Azure Synapse Analytics

The cost structure for Azure Synapse Analytics serverless SQL pool can sometimes be confusing. This is because the cost isn't based on compute instances and runtime, as are many other services. Use the following table to find answers to the most frequently asked questions about the costs that're associated with serverless SQL pools.

| FAQ | Solution |
|--|--|
| **How are serverless SQL pools billed for?** | The serverless SQL pool service is billed for based on the amount of *data processed* during the billing period. See [Cost management for serverless SQL pool in Azure Synapse Analytics](/azure/synapse-analytics/sql/data-processed) to understand activities that're included in the "data processed" concept. |
| **How can I estimate my costs for serverless SQL pools?** | Use the [Synapse pricing calculator](https://azure.microsoft.com/pricing/details/synapse-analytics/) to estimate the cost of serverless SQL pools. On the Azure Synapse Analytics pricing webpage, scroll down, and then select the **Data Warehousing** tab to see the costs for serverless SQL pools. |
| **How can I best reduce my costs for a serverless SQL pool?** | The most effective way to reduce costs is to reduce the amount of data to be processed by your workload. The following articles offer guidance for optimizing your data lake to achieve optimal performance at the lowest cost:<br>- [Filter optimization](/azure/synapse-analytics/sql/best-practices-serverless-sql-pool#filter-optimization)<br>- [Prepare files for querying](/azure/synapse-analytics/sql/best-practices-serverless-sql-pool#prepare-files-for-querying)<br>- [Optimize repeating queries](/azure/synapse-analytics/sql/best-practices-serverless-sql-pool#optimize-repeating-queries)|
| **How can the amount of data that's processed for a given query be bigger than the source data?** | Depending on its complexity, the query might run multiple scans over the same data files, adding to the total data processed.<br><br>See **How can I best reduce my costs?** in this table to learn techniques to reduce the amount of data processed. |
| **How can I apply cost limits to prevent overspending?** | The cost control feature in serverless SQL pool enables you to set the budget for the amount of data that's processed. You can set the budget in terabytes of data processed for a day, week, and month. You can also have one or more budgets set. To configure cost control for serverless SQL pools, you can use Azure Synapse Studio or T-SQL.<br><br>For more information, see [Configure cost control for serverless SQL pool](/azure/synapse-analytics/sql/data-processed#cost-control).|
| **Why was my cost limit exceeded?** | If a query exceeds the limit while it runs, the query won't be terminated. Therefore, the cost limit may be exceeded by the amount that's required to complete the query.<br><br>See [Exceeding the limits defined in the cost control](/azure/synapse-analytics/sql/data-processed#exceeding-the-limits-defined-in-the-cost-control). |
