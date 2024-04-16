---
title: Access violations when you cancel a DB2 query
description: This article provides a resolution for the problem that occurs when a user cancels a linked server query against an IBM DB2 database.
ms.date: 10/13/2020
ms.custom: sap:Data Integration (DB2, Host Files)
---
# SQL Server may experience access violations when canceling a DB2 query

This article helps you resolve the problem that occurs when a user cancels a linked server query against an IBM DB2 database.

_Original product version:_ &nbsp; Host Integration Server 2010  
_Original KB number:_ &nbsp; 2761993

## Symptoms

Consider the following scenario:

- You have a Linked Server that connects to an IBM DB2 database using the OLE DB Provider for DB2.

- The DB2 connection string includes the `Rowset Cache Size` parameter with a non-zero value (for example, `Rowset Cache Size=100`).

If a user attempts to cancel a query that is currently executing via the Linked Server to the IBM DB2 database, the SQL Server process may report an access violation and create a dump file.

## Cause

The problem occurs because of a synchronization problem in the Microsoft OLE DB Provider for DB2 when canceling a running query when the `Rowset Cache Size` feature is enabled.

## Resolution

Change the DB2 connection string in the Linked Server to include the parameter: `Rowset Cache Size=0`

The SQL Server process needs to be restarted after making this change to make sure the new connection string is loaded by the DB2 provider.

## More information

The `RowSet Cache Size` parameter instructs the DB2 data provider to pre-fetch rows from DB2 while concurrently processing and returning rows to the data consumer. This feature may improve performance in bulk read-only operations on multi-processor or multi-core computers. The default value for this property is **0** (Rowset Cache Size=0), which indicates that the optional pre-fetch feature is "off".

It is not recommended to enable this parameter (use a non-zero value) for scenarios other than bulk-read operations that require a high level of performance.
