---
title: Configure an Always On availability group to perform a failover
description: This article describes how to configure an Always On availability group to perform a failover when the database data file is unavailable.
ms.date: 01/16/2023
ms.custom: sap:Failover Clusters
ms.prod: sql
ms.topic: how-to
ms.author: v-sidong
author: sevend2
ms.reviewer: moraja
---

# How to configure an Always On availability group to perform a failover when the database data file is unavailable

## Summary

In a SQL Server Always On availability group, database-level health detection can perform a failover only if the error (disk failure or similar) occurs in the database transaction log.

If the error happens on the data file, SQL Server only sends the failure notice to a [Windows Server Failover Cluster](/sql/sql-server/failover-clusters/windows/windows-server-failover-clustering-wsfc-with-sql-server) (WSFC) and relies on it to make the right decision based on policy configuration.

To configure an Always On availability group to perform a failover, use one of the following methods:

## Configure Failover Cluster Manager

If you want the WSFC to trigger a failover instead of a resource restart when [errors 823 and others](https://techcommunity.microsoft.com/t5/sql-server-blog/sql-server-availability-groups-8211-enhanced-database-level/ba-p/385965) occur, follow these steps:

1. Open Failover Cluster Manager.

1. Expand your cluster and select **Roles**.

1. Right-click the AG role and select **Properties** > **Policies**.

1. Set the value of **Maximum restarts in the specified period** to **0**.

1. Check the box **If all the restart attempts fail, begin restarting again after the specified period (hh:mm)**, set the value to **00:10**, and select **OK**.

1. Make sure both your nodes are **Possible Owners** and **preferred owners**.

## Custom configuration option

1. Create a text file that contains the following t-sql commands, and note the path and file name for later steps:

   ```sql
   Connect <ReplicaVM\InstanceName>;
   Alter Availability Group [AGName] Failover;
   Go
   ```

   > [!Note]
   > `<ReplicaVM\InstanceName>` is a placeholder. You need to change it to match your environments. This script is an example for reference. A full script should perform other checks before performing a failover.

1. Expand **SQL Server Agent**, right-click **Alert**, and select **New Alert...**.

1. Specify a value for **Name**, select **SQL Server event alert** for **Type**, specify the value of **Error number** to **823** or any other desired error as per the list, and then select **OK**.

1. Select **Response**, check **Execute job**, select the job you want, and then select **OK**.

1. On the **Job Step Properties** dialog, specify a value for **Step name**, select **Operating system (CmdExec)** for **Type**, and then select **SQL Server Agent Service Account** for **Run as**.

1. Enter the following failover SQLCMD command:

   `sqlcmd -S <SecondaryReplicaName> -U SQLADMIN -P <YourPassword> -i "path to your sql file from step 1"`
