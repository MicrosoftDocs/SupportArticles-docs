---
title: Troubleshoot Azure Synapse Link for serverless SQL pool
description: Provides solutions for common issues experienced on Azure Synapse Link for Azure Synapse Analytics serverless SQL pool.
ms.date: 02/21/2023
ms.reviewer: scepperl, v-sidong, goventur
---

# Troubleshoot Azure Synapse Link for Azure Synapse Analytics serverless SQL pool

_Applies to:_ &nbsp; Azure Synapse Analytics

This article provides solutions for common issues experienced on Azure Synapse Link for Azure Synapse Analytics serverless SQL pool.

## Azure Synapse Link for Dataverse

### Data Export Service (DES) deprecation

Learn how to transition from Data Export Service to Azure Synapse Link for Dataverse with the following articles:

- [DES deprecation playbook](/shows/dynamics-365-fasttrack-architecture-insights/best-practice-des-deprecation-playbook)
- [Data Export Services (DES) - Deprecation note](https://community.dynamics.com/forums/thread/details/?threadid=47795f6f-fa49-4f55-bb9d-6d6ab3f5e7f5)
- [From Data Export Service to Azure Synapse Link for Dataverse](https://powerapps.microsoft.com/blog/do-more-with-data-from-data-export-service-to-azure-synapse-link-for-dataverse)

### Near real-time data and read-only snapshot data

After you create an Azure Synapse Link for Dataverse, there will be two versions of the table data that will be synchronized in Azure Synapse Analytics and/or Azure Data Lake Storage Gen2:

|Table type|Description|
|--|--|
|**Near real-time data**|Provides a copy of data synchronized from Dataverse by using Azure Synapse Link in an efficient manner by detecting what data has changed since it was initially extracted or last synchronized.|
|**Snapshot data**|Provides a read-only copy of near real-time data that's updated at regular intervals (in this case, every hour).|

For more information, see [Access near real-time data and read-only snapshot data](/power-apps/maker/data-platform/azure-synapse-link-synapse#access-near-real-time-data-and-read-only-snapshot-data).

### Incremental updates (Preview)

When creating an Azure Synapse Link for Dataverse with your Azure Synapse workspace, you can enable the incremental update feature to create a series of time-stamped folders containing only the changes to the Dataverse data that occurred during the user-specified time interval.

For more information, see [Query and analyze the incremental updates (preview)](/power-apps/maker/data-platform/azure-synapse-incremental-updates).

## Azure Synapse Link for Azure Cosmos DB

### Accessing Azure Cosmos DB data

You can query Azure Cosmos DB data in the analytical store using Spark pools and serverless SQL pools. Resolve common issues by following the steps in these articles:

- [Spark pools](/azure/synapse-analytics/synapse-link/how-to-query-analytical-store-spark)
- [Serverless SQL pools](/azure/synapse-analytics/sql/query-cosmos-db-analytical-store?tabs=openrowset-credential)

### Can't query Azure Cosmos DB container

Make sure you've properly configured Azure Synapse Link and the analytical store in the Azure Cosmos DB account.

### Understand schema representation

There are two modes of schema representation in the analytical store. These modes have tradeoffs between the simplicity of a columnar representation, handling the polymorphic schemas, and simplicity of query experience:

- Well-defined schema representation (default for Azure Cosmos DB SQL API)
- Full fidelity schema representation (default for Azure Cosmos DB's API for MongoDB)  

Learn how to [automatically handle analytical store schemas](/azure/cosmos-db/analytical-store-introduction#analytical-schema).  

### Missing properties (columns) in the query result

If you're missing columns that exist in your Azure Cosmos DB containers, it's probable that the schema constraints have been violated. The following constraints are applicable to the operational data in Azure Cosmos DB when you enable the analytical store to automatically infer and represent the schema correctly:

- You can have a maximum of 1,000 properties across all nested levels in the document schema and a maximum nesting depth of 127.
- Only the first 1,000 properties are represented in the analytical store.
- Only the first 127 nested levels are represented in the analytical store.
- The first level of a JSON document is its root level.
- Properties in the first level of the document will be represented as columns.

For more information on the schema constraints, see [Analytical store - Overview](/azure/cosmos-db/analytical-store-introduction#analytical-schema).

All transactional operations are propagated, including deletes. The analytical store time to live (TTL) setting also can cause data removal.

- If a document is deleted in the transactional store, it will also be deleted from the analytical store, despite both stores' TTLs.
- If transactional TTL is smaller than analytical TTL, the data is archived from the transactional store but kept in the analytical store up to the configured TTL limit.
- If transactional TTL is bigger than analytical TTL, data is archived from the analytical store and kept in the transactional store up to the configured TTL limit.
- If you use the SQL API, the schema is well-defined by default, meaning that the first document in the collection defines the analytical store schema. If a document doesn't conform to the first document's schema, it won't be synched to the analytical store.  

### Resources

- [What is Azure Cosmos DB analytical store?](/azure/cosmos-db/analytical-store-introduction)
- [Analytical store Time-to-Live (TTL) overview](/azure/cosmos-db/analytical-store-introduction#analytical-ttl)
- [Frequently asked questions about Azure Synapse Link for Azure Cosmos DB](/azure/cosmos-db/synapse-link-frequently-asked-questions)
- [Schema representation](/azure/cosmos-db/analytical-store-introduction#schema-representation)

