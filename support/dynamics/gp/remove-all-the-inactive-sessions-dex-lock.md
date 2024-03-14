---
title: Remove all the inactive sessions
description: Describes how to remove all the inactive sessions from the DEX_LOCK table in the TempDB database when you use Microsoft Dynamics GP together with Microsoft SQL Server.
ms.reviewer: theley
ms.topic: how-to
ms.date: 02/18/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# How to remove all the inactive sessions from the DEX_LOCK table in the TempDB database when you use Microsoft Dynamics GP together with Microsoft SQL Server

This article describes how to remove all the inactive sessions from the DEX_LOCK table in the TempDB database by using Microsoft SQL Server.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 864411

## Summary

Delete the IDs for inactive sessions from the DEX_LOCK table by using the appropriate method, depending on the version of SQL Server that you use.

## For SQL Server 2019 and later

1. Show all the session IDs that are in the DEX_LOCK table that aren't associated with active sessions in the ACTIVITY table in the DYNAMICS database. To do it, run the following script in SQL Server Management Studio.

    ```sql
    SELECT * from TempDB..DEX_LOCK where Session_ID not in (SELECT SQLSESID from DYNAMICS..ACTIVITY)
    ```

2. Delete any ghost sessions in the DEX_LOCK table. To do it, run the following script in SQL Server Management Studio.

    ```sql
    DELETE TempDB..DEX_LOCK where Session_ID not in (SELECT SQLSESID from DYNAMICS..ACTIVITY)
    ```

For more information about how to remove inactive sessions from the DEX_LOCK table, see [How to remove all the inactive sessions from the DEX_SESSION table in the TempDB database when you use Microsoft Dynamics GP together with Microsoft SQL Server](remove-all-the-inactive-dex-session.md).
