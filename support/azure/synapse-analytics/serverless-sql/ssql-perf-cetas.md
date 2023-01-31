---
title: Troubleshoot issues with CREATE EXTERNAL TABLE AS SELECT (CETAS) on Azure Synapse serverless SQL pools
description: FAQs about common issues with CETAS on Azure Synapse serverless SQL pools
ms.date: 01/31/2023
author: scott-epperly
ms.author: goventur
ms.reviewer: scepperl
---

# Troubleshoot issues with CREATE EXTERNAL TABLE AS SELECT (CETAS) on Azure Synapse serverless SQL pools

_Applies to:_ &nbsp; Azure Synapse Analytics

The [CREATE EXTERNAL TABLE AS SELECT](https://learn.microsoft.com/azure/synapse-analytics/sql/develop-tables-cetas) (also known as CETAS) statement in Azure Synapse serverless SQL pools is used to create an external table and export query results to Azure Storage Blob or Azure Data Lake Storage Gen2.  Use this guide to assist you with implementing best practices and implementing workarounds for the most common issues with exporting data with CETAS.

|FAQ|Recommendation|
|--|--|
|**Can I export results to a single file?**|No, serverless SQL doesn't have the ability to control the number of files when saving query results to storage using CETAS due to the highly parallel and scalable nature of the serverless SQL query engine.<br><br>**Workaround:**<br>As an alternative, you can export the data to storage using a Spark notebook.  Review [Create CSV and Parquet files in your storage account](https://learn.microsoft.com/azure/synapse-analytics/get-started-analyze-storage#create-csv-and-parquet-files-in-your-storage-account) to get an understand of how to export data to a single CSV file and Parquet file|
|**Can I modify the exported data after the first export?**|No, once the results are stored, the data in the external table can't be modified. CETAS won't overwrite the underlying data created in the first execution.<br><br>**Workaround:**<br>As an alternative, you can create a new external table that writes to a different folder.|
|**What are the supported export file formats?**|Only PARQUET and DELIMITEDTEXT are currently supported.<br>Gzip compression for DELIMITEDTEXT format isn't supported.<br><br>More details in [CETAS in serverless SQL pool](https://learn.microsoft.com/azure/synapse-analytics/sql/develop-tables-cetas).|
|**Why am I getting failures to connect to storage?**| Make sure you've created appropriate credentials for both source and destination storage accounts as specified in [control storage access for serverless SQL pool](https://learn.microsoft.com/azure/synapse-analytics/sql/develop-storage-files-storage-access-control) and that you have appropriate [permissions](https://learn.microsoft.com/azure/synapse-analytics/sql/develop-tables-cetas#permissions) on the source and destination storage accounts.|
|**How can I make my CETAS statements more performant?**|- Make sure the destination storage account is in the same region as your serverless SQL pool endpoint. You can find storage account and workspace regions in the Azure portal, in the **Overview** pane of your storage account or workspace.<br><br>- Make sure you use [data types supported by CETAS](https://learn.microsoft.com/azure/synapse-analytics/sql/develop-tables-cetas#supported-data-types).|