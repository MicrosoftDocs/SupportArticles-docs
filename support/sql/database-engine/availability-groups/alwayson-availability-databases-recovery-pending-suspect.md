---
title: Always On DB in recovery pending or suspect state 
description: This article describes the errors and limitations of an availability database in Microsoft SQL Server that is in a Recovery Pending or Suspect state and how to restore the database to full functionality in an availability group.
ms.date: 08/03/2020
ms.custom: sap:High Availability and Disaster Recovery features
ms.reviewer: ramakoni, cmathews
---

# Troubleshoot Always On availability databases in Recovery Pending or Suspect state in SQL Server

This article describes the errors and limitations of an availability database in Microsoft SQL Server that's in a `Recovery Pending` or `Suspect` state and how to restore the database to full functionality in an availability group.

_Original product version:_ &nbsp; SQL Server 2012  
_Original KB number:_ &nbsp; 2857849

## Summary

Assume that an availability database that is defined in an Always On availability group transitions to a `Recovery Pending` or `Suspect` state in SQL Server. If this occurs on the availability group's primary replica, database availability is affected. In this situation, you can't access the database through the client applications. Additionally, you can't drop or remove the database from the availability group.

For example, assume SQL Server is running and an availability database is set to the `Recovery Pending` or `Suspect` state. When you query the dynamic management views (DMVs) at the primary replica by using the following SQL script, the database might be reported in a `NOT_HEALTHY` and `RECOVERY_PENDING` state or in a `SUSPECT` state as follows:

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

Additionally, this database may be reported as being in the **Not Synchronizing / Recovery Pending** or **Suspect** state in SQL Server Management Studio.

:::image type="content" source="media/alwayson-availability-databases-recovery-pending-suspect/db-not-synchronizing-recovery-pending.png" alt-text="Screenshot of database which is in Not Synchronizing / Recovery Pending state.":::

When the database is defined in an availability group, the database can't be dropped or restored. Therefore, you have to take specific steps to recover the database and return it to production use.

## More information

The following content discusses the errors and limitations of an availability database that is in a Recovery Pending state in various situations.

- Database status prevents restoring database

  You try to run the following SQL script to restore the database that has the `RECOVERY` parameter:

  ```sql
  RESTORE DATABASE <DatabaseName> WITH RECOVERY
  ```

  When you run this script, you receive the following error message because the database is defined in an availability group:

  > Msg 3104, Level 16, State 1, Line 1  
  > RESTORE cannot operate on database \<DatabaseName\> because it is configured for database mirroring or has joined an availability group. If you intend to restore the database, use ALTER DATABASE to remove mirroring or to remove the database from its availability group.  
  >
  > Msg 3013, Level 16, State 1, Line 1  
  > RESTORE DATABASE is terminating abnormally.  

- Database status prevents dropping database

  You try to run the following SQL script to drop the database:

  ```sql
  DROP DATABASE <DatabaseName>
  ```

  When you run this script, you receive the following error message because the database is defined in an availability group:

  > Msg 3752, Level 16, State 1, Line 1  
  > The database \<DatabaseName\> is currently joined to an availability group. Before you can drop the database, you need to remove it from the availability group.

- Database status prevents removing database from availability group

  You try to run the following SQL script to remove the database from the availability group:

  ```sql
  ALTER DATABASE <DatabaseName> SET hadr OFF
  ```

  When you try to run this script, you receive the following error message because the availability database belongs to the primary replica:

  > Msg 35240, Level 16, State 14, Line 1  
  > Database \<DatabaseName\> cannot be joined to or unjoined from availability group \<AvailabilityGroupName\>. This operation is not supported on the primary replica of the availability group.

  Because of this error message, you may be compelled to fail over the database. After the database is failed over, the replica that owns the recovery pending database is in the secondary role. In this situation, you try to execute the following SQL script again to remove the database from the availability group at the secondary replica:

  ```sql
  ALTER DATABASE <DatabaseName> SET hadr OFF
  ```

  However, you still can't remove the database from the availability group, and you receive the following error message because the database is still in the Recovery Pending state:

  > Msg 921, Level 16, State 112, Line 1  
  > Database \<DatabaseName\> has not been recovered yet. Wait and try again.

## Resolution when the database is in the secondary role

To resolve this issue, take the following general actions:

- Remove from the availability group the replica that's hosting the damaged database when the database is in the secondary role.
- Resolve any issues that are affecting the system and that might have contributed to the database failure.
- Restore the replica to the availability group.

To take these actions, connect to the new primary replica, and then run the `ALTER AVAILABILITY GROUP` SQL script to remove the replica that's hosting the failed availability database. To do this, follow these steps.

These steps assume that the primary replica first hosts the damaged database. Therefore, a failover must first occur to transition the replica that's hosting the damaged database into a secondary role.

1. Connect to the server that's running SQL Server and that's hosting the secondary replica.
2. Run the following SQL script:

    ```sql
    ALTER AVAILABILITY GROUP <AvailabilityGroupName> FAILOVER
    ```

3. Run the following SQL script to remove the replica that's hosting the damaged database from the availability group:

    ```sql
    ALTER AVAILABILITY GROUP <AvailabilityGroupName> REMOVE REPLICA ON '<SQLServerNodeName>'
    ```

4. Resolve any issues on the server that's running SQL Server and that might contribute to the database failure.
5. Add the replica back into the availability group.

## Resolution when the primary replica is the only replica in the availability group

If the primary replica hosts the damaged database and is the only working replica in the availability group, the availability group must be dropped. After the availability group is dropped, your database can be recovered from a backup, or other emergency recovery efforts can be applied to restore the databases and to resume production.

To drop the availability group, use the following SQL script:

```sql
DROP AVAILABILITY GROUP <AvailabilityGroupName>
```

At this point, you can try to recover the problematic database. Or you can restore the database from the last-known good backup copy.

## Resolution when you drop the availability group

When you drop an availability group, the listener resource is also dropped and interrupts application connectivity to the availability databases.

To minimize application downtime, use one of the following methods to sustain application connectivity through the listener and drop the availability group:

### Method 1: Associate the listener with a new availability group (role) in Failover Cluster Manager

This method lets you maintain the listener while dropping and re-creating the availability group.

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

7. Click the **Dependencies** tab, select the listener resource from the drop-down box, and then select **OK**.

    :::image type="content" source="media/alwayson-availability-databases-recovery-pending-suspect/ag-test-properties-dependencies.png" alt-text="Screenshot of new availability group properties Dependencies tab.":::

8. In SQL Server Management Studio, use **Object Explorer** to connect to the instance of SQL Server that hosts the primary replica of the new availability group. Select **Always On High Availability**, click the new availability group, and then select **Availability Group Listeners**. You should find the listener.

9. Right-click the listener, select **Properties**, type the appropriate port number for the listener, and then select **OK**.

    :::image type="content" source="media/alwayson-availability-databases-recovery-pending-suspect/config-ag-listener.png" alt-text="Screenshot of availability group listener properties, showing the configuration of listener." border="false":::

This makes sure that applications that use the listener can still use it to connect to the instance of SQL Server that is hosting the production databases without interruption. The original availability group can now be completely removed and re-created. Or the databases and replicas can be added to the new availability group.

If you re-create the original availability group, you should reassign the listener back to the availability group role, set up the dependency between the new availability group resource and the listener, and then reassign the port to the listener. To do this, follow these steps:

1. Start Failover Cluster Manager, and then select **Roles** in the left pane. In the pane that lists the roles, click the new availability group that hosts the listener.
2. In the bottom middle pane under the **Resources** tab, right-click the listener, select **More Actions**, and then select **Assign to Another Role**. In the dialog box, choose the re-created availability group, and then select **OK**.
3. In the **Roles** pane, click the re-created availability group. In the bottom middle pane, under the **Resources** tab, you should now see the re-created availability group and the listener resource. Right-click the re-created availability group resource, and then select **Properties**.
4. Select the **Dependencies** tab, select the listener resource from the drop-down box, and then select **OK**.
5. In SQL Server Management Studio, use **Object Explorer** to connect to the instance of SQL Server that hosts the primary replica of the re-created availability group. Select **Always On High Availability**, click the new availability group, and then select **Availability Group Listeners**. You should find the listener.
6. Right-click the listener, select **Properties**, type the appropriate port number for the listener, and then select **OK**.

### Method 2: Associate the listener with an existing SQL Server Failover Clustered Instance (SQLFCI)

If you are hosting your availability group on a SQL Server Failover Clustered Instance (SQLFCI), you can associate the listener clustered resource with the SQLFCI clustered resource group while you drop and then re-create the availability group.

1. Start Failover Cluster Manager, and then select **Roles** in the left pane.
2. In the pane that lists the roles, select the original availability group.
3. In the bottom middle pane under the **Resources** tab, right-click the availability group resource, and then select **Properties**.
4. Select the **Dependencies** tab, delete the dependency to the listener, and then select **OK**.
5. In the bottom middle pane under the **Resources** tab, right-click the listener, select **More Actions**, and then select **Assign to Another Role**.
6. In the **Assign Resource to Role** dialog box, click the SQL Server FCI instance, and then select **OK**.

    :::image type="content" source="media/alwayson-availability-databases-recovery-pending-suspect/add-resouce-role-sqlfci.png" alt-text="Screenshot of Assign Resource to Role dialog box.":::

7. In the **Roles** pane, select the SQLFCI group. In the bottom middle pane, under the **Resources** tab, you should now see the new listener resource.

This makes sure that applications that use the listener can still use it to connect to the instance of SQL Server that hosts the production databases without interruption. The original availability group can now be removed and re-created. Or the databases and replicas can be added to the new availability group.

After the availability group is re-created, reassign the listener back to the availability group role. Then set up the dependency between the new availability group resource and the listener, and reassign the port to the listener:

  1. Start Failover Cluster Manager, and then select **Roles** in the left pane.
  2. In the pane that lists the roles, click the original SQLFCI role.
  3. In the bottom middle pane, under the **Resources** tab, right-click the listener, select **More Actions**, and then select **Assign to Another Role**.
  4. In the dialog box, click the re-created availability group, and then select **OK**.
  5. In the **Roles** pane, select the new availability group.
  6. Under the **Resources** tab, you should see the new availability group and the listener resource. Right-click the new availability group resource, and then select **Properties**.
  7. Select the **Dependencies** tab, select the listener resource from the drop-down box, and then select **OK**.
  8. In SQL Server Management Studio, use **Object Explorer** to connect to the instance of SQL Server that hosts the primary replica of the new availability group.
  9. Select **Always On High Availability**, click the new availability group, and then select **Availability Group Listeners**. You should find the listener.
  10. Right-click the listener, select **Properties**, type the appropriate port number for the listener, and then select **OK**.

### Method 3: Drop the availability group, and then re-create the availability group and listener with the same listener name

This method will result in a small outage for applications that are currently connected because the availability group and listener are dropped and then re-created:

1. Drop the availability group.

    > [!NOTE]
    > This will also drop the listener.

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

