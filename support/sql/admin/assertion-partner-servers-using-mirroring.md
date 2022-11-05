---
title: You might encounter a 'result == LCK_OK' assertion on a SQL Server mirror server  
description: This article provides a workaround for the problem that can occur on a partner server when using SQL Server mirroring architecture.
ms.date: 11/03/2022
ms.custom: sap:Administration and Management
ms.reviewer: 
ms.prod: sql
---

# You might encounter a 'result == LCK_OK' assertion on a SQL Server mirror server

_Original product version:_ &nbsp; SQL Server 2014, SQL Server 2012, SQL Server 2008 R2, SQL Server 2008
_Original KB number:_ &nbsp; 2729953

This article discusses Microsoft SQL Server assertion failure that can occur on a partner server when using SQL Server mirroring architecture.

## Symptoms

In SQL Server mirroring architecture, you might encounter a SQL Server assertion check failure on the partner (mirror) server. In such a case, check the SQL Server error log for details. In the log, you will find an error message that resembles the following message. This error usually means that you must rebuild the mirror pair.

> SQL Server Assertion: File: loglock.cpp, line=834 Failed Assertion = 'result == LCK_OK' . This error may be timing related. If the error persists after re-running the statement, use DBCC CHECKDB to check the database for structural integrity, or restart the server to ensure in-memory data structures are not corrupted.

> Error: 3624, Severity: 20, State: 1.

