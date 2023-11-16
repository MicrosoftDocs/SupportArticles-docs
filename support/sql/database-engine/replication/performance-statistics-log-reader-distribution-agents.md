---
title: Statistics for Log Reader and Distribution agents
description: This article introduces the performance statistics tools for Replication Log Reader and Distribution Agent in SQL Server.
ms.date: 12/01/2020
ms.custom: sap:Replication, change tracking, change data capture
ms.reviewer: ramakoni, syele
---
# Introduction to the performance statistics tools for Replication Log Reader and Replication Distribution agents

This article introduces the performance statistics tools for Replication Log Reader and Distribution Agent in SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2892631

## Introduction  

Performance statistics were added to the `mslogreader_history` table and the `msdistribution_history` table on the distribution database in Microsoft SQL Server. You can use these statistics to see the recent performance history of the Replication Log Reader and Replication Distribution agents.

> [!NOTE]
> These changes were first made in the following SQL Server builds:

- 9.00.4220
- 9.00.3315
- 10.00.1806
- 10.00.2714

Every five minutes, the performance statistics for the Log Reader and Distribution agents are recorded in the history tables. By default, only the data for the last 48 hours is retained. A cleanup process removes the data that is older than 48 hours. The default value can be changed by executing the `sp_changedistributiondb` stored procedure and specifying a new value for the `history_retention` parameter.

The following is a sample performance output from the history table for the Log Reader Agent:

```console
<stats state="1" work="9" idle="295"> <reader fetch="8" wait="0"/> <writer write="9" wait="0"/> <sincelaststats elapsedtime="304" work="9" cmds="52596" cmdspersec="5753.000000"> <reader fetch="8" wait="0"/> <writer write="9" wait="0"/> </sincelaststats> </stats>
```

There are three state events that can be recorded:

|State|Description|
|---|---|
|1|Normal events that describe both the reader and writer thread performance.|
|2|Raised events that occur when an agent's reader thread waits longer than the agent's `-messageinterval`  time. (By default, the time is 60 seconds.) If you notice State 2 events that are recorded for an agent, this indicates that the agent is taking a long time to write changes to the destination.|
|3|Raised events that are generated only by the Log Reader Agent when the writer thread waits longer than the `-messageinterval` time. If you notice State 3 events that are recorded for the Log Reader Agent, this indicates that the agent is taking a long time to scan the replicated changes from the transaction log.|
  
## Distribution Agent reader thread

The following performance statistics demonstrate a situation in which there is latency in the replication topology and in which the bottleneck is the Distribution Agent reader thread. This thread queries the distribution database (< **Distribution server** >..MSdistribution_history.Comments table) for commands to apply at the subscriber.

```xml
<stats state="1" work="14798" idle="2035">
    <reader fetch="14798" wait="193"/>
    <writer write="12373" wait="9888"/>
    <sincelaststats elapsedtime="424" work="415" cmds="296900" cmdspersec="713.000000">
        <reader fetch="415" wait="7"/>
        <writer write="377" wait="212"/>
    </sincelaststats>
</stats>
```

The `sincelaststats` writer wait time (212 seconds) appears high. This is the time that the writer thread waits for the reader thread to supply buffers that the writer thread can apply at the subscriber database. The Distribution Agent reader thread executes the `sp_MSget_repl_commands` stored procedure.

If you notice high writer wait times in the Distribution Agent performance statistics, you should investigate the performance of the Distribution Agent execution against the distribution server and database. In particular, you should investigate the execution time of the `sp_MSget_repl_commands` stored procedure.

## Distribution Agent writer thread

The following performance statistics demonstrate a situation in which there is latency in the replication topology and in which the bottleneck is the Distribution Agent reader thread. This thread queries the distribution database (< **Distribution server** >..MSdistribution_history.Comments table) for commands to apply at the subscriber.

> [!NOTE]
> The state is 2, and the output is somewhat different from State 1 statistics. State 2 state data indicates that the reader thread had to wait longer than the Distribution Agent's configured `-messageinterval` value. By default, the `-messageinterval` value is **60** seconds.

```xml
<stats state="2" fetch="48" wait="384" cmds="1028" callstogetreplcmds="321">
<sincelaststats elapsedtime="312" fetch="47" wait="284" cmds="1028" cmdspersec="3.000000"/>
</stats>
```

If the `-messageinterval` value is increased, you may again receive State 1 statistics that resemble the following:

```xml
<stats state="1" work="1941" idle="0">
    <reader fetch="717" wait="1225"/>
    <writer write="1941" wait="134"/>
    <sincelaststats elapsedtime="764" work="764" cmds="1170730" cmdspersec="1530.000000">
        <reader fetch="258" wait="505"/>
        <writer write="764" wait="50"/>
    </sincelaststats>
</stats>
```

> [!NOTE]
> The sincelaststats fetch wait time of 505 seconds is very high.

If you notice high reader wait times in the Distribution Agent performance statistics, you should investigate the performance of the Distribution Agent execution against the subscriber server and database. Use the profiler trace tool to investigate the performance of the execution of the replication stored procedures. Usually the stored procedures are named as follows:

- sp_MSupd_<**ownertablename**>
- sp_MSins_<**ownertablename**>
- sp_MSdel_<**ownertablename**>

Additionally, to determine whether the bottleneck is hardware-based or system-based, use the performance monitor to monitor system performance. For example, use the performance monitor to monitor the Physical Disk counters.

## Log Reader Agent reader thread

The following performance statistics demonstrate a situation in which there is latency in the replication topology and in which the bottleneck is the Log Reader Agent reader thread. The Log Reader Agent reader thread scans the published database transaction log for commands to deliver to the distribution database.

```xml
<Distribution server>..MSlogreader_history.Comments

<stats state="1" work="301" idle="0" >
    <reader fetch="278" wait="0"/>
    <writer write="12" wait="288"/>
    <sincelaststats elapsedtime="301" work="301" cmds="104500" cmdspersec="347.000000">
        <reader fetch="278" wait="0"/>
        <writer write="12" wait="288"/>
    </sincelaststats>
</stats>
```

The sincelaststats writer wait statistic of 288 seconds appears high. This is the time that the writer thread waits for the reader thread to supply buffers to apply. The Log Reader Agent reader thread executes the `sp_replcmds` stored procedure. If you notice high writer wait threads in the Log Reader Agent performance statistics, you should investigate the performance of the Log Reader Agent execution against the publication server and database and then investigate the execution time of the `sp_replcmds` stored procedure.

The following is the description of each performance statistic:

|Statistic|State|Description|
|---|---|---|
| State||State 1: This state indicates that the performance report is usual after a batch commit.<br/><br/>State 2: Reader thread indicates that a batch read waits longer time than the value for `messageinterval` property.<br/><br/>State 3: Writer thread indicates that a batch write waits longer time than the `-messageinterval` value.|
| cmds|2 only|This state indicates the number of commands that are read by the Distribution Agent.|
| callstogetreplcmds|2 only|This state indicates the number of calls to the `sp_MSget_repl_commands`  stored procedure by the Distribution Agent.<br/>|
| work||The value represents the cumulative time that the agent spent on work since the last agent start. The time excludes the idle time.|
| idle||The value represents the cumulative time that the agent waits to call the `sp_replcmds` stored procedure when the previous call returns no transactions or when the number of the transactions is smaller than the value for the `MaxTrans` property since the last agent start.|
| reader fetch||The value represents the cumulative time that the reader spent since the last agent start. The time excludes the idle time and the wait-for-writer time.|
| reader wait||The value represents the cumulative wait-for-writer time since the last agent start. The value shows the time that is spent waiting for the writer thread to finish using the data buffer before the reader can fill the data buffer again. |
| writer write||The value represents the cumulative time that the writer spent since the last agent start. The time excludes the idle time and the wait-for-reader time.<br/><br/>For writer wait, this value represents the wait-for-reader time since the last agent start. The value shows the time that is spent waiting for the reader thread to finish populating the data buffer before the writer can apply the data buffer. |
| sincelaststats_elapsed_time||The sincelaststats node shows similar statistics for the period beginning at the last recorded stats event. By default, the period is five minutes. The time excludes the idle time. The value represents the time that elapsed since last recorded stats event. |
| sincelaststats work||The value represents the time that the agent spent since the last stats event. |
| sincelaststats cmds||The value represents the number of commands since the last stats event.|
| sincelaststats cmdspersec||The value represents the number of commands that are performed per second since the last stats event.|
| sincelaststats\reader fetch||The value represents the cumulative time that the reader spent since the last stats event. The time excludes the idle time and the wait-for-writer time.|
| sincelaststats\reader wait||The value represents the cumulative wait-for-writer time since the last stats event. The value shows the time that is spent waiting for the writer thread to finish using the data buffer before reader can fill the data buffer again. |
| sincelaststats\writer||The value represents the cumulative time that writer spent since the last stats event. The time excludes the idle time and the wait-for-reader time.|
| sincelaststats\writer wait||The value represents the wait-for-reader time since the last stats event. The value shows the time that is spent waiting for the reader thread to finish populating the data buffer before writer can apply the data buffer. |
  
## Script to load MSlogreader_history and MSdistribution_history run statistics from XML data into a table that can be queried easily

There are four script samples help you extract the performance statistics into a permanent table that can be easily queried. There is also a stored procedure that approximately correlates the Log Reader Agent performance statistics to the Distribution Agent performance statistics (that is, to the `perf_stats_tab` table).

To obtain the script samples, visit [this sample](https://gallery.technet.microsoft.com/extract-the-performance-777f02b8) and click KB2892631.zip, and then uncompress file KB2892631.zip, you will see the following four script files:

- Original version of the _Perf_stats_script.sql_ file: _perf_stats_script.sql_
- Revised _Usp_move_stats_to_table.sql_ file: _usp_move_stats_to_table.sql_
- Revised _Sp_endtoend_stats.sql_ file: _sp_endtoend_stats.sql_
- Another script to read the data in real time or from a distribution database backup: _Additional_Script.sql_

> [!NOTE]
>
> - The `perf_stats_tab` table contains performance statistics for both the Log Reader Agent and the Distribution Agent. The statistics can be queried independently by using the `WHERE TYPE='Distrib'` clause or the `WHERE TYPE='LogRead'` clause.
> - The `move_stats_to_tab` stored procedure opens a cursor on the `mslogreader_history` table and the `msdistribution_history` table and then calls the `move_stats_to_tab` stored procedure for each row in order to extract the XML performance statistics data into the `perf_stats_tab` table.
