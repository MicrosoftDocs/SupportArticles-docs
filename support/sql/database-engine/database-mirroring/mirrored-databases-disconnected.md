---
title: Mirrored databases are disconnected
description: This article provides a resolution for the problem where mirrored databases are left in a Disconnected or In Recovery state.
ms.date: 11/05/2020
ms.custom: sap:Database Mirroring
ms.reviewer: ramakoni
---
# Mirrored databases are disconnected after you restart the database mirror in SQL Server

This article helps you resolve the problem where mirrored databases are left in a **Disconnected** or **In Recovery** state.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2490051

## Symptom

Consider the following scenario:

- You have a computer that's running a secondary instance of Microsoft SQL Server in a two-server database mirror.

- CPU usage reaches 100 percent on the computer, and you can't stop the SQL Server service by using SQL Server Management Tools.

- You end the process of the SQL Server secondary instance by using Task Manager.

- You restart the secondary instance of SQL Server.

In this scenario, all mirrored databases are in a **Disconnected** or **In Recovery** state. Additionally, an error message that resembles the following is logged in the SQL Server error log for each database:

> Bypassing recovery for database 'Database Name' because it is marked as an inaccessible database mirroring database. A problem exists with the mirroring session. The session either lacks a quorum or the communications links are broken because of problems with links, endpoint configuration, or permissions (for the server account or security certificate). To gain access to the database, figure out what has changed in the session configuration and undo the change.

## Cause

This issue occurs because of problems in the SQL Server database mirroring endpoints.

## Resolution

To resolve this issue, use the following methods. If the first method doesn't resolve the issue, use the second method.

## Method 1

Recycle the endpoint on the database mirror. To do this, follow these steps:

1. On the principal database, run the following SQL script to stop the endpoint:

    ```sql
    ALTER ENDPOINT <Endpoint Name> STATE=STOPPED
    ```

2. Execute the following SQL script to restart the endpoint:

    ```sql
    ALTER ENDPOINT <Endpoint Name> STATE=STARTED
    ```

    > [!NOTE]
    > If communication between the endpoints doesn't restart after you execute the scripts, run the scripts on the database mirror. However, the database may enter a **Suspended** state after you do this. If this issue occurs, run the following SQL script:

    ```sql
    ALTER DATABASE <Database Name> SET PARTNER RESUME
    ```

## Method 2

Delete and re-create the database mirroring endpoints on both servers.
