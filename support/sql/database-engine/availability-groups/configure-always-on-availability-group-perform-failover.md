---
title: Manually configure AG for automatic failover for errors on data file
description: This article describes how to configure an Always On availability group to perform a failover when the database data file is unavailable.
ms.date: 02/07/2023
ms.custom: sap:Availability Groups
ms.topic: how-to
ms.reviewer: moraja, v-sidong
---

# How to configure an Always On availability group to perform a failover when the database data file is unavailable

## Summary

In a SQL Server Always On availability group, database-level health detection can perform a failover only if the error (disk failure or similar) occurs in the database transaction log.

If the error happens on the data file, SQL Server only sends the failure notice to a [Windows Server Failover Cluster](/sql/sql-server/failover-clusters/windows/windows-server-failover-clustering-wsfc-with-sql-server) (WSFC) and relies on it to make the right decision based on policy configuration.

To configure an Always On availability group to perform a failover when [errors 823 and others](https://techcommunity.microsoft.com/t5/sql-server-blog/sql-server-availability-groups-8211-enhanced-database-level/ba-p/385965) occur, use one of the following procedures:

## Configure Failover Cluster Manager

This procedure sets up the WSFC policy to cause a failover to one of the possible owners instead of attempting to restart the role on the current primary node.

1. Open Failover Cluster Manager.

1. Expand your cluster and select **Roles**.

1. Right-click the AG role and select **Properties** > **Policies**.

1. Set the value of **Maximum restarts in the specified period** to **0**.

1. Check the box **If all the restart attempts fail, begin restarting again after the specified period (hh:mm)** and select **OK**.

1. Make sure both your nodes are **Possible Owners** and **preferred owners**.

## Custom configuration option

This procedure provides an example of how to utilize the available alert mechanism in SQL Server and SQL Server Agent to detect the error and perform a failover.

1. In SQL Server Management Studio, expand **SQL Server Agent**, right-click **Alerts**, and select **New Alert...**.

1. Specify a value for **Name**, select **SQL Server event alert** for **Type**, specify the value of **Error number** to **823** or any other desired error as per the list, and then select **OK**.

1. Select **Response**, check **Execute job**, select the job you want, and then select **OK**.

1. On the **Job Step Properties** dialog, specify a value for **Step name**, select **Operating system (CmdExec)** for **Type**, and then select **SQL Server Agent Service Account** for **Run as**.

1. Enter the following failover sqlcmd command:

   `sqlcmd -S <SecondaryReplicaName> -U SQLADMIN -P <YourPassword> -Q "ALTER Availability Group <AGName> Failover"`
   
   > [!NOTE]
   > `<SecondaryReplicaName>`, `<YourPassword>`, and `<AGName>` are placeholders. You need to change it to match your environments. This script is an example for reference. A full script should perform other checks before performing a failover.
