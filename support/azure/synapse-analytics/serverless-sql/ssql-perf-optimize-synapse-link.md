---
title: Troubleshooting Synapse Link for Azure Synapse Analytics serverless SQL pool
description: Solutions for common issues experienced on Synapse Link for Azure Synapse Analytics serverless SQL pool
ms.date: 01/31/2023
author: scott-epperly
ms.author: goventur
ms.reviewer: scepperl
---

# Troubleshooting Synapse Link for Azure Synapse Analytics serverless SQL pool

_Applies to:_ &nbsp; Azure Synapse Analytics

need a description here

## Synapse Link for Dataverse

### Data Export Service (DES) deprecation

Learn how to transition from Data Export Service to Azure Synapse Link for Dataverse with the following articles:

- [DES deprecation playbook](/shows/dynamics-365-fasttrack-architecture-insights/best-practice-des-deprecation-playbook)
- [Data Export Services (DES) - Deprecation note](https://community.dynamics.com/365/f/dynamics-365-general-forum/442397/data-export-services-des---deprecation---metadata-information)
- [From Data Export Service to Azure Synapse Link for Dataverse](https://powerapps.microsoft.com/blog/do-more-with-data-from-data-export-service-to-azure-synapse-link-for-dataverse)

### Near real-time data and read-only snapshot data

After creating an Azure Synapse Link, two versions of the table data will be synchronized in Azure Synapse Analytics and/or Azure Data Lake Storage Gen2 in your Azure subscription by default to ensure you can reliably consume updated data in the lake at any given time:

|Table type|Description|
|--|--|
|**Near real-time data**|Provides a copy of data synchronized from Dataverse by using Synapse Link in an efficient manner by detecting what data has changed since it was initially extracted or last synchronized.|
|**Snapshot data**|Provides a read-only copy of near real-time data that's updated at regular intervals (in this case every hour).|

For more information, see [Access near real-time data and read-only snapshot data](/power-apps/maker/data-platform/azure-synapse-link-synapse#access-near-real-time-data-and-read-only-snapshot-data).

### Incremental updates (Preview)

When creating an Azure Synapse Link for Dataverse with your Azure Synapse workspace, you can enable the incremental update feature to create a series of time-stamped folders containing only the changes to the Dataverse data that occurred during the user-specified time interval.

For more information, see [Query and analyze the incremental updates (preview)](/power-apps/maker/data-platform/azure-synapse-incremental-updates).

## Synapse Link for Azure Cosmos DB

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

If you don't see some of the columns that represent properties existing in your Azure Cosmos DB containers, check the constraints.

You can have a maximum of 200 properties at any nesting level in the schema and a maximum nesting depth of 5. An item with 201 properties doesn't meet this constraint and will not be represented in the analytical store. An item with more than 5 nested levels in the schema also doesn't meet this constraint and will not be represented in the analytical store.  

Another possible cause is that if the Azure Cosmos DB analytical store follows the well-defined schema representation and the specification above is violated by certain items, those items will not be included in the analytical store. Learn how to [automatically handle analytical store schemas](/azure/cosmos-db/analytical-store-introduction#analytical-schema).  

All transactional operations are propagated, including deletes. The analytical store time to live (TTL) setting also can cause data removal.

- If a document is deleted in transactional store, it will also be deleted from analytical store, despite both store's TTLs.
- If transactional TTL is smaller than analytical TTL, the data is archived from transactional store but kept in analytical store up to the configured TTL limit.
- If transactional TTL is bigger than analytical TTL, data will be archived from analytical store and kept in transactional store up to the configured TTL limit.
- If you use the SQL API, the schema is well-defined by default, meaning that the first document in the collection will define the analytical store schema. Documents that violate that format won't be synced to the analytical store.  

### Additional resources

- [What is Azure Cosmos DB analytical store](/azure/cosmos-db/analytical-store-introduction)
- [Analytical store time to live (TTL) overview](/azure/cosmos-db/analytical-store-introduction#analytical-ttl)
- [Frequently asked questions about Synapse Link for Azure Cosmos DB](/azure/cosmos-db/synapse-link-frequently-asked-questions)
- [Schema representation](/azure/cosmos-db/analytical-store-introduction#schema-representation)