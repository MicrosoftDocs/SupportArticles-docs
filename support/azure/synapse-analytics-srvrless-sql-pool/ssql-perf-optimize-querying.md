---
title: Performance tuning guidance for Azure Synapse Analytics serverless SQL pool
description: This article provides guidance for optimizing performance on Azure Synapse Analytics serverless SQL pool.
ms.date: 02/21/2023
author: scott-epperly
ms.author: goventur
ms.reviewer: scepperl
---

# Performance tuning guidance for Azure Synapse Analytics serverless SQL pool

_Applies to:_ &nbsp; Azure Synapse Analytics

This article helps you enhance performance for Azure Synapse Analytics serverless SQL pool.

> [!NOTE]
> Review the [list of known issues](/azure/synapse-analytics/known-issues) that are currently active or recently resolved in Azure Synapse Analytics.

See the next few sections for information about how to achieve optimal performance and prevent failures that are related to resource constraints on your Azure Synapse Analytics serverless SQL pools.

## Best practices and troubleshooting guides

The information and strategies in the following articles can help you get the best performance out of your serverless SQL pool. We recommend that you use these articles to review use cases and troubleshoot common issues.

- [Best practices for serverless SQL pool in Azure Synapse Analytics](/azure/synapse-analytics/sql/best-practices-serverless-sql-pool)
- [Troubleshoot serverless SQL pool in Azure Synapse Analytics](/azure/synapse-analytics/sql/resources-self-help-sql-on-demand?tabs=x80070002)

## Understand scaling on serverless SQL pool

Serverless SQL pools don't require that you manually select the right size. The system automatically adjusts the size based on your query requirements, and thereby manages the infrastructure and select the right size for your solution.

## Performance tuning guidance for Delta Lake files

For more information about performance tuning for Delta Lake files, see the following resources:

- [Delta Lake Documentation Page](https://docs.delta.io/latest/delta-intro.html).
- [What is Delta Lake](/azure/synapse-analytics/spark/apache-spark-what-is-delta-lake)
- [Query Delta Lake files using serverless SQL pool in Azure Synapse Analytics](/azure/synapse-analytics/sql/query-delta-lake-format)

## Performance tuning guidance for CSV files

When you query CSV files on a serverless SQL pool, the most important task to ensure high performance is to create statistics on the external tables. Though statistics are automatically created on Parquet and CSV files, and accessed by using `OPENQUERY()`, reading the CSV files by using external tables requires you to manually create statistics.

For more detailed information about the role of statistics in querying CSV files in serverless SQL pools, see the following articles:

- [Querying CSV files](/azure/synapse-analytics/sql/query-single-csv-file)
- [Statistics in serverless SQL pool](/azure/synapse-analytics/sql/develop-tables-statistics#statistics-in-serverless-sql-pool)
- [Manually create statistics for CSV files](/azure/synapse-analytics/sql/best-practices-serverless-sql-pool#manually-create-statistics-for-csv-files)
- [Query timeout expired](/azure/synapse-analytics/sql/resources-self-help-sql-on-demand?tabs=x80070002#query-timeout-expired)

## Recommendations for using Power BI and other reporting tools

We recommend the following best practices when you use Power BI and other reporting tools:

- Always check your tenant location.
- Set up a cache for a better user experience.
- Avoid returning millions of records to a dashboard.
- Use scheduled refreshes to avoid parallel query executions that drain SQL serverless pool resources.
- Use Spark to pre-aggregate common analytical queries. This "write once/read many" approach can avoid heavy queries that are run continuously.
- For joins between different data stores: Use filters to avoid big data volumes that were moved across your Azure infrastructure.
- Use `Latin1_General_100_BIN2_UTF8` collation for character data types. This collation avoids transferring all data from storage to your serverless SQL pool by pushing down filters when tools read from storage.
- Use the most optimal size, if you're casting or converting data to `char` or `varchar` while running a query. When possible, avoid using `VARCHAR(MAX)`.
- Automatic inference converts data types to a format that might not be optimal. Use the `WITH` clause to optimize data types.
- The Azure Synapse SQL serverless pool resources have limits. Running queries simultaneously will consume resources. It's common to see Power BI (PBI) dashboards reaching resource limits when multiple refreshes occur in parallel. Scheduled refreshes and load testing can help avoid this problem. Also, using multiple Azure Synapse workspaces can address greater concurrency requirements.
- You can run the query `sys.columns` or use `sp_describe_first_result_set` and `select top 0 from <view>` to check the data types after you create a view. This approach is faster and less costly than using `SELECT * FROM...`.
- Use the [Statement Generator](https://htmlpreview.github.io/?https://github.com/Azure-Samples/Synapse/blob/main/SQL/tools/cosmosdb/generate-openrowset.html) to automatically create optimum column formats for your query.
- Use the `OPENJSON` function to expose nested JSON data as columns. But if you also use the `AS JSON` command, the column type must be `NVARCHAR(MAX)`. This approach isn't ideal for performance. The best option is to use the `WITH` clause to expose nested arrays as columns.
- The Cosmos DB transactional store partition key isn't used in the analytical store. In Azure Synapse Link, you can now model your transactional data to optimize data ingestion and point reads.

## Extra guidance and best practices

| Category | Recommended actions or documentation |
|---|---|
| Data Exploration | [Azure storage](/azure/synapse-analytics/sql/develop-storage-files-overview?tabs=impersonation)<br>[Store query results on Azure storage](/azure/synapse-analytics/sql/create-external-table-as-select)<br>[Logical data warehouse](/azure/synapse-analytics/sql/tutorial-logical-data-warehouse) |
| OPENROWSET and External Tables | [OPENROWSET function](/azure/synapse-analytics/sql/develop-openrowset)<br>[External tables](/azure/synapse-analytics/sql/develop-tables-external-tables?tabs=native)<br>[Stored Procedures](/azure/synapse-analytics/sql/develop-stored-procedures)<br>[Views](/azure/synapse-analytics/sql/create-use-views)<br>[Data transformations](/azure/synapse-analytics/sql/develop-tables-cetas#cetas-in-serverless-sql-pool) |
| Available T-SQL features in serverless SQL pools | [T-SQL features in Azure Synapse pools](/azure/synapse-analytics/sql/overview-features) |

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
