---
title: SQL Server merge replication can't sync
description: This article provides resolutions for the problem where synchronization for SQL Server merge replication fails when a table article uses a stored procedure custom conflict resolver.
ms.date: 03/16/2020
ms.custom: sap:Replication, change tracking, change data capture
ms.reviewer: holgerl, sqlblt
---
# Synchronization for SQL Server merge replication fails when an article uses a stored procedure custom conflict resolver

This article helps you work around the problem where synchronization for SQL Server merge replication fails when a table article uses a stored procedure custom conflict resolver.

_Original product version:_ &nbsp; SQL Server 2008 R2, SQL Server 2008, SQL Server 2005  
_Original KB number:_ &nbsp; 2585632

## Symptoms

Consider the following scenario:

- You configure merge replication in Microsoft SQL Server 2008 R2, in Microsoft SQL Server 2008, or in Microsoft SQL Server 2005.
- The publication contains a table article.
- The table article contains columns of data type `varchar` or `nvarchar`.

    > [!NOTE]
    > The table article may contain columns of both data types.
- The table article also contains a column of data type `decimal`.

    > [!NOTE]
    > The table may also contain a column of data type `numeric`  or `money`.
- A column of data type `uniqueidentifier` that has the `Rowguidcol` property isn't the last column in the table. For example, a column of data type `decimal`, `numeric`, or `money` is sorted after the `uniqueidentifier` column.
- You configure the table article to use a stored procedure custom conflict resolver.
- A conflict is detected for the table article.

In this scenario, the synchronization may fail during the conflict resolution. When this issue occurs, you may receive an error message that resembles one of the following:

Error message 1  

> The Merge Agent failed because the schema of the article at the Publisher does not match the schema of the article at the Subscriber. This can occur when there are pending DDL changes waiting to be applied at the Subscriber.  
> Restart the Merge Agent to apply the DDL changes and synchronize the subscription.

Error message 2  

> The merge process could not store conflict information for article 'article_name'. Check the publication properties to determine where conflicts records are stored.  
> Invalid character value for cast specification.

These errors are reported by the merge agent if the merge agent job fails.

## Cause

This issue occurs because the data that is returned by the stored procedure custom conflict resolver is converted incorrectly to the SQL Server data types in the base tables.

> [!NOTE]
> The stored procedure returns the correct data.

## Status

Microsoft has confirmed that this is a bug in the Microsoft products that are listed in **Original product version** at the beginning of this article.

## Workaround 1: Cast the columns of data type varchar to char

> [!NOTE]
> The error message that you receive depends on the table definition. You may have to try variations of these methods to work around the issue.

To work around this issue, cast the columns of data type `varchar` to data type `char` in the stored procedure custom conflict resolver code.

## Workaround 2: Change the column order in the underlying table

To work around this issue, change the column order in the underlying table. For example, change the column order so that the `uniqueidentifier` column that has the `Rowguidcol` property is sorted after the columns of data type `decimal`, `numeric`, `money`, and `varchar`.

> [!NOTE]
> You may have to drop and then re-add columns to change the sort order. Additionally, the issue may reoccur if you add columns later.
