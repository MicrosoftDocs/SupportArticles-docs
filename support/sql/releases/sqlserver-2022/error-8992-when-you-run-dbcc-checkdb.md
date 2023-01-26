---
title: Error 8992 when you run DBCC CHECKDB against the cloned database
description: Describes the symptoms that error 8992 occurs when you run DBCC CHECKDB against the cloned database in Microsoft SQL Server 2022.
ms.date: 02/15/2023
ms.custom: KB5023105
appliesto:
- SQL Server 2022 on Linux
- SQL Server 2022 on Windows
---
# KB5023105 - FIX: Error 8992 when you run DBCC CHECKDB against the cloned database

## Symptoms

In Microsoft SQL Server 2022, assume that you use DBCC CLINEDATABASE on a database where change data capture (CDC) is enabled and create roles assigned to the CDC user in this database. When you run DBCC CHECKDB against the cloned database, the following error occurs:

>Msg 8992, Level 16, State 1, Line <*LineNumber*></br>
Check Catalog Msg 3853, State 1: Attribute (owning_principal_id=*ID*) of row (principal_id=*ID*) in sys.database_principals does not have a matching row (principal_id=*ID*) in sys.database_principals.

## Resolution

This problem is fixed in the following cumulative update for SQL Server:

[Cumulative Update 1 for SQL Server 2022](cumulativeupdate1.md)

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

Latest cumulative update for SQL Server 2022

## References

Learn about the [terminology](../../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates.