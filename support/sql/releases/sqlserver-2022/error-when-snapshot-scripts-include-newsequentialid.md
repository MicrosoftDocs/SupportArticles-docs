---
title: Error when snapshot scripts include NEWSEQUENTIALID as a default value
description: Describes the symptoms that an error occurs when snapshot scripts include the NEWSEQUENTIALID function as a default value.
ms.date: 02/15/2023
ms.custom: KB5023107
appliesto:
- SQL Server 2022 on Windows
---
# KB5023107 - FIX: Error when snapshot scripts include NEWSEQUENTIALID as a default value

## Symptoms

When the distributor agent attempts to apply a snapshot generated on a table that has a primary key that has the NEWSEQUENTIALID function as a default value, the following error occurs:

>The newsequentialid() built-in function can only be used in a DEFAULT expression for a column of type 'uniqueidentifier' in a CREATE TABLE or ALTER TABLE statement.  It cannot be combined with other operators to form a complex scalar expression.

## Resolution

This problem is fixed in the following cumulative update for SQL Server:

[Cumulative Update 1 for SQL Server 2022](cumulativeupdate1.md)

> [!NOTE]
> This fix is used for bypassing the previous change in [KB5018231 - FIX: Error 20598 after adding columns that have default constraints as part of the primary key for an existing table and configuring transactional replication](https://support.microsoft.com/help/5018231) when the NEWSEQUENTIALID function is a default value.

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

Latest cumulative update for SQL Server 2022

## References

Learn about the [terminology](../../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates.