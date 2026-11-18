---
title: Always On availability database in recovery pending or suspect state 
description: Troubleshoot an Always On availability database in Recovery Pending or Suspect state in SQL Server by removing the replica or dropping the availability group.
ms.date: 11/17/2026
ms.custom: sap:Always On Availability Groups (AG)
ms.reviewer: jopilov
ai-usage: ai-assisted
---

# Troubleshoot Always On availability databases in Recovery Pending or Suspect state in SQL Server

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2857849

## Summary

This article helps database administrators resolve an availability database in a `Recovery Pending` or `Suspect` state in an Always On availability group in Microsoft SQL Server. In this state, you can't restore the database, drop it, or remove it from the availability group. If the database is on the primary replica, client applications also lose access to it. The article describes the errors that you might see (Msg 3104, 3752, 35240, and 921) and the steps to restore the database to full functionality. The resolution depends on the replica role and on whether another working replica exists: fail over and then remove the replica that hosts the damaged database, remove it directly when it's already a secondary replica, or drop and re-create the availability group when the primary replica is the only working replica.

## Symptoms of an availability database in Recovery Pending or Suspect state

Assume that an availability database that's defined in an Always On availability group transitions to a `Recovery Pending` or `Suspect` state in SQL Server. If this occurs on the primary replica of the availability group, database availability is affected. In this situation, you can't access the database through client applications. Additionally, you can't drop the database or remove it from the availability group.

### Check the database state by using dynamic management views

When SQL Server is running and an availability database is in the `Recovery Pending` or `Suspect` state, query the dynamic management views (DMVs) at the primary replica by using the following SQL script. The database might be reported in a `NOT_HEALTHY` and `RECOVERY_PENDING` state or in a `SUSPECT` state:

```sql
SELECT
    dc.database_name,
    d.synchronization_health_desc,
    d.synchronization_state_desc,
    d.database_state_desc
FROM
    sys.dm_hadr_database_replica_states d
    JOIN sys.availability_databases_cluster dc ON d.group_database_id = dc.group_database_id
    AND d.is_local = 1
```

```output
database_name          synchronization_health_desc     synchronization_state_desc   database_state_desc
-------------------- ------------------------------ ------------------------------ ---------------------
<DatabaseName>                         NOT_HEALTHY              NOT SYNCHRONIZING      RECOVERY_PENDING
(1 row(s) affected)
```

:::image type="content" source="media/alwayson-availability-databases-recovery-pending-suspect/script-db-health-sync-state.png" alt-text="Screenshot of the execute result for script to check database health and sync state.":::

### Check the database state in SQL Server Management Studio

SQL Server Management Studio (SSMS) might report the database as **Not Synchronizing / Recovery Pending** or **Suspect**.

:::image type="content" source="media/alwayson-availability-databases-recovery-pending-suspect/db-not-synchronizing-recovery-pending.png" alt-text="Screenshot of database which is in Not Synchronizing / Recovery Pending state.":::

When the database is defined in an availability group, the database can't be dropped or restored. Therefore, you have to take specific steps to recover the database and return it to production use.

## Errors and limitations of a Recovery Pending availability database

The following sections describe the errors that you receive when you try to restore, drop, or remove an availability database that's in a `Recovery Pending` state in various situations.

### RESTORE DATABASE fails with error 3104 because the database is in an availability group

You try to run the following SQL script to restore the database by using the `RECOVERY` parameter:

```sql
RESTORE DATABASE <DatabaseName> WITH RECOVERY
```

When you run this script, you receive the following error message because the database is defined in an availability group:

> Msg 3104, Level 16, State 1, Line 1  
> RESTORE cannot operate on database \<DatabaseName\> because it is configured for database mirroring or has joined an availability group. If you intend to restore the database, use ALTER DATABASE to remove mirroring or to remove the database from its availability group.  
>
> Msg 3013, Level 16, State 1, Line 1  
> RESTORE DATABASE is terminating abnormally.  

### DROP DATABASE fails with error 3752 because the database is joined to an availability group

You try to run the following SQL script to drop the database:

```sql
DROP DATABASE <DatabaseName>
```

When you run this script, you receive the following error message because the database is defined in an availability group:

> Msg 3752, Level 16, State 1, Line 1  
> The database \<DatabaseName\> is currently joined to an availability group. Before you can drop the database, you need to remove it from the availability group.

### ALTER DATABASE SET HADR OFF fails with errors 35240 and 921

You try to run the following SQL script to remove the database from the availability group by using [ALTER DATABASE SET HADR](/sql/t-sql/statements/alter-database-transact-sql-set-hadr):

```sql
ALTER DATABASE <DatabaseName> SET hadr OFF
```

When you run this script on the primary replica, you receive the following error message because the availability database belongs to the primary replica:

> Msg 35240, Level 16, State 14, Line 1  
> Database \<DatabaseName\> cannot be joined to or unjoined from availability group \<AvailabilityGroupName\>. This operation is not supported on the primary replica of the availability group.

Because of this error message, you might try to fail over the database. After the database is failed over, the replica that owns the recovery pending database is in the secondary role. In this situation, you run the following SQL script again at the secondary replica to remove the database from the availability group:

```sql
ALTER DATABASE <DatabaseName> SET hadr OFF
```

However, you still can't remove the database from the availability group, and you receive the following error message because the database is still in the `Recovery Pending` state:

> Msg 921, Level 16, State 112, Line 1  
> Database \<DatabaseName\> has not been recovered yet. Wait and try again.

## Which resolution applies to your availability group?

Choose the resolution based on where the damaged database is hosted and how many working replicas the availability group has:

- **The primary replica hosts the damaged database and the availability group has another working replica:** Fail over to a replica that's eligible for failover, and then remove the replica that hosts the damaged database. A planned failover requires a synchronized replica; a forced failover can cause data loss. For prerequisites and risks, see the failover articles linked in the following section. See [Resolution when the database is in the secondary role](#resolution-when-the-database-is-in-the-secondary-role).
- **The damaged database is already on a replica in the secondary role:** Remove that replica from the primary replica. See [Resolution when the database is in the secondary role](#resolution-when-the-database-is-in-the-secondary-role), and skip the failover steps.
- **The primary replica hosts the damaged database and is the only working replica:** See [Resolution when the primary replica is the only replica in the availability group](#resolution-when-the-primary-replica-is-the-only-replica-in-the-availability-group).
- **You have to drop the availability group but need to keep application connectivity through the listener:** See [Resolution when you drop the availability group](#resolution-when-you-drop-the-availability-group).

## Resolution when the database is in the secondary role

This resolution applies when the replica that hosts the damaged database is in the secondary role. If the primary replica first hosts the damaged database, a failover must first occur to transition that replica into a secondary role (steps 1 and 2). If the damaged database is already on a secondary replica, skip steps 1 and 2 and start at step 3 from the primary replica. 

For more information about failover, see [Perform a planned manual failover of an availability group](/sql/database-engine/availability-groups/windows/perform-a-planned-manual-failover-of-an-availability-group-sql-server) and [Perform a forced manual failover of an availability group](/sql/database-engine/availability-groups/windows/perform-a-forced-manual-failover-of-an-availability-group-sql-server).

To resolve this issue, take the following general actions:

- Remove from the availability group the replica that's hosting the damaged database when the database is in the secondary role.
- Resolve any issues that are affecting the system and that might have contributed to the database failure.
- Restore the replica to the availability group.

To take these actions, connect to the new primary replica, and then run the [ALTER AVAILABILITY GROUP](/sql/t-sql/statements/alter-availability-group-transact-sql) SQL script to remove the replica that's hosting the failed availability database. To do this, follow these steps.

1. Connect to the server that's running SQL Server and that's hosting a secondary replica.
2. Run the following SQL script:

    ```sql
    ALTER AVAILABILITY GROUP <AvailabilityGroupName> FAILOVER
    ```

3. Run the following SQL script to [remove the replica](/sql/database-engine/availability-groups/windows/remove-a-secondary-replica-from-an-availability-group-sql-server) that's hosting the damaged database from the availability group:

    ```sql
    ALTER AVAILABILITY GROUP <AvailabilityGroupName> REMOVE REPLICA ON '<SQLServerNodeName>'
    ```

4. Resolve any issues on the server that's running SQL Server and that might contribute to the database failure.
5. [Add the replica back](/sql/database-engine/availability-groups/windows/add-a-secondary-replica-to-an-availability-group-sql-server) into the availability group.

## Resolution when the primary replica is the only replica in the availability group

This resolution applies when the primary replica hosts the damaged database and is the only working replica in the availability group. In this situation, you must drop the availability group. After you drop the availability group, you can recover your database from a backup or apply other emergency recovery efforts to restore the databases and resume production.

To drop the availability group, use the following [DROP AVAILABILITY GROUP](/sql/t-sql/statements/drop-availability-group-transact-sql) SQL script:

```sql
DROP AVAILABILITY GROUP <AvailabilityGroupName>
```

At this point, you can try to recover the problematic database or restore the database from the last-known good backup copy.

## Resolution when you drop the availability group

When you drop an availability group, you also drop the listener resource, which interrupts application connectivity to the availability databases.

To minimize application downtime, use one of the following methods to sustain application connectivity through the [availability group listener](/sql/database-engine/availability-groups/windows/create-or-configure-an-availability-group-listener-sql-server) and drop the availability group:

- [Method 1: Associate the listener with a new availability group (role) in Failover Cluster Manager](#method-1-associate-the-listener-with-a-new-availability-group-role-in-failover-cluster-manager)
- [Method 2: Associate the listener with an existing SQL Server failover cluster instance (FCI)](#method-2-associate-the-listener-with-an-existing-sql-server-failover-cluster-instance-fci)
- [Method 3: Drop the availability group, and then re-create the availability group and listener with the same listener name](#method-3-drop-the-availability-group-and-then-re-create-the-availability-group-and-listener-with-the-same-listener-name)

### Method 1: Associate the listener with a new availability group (role) in Failover Cluster Manager

This method lets you maintain the listener while dropping and re-creating the availability group.

#### Move the listener to a new availability group

1. On the instance of SQL Server to which the existing availability group listener is directing connections, create a new, empty availability group. To simplify this process, use the Transact-SQL command to create an availability group that has no secondary replica or database:

    ```sql
    USE master
    GO
    CREATE AVAILABILITY GROUP ag FOR REPLICA ON 'sqlnode1' WITH (
        ENDPOINT_URL = 'tcp://sqlnode1:5022',
        AVAILABILITY_MODE = ASYNCHRONOUS_COMMIT,
        FAILOVER_MODE = MANUAL
    )
    ```

2. Start Failover Cluster Manager, and then select **Roles** in the left pane. In the pane that lists the roles, select the original availability group.
3. In the bottom-middle pane under the **Resources** tab, right-click the availability group resource, and then select **Properties**. Select the **Dependencies** tab, delete the dependency to the listener, and then select **OK**.

    :::image type="content" source="media/alwayson-availability-databases-recovery-pending-suspect/ag-properties-dependencies-delete.png" alt-text="Screenshot of availability group properties Dependencies tab.":::

4. Under the resources, right-click the listener, select **More Actions**, and then select **Assign to Another Role**.
5. In the **Assign Source to Role** dialog box, select the new availability group, and then select **OK**.

    :::image type="content" source="media/alwayson-availability-databases-recovery-pending-suspect/add-resouce-role-ag-test.png" alt-text="Screenshot of Assign Source to Role dialog box, showing the added new availability group.":::

6. In the **Roles** pane, select the new availability group. In the bottom-middle pane, under the **Resources** tab, you should now see the new availability group and the listener resource. Right-click the new availability group resource, and then select **Properties**.

7. Select the **Dependencies** tab, select the listener resource from the drop-down box, and then select **OK**.

    :::image type="content" source="media/alwayson-availability-databases-recovery-pending-suspect/ag-test-properties-dependencies.png" alt-text="Screenshot of new availability group properties Dependencies tab.":::

8. In SSMS, use **Object Explorer** to connect to the instance of SQL Server that hosts the primary replica of the new availability group. Select **Always On High Availability**, select the new availability group, and then select **Availability Group Listeners**. You should find the listener.

9. Right-click the listener, select **Properties**, type the appropriate port number for the listener, and then select **OK**.

    :::image type="content" source="media/alwayson-availability-databases-recovery-pending-suspect/config-ag-listener.png" alt-text="Screenshot of availability group listener properties, showing the configuration of listener." border="false":::

This ensures that applications that use the listener can still use it to connect to the instance of SQL Server that is hosting the production databases without interruption. You can now completely remove and re-create the original availability group. Or you can add the databases and replicas to the new availability group.

#### Reassign the listener to the re-created availability group

If you re-create the original availability group, reassign the listener back to the availability group role, set up the dependency between the new availability group resource and the listener, and then reassign the port to the listener. To do this, follow these steps:

1. Start Failover Cluster Manager, and then select **Roles** in the left pane. In the pane that lists the roles, select the new availability group that hosts the listener.
2. In the bottom-middle pane under the **Resources** tab, right-click the listener, select **More Actions**, and then select **Assign to Another Role**. In the dialog box, choose the re-created availability group, and then select **OK**.
3. In the **Roles** pane, select the re-created availability group. In the bottom-middle pane, under the **Resources** tab, you should now see the re-created availability group and the listener resource. Right-click the re-created availability group resource, and then select **Properties**.
4. Select the **Dependencies** tab, select the listener resource from the drop-down box, and then select **OK**.
5. In SSMS, use **Object Explorer** to connect to the instance of SQL Server that hosts the primary replica of the re-created availability group. Select **Always On High Availability**, select the new availability group, and then select **Availability Group Listeners**. You should find the listener.
6. Right-click the listener, select **Properties**, type the appropriate port number for the listener, and then select **OK**.

### Method 2: Associate the listener with an existing SQL Server failover cluster instance (FCI)

If you're hosting your availability group on a SQL Server failover cluster instance (FCI), you can associate the listener clustered resource with the FCI clustered resource group while you drop and then re-create the availability group.

#### Move the listener to the failover cluster instance

1. Start Failover Cluster Manager, and then select **Roles** in the left pane.
2. In the pane that lists the roles, select the original availability group.
3. In the bottom middle pane under the **Resources** tab, right-click the availability group resource, and then select **Properties**.
4. Select the **Dependencies** tab, delete the dependency to the listener, and then select **OK**.
5. In the bottom middle pane under the **Resources** tab, right-click the listener, select **More Actions**, and then select **Assign to Another Role**.
6. In the **Assign Resource to Role** dialog box, select the SQL Server FCI instance, and then select **OK**.

    :::image type="content" source="media/alwayson-availability-databases-recovery-pending-suspect/add-resouce-role-sqlfci.png" alt-text="Screenshot of Assign Resource to Role dialog box.":::

7. In the **Roles** pane, select the FCI group. In the bottom middle pane, under the **Resources** tab, you should now see the new listener resource.

This change ensures that applications that use the listener can still use it to connect to the instance of SQL Server that hosts the production databases without interruption. You can now remove and re-create the original availability group. Or you can add the databases and replicas to the new availability group.

#### Reassign the listener to the re-created availability group

After you re-create the availability group, reassign the listener back to the availability group role. Then set up the dependency between the new availability group resource and the listener, and reassign the port to the listener:

1. Start Failover Cluster Manager, and then select **Roles** in the left pane.
2. In the pane that lists the roles, select the original FCI role.
3. In the bottom middle pane, under the **Resources** tab, right-click the listener, select **More Actions**, and then select **Assign to Another Role**.
4. In the dialog box, select the re-created availability group, and then select **OK**.
5. In the **Roles** pane, select the new availability group.
6. Under the **Resources** tab, you should see the new availability group and the listener resource. Right-click the new availability group resource, and then select **Properties**.
7. Select the **Dependencies** tab, select the listener resource from the drop-down box, and then select **OK**.
8. In SSMS, use **Object Explorer** to connect to the instance of SQL Server that hosts the primary replica of the new availability group.
9. Select **Always On High Availability**, select the new availability group, and then select **Availability Group Listeners**. You should find the listener.
10. Right-click the listener, select **Properties**, type the appropriate port number for the listener, and then select **OK**.

### Method 3: Drop the availability group, and then re-create the availability group and listener with the same listener name

This method results in a small outage for applications that are currently connected because the availability group and listener are dropped and then re-created:

1. Drop the availability group.

    > [!NOTE]
    > This step also drops the listener.

2. Immediately create a new, empty availability group that includes the listener definition, on the same server that hosts the production databases.

    For example, assume that your availability group listener is *aglisten*. The following Transact-SQL statement creates an availability group with no primary or secondary database, but it also creates a listener named *aglisten*. Applications can use this listener to connect.

    ```sql
    USE master
    GO
        CREATE AVAILABILITY GROUP ag FOR REPLICA ON 'sqlnode1' WITH (
            ENDPOINT_URL = 'tcp://sqlnode1:5022',
            AVAILABILITY_MODE = ASYNCHRONOUS_COMMIT,
            FAILOVER_MODE = MANUAL
        ) LISTENER 'aglisten' (
            WITH IP ((N'11.0.0.25', N'255.0.0.0')),
            PORT = 1433
        )
    GO
    ```

3. Recover the damaged database. Then add it and the secondary replica back to the availability group.

## Related content

- [What is an Always On availability group?](/sql/database-engine/availability-groups/windows/overview-of-always-on-availability-groups-sql-server)
- [Remove a primary database from an availability group](/sql/database-engine/availability-groups/windows/remove-a-primary-database-from-an-availability-group-sql-server)
- [Availability database is suspended for an availability group](/sql/database-engine/availability-groups/windows/availability-database-is-suspended)
- [Data synchronization state of some availability database is not healthy](/sql/database-engine/availability-groups/windows/data-synchronization-state-of-some-availability-database-is-not-healthy)
