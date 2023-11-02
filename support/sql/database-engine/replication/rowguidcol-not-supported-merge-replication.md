---
title: Rowguidcol is not supported in merge replication
description: This article describes that using rowguidcol in filter definition is not supported in merge replication.
ms.date: 09/22/2020
ms.custom: sap:Replication
---
# Using rowguidcol in filter definition is not supported in merge replication

This article describes that using `rowguidcol` in filter definition is not supported in merge replication.

_Original product version:_ &nbsp; SQL Server 2008 Enterprise, SQL Server 2008 R2 Enterprise, SQL Server 2005 Enterprise Edition  
_Original KB number:_ &nbsp; 2646528

## Summary

When designing a replication topology, a filter must not include the `rowguidcol` and `uniqueidentitifier` used by replication to identify rows. By default, SQL Server adds this column when setting up merge replication on a table.

## More information

To track changes, merge replication (and transactional replication with queued updating subscriptions) must be able to uniquely identify every row in every published table.

To accomplish this merge replication adds the column rowguid to every table, unless the table already has a column of data type `uniqueidentifier` with the `ROWGUIDCOL` property set (in which case this column is used).

If the table is dropped from the publication, the rowguid column is removed; if an existing column was used for tracking, the column is not removed. A filter must not include the `rowguidcol` used by replication to identify rows. When replication is configured, the `newsequentialid()` function is provided as a default for the rowguid column or user column with `rowguidcol`.

It is possible for customers to provide a guid for each row if needed, though the value **00000000-0000-0000-0000-000000000000** should not be used.
