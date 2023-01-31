---
title: Performance tuning guidance for Azure Synapse Analytics serverless SQL pool
description: Guidance for optimizing performance on Azure Synapse Analytics serverless SQL pool
ms.date: 01/31/2023
author: scott-epperly
ms.author: goventur
ms.reviewer: scepperl
---

# Performance tuning guidance for Azure Synapse Analytics serverless SQL pool

_Applies to:_ &nbsp; Azure Synapse Analytics

> **Note**: Review the [list of known issues](https://learn.microsoft.com/azure/synapse-analytics/known-issues) currently active or recently resolved in Azure Synapse Analytics.

Scan the following sections for guidance to achieve optimal performance and to prevent failures related to resource constraints on your Azure Synapse Analytics serverless SQL pools.

## Best Practices and Troubleshooting Guides

The information and strategies contained in the following articles lay the foundation for much of what you need to know for getting the best performance out of your serverless SQL pool.  It's highly encouraged that you review these articles to establish your understanding of the use cases and common issues to expect.

- [Best practices for serverless SQL pool in Azure Synapse Analytics](https://learn.microsoft.com/azure/synapse-analytics/sql/best-practices-serverless-sql-pool)
- [Troubleshoot serverless SQL pool in Azure Synapse Analytics](https://learn.microsoft.com/azure/synapse-analytics/sql/resources-self-help-sql-on-demand?tabs=x80070002)

## Understand scaling on serverless SQL pool

Serverless SQL pools don't require you to manually pick the right size. The system automatically adjusts based on your query requirements, freeing you up from managing your infrastructure and picking the right size for your solution.

## Performance tuning guidance for Delta Lake files

For full documentation on performance tuning for Delta Lake files, see the following resources:

- [Delta Lake Documentation Page](https://docs.delta.io/latest/delta-intro.html).
- [What is Delta Lake](https://learn.microsoft.com/azure/synapse-analytics/spark/apache-spark-what-is-delta-lake)
- [Query Delta Lake files using serverless SQL pool in Azure Synapse Analytics](https://learn.microsoft.com/azure/synapse-analytics/sql/query-delta-lake-format)

## Performance tuning guidance for CSV files

The most important activity for ensuring performant querying over CSV files on a serverless SQL pool is to create statistics on the external tables.  Though statistics are automatically created on Parquet files and on CSV files accessed using `OPENQUERY()`, reading CSV files using external tables requires you to manually create statistics.

For more detailed information about the role of statistics on CSV files in serverless SQL pools, see:

- [Querying CSV files](https://learn.microsoft.com/azure/synapse-analytics/sql/query-single-csv-file)
- [Statistics in serverless SQL pool](https://learn.microsoft.com/azure/synapse-analytics/sql/develop-tables-statistics#statistics-in-serverless-sql-pool)
- [Manually create statistics for CSV files](https://learn.microsoft.com/azure/synapse-analytics/sql/best-practices-serverless-sql-pool#manually-create-statistics-for-csv-files)
- [Query time-out expired](https://learn.microsoft.com/azure/synapse-analytics/sql/resources-self-help-sql-on-demand?tabs=x80070002#query-timeout-expired)

## Recommendations for using Power BI and other reporting tools

- Always check your tenant location.
- Set up a cache for a better user experience.
- Avoid returning millions of records to a dashboard.
- Use scheduled refreshes to avoid parallel query executions that drain SQL serverless pool resources.
- You can use Spark to pre-aggregate common analytical queries. This "write once/read many" approach can avoid heavy queries that are run continuously.
- Joins between different data stores: Use filters to avoid big data volumes that were moved across your Azure infrastructure.
- Use `Latin1_General_100_BIN2_UTF8` collation for character data types.  This collation avoids transferring all data from storage to your serverless SQL pool by pushing down filters when reading from storage.
- If you're casting/converting data to `char` or `varchar` during query time, use the most optimal size. When possible, avoid using `VARCHAR(MAX)`.
- Automatic inference converts datatypes to a format that may not be optimal. Use the `WITH` clause to optimize data types.
- Azure Synapse SQL serverless pool resources have limits. Executing queries simultaneously will consume resources simultaneously. It's common to see PBI dashboards reaching resource limits when multiple refreshes occur in parallel.  Scheduled refreshes and load testing can help you avoid this problem. Also, utilizing multiple Azure Synapse workspaces can address greater concurrency requirements.
- After you create a view, you can query `sys.columns` or use `sp_describe_first_result_set` and `select top 0 from <view>` to check the data types. This approach is faster and less costly than using `SELECT * FROM...`.
- Use the [Statement Generator](https://htmlpreview.github.io/?https://github.com/Azure-Samples/Synapse/blob/main/SQL/tools/cosmosdb/generate-openrowset.html) to automatically create optimum column formats for your query.
- You can use the `OPENJSON` function to expose nested JSON data as columns. But if you also use the `AS JSON` option, the column type must be `NVARCHAR(MAX)`. This approach isn't ideal for performance. The best option is to use the `WITH` clause to expose nested arrays as columns.
- The Cosmos DB transactional store partition key isn't used in the analytical store. In Azure Synapse Link, you can now model your transactional data to optimize data ingestion and point reads.

## Extra guidance and best practices

|Category|Recommended actions or documentation|
|--|--|
|Data Exploration|[Azure storage](https://learn.microsoft.com/azure/synapse-analytics/sql/develop-storage-files-overview?tabs=impersonation)<br>[Store query results on Azure storage](https://learn.microsoft.com/azure/synapse-analytics/sql/create-external-table-as-select)<br>[Logical data warehouse](https://learn.microsoft.com/azure/synapse-analytics/sql/tutorial-logical-data-warehouse)|
|OPENROWSET and External Tables|[OPENROWSET function](https://learn.microsoft.com/azure/synapse-analytics/sql/develop-openrowset)<br>[External tables](https://learn.microsoft.com/azure/synapse-analytics/sql/develop-tables-external-tables?tabs=native)<br>[Stored Procedures](https://learn.microsoft.com/azure/synapse-analytics/sql/develop-stored-procedures)<br>[Views](https://learn.microsoft.com/azure/synapse-analytics/sql/create-use-views)<br>[Data transformations](https://learn.microsoft.com/azure/synapse-analytics/sql/develop-tables-cetas#cetas-in-serverless-sql-pool)|
| Available T-SQL features in serverless SQL pools | [T-SQL features in Azure Synapse pools](https://learn.microsoft.com/azure/synapse-analytics/sql/overview-features)|
