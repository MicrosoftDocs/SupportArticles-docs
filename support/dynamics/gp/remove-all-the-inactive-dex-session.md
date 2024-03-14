---
title: Remove all the inactive sessions from the DEX_SESSION table
description: Describes how to remove all the inactive sessions from the DEX_SESSION table in the TempDB database.
ms.reviewer: theley
ms.topic: how-to
ms.date: 02/22/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# How to remove all the inactive sessions from the DEX_SESSION table in the TempDB database when you use Microsoft Dynamics GP together with Microsoft SQL Server

This article describes how to remove all the inactive sessions from the `DEX_SESSION `table in the TempDB database when you use Microsoft Dynamics GP together with Microsoft SQL Server.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 864413

## Introduction

To remove the inactive sessions, you must first find the inactive sessions. After you find the inactive sessions, you must delete them. To do it, use the appropriate method.

## Microsoft SQL Server

1. Start Microsoft SQL Server Management Studio.
2. Find the inactive sessions. To do it, paste the following statement in the **New Query** window, and then run the statement against the `DEX_SESSION` table.

    ```sql
    SELECT * from TempDB..DEX_SESSION where Session_ID not in (SELECT SQLSESID from DYNAMICS..ACTIVITY)
    ```

3. Delete the inactive sessions in the `DEX_SESSION` table. To do it, paste the following statement in the **New Query** window, and then run the statement against the `DEX_SESSION` table.

    ```sql
    DELETE TempDB..DEX_SESSION where Session_ID not in (SELECT SQLSESID from DYNAMICS..ACTIVITY
    ```

For more information about how to remove inactive sessions from the `DEX_LOCK` table, see [How to remove all the inactive sessions from the DEX_LOCK table in the TempDB database when you use Microsoft Dynamics GP together with Microsoft SQL Server](remove-all-the-inactive-sessions-dex-lock.md).
