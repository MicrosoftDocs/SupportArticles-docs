---
title: Object Explorer intermittently crashes
description: This article provides resolution for the problem where the Object Explorer intermittently hangs when you use SQL Server Management Studio 2012 or a later version.
ms.date: 09/10/2020
ms.custom: sap:Tools
ms.reviewer: cbenkler, daleche
---
# Object Explorer intermittently hangs when you use SSMS 2012 or later

This article helps you resolve the problem where the Object Explorer intermittently hangs when you use SQL Server Management Studio (SSMS) 2012 or a later version.

_Original product version:_ &nbsp; Microsoft SQL Server Management Studio  
_Original KB number:_ &nbsp; 4091777

## Symptoms

Object Explorer intermittently hangs when you use SSMS. This issue applies to all versions starting from SSMS 2012.

This issue may occur anytime that Object Explorer is in focus (for example, when you click an item in the tree). However, this issue occurs only if all the following conditions are true:

- SQL Server authentication is used.
- The default database for the logon that is used to connect is not the master.
- The SSMS version is 2012 or a later version.
- Object Explorer is connected to the database engine.

    > [!NOTE]
    > Query windows do not experience this issue.

## Cause

This issue is caused by a type of race condition that occurs between threads that are used by Object Explorer.

## Resolution

To prevent this issue from occurring, use any of the following methods:

- Method 1: Use Windows Authentication.
- Method 2: Change the default database setting to the master database for the login.
- Method 3: Change the SSMS connection string to request a connection to the master database.

## For Method 2

To change the default database for the login, run the following commands by using a login that has the ALTER ANY LOGIN permission:

```sql
USE [master]
GO
ALTER LOGIN [YourLogin] WITH DEFAULT_DATABASE=[master]
GO
```

## For Method 3

To change the SSMS connection string, follow these steps:

1. In Object Explorer, click **Connect**, and then click **Database Engine**.

    :::image type="content" source="media/object-explorer-intermittently-crashes/database-engine.png" alt-text="Screenshot of the Connect menu of Object Explorer.":::

2. In the **Connect to Server** window, click the **Options** button.

    :::image type="content" source="media/object-explorer-intermittently-crashes/connect-to-server.png" alt-text="Screenshot of the Connect to Server window.":::

3. On the **Connection Properties** tab, enter *master* in the **Connect to database** field, and then click **Connect**.

    :::image type="content" source="media/object-explorer-intermittently-crashes/connection-properties.png" alt-text="Screenshot of the Connection Properties tab of the Connect to Server window.":::
