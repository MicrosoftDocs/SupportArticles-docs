---
title: Troubleshooting Azure Synapse Link for Azure Synapse Analytics serverless SQL pool
description: Solutions for common issues experienced on Azure Synapse Link for Azure Synapse Analytics serverless SQL pool
ms.date: 01/31/2023
author: scott-epperly
ms.author: goventur
ms.reviewer: scepperl
---

# Troubleshooting Azure Synapse Link for Azure Synapse Analytics serverless SQL pool

_Applies to:_ &nbsp; Azure Synapse Analytics

need a description here

## Azure Synapse Link for Dataverse

### Data Export Service (DES) deprecation

Learn how to transition from Data Export Service to Azure Synapse Link for Dataverse with the following articles:

- [DES deprecation playbook](/shows/dynamics-365-fasttrack-architecture-insights/best-practice-des-deprecation-playbook)
- [Data Export Services (DES) - Deprecation note](https://community.dynamics.com/365/f/dynamics-365-general-forum/442397/data-export-services-des---deprecation---metadata-information)
- [From Data Export Service to Azure Synapse Link for Dataverse](https://powerapps.microsoft.com/blog/do-more-with-data-from-data-export-service-to-azure-synapse-link-for-dataverse)

### Near real-time data and read-only snapshot data

After you create an Azure Synapse Link for Dataverse, there will be two versions of the table data that will be synchronized in Azure Synapse Analytics and/or Azure Data Lake Storage Gen2:

|Table type|Description|
|--|--|
|**Near real-time data**|Provides a copy of data synchronized from Dataverse by using Azure Synapse Link in an efficient manner by detecting what data has changed since it was initially extracted or last synchronized.|
|**Snapshot data**|Provides a read-only copy of near real-time data that's updated at regular intervals (in this case every hour).|

For more information, see [Access near real-time data and read-only snapshot data](/power-apps/maker/data-platform/azure-synapse-link-synapse#access-near-real-time-data-and-read-only-snapshot-data).

### Incremental updates (Preview)

When creating an Azure Synapse Link for Dataverse with your Azure Synapse workspace, you can enable the incremental update feature to create a series of time-stamped folders containing only the changes to the Dataverse data that occurred during the user-specified time interval.

For more information, see [Query and analyze the incremental updates (preview)](/power-apps/maker/data-platform/azure-synapse-incremental-updates).

## Azure Synapse Link for Azure Cosmos DB

### Accessing Azure Cosmos DB data

You can query Azure Cosmos DB data in the analytical store using Spark pools and serverless SQL pools. Resolve common issues by following the steps found in these articles:

- [Spark pools](/azure/synapse-analytics/synapse-link/how-to-query-analytical-store-spark) 
- [Serverless SQL pools](/azure/synapse-analytics/sql/query-cosmos-db-analytical-store?tabs=openrowset-credential)

### Can't query Azure Cosmos DB container

Make sure you've properly configured Azure Synapse Link and the analytical store in the Azure Cosmos DB account.

### Understanding schema representation

There are two modes of schema representation in the analytical store. These modes have tradeoffs between the simplicity of a columnar representation, handling the polymorphic schemas, and simplicity of query experience:

- Well-defined schema representation (default for Azure Cosmos DB SQL API)
- Full fidelity schema representation (default for Azure Cosmos DB's API for MongoDB)  

Learn how to [automatically handle analytical store schemas](/azure/cosmos-db/analytical-store-introduction#analytical-schema).  

### Missing properties (columns) in the query result

If you're missing columns that exist in your Azure Cosmos DB containers, it's probable that the schema constraints have been violated.  The following constraints are applicable on the operational data in Azure Cosmos DB when you enable analytical store to automatically infer and represent the schema correctly:

* You can have a maximum of 1000 properties across all nested levels in the document schema and a maximum nesting depth of 127.
    * Only the first 1000 properties are represented in the analytical store.
    * Only the first 127 nested levels are represented in the analytical store.
    * The first level of a JSON document is its / root level.
    * Properties in the first level of the document will be represented as columns.

For more information on the schema constraints, see [Analytical store - Overview](/azure/cosmos-db/analytical-store-introduction#analytical-schema).

All transactional operations are propagated, including deletes. The analytical store time to live (TTL) setting also can cause data removal.

- If a document is deleted in transactional store, it will also be deleted from analytical store, despite both store's TTLs.
- If transactional TTL is smaller than analytical TTL, the data is archived from transactional store but kept in analytical store up to the configured TTL limit.
- If transactional TTL is bigger than analytical TTL, data will be archived from analytical store and kept in transactional store up to the configured TTL limit.
- If you use the SQL API, the schema is well-defined by default, meaning that the first document in the collection will define the analytical store schema. If a document doesn't conform to the first document's schema, then it won't be synced to the analytical store.  

### Resources

- [What is Azure Cosmos DB analytical store](/azure/cosmos-db/analytical-store-introduction)
- [Analytical store time to live (TTL) overview](/azure/cosmos-db/analytical-store-introduction#analytical-ttl)
- [Frequently asked questions about Azure Synapse Link for Azure Cosmos DB](/azure/cosmos-db/synapse-link-frequently-asked-questions)
- [Schema representation](/azure/cosmos-db/analytical-store-introduction#schema-representation)