---
title: Troubleshoot issues with CETAS on Azure Synapse serverless SQL pools
description: FAQs about CREATE EXTERNAL TABLE AS SELECT (CETAS) on Azure Synapse serverless SQL pools.
ms.date: 02/21/2023
ms.reviewer: scepperl, goventur, v-sidong
---

# Troubleshoot issues with CREATE EXTERNAL TABLE AS SELECT (CETAS) on Azure Synapse serverless SQL pools

_Applies to:_ &nbsp; Azure Synapse Analytics

The [CREATE EXTERNAL TABLE AS SELECT](/azure/synapse-analytics/sql/develop-tables-cetas) (also known as CETAS) statement in Azure Synapse serverless SQL pools is used to create external tables and export query results to Azure Storage Blob or Azure Data Lake Storage Gen2. This guide helps you implement best practices and workarounds for frequently asked questions about exporting data with CETAS.

## Frequently asked questions

|Questions|Recommendation|
|--|--|
|**Can I export the results to a single file?**|No. Due to the highly parallel and scalable nature of the serverless SQL query engine, serverless SQL doesn't have the ability to control the number of files when saving query results to storage using CETAS.<br><br>**Workaround:**<br>As an alternative, you can export the data to storage using a Spark notebook. See [Create CSV and Parquet files in your storage account](/azure/synapse-analytics/get-started-analyze-storage#create-csv-and-parquet-files-in-your-storage-account) to understand how to export data to a single CSV file and Parquet file.|
|**Can I modify the exported data after the first export?**|No. Once the results are stored, the data in the external table can't be modified. CETAS doesn't overwrite the underlying data created in the first execution.<br><br>**Workaround:**<br>As an alternative, you can create a new external table that writes to a different folder.|
|**What are the supported export file formats?**|Only PARQUET and DELIMITEDTEXT are currently supported.<br>Gzip compression of the DELIMITEDTEXT format isn't supported.<br><br>More details in [CETAS in serverless SQL pool](/azure/synapse-analytics/sql/develop-tables-cetas).|
|**Why am I getting failures to connect to storage?**|- Make sure you've created appropriate credentials for both the source and destination storage accounts as specified in [control storage access for serverless SQL pool](/azure/synapse-analytics/sql/develop-storage-files-storage-access-control).<br><br> - Make sure you have appropriate [permissions](/azure/synapse-analytics/sql/develop-tables-cetas#permissions) on the source and destination storage accounts.|
|**How can I make my CETAS statements more performant?**|- Make sure the destination storage account is in the same region as your serverless SQL pool endpoint. In the Azure portal, you can find storage account and workspace regions in the **Overview** pane of your storage account or workspace.<br><br>- Make sure you use [data types supported by CETAS](/azure/synapse-analytics/sql/develop-tables-cetas#supported-data-types).|
