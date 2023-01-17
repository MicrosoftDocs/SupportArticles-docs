---
title: Troubleshooting automatic failover problems
description: This article provides the troubleshooting steps for the problems that occur during automatic failover in SQL Server.
ms.date: 12/16/2022
ms.custom: sap:Availability Groups
ms.reviewer: ramakoni, cmathews
ms.prod: sql
---
# Troubleshooting automatic failover problems in SQL Server Always On environments

This article helps you resolve the problems that occur during automatic failover in SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2833707

## Summary  

Microsoft SQL Server Always On availability groups can be configured for automatic failover. Therefore, if a health issue is detected on the instance of SQL Server that is hosting the primary replica, the primary role can be transitioned to the automatic failover partner (secondary replica). However, the secondary replica can't always be transitioned to the primary role, instead being transitioned only to the resolving role. Unless the primary replica returns to a healthy state, there's no replica in the primary role. Additionally, the availability databases are inaccessible.

This article lists some common causes of unsuccessful automatic failover. Additionally, this article discusses the steps that you can perform in order to diagnose the cause of these failures.

## The symptoms when an automatic failover is triggered successfully

When an automatic failover is triggered on the instance of SQL Server that is hosting the primary replica, the secondary replica transitions to the resolving role and then to the primary role. Additionally, you receive error messages in the SQL Server log report that resemble the following one:

> The state of the local availability replica in availability group '\<Group name>' has changed from 'RESOLVING_NORMAL' to 'PRIMARY_PENDING'  
The state of the local availability replica in availability group '\<Group name>' has changed from 'PRIMARY_PENDING' to 'PRIMARY_NORMAL'

:::image type="content" source="media/troubleshooting-automatic-failover-problems/error-log-notepad.png" alt-text="Screenshot of the error log when an automatic failover is triggered successfully.":::

> [!NOTE]
> The secondary replica transitions successfully from a **RESOLVING_NORMAL** status to a **PRIMARY_NORMAL** status.

## The symptoms when automatic failover is unsuccessful

If an automatic failover event isn't successful, the secondary replica doesn't successfully transition to the primary role. Therefore, the availability replica will report that this replica is in Resolving status. Additionally, the availability databases report that they are in **Not Synchronizing** status, and applications can't access these databases.

For example, in the following image, SQL Server Management Studio reports that the secondary replica is in **Resolving** status because the automatic failover process was unable to transition the secondary replica into the primary role:

:::image type="content" source="media/troubleshooting-automatic-failover-problems/availability-replicas.png" alt-text="Screenshot of the availability replicas in SQL Server Management Studio.":::

This article describes several possible reasons that automatic failover may not succeed, and how to diagnose each cause.  

## Case 1: "Maximum Failures in the Specified Period" value is exhausted

The availability group has Windows cluster resource properties, such as the **Maximum Failures in the Specified Period** property. This property is used to avoid the indefinite movement of a clustered resource when multiple node failures occur.

To investigate and diagnose whether this is the cause of unsuccessful failover, review the Windows cluster log (_Cluster.log_), and then check the property. To do this, follow these steps:

### Step 1: Review the data in the Windows cluster log (_Cluster.log_)

1. Use Windows PowerShell to generate the Windows cluster log on the cluster node that is hosting the primary replica. To do this, run the following cmdlet in an elevated PowerShell window on the instance of SQL Server that is hosting the primary replica:

   ```powershell
   Get-ClusterLog -Node <SQL Server node name> -TimeSpan 15
   ```

   :::image type="content" source="media/troubleshooting-automatic-failover-problems/windows-powershell.png" alt-text="Screenshot of the Windows cluster log in Windows PowerShell." border="false":::

   > [!NOTE]
   >
   > - The `-TimeSpan 15` parameter in this step is used under the assumption that the issue being diagnosed occurred in the previous 15 minutes.
   > - By default, the log file is created in _%WINDIR%\cluster\reports_.

1. Open the _Cluster.log_ file in Notepad in order to review the Windows cluster log.

1. Select **Edit** in Notepad, and then select **Find**, and search for the string "failoverCount" at the end of the file. Review the results, and you should find a message that resembles the following one:

   > Not failing over group \<Resource name>, failoverCount 3, failoverThresholdSetting \<Number>, computedFailoverThreshold 2

   :::image type="content" source="media/troubleshooting-automatic-failover-problems/cluster-notepad.png" alt-text="Screenshot of Cluster.log file in Notepad.":::

### Step 2: Check the Maximum Failures in the Specified Period property

1. Start Failover Cluster Manager.
1. In the navigation pane, select **Roles**.
1. In the **Roles** pane, right-click the clustered resource, and then select **Properties**.
41 Select the **Failover** tab, and check the **Maximum Failures in the Specified Period** value.

   :::image type="content" source="media/troubleshooting-automatic-failover-problems/properties.png" alt-text="Screenshot of the Maximum Failures in the Specified Period property.":::

   > [!NOTE]
   > The default behavior specifies that if the clustered resource fails three times in a six hour period, it should remain in the failed state. For an availability group, this means the replica is left in the RESOLVING state.

Conclusion

After you analyze the log, you find that the **failoverCount** value of 3 is greater than the **computedFailoverThreshold** value of 2. Therefore, Windows cluster can't complete the failover operation of the availability group resource to the failover partner.

Resolution

To resolve this issue, increase the **Maximum Failures in the Specified Period** value.

> [!NOTE]
> Increasing this value may not resolve the issue. There may be a more critical issue that causes the availability group to fail many times in a short period, which is 15 minutes by default. Increasing this value may only cause the availability group to fail more times before remaining in a failed state. We recommend an aggressive troubleshooting effort to determine why automatic failover keeps occurring.  

## Case 2: Insufficient NT Authority\SYSTEM account permissions

The SQL Server Database Engine resource DLL connects to the instance of SQL Server that is hosting the primary replica by using ODBC in order to monitor health. The logon credentials that are used for this connection are the local SQL Server NT AUTHORITY\SYSTEM login account. By default, this local login account is granted the following permissions:

- **Alter Any Availability Group**  
- **Connect SQL**  
- **View server state**

If the NT AUTHORITY\SYSTEM login account lacks any of these permissions on the automatic failover partner (the secondary replica), then SQL Server can't start health detection when an automatic failover occurs. Therefore, the secondary replica can't transition to the primary role. To investigate and diagnose whether this is the cause, review the Windows cluster log. To do this, follow these steps:

1. Use Windows PowerShell to generate the Windows cluster log on the cluster node. To do this, run the following cmdlet in an elevated PowerShell window on the instance of SQL Server that is hosting the secondary replica that didn't transition into the primary role:

   ```powershell
   Get-ClusterLog -Node <SQL Server node name> -TimeSpan 15
   ```

   :::image type="content" source="media/troubleshooting-automatic-failover-problems/windows-powershell.png" alt-text="Screenshot of the Windows cluster log in Windows PowerShell in Case 2." border="false":::

1. Open the Cluster.log file in Notepad in order to review the Windows cluster log.

1. You can find error messages that resemble the following one:

   > Failed to run diagnostics command.
   The user does not have permission to perform this action.

   :::image type="content" source="media/troubleshooting-automatic-failover-problems/error-messages.png" alt-text="Screenshot of Cluster.log file in Notepad in Case 2." border="false":::

Conclusion

The Cluster.log file reports that there's a permission issue when SQL Server runs the diagnostics command. In this example, the failure was caused by removing the View server state permission from the NT AUTHORITY\SYSTEM login account on the instance of SQL Server that is hosting the secondary replica of an automatic failover pair.

Resolution

To resolve this issue, grant sufficient permissions to the NT AUTHORITY\SYSTEM login account for the health detection of SQL Server Database Engine resource DLL.  

## Case 3: The availability databases aren't in a SYNCHRONIZED state

In order to automatically fail over, all availability databases that are defined in the availability group must be in a SYNCHRONIZED state between the primary replica and the secondary replica. When an automatic failover occurs, this synchronization condition must be met in order to make sure that there's no data loss. Therefore, if one availability database in the availability group in the synchronizing or not synchronized state, automatic failover won't successfully transition the secondary replica into the primary role.

For more information about the required conditions for an automatic failover, see the **Conditions required for an Automatic Failover** section and the **Synchronous-commit replicas support two settings** section of the article: [Failover and Failover Modes (Always On Availability Groups)](/sql/database-engine/availability-groups/windows/failover-and-failover-modes-always-on-availability-groups).

To investigate and diagnose whether this is the cause of unsuccessful failover, review the SQL Server error log. You should find an error message that resembles the following one:

One or more databases aren't synchronized or haven't joined the availability group

:::image type="content" source="media/troubleshooting-automatic-failover-problems/error-log.png" alt-text="Screenshot of the SQL Server error log in Case 3." border="false":::

To check whether the availability databases were in the SYNCHRONIZED status, follow these steps:

1. Connect to the secondary replica.
1. Run the following SQL script in order to check the `is_failover_ready` value for all availability databases in the availability group that didn't fail over.

   > [!NOTE]
   > A value of zero for any of the availability databases can prevent automatic failover, and this value indicates that the availability database was not SYNCHRONIZED.

    ```sql
    Select database_name, is_failover_ready from sys.dm_hadr_database_replica_cluster_states where replica_id in (select replica_id from sys.dm_hadr_availability_replica_states)
    ```

   :::image type="content" source="media/troubleshooting-automatic-failover-problems/sql-query.png" alt-text="Screenshot of SQL query in Case 3.":::

Conclusion

A successful automatic failover of the availability group requires all availability databases be in the `SYNCHRONIZED` status. For more information about availability modes, review the following link:

[Availability modes in Always On availability groups](/sql/database-engine/availability-groups/windows/availability-modes-always-on-availability-groups)

## Case 4: Unable to fail over, "Force Protocol Encryption" configuration has been selected for the client protocols

To check for this configuration:  

1. Launch SQL Server Configuration Manager.  
1. In **left** pane, right-click the **SQL Native Client 11.0 Configuration** and choose **Properties**.  
1. In dialog check **Force Encryption**, if set to **Yes**, change to **No**.
1. Retest failover.  

:::image type="content" source="media/troubleshooting-automatic-failover-problems/sql-config.png" alt-text="Screenshot of the SQL Native Client 11.0 Configuration properties in SQL Server Configuration Manager." border="false":::

Conclusion

SQL Server Always On health monitoring uses a local ODBC connection to monitor SQL Server health. **Force Protocol Encryption** should only be enabled in the Client Configuration section of SQL Server Configuration Manager, if SQL Server itself has been configured to Force Encryptions in SQL Server Configuration Manager under the **SQL Server Network Configuration** section. For more information, see: [Enable encrypted connections to the Database Engine](/sql/database-engine/configure-windows/enable-encrypted-connections-to-the-database-engine).

## Troubleshoot other failed failover events

During failover, to monitor the health of the new primary replica, AlwaysOn health monitoring must locally connect to the SQL Server instance transitioning to the primary role.

Besides the more common reasons covered in this document, there are multiple other reasons this connection attempt may fail. To investigate the reasons, review the Cluster log on the failover partner (the replica you were unable to fail over to) after a failed failover attempt.

1. Use Windows PowerShell to generate the Windows Cluster log on the cluster node.

   To do this, run the following cmdlet in an elevated PowerShell window on the instance of SQL Server that's hosting the secondary replica that didn't transition into the primary role. A Cluster log will be generated for the last 60 minutes of activity.

   ```powershell
   Get-ClusterLog -Node <SQLServerNodeName> -TimeSpan 60
   ```

1. Open the _Cluster.log_ file in Notepad to review the Windows Cluster log.

1. Search for the string "Connect to SQL Server" that falls during the failed failover event.

1. Review the subsequent login messages using the thread id (see the following picture) to correlate the events tied to login.

Here's an example, searching for "Connect to SQL Server" and using the thread id (left side) to locate the other diagnostics that describe why.

:::image type="content" source="media/troubleshooting-automatic-failover-problems/cluster-log-example.png" alt-text="Screenshot of the Cluster log showing connect to SQL and the threadID." lightbox="media/troubleshooting-automatic-failover-problems/cluster-log-example.png":::

Examples of connection failures to the new primary replica:

### Example Set 1

> [hadrag] ODBC Error: [08001] [Microsoft][SQL Server Native Client 11.0]SQL Server Network
Interfaces: No client protocols are enabled and no protocol was specified in the connection
string [xFFFFFFFF]. (268435455)

Resolution

Launch SQL Server Configuration Manager and confirm Shared Memory or TCPIP is enabled
under the Client Protocols for the SQL Native Client Configuration.

### Example Set 2

> [hadrag] ODBC Error: [08001] [Microsoft][SQL Server Native Client 11.0]SQL Server Network
Interfaces: Server doesn't support requested protocol [xFFFFFFFF]. (268435455)

Resolution

Launch SQL Server Configuration Manager and confirm Shared Memory or TCPIP is enabled
under the Client Protocols for the SQL Native Client Configuration.

### Example Set 3

> 000010b8.00001764::2020/12/02-16:52:49.808 ERR [RES] SQL Server Availability Group : [hadrag]
ODBC Error: [42000] [Microsoft][SQL Server Native Client 11.0][SQL Server]Cannot alter the availability
group 'ag', because it does not exist or you do not have permission. (15151)
>
> 000010b8.00000fd0::2020/12/02-17:01:14.821 ERR [RES] SQL Server Availability Group: [hadrag]
ODBC Error: [42000] [Microsoft][SQL Server Native Client 11.0][SQL Server]The user does not have permission to perform this action. (297)
>
> 000010b8.00001838::2020/12/02-17:10:04.427 ERR [RES] SQL Server Availability Group : [hadrag]
ODBC Error: [42000] [Microsoft][SQL Server Native Client 11.0][SQL Server]Login failed for user
'SQLREPRO\NODE2$'. Reason: The account is disabled. (18470)

Resolution

Review [Case 2: Insufficient NT Authority\SYSTEM account permissions](#case-2-insufficient-nt-authoritysystem-account-permissions).
