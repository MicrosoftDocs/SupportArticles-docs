---
title: Troubleshoot blank reports
description: This article helps you troubleshoot five common problems about blank reports in Operations Manager.
ms.date: 04/15/2024
ms.reviewer: adoyle
---
# Troubleshoot blank reports in System Center Operations Manager

Blank reports can be a common issue with System Center Operations Manager. These are caused by many different reasons.

_Original product version:_ &nbsp; System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 2573329

In this article, we'll discuss the following common problems:

- [The wrong type of entity was selected as the report target](#the-wrong-type-of-entity-was-selected-as-the-report-target).
- [The corresponding performance collection rule or the script that generates the performance data is not enabled for the report target](#the-performance-collection-rule-or-the-script-that-generates-the-performance-data-is-not-enabled-for-the-report-target).
- [There is a functional problem with the Health Service on the agent](#there-is-a-functional-problem-with-the-health-service-on-the-agent).
- [Management servers are unable to insert data into the OperationsManagerDW database](#management-servers-are-unable-to-insert-data-into-the-operationsmanagerdw-database).
- [Data is stuck in the staging tables in the OperationsManagerDW database](#data-is-stuck-in-the-staging-tables-in-the-operationsmanagerdw-database).

There are other reasons why reports may return blank but they are outside of the scope of this article. For those issues, it is recommended that you open a support case with Microsoft product support and get assistance.

## The wrong type of entity was selected as the report target

For this problem and the other issues, we are going to focus on performance reports. They are the most common to return blank and the same steps typically apply for the other reports as well. The first step is to identify the entity and the performance counter that generates the report data. The easiest way to get this information is to find the corresponding performance view in **Monitoring**. The legend in the performance view will list the name of the entity, performance counter, and performance collection rule.

For example, if you're troubleshooting the **Exchange Information Store Usage** report from the Exchange 2003 management pack, go to **Monitoring** and open the **IS Performance Data** view. The path for this view is Microsoft Exchange Server/Exchange 2003/Components/IS Performance Data. In the performance view, the legend will show you the target, counter, and collection rule for the performance data. In the **IS Performance Data** view, the target is always **Information Store** and the path is always the name of a server that runs the IS service. If you check the box for any row in the legend, the performance data for that counter on that **Information Store** is displayed in the chart. If a line appears in the chart, the data is being collected.

In this example, the target is always **Information Store**. This means that you must select **Information Store** entities only when you run the **Exchange Information Store Usage** report. Any other entity besides **Information Store** will return no data. Therefore, if you select an Exchange 2003 role object, you will generate an empty report. To select an **Information Store** entity as the report target, select **Add Object**, type **Information Store** for the search string and select **Search**. A list of every **Information Store** will appear. The path value in the search results will give you the server name that hosts the **Information Store**.

The same principles apply for most other reports. To troubleshoot the **Exchange SMTP Usage** report, go to **Monitoring** and open the **SMTP Performance Data** view under Microsoft Exchange Server/Exchange 2003/SMTP. You will see that target is always **SMTP**. To troubleshoot the **SQL Server Database space** report from the SQL Server 2005 management pack, go to **Monitoring** and open the **Database Free Space performance** view under **SQL Server/Performance**. You will see that target is always the database name. And remember that **Target** in the legend will be the search string and the target you must use when configuring the report parameters.

## The performance collection rule or the script that generates the performance data is not enabled for the report target

Again, you will rely on the performance view in **Monitoring**. If the performance data isn't being collected, you will see one of two symptoms in the performance view:

- The expected entity is not listed in the legend.
- The entity is listed in the legend, but no data is displayed when you check its box.

If the expected entity is missing from the performance view legend, this may mean that the entity has not been discovered. For example, you may have an **Information Store** or a SQL Server 2005 Database Engine running on an agent that doesn't appear in the list. To check for this, open **My Workspace**, create a new state view, and configure the state view to show data related to that type of entity. If the expected entity does not appear in the view, it hasn't been discovered. You then would troubleshoot this as a discovery problem instead of as a reporting problem.

If the expected entity is missing from the performance view legend, this could also mean that the performance collection rule for that counter isn't enabled for that target. This can happen if the rule is disabled. Some management packs contain performance collection rules that are disabled by default and require overrides to enable them. This is documented in the management pack guide. For example, when using the Exchange 2003 management pack, you must create overrides to enable the performance collection rules for message tracking. If you don't do this, no data is collected for the **SMTP Out** and **SMTP In** reports. Refer to the management pack guide for information about which performance collection rules are enabled and for any manual configuration steps, if applicable.

If you don't find the answer in the management pack guide, find the performance collection rule in **Authoring** and verify that it's enabled for the targeted entity. The easiest way to find the rule is to identify the rule name in the performance view legend and then use the Search tool in **Authoring** to find the rule. For example, you discover that you can't get data consistently for the **Exchange Disk Usage** report in the Exchange 2003 management pack. You go to **Monitoring** and open the PhysicalDisk performance view under Microsoft Exchange Server/Exchange 2003/Server Performance. You notice that some of the Exchange servers are not listed in the legend, but others are there. The following rule names are listed in the legend:

- Average Disk Queue Length (All Disks)
- Current Disk Queue Length (All Disks)
- Disk Reads /second (All disks)
- Disk Writes / second (All disks)

You open **Authoring** and use the **Search** command to find the rule named **Average Disk Queue Length (All Disks)**. You open the rule properties and discover that this rule is disabled, and there is an override to enable the rule only for a select group of Exchange servers. This explains why some Exchange servers aren't generating data for this report. You have to adjust the rule configuration to target all Exchange servers instead of the custom group.

## There is a functional problem with the Health Service on the agent

In some cases, the expected entity may be listed in the performance view legend, but no data is displayed when you check its box. This could indicate performance or functional problems on the agent. For example, the Health Service on the agent may not be running or the agent may not be able to connect to its management server. Try increasing the time range for the performance view to go back a few days. This may help you pinpoint when the performance data stopped being collected. Also, check the Operations Manager event log on the corresponding agent and look for Health Service and Health Service Module errors. In particular, look for events that indicate missing performance counters. Also, check for Health Service script 6026 or 6024 events. These events are logged when the Health Service exceeds thresholds for private bytes or handle count and is restarted. When this issue happens, there may be gaps in performance data collection.

## Management servers are unable to insert data into the OperationsManagerDW database

If one or more management servers are unable to write to the `OperationsManagerDW` database, symptoms are varied and unpredictable. You may have reporting data for agents that use one management server, but not for agents using another. Reporting may be spotty in all cases.

The first step in identifying these problems is checking the Operations Manager event log on all management servers. HealthService 2115 events are a common symptom of database access problems. These events are logged by the Health Service on a management server when the server collects data that it can't insert in the database. This can occur with operations data and with reporting data. Generally, the workflow ID that is listed in the event description will indicate what type of data was collected. A workflow with **DataWarehouse** in the ID is related to reporting data. Troubleshoot this type of problem as a database connectivity or database performance issue. One known cause of this error is documented in [Event ID 2115 is logged, and a management server generates an "unable to write data to the Data Warehouse" alert in System Center Operations Manager 2007](https://support.microsoft.com/help/945946).

If you don't see 2115 events, configure a filter on the event log to show warning and error events from source **Health Service Modules** and category **Data Warehouse**. These are logged when any data warehouse workflow fails on a management server. The description for these events will often include the SQL Server error that was returned and the workflow name. The workflow name may provide some context on what task was affected. The workflow named `Microsoft.SystemCenter.DataWarehouse.CollectPerformanceData` collects performance data for reporting and inserts the data into the database.

## Data is stuck in the staging tables in the OperationsManagerDW database

First check the Operations Manager event log on the management server for event ID 31552 with the following workflow name listed in the event description:

`Microsoft.SystemCenter.DataWarehouse.StandardDataSetMaintenance`

`StandardDataSetMaintenance` is the workflow (also known as rule) that grooms, optimizes, and aggregates data in the data warehouse. If this workflow fails, data may become stuck in the staging tables. This rule runs a stored procedure in the `OperationsManagerDW` database named `StandardDatasetMaintenance`, which calls other stored procedures to process staging, aggregate, optimize, and groom the standard data sets. All of the stored procedure names begin with StandardDataset. By default, the rule runs every 60 seconds. If you see 31553 or other error events, this could indicate an issue with the data set listed in the event. Continue reading for more information on this and steps to troubleshoot.

Management servers insert raw reporting data into the staging tables in the `OperationsManagerDW` database. Another set of workflows then is run to move the data from the staging tables to the hourly and daily tables. These are the tables used for the reports. Therefore, if performance data is stuck in the staging tables, reports will fail to return data. To check for performance data that is stuck in the staging table, run the following query against the `OperationsManagerDW` database:

```sql
Use OperationsManagerDW
Select
   DateTime
From
   Perf.PerformanceStage
Order By
   DateTime
```

Records in this table that date back more than a day or two may indicate that the data is not being moved to the daily and hourly tables as expected. Now, before we move forward, let's talk a little bit about maintenance in the database. Maintenance is separated into what is called **Data Sets**. When we run maintenance, we run it for each data set in the database. To see this better, run the following query:

```sql
Use OperationsManagerDW;
With AggregationInfo As
(
   Select
      AggregationType =
      Case
         When
            AggregationTypeId = 0
         Then
            'Raw'
         When
            AggregationTypeId = 20
         Then
            'Hourly'
         When
            AggregationTypeId = 30
         Then
            'Daily'
         Else
            NULL
      End
   ,AggregationTypeId, MIN(AggregationDateTime) As 'TimeUTC_NextToAggregate'
   ,SUM(Cast (DirtyInd As Int)) As 'Count_OutstandingAggregations', DatasetId
   From
      StandardDatasetAggregationHistory
   Where
      LastAggregationDurationSeconds Is Not NULL
   Group By
      DatasetId, AggregationTypeId
)
   Select
      SDS.SchemaName,
      AI.AggregationType,
      AI.TimeUTC_NextToAggregate,
      Count_OutstandingAggregations,
      SDA.MaxDataAgeDays,
      SDA.LastGroomingDateTime,
      SDS.DebugLevel,
      AI.DataSetId
   From
      StandardDataSet As SDS WITH(NOLOCK)
      Join
         AggregationInfo As AI WITH(NOLOCK)
         On SDS.DatasetId = AI.DatasetId
      Join
         dbo.StandardDatasetAggregation As SDA WITH(NOLOCK)
         On SDA.DatasetId = SDS.DatasetId
         And SDA.AggregationTypeID = AI.AggregationTypeID
   Order By
      SchemaName Desc
```

This will show you all **Data Set** types and information about them. Here is a little information about the columns you see:

- `SchemaName`: This is the name of the data set (for example, perf, state, some other custom data set, and so on.) You'll note that alerts and events don't show up here and that's because those data sets don't have aggregated tables.
- `AggregationType`: Data sets can be aggregated into different levels of granularity and this query shows the results for each type of aggregation (for example, hourly, daily).
- `TimeUTC_NextToAggregate`: This is the timestamp in UTC format, of the next time interval to be aggregated. For the daily aggregation type, you can just look at the YYYY-MM-DD value and disregard the rest.
- `Count_OutstandingAggregations`: This is how many aggregations the data set is behind. If you see values between **1** and **3**, you're effectively caught up. If (as is the case with state above) you see bigger numbers, you've fallen behind.
- `MaxDataAgeDays`: This is the retention policy that is set for the given data set's aggregation.
- `LastGroomingDateTime`: Pretty straight forward.
- `DebugLevel`: You can turn up the debug levels on data sets and get something like tracing going to diagnose problems. The key takeaway here is, you only want this turned on for short periods of time and if you see a value higher than **0** on a data set, you are not investigating then set it back to **0**.
- `DataSetId`: This is the GUID of the data set, which will come in handy later.

With the above information, we can now see if any of our data sets are lagging behind. Once again we are going to use the performance data set for our example here. Let's run this query:

```sql
Use OperationsManagerDW
Select
   AggregationDateTime,
   LastAggregationDurationSeconds
From
   StandardDatasetAggregationHistory AS AH
   Inner Join
      StandardDataSet As DS
      On AH.DatasetId = DS.DatasetId
Where
   DS.SchemaName = 'Perf'
Order By
   AggregationDateTime Desc
```

If you don't see records with the current date, it indicates that aggregation is not occurring. High values for `LastAggregationDurationSeconds` indicate that aggregation is slow. These types of problems usually indicate SQL Server configuration or performance issues. A check of the SQL Server error logs and a SQL Server performance analysis is a good place to start.

Alternatively, you can check for what is called `DirtyInd` entries. `DirtyInd` entries indicate a slightly different issue where data is getting aggregated but there is more data than the procedure can keep up with. By default the performance aggregation only moves 100,000 rows at a time, so if there was a flood of performance data this could get behind, resulting in blank or incomplete reports. To check for `Dirtyind` entries, run this query:

```sql
Declare @DataSet as uniqueidentifier
Set
   @DataSet =
   (
      Select
         DataSetId
      From
         StandardDataSet
      Where
         SchemaName = 'Perf'
   )
   Select
      *
   From
      StandardDataSetAggregationHistory
   Where
      DataSetId = @DataSet
      And DirtyInd = 1
```

If you see more than 4-5 entries from the above query, you may want to run maintenance manually. Before you run it manually, or do the next steps, you need to turn off our default maintenance rule. To turn off the rule, go to the console, open **Authoring**, select **Rules**. Change the scope to **Standard Data Set**. Override the rule for the **Perf Data Set** (Or the data set you are troubleshooting). Now wait on the management server to get a 1210 event confirming the new configuration was applied, and continue to the next steps.

To run maintenance manually, run this query:

```sql
Declare @DataSet uniqueidentifier
Set
   @DataSet =
   (
      Select
         DataSetId
      From
         StandardDataset
      Where
         SchemaName = 'Perf'
   )
   Exec StandardDataSetMaintenance @DataSet
```

Continue running the above until you only have 1-3 entries (this is normal, one entry for each aggregation type). If you see many entries (more than 100), you may want to run the below:

```sql
Declare @i int
Set
   @i = 0
   Declare @DataSet uniqueidentifier
   Set
      @DataSet =
      (
         Select
            DataSetId
         From
            StandardDataset
         Where
            SchemaName = 'Perf'
      )
      While(@i <= 500)
      Begin
         Exec StandardDataSetMaintenance @DataSet
         Set
            @i = @i + 1 Waitfor Delay '00:00:05'
      End
```

This will run maintenance in a loop based on the value you set for `While(@i<=500)`. You can set this value to any value you want, but it is not recommended to go higher than 500. You can check the progress of the loop by running the `Dirtyind` query again, which should return fewer rows as the loop progresses. Once the script completes check the `Dirtyind` entries again, and if it's now current, test your reports. If there are still too many entries, continue running the script until aggregation is up to date.
