---
title: Detect and troubleshoot frequent configuration changes
description: Discusses how to detect and troubleshoot frequent configuration changes in System Center Operations Manager.
ms.date: 04/15/2024
ms.reviewer: rpesenko, vitalyf
---
# Detect and troubleshoot frequent configuration changes in Operations Manager

This article discusses how to detect and troubleshoot frequent configuration changes in System Center Operations Manager.

_Original product version:_ &nbsp; Microsoft System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 2603913

## Configuration overview

The System Center Management Configuration service is responsible for calculating the configuration of every health service in the Operations Manager management group. The configuration of a health service consists of the rules, monitors, discoveries, and tasks for the health service and for all the instances that the health service monitors.

To calculate all the required configurations for each health service, the Management Configuration service must have a list of the following items:

- All instances of all monitored classes
- The hosting relationships between instances
- The rules, monitors, discoveries, and other workflows that are assigned to the monitored classes
- The health services that are responsible for monitoring the instances

In addition, the Management Configuration service must be able to read the membership of all instance groups in the management group. The Management Configuration service must also apply any overrides for rules and monitors that are targeted at these groups, classes, or individual instances.

Objects in a management group will be defined as instances of monitored classes based on discovery data that's submitted by discovery workflows. If a key property of an object changes, that object may be added as a new instance of a monitored class. Otherwise, that object is no longer considered an instance of that class.

As the list changes for the classes that the object is a member of, the configuration also changes for the health service that monitors that object. These changes occur as rules, monitors, discoveries, tasks, and overrides are added or removed from the previous configuration.

## Configuration churn

Agents may be unable to receive a stable configuration in the following scenarios:

- A large amount of discovery data is submitted to the Management Configuration service.
- Discovery data is submitted too fast for the Management Configuration service to process before more discovery data is submitted. This scenario occurs because the data will always be in the process of being calculated.

The frequent submission of discovery data, also known as configuration churn, can cause some health services to run under old configurations or cause the configuration of management servers to become stale. This behavior then causes some health services to appear dimmed (unavailable) in the Operations console.

Discovery data is submitted by a health service when a discovery workflow runs. Introduction of a new management pack to a management group can cause several discovery workflows to run on each agent. And, as new instances are discovered, additional discoveries may be run on some agents. Changes to groups, overrides, and other workflows can cause discovery workflows to run on agents. And, introduction of new agents can also cause the Management Configuration service to update the instance space by using the new agent's configuration.

The Configuration Management service is forced to recalculate the health service configuration frequently in the following scenarios:

- A discovery workflow is configured to run too frequently.
- The properties that are discovered by the workflow change every time that the discovery workflow is run.

If these scenarios occur for many agents, or management servers are under a heavy workload already, the Configuration Management service may be unable to keep up with the rate of change, and configuration churn may occur.

## Identify configuration churn by using the management server event log

An event that resembles the following in the Operations Manager event log on management server indicates that the management group configuration has changed because of new discovery data:

> Log Name: Operations Manager  
> Source: OpsMgr Connector  
> Event ID: 21024  
> Level: Information  
> Computer: \<Name>  
> Description:  
> OpsMgr's configuration may be out-of-date for management group \<ManagementGroupName>, and has requested updated configuration from the Configuration Service. The current(out-of-date) state cookie is "3A B0 1E 5C 81 F3 12 F5 56 B7 8A EF F8 01 BA 09 86 55 06 48 "

An event that resembles the following indicates that the Management Configuration service has finished processing the new discovery data and calculated any changes that are required to the management group configuration, based on the new data:

> Log Name: Operations Manager  
> Source: OpsMgr Connector  
> Event ID: 21025  
> Level: Information  
> Computer: \<Name>  
> Description:  
> OpsMgr has received new configuration for management group \<ManagementGroupName> from the Configuration Service. The new state cookie is "34 FA 11 61 4D B8 03 59 3D 1D 66 B7 83 F3 C0 AA 7A 6F 1A 3B "

In a typical environment, every event 21024 should be followed by event 21025. If the discovery data did not cause any configuration data to change, the event ID will be 21026 instead. In a large management group, pairs of 21024 and 21025 or 21026 events should be expected to occur several times per hour. Long strings of 21024 events without a corresponding 21025 or 21026 event is a sign of configuration churn. In addition, the event log may show the following event that indicates that churn was detected:

> Log Name: Operations Manager  
> Source: OpsMgr Config Service  
> Event ID: 29202  
> Level: Warning  
> Computer: \<Name>  
> Description:  
> OpsMgr Config Service could not retrieve a consistent state from the OpsMgr database due to too frequent database changes.  
> This could be due to a normal and temporary increase of discovery data; however check the most recent changes to determine if this increase is unexpected.  
> Most recent monitoring object change:  
> Instance = %1  
> Class = %2  
> Modified time = %3  
> Most recent monitoring relationship change:  
> Relationship instance = %4  
> Source instance = %5  
> Target instance = %6  
> RelationshipClass = %7  
> Modified time = %8  

The Data Access Layer must read multiple tables when the Data Access Layer queries for changes. If one of the tables is modified after it is read but before all tables were read, the Data Access Layer logs the previous event ID 29202 and retry. If an entity or relationship instance was read during this time, information about these instances is included in the event fields. Otherwise, these fields are left empty.

## Identify potential causes of configuration churn by using the Operations Manager Data Warehouse

In management groups in which the Operations Manager Reporting component was installed, several SQL queries can be used to identify workflows that are submitting frequent changes. These queries should be run in SQL Server Management Studio against the Data Warehouse instance.

Total changes submitted by discovery workflows in last 24 hours:

```sql
select
   ManagedEntityTypeSystemName,
   DiscoverySystemName,
   count(*) As 'Changes'
from
   (
      select distinct
         MP.ManagementPackSystemName,
         MET.ManagedEntityTypeSystemName,
         PropertySystemName,
         D.DiscoverySystemName,
         D.DiscoveryDefaultName,
         MET1.ManagedEntityTypeSystemName As 'TargetTypeSystemName',
         MET1.ManagedEntityTypeDefaultName As 'TargetTypeDefaultName',
         ME.Path,
         ME.Name,
         C.OldValue,
         C.NewValue,
         C.ChangeDateTime
      from
         dbo.vManagedEntityPropertyChange C
         inner join
            dbo.vManagedEntity ME
            on ME.ManagedEntityRowId = C.ManagedEntityRowId
         inner join
            dbo.vManagedEntityTypeProperty METP
            on METP.PropertyGuid = C.PropertyGuid
         inner join
            dbo.vManagedEntityType MET
            on MET.ManagedEntityTypeRowId = ME.ManagedEntityTypeRowId
         inner join
            dbo.vManagementPack MP
            on MP.ManagementPackRowId = MET.ManagementPackRowId
         inner join
            dbo.vManagementPackVersion MPV
            on MPV.ManagementPackRowId = MP.ManagementPackRowId
         left join
            dbo.vDiscoveryManagementPackVersion DMP
            on DMP.ManagementPackVersionRowId = MPV.ManagementPackVersionRowId
            AND CAST(DefinitionXml.query('data(/Discovery/DiscoveryTypes/DiscoveryClass/@TypeID)') AS nvarchar(max)) like '%' + MET.ManagedEntityTypeSystemName + '%'
         left join
            dbo.vManagedEntityType MET1
            on MET1.ManagedEntityTypeRowId = DMP.TargetManagedEntityTypeRowId
         left join
            dbo.vDiscovery D
            on D.DiscoveryRowId = DMP.DiscoveryRowId
      where
         ChangeDateTime > dateadd(hh, - 24, getutcdate())
   )
   As # T
group by
   ManagedEntityTypeSystemName,
   DiscoverySystemName
order by
   count(*) DESC
```

This query creates three columns. The first column is the class of object at which the workflow is targeted. The second column indicates the internal name of the discovery workflow. The third column indicates the total number of property changes for all instances of this class that were submitted by the workflow in the last 24 hours. The total number of changes, for all classes, represents the number of times the Configuration Management service must recalculate the configuration for an agent health service.

The number of changes for some classes of objects, even in a stable environment, may not ever reach zero. Any change, such as adding or removing a property, agents that are added or decommissioned, server roles that are added or changed, and so on, are reflected in the numbers that are returned. In environments in which configuration churn is experienced, one or several workflows will likely show a larger value than other workflows.

Properties changed in the last 24 hours:

```sql
select distinct
   MP.ManagementPackSystemName,
   MET.ManagedEntityTypeSystemName,
   PropertySystemName,
   D.DiscoverySystemName,
   D.DiscoveryDefaultName,
   MET1.ManagedEntityTypeSystemName As 'TargetTypeSystemName',
   MET1.ManagedEntityTypeDefaultName As 'TargetTypeDefaultName',
   ME.Path,
   ME.Name,
   C.OldValue,
   C.NewValue,
   C.ChangeDateTime
from
   dbo.vManagedEntityPropertyChange C
   inner join
      dbo.vManagedEntity ME
      on ME.ManagedEntityRowId = C.ManagedEntityRowId
   inner join
      dbo.vManagedEntityTypeProperty METP
      on METP.PropertyGuid = C.PropertyGuid
   inner join
      dbo.vManagedEntityType MET
      on MET.ManagedEntityTypeRowId = ME.ManagedEntityTypeRowId
   inner join
      dbo.vManagementPack MP
      on MP.ManagementPackRowId = MET.ManagementPackRowId
   inner join
      dbo.vManagementPackVersion MPV
      on MPV.ManagementPackRowId = MP.ManagementPackRowId
   left join
      dbo.vDiscoveryManagementPackVersion DMP
      on DMP.ManagementPackVersionRowId = MPV.ManagementPackVersionRowId
      AND CAST(DefinitionXml.query('data(/Discovery/DiscoveryTypes/DiscoveryClass/@TypeID)') AS nvarchar(max)) like '%' + MET.ManagedEntityTypeSystemName + '%'
   left join
      dbo.vManagedEntityType MET1
      on MET1.ManagedEntityTypeRowId = DMP.TargetManagedEntityTypeRowId
   left join
      dbo.vDiscovery D
      on D.DiscoveryRowId = DMP.DiscoveryRowId
where
   ChangeDateTime > dateadd(hh, - 24, getutcdate())
ORDER BY
   MP.ManagementPackSystemName,
   MET.ManagedEntityTypeSystemName
```

This query can identify which properties have changed in the last 24 hours. Combined with the previous query, this query can show what the old and new values were for the property, which agents submitted the change, the workflow that conducted the discovery, and the management pack in which it was contained.

## Reduce configuration churn

Older management packs introduced discovery workflows that submitted property changes too frequently. The current versions of most management packs have modified these discovery workflows to submit data less frequently, or the management packs don't query volatile properties that frequently change. We recommend that you upgrade management packs that contain workflows that frequently occur in the previous query.

If a new version of the management pack isn't available, or the new version cannot be deployed now, the discovery interval can be adjusted by using override to run less frequently. Sometimes, the discovery that is responsible for the configuration churn can be disabled by override. If the discovery is disabled for several weeks, the objects that are discovered by the workflow may be groomed out of the database. However, disabling the discovery can provide a short-term workaround to eliminate configuration churn, as long as a permanent solution can be implemented before any objects are groomed from the database. The workflow can also be enabled for short intervals to rediscover the objects before they are groomed.

Some workflows in these older management packs are discussed in [What is config churn?](https://kevinholman.com/2009/10/04/what-is-config-churn/#:~:text=Config%20churn%20is%20basically%2C%20when,ending%20loop%20of%20generating%20config.&text=For%20large%20management%20groups%20over,%2C%20and%20Disk%20I%2FO.)

If the workflow is from a custom discovery that targets a volatile property, such as free disk space, the discovery should be rewritten so that it does not target a property that frequently changes. Discovery workflows should not target instances that have a short lifetime (several weeks or less). Discovery workflows should not collect properties of those instances that frequently change (one or more times a month). Volatile data is not considered in calculating a configuration. Therefore, volatile data should be collected by performance rules and not by discovery workflows.

## Additional performance tuning

In large management groups (greater than 1,000 agents), the root management server (RMS) may become busy with operations that typically don't cause a problem in smaller management groups. In this situation, even a small rate of property changes could cause frequent churn because of the length of time that is required to process the changes. Several configuration changes can be used to reduce the operational overhead of the RMS and enable it to process a typical rate of property changes quickly enough to avoid configuration churn. These configuration changes are discussed in [Performance Optimizations for Operations Manager 2007 R2 and 2012](/archive/blogs/mgoedtel/performance-optimizations-for-operations-manager-2007-r2-and-2012).

## Force configuration change for the management group

If configuration churn for the management group occurs constantly, any changes to reduce the frequency of the problem workflows or to disable the problem workflows will never be propagated to agents. In this case, the flow of incoming discovery data must be blocked to allow the System Center Configuration Management service to calculate a current configuration in which the workflow that produces this data is disabled or runs less frequently.

Discovery data is submitted to the `OperationsManager` database through the System Center Data Access Service (DAS). The data is first submitted to the DAS by the System Center Management service on the RMS. The RMS obtains this data from agents or from other management servers. You can use Windows firewall or some other networking means to block incoming connections to the RMS on port 5723. This blocking procedure prevents discovery data from being submitted to the `OperationsManager` database long enough for the Configuration Management service to calculate the current configuration for the agents that are submitting the data.

The System Center Management service and the System Center Data Access Service on the RMS should not be stopped or disabled while the Configuration Management service is calculating the current configuration. The System Center Configuration Management service requires the following in order to complete the calculation of the management group configuration:

- The System Center Management service on the RMS must be running and healthy.
- The System Center Data Access Service must be able to communicate with the database.

In addition, some data may become backlogged on the agents and on other management servers while the Configuration Management service is calculating the current configuration. Therefore, the firewall or port exclusion should be lifted as soon as you see event ID 21025 in the Operations Manager event log on the RMS. This event indicates that the Configuration Management service has calculated the new configuration for the management group where the workflow is now disabled or modified

## Identify potential causes of configuration churn by using Operations Manager reporting  

New reports were introduced. These reports provide insight into the overall volume of data that the management group processes. These reports can be used to establish a standard baseline and to identify opportunities for tuning object discovery workflows. As soon as configuration churn is identified and addressed, these reports can be used for long-term planning to prevent recurrences of churn.

- Data Volume by Management Pack report

  The **Data Volume by Management Pack** report compiles information about the volume of data that the management packs generate. The report lists the number of occurrences per management pack for the following data types:

  - Discoveries
  - Alerts
  - Performance (number of instances that are submitted for performance counters and that are collected by management pack)
  - Events
  - State changes

- Data Volume by Workflow and Instance report

  The **Data Volume by Workflow and Instance** report compiles information on the volume of data that is generated, organized by workflows (discoveries, rules, monitors, and so on) and by instances.

  There are two ways to access this report:

  - In the **Data Volume by Management Pack** report, select one of the counts cells in the table at the top of the report to open the **Data Volume by Workflow and Instance** report for the management packs.
  - Run the report directly from the **Reporting** section in the Operations console. If you run the **Data Volume by Workflow and Instance** report directly, you should set the parameters of the report to customize the results. This report provides details for information in the **Data Volume by Management Pack** report. Therefore, the default parameter settings may not provide the information that you are looking for.
