---
title: Remove all the inactive sessions from the DEX_SESSION table
description: Describes how to remove all the inactive sessions from the DEX_SESSION table in the TempDB database.
ms.reviewer: v-jomcc
ms.topic: how-to
ms.date: 03/31/2021
---
# How to remove all the inactive sessions from the DEX_SESSION table in the TempDB database when you use Microsoft Dynamics GP together with Microsoft SQL Server

This article describes how to remove all the inactive sessions from the DEX_SESSION table in the TempDB database when you use Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains together with Microsoft SQL Server.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 864413

## Introduction

To remove the inactive sessions, you must first find the inactive sessions. After you find the inactive sessions, you must delete them. To do it, use the appropriate method.

## Microsoft SQL Server 2000

1. Start SQL Query Analyzer.
2. Find the inactive sessions. To do it, paste the following statement in the query window, and then run the statement against the DEX_SESSION table.

    ```sql
    SELECT * from TempDB..DEX_SESSION where Session_ID not in (SELECT SQLSESID from DYNAMICS..ACTIVITY)
    ```

3. Delete the inactive sessions in the DEX_SESSION table. To do it, paste the following statement in the query window in SQL Query Analyzer, and then run the statement against the DEX_SESSION table.

    ```sql
    DELETE TempDB..DEX_SESSION where Session_ID not in (SELECT SQLSESID from DYNAMICS..ACTIVITY)
    ```

## Microsoft SQL Server 2005 and Microsoft SQL Server 2008

1. Start SQL Server Management Studio.
2. Find the inactive sessions. To do it, paste the following statement in the New Query window, and then run the statement against the DEX_SESSION table.

    ```sql
    SELECT * from TempDB..DEX_SESSION where Session_ID not in (SELECT SQLSESID from DYNAMICS..ACTIVITY)
    ```

3. Delete the inactive sessions in the DEX_SESSION table. To do it, paste the following statement in the New Query Window, and then run the statement against the DEX_SESSION table.

    ```sql
    DELETE TempDB..DEX_SESSION where Session_ID not in (SELECT SQLSESID from DYNAMICS..ACTIVITY
    ```

For more information about how to remove inactive sessions from the DEX_LOCK table, see [How to remove all the inactive sessions from the DEX_LOCK table in the TempDB database when you use Microsoft Dynamics GP together with Microsoft SQL Server](https://support.microsoft.com/help/864411).
