---
title: Configuration data isn't updated
description: Fixes some configuration update issues in a System Center Operations Manager management group.
ms.date: 07/10/2024
ms.reviewer: RPesenko
---
# Configuration may not update in System Center Operations Manager

This article provides a resolution for the issues that configuration changes may not update in a System Center Operations Manager management group.

_Original product version:_ &nbsp; System Center Operations Manager  
_Original KB number:_ &nbsp; 2635742

## Symptoms

You may experience one or more of the following symptoms in a System Center Operations Manager management group:

- Newly installed agents display as **Not Monitored** in the Operations console, yet existing agents are monitored.
- One or more monitors on one or more agents may not change state when healthy or unhealthy conditions are met.
- Agents show as being in maintenance mode in the Operations console, yet the workflows are not actually unloaded by the System Center Management service on the monitored computer.
- Configuration changes, new rules, monitors, or overrides are not applied to some agents.
- The Operations Manager event log on one or more agents displays event 21026, indicating that the current configuration is still valid, even though the configuration for these agents should have been updated.
- The file OpsMgrConnector.Config.xml in the management group folder under `Health Service State\Connector Configuration Cache` doesn't update for long periods of time relative to the rest of the management group on one or more agents.

In addition, the Operations Manager event log may display one or more events with an ID 29106 when the System Center Configuration Management service restarts. For example:

> Log Name:      Operations Manager  
> Source:          OpsMgr Config Service  
> Event ID:        29106  
> Level:            Warning  
> Description:  
> The request to synchronize state for OpsMgr Health Service identified by "da4d36df-ce22-8930-e6d4-45b783e9fdb1" failed due to the following exception "System.Collections.Generic.KeyNotFoundException: The given key was not present in the dictionary.

> Log Name:      Operations Manager  
> Source:          OpsMgr Config Service  
> Event ID:        29106  
> Level:            Warning  
> Description:  
> The request to synchronize state for OpsMgr Health Service identified by "fc1c815b-c0c4-242d-ae27-30db4ef99b54" failed due to the following exception "Microsoft.EnterpriseManagement.Common.DataItemDoesNotExistException: TypedManagedEntityId = 'ac8f3d08-ee2a-ae21-0e46-19c3da794183' is deleted.

Collecting ETL logs against the Configuration Service at INF level might reveal lines similar to the following:

> 3326  [ConfigurationChangeSetProvider.UpdateQueryTimestampFromResults]    \[configurationchangesetprovider_cs595]( 000000000343A92F )Timestamp = *04/11/2074* 08:57:09.  
> 3327  [DatabaseAccessor.NotifyOnChanges]    \[databasenotification_cs329]( 0000000002E4BD4E )Firing change notification.  
> 3328  [ConfigurationEngine.DatabaseHelper.OnConfigurationChange]    \[configurationengine_cs499]( 00000000023546E1 )IsIncremental=True, NumberOfChanges=0  
> 3329  [StateManager.CollectDirty]    \[statemanager_cs39]( 00000000035D75A8 )State=274cda45-6031-c0e2-3659-0072251f5655 is dirty  
    < large number of additional GUIDS >  
> 3432  [StateManager.CollectDirty]    \[statemanager_cs39]( 00000000035D75A8 )State=6ec4fb2d-d1c1-72a8-32e6-fe26df42aba8 is dirty  
> 3433  [StateManager.CollectDirty]    \[statemanager_cs45]( 00000000035D75A8 ) **NumberOfDirtyStates=104**  
> 3434  [ConfigurationEngine.CommunicationHelper.NotifyDirtyStatesTask.Run]    \[configurationengine_cs869]Completed successfully  
> 3435  [DatabaseAccessor.GetPollingIntervalMillisecondsTimeSpan]    [databaseaccessor_cs126]Database polling interval 0 milliseconds

> [!NOTE]
> The timestamp in line 3326 is set to *04/11/2074*. If this appears in ETL logging, use the SQL queries in the [More information](#more-information) section to confirm the condition listed in the Cause section exists.

## Cause

The System Center Management Configuration service uses a timestamp to determine when new configuration data needs to be calculated for agents and management servers. If the system clock on an agent is faster than the system clock on the management server, discovery data from this agent will set the timestamp for one or more managed instances hosted by that agent to the current agent system clock time. The System Center Configuration Management service will delay calculating configuration updates for the instances on that agent until the system clock on the management server is current with the timestamp for that discovery data. If the agent system clock was faster than management server system time when discovery data was sent, or the agent continues to send data with a future timestamp, then it is possible that the management group would experience the symptoms listed above.

Setting the agent system clock time to match the management server system clock time will not reset the timestamp for the existing discovery data and the issue will remain until the management server system clock time exceeds the discovery data by the grooming interval, when the obsolete discovery data will be groomed normally.

## Resolution

1. The system clocks for all agents in the management group must not significantly exceed the system clock on the management servers when submitting any data. If any agents have system clocks more than a few minutes faster than the management servers, they should be corrected first to avoid any additional data with future timestamps being added to the database.

2. The future timestamps for the discovery data that has already been submitted must be modified in the `OperationsManager` database to reflect the current time.

3. The System Center Configuration Management service and System Center Management service on the management server must be restarted after both the above conditions are met.

## More information

1. Use the following three queries to determine if this condition exists. The queries must be run against the `OperationsManager` database. If the timestamp with the greatest value in the table is greater than the current time (in UTC format), then the condition exists.

    ```sql
    Select GetUTCDate()as 'Current Time',
    MAX(TimeGeneratedOfLastSnapshot) as 'DiscoverySource Timestamp' from DiscoverySource

    Select GetUTCDate()as 'Current Time',
    MAX(timegenerated) as 'DiscoverySourceToTypedManagedEntity Timestamp' from DiscoverySourceToTypedManagedEntity

    Select GetUTCDate()as 'Current Time',
    MAX(timegenerated) as 'DiscoverySourceToRelationship Timestamp' from DiscoverySourceToRelationship
    ```

2. The following three queries can be used to determine which computers may have submitted discovery data with a future timestamp. If the system clocks on these agents are not current, set them to current time before taking any additional action.

    **Find all computers with `DiscoverySource Timestamp` more than one day in future**

    ```sql
    Select DisplayName, *
    from BaseManagedEntity
    where BaseManagedEntityID in
     (select BaseManagedEntityId from BaseManagedEntity BME
      join DiscoverySource DS on DS.BoundManagedEntityId = BME.BaseManagedEntityId
      where DS.TimeGeneratedOfLastSnapshot > DATEADD (d, 1, GETUTCDATE())
      and FullName like 'Microsoft.Windows.Computer%')
    ```

    **Find all computers with `DiscoverySourceToTypedManagedEntity Timestamp` more than one day in future**

    ```sql
    Select DisplayName, *
    from BaseManagedEntity
    where BaseManagedEntityID in
     (select BaseManagedEntityId from BaseManagedEntity BME
      join DiscoverySourceToTypedManagedEntity DSTME on DSTME.TypedManagedEntityId = BME.BaseManagedEntityId
      where DSTME.TimeGenerated > DATEADD (d, 1, GETUTCDATE())
      and FullName like 'Microsoft.Windows.Computer%')
       )
    ```

    **Find all computers with `DiscoverySourceToRelationship Timestamp` more than one day in future**

    ```sql
    Select DisplayName, *
    from BaseManagedEntity
    where BaseManagedEntityID in
      (select BaseManagedEntityId from BaseManagedEntity BME
       join DiscoverySource DS on DS.BoundManagedEntityId = BME.BaseManagedEntityId
       join DiscoverySourceToRelationship DSR on DSR.DiscoverySourceId = DS.DiscoverySourceId
       where DSR.TimeGenerated > DATEADD (d, 1, GETUTCDATE())
       and FullName like 'Microsoft.Windows.Computer%')
    ```

3. To correct the existing data, run the following commands against the affected tables.

    ```sql
    Update DiscoverySource
    Set TimeGeneratedOfLastSnapshot = GETUTCDATE()
    where TimeGeneratedOfLastSnapshot > GETUTCDATE()

    Update DiscoverySourceToTypedManagedEntity
    Set TimeGenerated = GETUTCDATE()
    where TimeGenerated > GETUTCDATE()

    Update DiscoverySourceToRelationship
    Set TimeGenerated = GETUTCDATE()
    where TimeGenerated > GETUTCDATE()
    ```

4. The following query can be used to see what additional data has been submitted to the database with a timestamp in the future. The tables related to maintenance mode should have several rows, assuming there are agents currently in maintenance mode that's scheduled to end at some time. All other tables should have timestamps with the current time, or in the past.

    This query doesn't work if we have any custom schema due to application requirement (If you run it against Data Warehouse or Database, you will have errors). The following query will help to get the table information including the custom schema.

   ```sql
    /* */

    /* The following query will search all tables in the database */

    /* for columns with datetime datatypes. It will then return */

    /* the total number of rows in each table that have values */

    /* greater than the configured number of days from present. */

    /* Times are all in UTC format. The default increment is */

    /* 3 days, but can be adjusted as needed. */

    /* */

    -- Variable declarations

    DECLARE @schemaname AS sysname;

    DECLARE @tabname AS sysname;

    DECLARE @colname AS sysname;

    DECLARE @fcontin AS tinyint;

    DECLARE @query AS nvarchar(max);

    -- Temporary table to store the results

    CREATE TABLE #work

    (

    SchemaName sysname,

    TableName sysname,

    ColumnName sysname,

    NumRows int

    );

    -- Cursor to fetch schema, table, and column names with datetime type

    DECLARE cur_meta CURSOR FOR

    SELECT

    s.name AS SchemaName,

    t.name AS TableName,

    c.name AS ColumnName

    FROM

    sys.columns c

    INNER JOIN

    sys.tables t ON c.object_id = t.object_id

    INNER JOIN

    sys.schemas s ON t.schema_id = s.schema_id

    INNER JOIN

    sys.types y ON c.system_type_id = y.system_type_id

    WHERE

    y.name IN ('datetime', 'date', 'datetime2', 'smalldatetime');

    -- Open the cursor

    OPEN cur_meta;

    -- Loop control variable

    SET @fcontin = 1;

    -- Loop through the cursor

    WHILE (@fcontin > 0)

    BEGIN

    -- Fetch the next row

    FETCH cur_meta INTO @schemaname, @tabname, @colname;

    -- Exit loop if no more rows

    IF (@@FETCH_STATUS < 0)

    BREAK;

    -- Debug print statement (can be commented out in production)

    PRINT 'Schema = ' + @schemaname + ', Table = ' + @tabname + ', Column = ' + @colname;

    /* Change the increment in the DATEADD(dd,3,GETUTCDATE()) function */

    /* as needed from the default of +3 days from current time */

    SET @query = 'IF EXISTS (SELECT 1 FROM ' + QUOTENAME(@schemaname) + '.' + QUOTENAME(@tabname) + ') '

    + 'BEGIN '

    + ' SELECT ''' + @schemaname + ''', ''' + @tabname + ''', ''' + @colname + ''', COUNT(*) '

    + ' FROM ' + QUOTENAME(@schemaname) + '.' + QUOTENAME(@tabname)

    + ' WHERE ' + QUOTENAME(@colname) + ' > DATEADD(dd,3,GETUTCDATE())'

    + 'END';

    -- Execute the query and insert results into the temporary table

    INSERT INTO #work (SchemaName, TableName, ColumnName, NumRows)

    EXECUTE sp_executesql @query;

    END

    -- Close and deallocate the cursor

    CLOSE cur_meta;

    DEALLOCATE cur_meta;

    -- Select results ordered by number of rows with future dates

    SELECT *

    FROM #work

    ORDER BY NumRows DESC;

    -- Drop the temporary table

    DROP TABLE #work;
    ```
