---
title: Error 105005 when you do CETAS to blob storage
description: This article provides resolutions for the error that occurs when you do a CETAS operation to Azure Blob storage by using PolyBase.
ms.date: 05/09/2025
ms.custom: sap:Parallel Data Warehouse (APS)
ms.reviewer: daleche, christys, ccaldera
---
# Error 105005 when you do CETAS operation to Azure blob storage

This article helps you resolve the problem that occurs when you do a `CREATE EXTERNAL TABLE AS SELECT (CETAS)` operation to Azure Blob storage by using PolyBase.

_Original product version:_ &nbsp; SQL Server Parallel Data Warehouse (APS)   
_Original KB number:_ &nbsp; 3210540

## Symptoms

When you do a [CREATE EXTERNAL TABLE (Transact-SQL)](/sql/t-sql/statements/create-external-table-transact-sql) operation to Azure blob storage by using [What is PolyBase?](/sql/relational-databases/polybase/polybase-guide) from the Microsoft SQL Server Parallel Data Warehouse (PDW) appliance, the Azure service returns the following error message:

```console
Msg 105005, Level 16, State 1, Server [Server name], LineLineNumber
CREATE EXTERNAL TABLE AS SELECT statement failed as the path name 'wasbs://[Container name]@[Storage name].blob.core.windows.net/[Location name]' could not be used for export.
Please ensure that the specified path is a directory which exists or can be created, and that files can be created in that directory.
```

## Cause

This error occurs because PolyBase can't complete the operation. The operation failure can be due to one or both of the following:

- Network failure when you try to access the Azure blob storage on the required network ports.
- The configuration of the Azure storage account

## Resolution

To fix this issue, make sure that the following prerequisites are met.

- **Network requirements**:

  Allow local firewall ports 80 and 443 outbound to *.blob.core.windows.net from CTL01 node through provided internet connectivity.
  
- **Storage account requirements**:

  - Make sure that the storage account is configured as a standard storage account that uses either of the following storage replication options (Classic or Resource Manager based):

    - Standard Locally Redundant Storage (Standard-LRS)
    - Standard Geo-Redundant Storage (Standard-GRS)

  - For Resource Manager based storage accounts:

    Configure the account for General Purpose.
  
> [!NOTE]
> When you use Resource Manager Based storage accounts, make sure that the account is configured for General Purpose. If you use Blob Store, an error message will be returned.

## More information

For more information about PolyBase, see the following Azure articles:

- [Tutorial: Load data to Azure Synapse Analytics SQL pool](/azure/synapse-analytics/sql-data-warehouse/load-data-wideworldimportersdw)

- [Best practices for loading data using Synapse SQL pool](/azure/synapse-analytics/sql-data-warehouse/guidance-for-loading-data)
