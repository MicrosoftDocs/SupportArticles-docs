---
title: Troubleshooting automatic failover problems
description: This article provides troubleshooting steps for problems that occur during automatic failover in SQL Server.
ms.date: 01/19/2023
ms.custom: sap:Availability Groups
ms.reviewer: ramakoni, cmathews, v-jayaramanp
---

# Troubleshooting automatic failover problems in SQL Server Always On environments

This article helps you resolve problems that occur during automatic failover in Microsoft SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2833707  

## Summary  

SQL Server Always On availability groups can be configured for automatic failover. If a health issue is detected on the instance of SQL Server that's hosting the primary replica, the primary role can be transitioned to the automatic failover partner (secondary replica). However, the secondary replica can't always be transitioned to the primary role. In some cases, it can be transitioned only to the `RESOLVING` role. In this situation, no replica will have the primary role unless the primary replica returns to a healthy state. Additionally, the availability databases will be inaccessible.

This article lists some common causes of unsuccessful automatic failover and discusses the steps that you can take to diagnose the cause of these failures.

## Symptoms if an automatic failover is triggered successfully

When an automatic failover is triggered on the instance of SQL Server that is hosting the primary replica, the secondary replica transitions to the `RESOLVING` role and then to the primary role. Although the process is successful, error entries are logged in the SQL Server log report that resemble the following text:

```output
The state of the local availability replica in availability group '\<Group name>' has changed from 'RESOLVING_NORMAL' to 'PRIMARY_PENDING'  
The state of the local availability replica in availability group '\<Group name>' has changed from 'PRIMARY_PENDING' to 'PRIMARY_NORMAL'
```

:::image type="content" source="media/troubleshooting-automatic-failover-problems/error-log-notepad.png" alt-text="Screenshot of the error log if an automatic failover is triggered successfully.":::

> [!NOTE]  
> The secondary replica transitions successfully from a `RESOLVING_NORMAL` state to a `PRIMARY_NORMAL` state.

## Symptoms if an automatic failover is unsuccessful

If an automatic failover event isn't successful, the secondary replica doesn't successfully transition to the primary role. Therefore, the availability replica will report that this replica is in a `RESOLVING` state. Additionally, the availability databases report that they are in a `NOT SYNCHRONIZING` state, and applications can't access these databases.

For example, in the following image, SQL Server Management Studio reports that the secondary replica is in a `RESOLVING` state because the automatic failover process couldn't transition the secondary replica into the primary role.

:::image type="content" source="media/troubleshooting-automatic-failover-problems/availability-replicas.png" alt-text="Screenshot of the availability replicas in SQL Server Management Studio.":::

The following sections discuss several possible reasons why automatic failover might not succeed, and how to diagnose each cause.  

## Case 1: "Maximum Failures in the Specified Period" value is exhausted

The availability group has Windows cluster resource properties, such as the **Maximum Failures in the Specified Period** property. This property is used to avoid the indefinite movement of a clustered resource when multiple node failures occur.

To investigate and diagnose whether this is the cause of unsuccessful failover, review the Windows cluster log (_Cluster.log_), and then check the property.

### Step 1: Review the data in the Windows cluster log (_Cluster.log_)

1. Use Windows PowerShell to generate the Windows cluster log on the cluster node that is hosting the primary replica. To do this, run the following cmdlet in an elevated PowerShell window on the instance of SQL Server that's hosting the primary replica:

   ```powershell
   Get-ClusterLog -Node <SQL Server node name> -TimeSpan 15
   ```

   :::image type="content" source="media/troubleshooting-automatic-failover-problems/windows-powershell.png" alt-text="Screenshot of the Windows cluster log in Windows PowerShell." border="false":::

   > [!NOTES]  
   > - The `-TimeSpan 15` parameter in this step assumes that the problem that's being diagnosed occurred during the previous 15 minutes.
   > - By default, the log file is created in _%WINDIR%\cluster\reports_.

1. Open the _Cluster.log_ file in Notepad to review the Windows cluster log.

1. In Notepad, select **Edit** > **Find**, and then search for the "failoverCount" string at the end of the file. In the results, you should find a message that resembles the following message:

   > Not failing over group \<Resource name>, failoverCount 3, failoverThresholdSetting \<Number>, computedFailoverThreshold 2

   :::image type="content" source="media/troubleshooting-automatic-failover-problems/cluster-notepad.png" alt-text="Screenshot of the Cluster.log file in Notepad.":::

### Step 2: Check the Maximum Failures in the Specified Period property

1. Start Failover Cluster Manager.
1. In the navigation pane, select **Roles**.
1. In the **Roles** pane, right-click the clustered resource, and then select **Properties**.
1. Select the **Failover** tab, and select the **Maximum Failures in the Specified Period** value.

   :::image type="content" source="media/troubleshooting-automatic-failover-problems/properties.png" alt-text="Screenshot of the Maximum Failures in the Specified Period property.":::

   > [!NOTE]  
   > The default behavior specifies that if the clustered resource fails three times within six hours, it should remain in the failed state. For an availability group, this means that the replica is left in the `RESOLVING` state.

**Conclusion**

After you analyze the log, you find that the **failoverCount** value of **3** is greater than the **computedFailoverThreshold** value of **2**. Therefore, the Windows cluster can't complete the failover operation of the availability group resource to the failover partner.

**Resolution**

To resolve this problem, increase the **Maximum Failures in the Specified Period** value.

> [!NOTE]  
> Increasing this value might not resolve the problem. There might be a more critical problem that causes the availability group to fail many times within a short period. By default, this period is 15 minutes. Increasing this value might simply cause the availability group to fail more times and remain in a failed state. We recommend that you use aggressive troubleshooting to determine why automatic failover keeps occurring.  

## Case 2: Insufficient NT Authority\SYSTEM account permissions

The SQL Server Database Engine resource DLL connects to the instance of SQL Server that is hosting the primary replica by using ODBC to monitor health. The logon credentials that are used for this connection are the local SQL Server `NT AUTHORITY\SYSTEM` login account. By default, this local login account is granted the following permissions:

- **Alter Any Availability Group**  
- **Connect SQL**  
- **View server state**

If the `NT AUTHORITY\SYSTEM` login account lacks any of these permissions on the automatic failover partner (the secondary replica), then SQL Server can't start health detection when an automatic failover occurs. Therefore, the secondary replica can't transition to the primary role. To investigate and diagnose whether this is the cause, review the Windows cluster log. To do this, follow these steps:

1. Use Windows PowerShell to generate the Windows cluster log on the cluster node. To do this, run the following cmdlet in an elevated PowerShell window on the instance of SQL Server that is hosting the secondary replica that didn't transition into the primary role:

   ```powershell
   Get-ClusterLog -Node <SQL Server node name> -TimeSpan 15
   ```

   :::image type="content" source="media/troubleshooting-automatic-failover-problems/windows-powershell.png" alt-text="Screenshot of the Windows cluster log in Windows PowerShell in Case 2." border="false":::

1. Open the *Cluster.log* file in Notepad to review the Windows cluster log.

1. Find error entry that resembles the following text:

   > Failed to run diagnostics command.
   The user does not have permission to perform this action.

   :::image type="content" source="media/troubleshooting-automatic-failover-problems/error-messages.png" alt-text="Screenshot of the Cluster.log file in Notepad in Case 2." border="false":::

**Conclusion**

The *Cluster.log* file reports that a permissions issue exists when SQL Server runs the diagnostics command. In this example, the failure was caused by removing the View server state permission from the `NT AUTHORITY\SYSTEM` login account on the instance of SQL Server that's hosting the secondary replica of an automatic failover pair.

**Resolution**

To resolve this issue, grant sufficient permissions to the `NT AUTHORITY\SYSTEM` login account for the health detection of the SQL Server Database Engine resource DLL.  

## Case 3: The availability databases aren't in a SYNCHRONIZED state

To automatically fail over, all availability databases that are defined in the availability group must be in a `SYNCHRONIZED` state between the primary replica and the secondary replica. When an automatic failover occurs, this synchronization condition must be met in order to make sure that there's no data loss. Therefore, if one availability database in the availability group is in the synchronizing or `NOT SYNCHRONIZED` state, automatic failover won't successfully transition the secondary replica into the primary role.

For more information about the required conditions for an automatic failover, see the **Conditions required for an Automatic Failover** and the **Synchronous-commit replicas support two settings** sections of [Failover and Failover Modes (Always On Availability Groups)](/sql/database-engine/availability-groups/windows/failover-and-failover-modes-always-on-availability-groups).

To investigate and diagnose whether this is the cause of unsuccessful failover, review the SQL Server error log. You should find an error entry that resembles the following text:

> One or more databases aren't synchronized or haven't joined the availability group.

:::image type="content" source="media/troubleshooting-automatic-failover-problems/error-log.png" alt-text="Screenshot of the SQL Server error log in Case 3." border="false":::

To check whether the availability databases were in the `SYNCHRONIZED` state, follow these steps:

1. Connect to the secondary replica.
1. Run the following SQL script to check the `is_failover_ready` value for all availability databases in the availability group that didn't fail over.

   > [!NOTE]  
   > A value of zero for any of the availability databases can prevent automatic failover. This value indicates that the availability database wasn't `SYNCHRONIZED`.

    ```sql
    SELECT database_name, is_failover_ready FROM sys.dm_hadr_database_replica_cluster_states WHERE replica_id IN (SELECT replica_id FROM sys.dm_hadr_availability_replica_states)
    ```

   :::image type="content" source="media/troubleshooting-automatic-failover-problems/sql-query.png" alt-text="Screenshot of SQL query in Case 3.":::

**Conclusion**

A successful automatic failover of the availability group requires that all availability databases be in the `SYNCHRONIZED` state. For more information about availability modes, see [Availability modes in Always On availability groups](/sql/database-engine/availability-groups/windows/availability-modes-always-on-availability-groups).

## Case 4: "Force Protocol Encryption" configuration is selected for the client protocols on secondary replica (target primary) though the replica isn't configured for encryption

During failover, when the primary server detects a health issue the cluster DLL on failover partner (secondary replica) tries to connect to local replica to initiate health monitoring. This is part of the transition to the primary role. If the secondary replica isn't configured for encryption, but the **Force Protocol Encryption** setting is inadvertently set in client configuration, the connection will fail, and the failover can't occur.

To check for this configuration:  

1. Start SQL Server Configuration Manager.  
1. In the **left** pane, right-click the **SQL Native Client 11.0 Configuration**, and then select **Properties**.  
1. In the dialog box, check the **Force Protocol Encryption** setting. If it's set to **Yes**, change the value to **No**.
1. Retest the failover.

:::image type="content" source="media/troubleshooting-automatic-failover-problems/sql-config.png" alt-text="Screenshot of the SQL Native Client 11.0 Configuration properties in SQL Server Configuration Manager." border="false":::

**Conclusion**

SQL Server Always On health monitoring uses a local ODBC connection to monitor SQL Server health. **Force Protocol Encryption** should be enabled in the **Client Configuration** section of SQL Server Configuration Manager only if SQL Server itself was configured to Force Encryptions in SQL Server Configuration Manager in the **SQL Server Network Configuration** section. For more information, see [Enable encrypted connections to the Database Engine](/sql/database-engine/configure-windows/enable-encrypted-connections-to-the-database-engine).

## Case 5: Performance issues on secondary replica or node causes Always On health checks to fail

Before failing over from primary replica to the secondary replica, SQL Server Database Engine resource DLL connects to the secondary replica to ascertain the health of the replica. If this connection fails because of performance issues on the secondary replica, automatic failover doesn't occur.

To investigate and diagnose whether this is the cause, follow these steps:

1. Review the Cluster log on the secondary replica to check for the error message, "Unable to complete login process due to delay in opening server connection".

    ```output
    0000110c.00002bcc::2020/08/06-01:17:54.943 INFO  [RCM] move of group AOCProd01AG from CO2ICMV3SQL09(1) to CO2ICMV3SQL10(2) of type MoveType::Manual is about to succeed, failoverCount=3, lastFailoverTime=2020/08/05-02:08:54.524 targeted=true 
    00002a54.0000610c::2020/08/06-01:18:44.929 ERR   [RES] SQL Server Availability Group <AOCProd01AG>: [hadrag] ODBC Error: [08001] [Microsoft][SQL Server Native Client 11.0]Unable to complete login process due to delay in opening server connection (0) 
    00002a54.0000610c::2020/08/06-01:18:44.929 INFO  [RES] SQL Server Availability Group <AOCProd01AG>: [hadrag] Could not connect to SQL Server (rc -1) 
    00002a54.0000610c::2020/08/06-01:18:44.929 INFO  [RES] SQL Server Availability Group <AOCProd01AG>: [hadrag] SQLDisconnect returns following information 
    00002a54.0000610c::2020/08/06-01:18:44.929 ERR   [RES] SQL Server Availability Group <AOCProd01AG>: [hadrag] ODBC Error: [08003] [Microsoft][ODBC Driver Manager] Connection not open (0) 
    00002a54.0000610c::2020/08/06-01:18:44.931 ERR   [RES] SQL Server Availability Group <AOCProd01AG>: [hadrag] Failed to connect to SQL Server 
    00002a54.0000610c::2020/08/06-01:18:44.931 ERR   [RHS] Online for resource AOCProd01AG failed. 
    ```

    This situation can occur if the failover is made to a SQL Server secondary replica that has a busy existing workload. This could delay SQL Server's response to the HADR health connection request attempt and prevent a successful failover attempt.

1. To determine whether there's pressure on system schedulers, use SQL Server Management Studio to run the following script on the secondary replica:

    ```sql
    USE MASTER 
    GO  
    WHILE 1=1 
    BEGIN 
    PRINT convert(varchar(20), getdate(),120) 
    DECLARE @max INT; 
    SELECT @max = max_workers_count 
    FROM sys.dm_os_sys_info; 
    SELECT GETDATE() AS 'CurrentDate',  
           @max AS 'TotalThreads',  
           SUM(active_Workers_count) AS 'CurrentThreads',  
           @max - SUM(active_Workers_count) AS 'AvailableThreads',  
           SUM(runnable_tasks_count) AS 'WorkersWaitingForCpu',  
           SUM(work_queue_count) AS 'RequestWaitingForThreads' 
           --SUM(current_workers_count) AS 'AssociatedWorkers' 
    FROM sys.dm_os_Schedulers 
    WHERE STATUS = 'VISIBLE ONLINE'; 
    wait for delay '0:0:15' 
    END
    ```

    The following is sample output of the preceding query:
    
    |     CurrentDate         |TotalThreads  |CurrentThreads  |AvailableThreads  |WorkersWaitingForCpu |RequestWaitingForThreads |
    |-------------------------|--------------|----------------|------------------|---------------------|-------------------------|
    |2020-10-06 01:27:01.337  |1216          |361             |855               |33                   |0                        |
    |2020-10-06 01:27:08.340  |1216          |1412            |-196              |22                   |76                       |
    |2020-10-06 01:27:15.340  |1216          |1304            |-88               |2                    |161                      |
    |2020-10-06 01:27:22.340  |1216          |1242            |-26               |21                   |185                      |
    |2020-10-06 01:27:29.343  |1216          |1346            |-130              |19                   |476                      |
    |2020-10-06 01:27:36.350  |1216          |1350            |-134              |9                    |630                      |
    |2020-10-06 01:27:43.353  |1216          |1346            |-130              |13                   |539                      |
    |2020-10-06 01:27:50.360  |1216          |1378            |-162              |5                    |328                      |
    |2020-10-06 01:27:57.360  |1216          |197             |1019              |0                    |0                        |

    High values reported for `WorkersWaitingForCpu` and `RequestWaitingForThreads` indicate that scheduling contention is occurring and that SQL Server can't service the current workload in a timely manner.

**Resolution**

If you experience this problem, rebalance the workload on the secondary replica or consider increasing the processing power (add processors) on the computers running these workloads.

## Troubleshoot other failed failover events

To monitor the health of the new primary replica during failover, you must locally connect AlwaysOn health monitoring to the SQL Server instance that's transitioning to the primary role.

In addition to the more common reasons that are discussed in this article, there are many other reasons that this connection attempt might fail. To investigate a failed failover attempt further, review the Cluster log on the failover partner (the replica that you couldn't fail over to):

1. Use Windows PowerShell to generate the Windows Cluster log on the cluster node. To do this, run the following cmdlet in an elevated PowerShell window on the instance of SQL Server that's hosting the secondary replica that didn't transition into the primary role. A Cluster log will be generated for the last 60 minutes of activity.

   ```powershell
   Get-ClusterLog -Node <SQLServerNodeName> -TimeSpan 60
   ```

1. To review the Windows Cluster log, open the _Cluster.log_ file in Notepad.

1. Search for the "Connect to SQL Server" string that falls during the unsuccessful failover event.

1. Review the subsequent login messages by using the thread ID (see the following screenshot) to correlate the events that are related to the login event. The following example shows a search for "Connect to SQL Server." It also shows using the thread ID (left side) to locate the other diagnostics that describe why the connection attempt failed.

    :::image type="content" source="media/troubleshooting-automatic-failover-problems/cluster-log-example.png" alt-text="Screenshot of the Cluster log showing connect to SQL and the threadID." lightbox="media/troubleshooting-automatic-failover-problems/cluster-log-example.png":::

The following examples show connection failures to the new primary replica.

### Example Set 1

 ```output
[hadrag] ODBC Error: [08001] [Microsoft][SQL Server Native Client 11.0]SQL Server Network
Interfaces: No client protocols are enabled and no protocol was specified in the connection
string [xFFFFFFFF]. (268435455)
 ```

**Resolution**

Start SQL Server Configuration Manager, and then verify that Shared Memory or TCP/IP is enabled under **Client Protocols** for the SQL Native Client Configuration.

### Example Set 2

 ```output
[hadrag] ODBC Error: [08001] [Microsoft][SQL Server Native Client 11.0]SQL Server Network
Interfaces: Server doesn't support requested protocol [xFFFFFFFF]. (268435455)
 ```

**Resolution**

Start SQL Server Configuration Manager, and then verify that Shared Memory or TCP/IP is enabled under **Client Protocols** for the SQL Native Client Configuration.

### Example Set 3

 ```output
000010b8.00001764::2020/12/02-16:52:49.808 ERR [RES] SQL Server Availability Group : [hadrag]
ODBC Error: [42000] [Microsoft][SQL Server Native Client 11.0][SQL Server]Cannot alter the availability
group 'ag', because it does not exist or you do not have permission. (15151)
000010b8.00000fd0::2020/12/02-17:01:14.821 ERR [RES] SQL Server Availability Group: [hadrag]
ODBC Error: [42000] [Microsoft][SQL Server Native Client 11.0][SQL Server]The user does not have permission to perform this action. (297)
000010b8.00001838::2020/12/02-17:10:04.427 ERR [RES] SQL Server Availability Group : [hadrag]
ODBC Error: [42000] [Microsoft][SQL Server Native Client 11.0][SQL Server]Login failed for user
'SQLREPRO\NODE2$'. Reason: The account is disabled. (18470)
 ```

**Resolution**

Review [Case 2: Insufficient NT Authority\SYSTEM account permissions](#case-2-insufficient-nt-authoritysystem-account-permissions).
