---
title: Error 302 when the Distribution Agent applies snapshot scripts
description: Describes the symptoms that error 302 occurs when the Distribution Agent applies snapshot scripts.
ms.date: 02/15/2023
ms.custom: KB5023107
appliesto:
- SQL Server 2022 on Windows
---
# KB5023107 - FIX: Error 302 when the Distribution Agent applies snapshot scripts

## Symptoms

When the Distribution Agent attempts to apply a snapshot generated on a table that has a primary key that has the NEWSEQUENTIALID function as a default value, the following error occurs:

>The newsequentialid() built-in function can only be used in a DEFAULT expression for a column of type 'uniqueidentifier' in a CREATE TABLE or ALTER TABLE statement.  It cannot be combined with other operators to form a complex scalar expression.

## Resolution

This problem is fixed in the following cumulative update for SQL Server:

[Cumulative Update 1 for SQL Server 2022](cumulativeupdate1.md)

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

Latest cumulative update for SQL Server 2022

## References

Learn about the [terminology](../../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates.