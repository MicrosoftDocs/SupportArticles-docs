---
title: Error 41131 when creating availability group
description: Provides resolutions for an issue where error 41131 occurs when you create an availability group in Microsoft SQL Server.
ms.date: 05/31/2022
ms.custom: sap:High Availability and Disaster Recovery features
ms.reviewer: ramakoni, v-sidong
---

# Error 41131 when creating availability group

This article provides resolutions for an issue where error 41131 occurs when you create an availability group in Microsoft SQL Server.

_Original product version:_&nbsp;SQL Server  
_Original KB number:_&nbsp;2847723

## Symptoms

When you try to create a high-availability group in Microsoft SQL Server, you receive the following error message:

> Msg 41131, Level 16, State 0, Line 2  
Failed to bring availability group 'availability_group' online. The operation timed out. Verify that the local Windows Server Failover Clustering (WSFC) node is online. Then verify that the availability group resource exists in the WSFC cluster. If the problem persists, you might need to drop the availability group and create it again.

## Cause

This issue occurs if the `[NT AUTHORITY\SYSTEM]` account is missing from the SQL Server login or if the account lacks the necessary permissions to create the high-availability group.

## Resolution

To resolve this issue, use one of the following methods:

### Method 1: Use manual steps

1. Create a login in SQL Server for the `[NT AUTHORITY\SYSTEM]` account on each SQL Server computer that hosts a replica in your availability group.

1. Grant the `[NT AUTHORITY\SYSTEM]` account the following server-level permissions:

    - ALTER any availability group

    - Connect SQL

    - View server state

    > [!NOTE]
    > Make sure that no other permissions are granted to the account.

### Method 2: Use script

1. To create the `[NT AUTHORITY\SYSTEM]` account, run the following statement in a query window:

    ```sql
    USE [master]
    GO
    CREATE LOGIN [NT AUTHORITY\SYSTEM] FROM WINDOWS WITH DEFAULT_DATABASE=[master]
    GO
    ```

1. To grant the permissions to the `[NT AUTHORITY\SYSTEM]` account, run the following statement in a query window:

    ```sql
    GRANT ALTER ANY AVAILABILITY GROUP TO [NT AUTHORITY\SYSTEM]
    GO
    GRANT CONNECT SQL TO [NT AUTHORITY\SYSTEM]
    GO
    GRANT VIEW SERVER STATE TO [NT AUTHORITY\SYSTEM]
    GO
    ```

## More information

The `[NT AUTHORITY\SYSTEM]` account is used by SQL Server Always On health detection to connect to the SQL Server computer and to monitor health. When you create an availability group and the primary replica in the availability group comes online, health detection is initiated. If the `[NT AUTHORITY\SYSTEM]` account doesn't exist or have sufficient permissions, health detection can't be initiated, and the availability group can't come online during the creation process.

Make sure that these permissions exist on each SQL Server computer that could host the primary replica of the availability group.  

> [!NOTE]
> The Resource Host Monitor Service process (RHS.exe) that hosts SQL Resource.dll can be run only under a System account.

For more information, see [Troubleshooting automatic failover problems in SQL Server Always On environments](../availability-groups/troubleshooting-automatic-failover-problems.md).
