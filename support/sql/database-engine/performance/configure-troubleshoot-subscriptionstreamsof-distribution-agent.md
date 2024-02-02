---
title: Configure and troubleshoot the parameter SubscriptionStreams
description: This article describes how to configure and troubleshoot the parameter SubscriptionStreams of the Distribution Agent in SQL Server.
ms.date: 11/08/2022
ms.reviewer: ramakoni, v-sidong
---

# How to configure and troubleshoot the SubscriptionStreams parameter of the Distribution Agent in SQL Server

_Original product version:_ &nbsp; SQL Server (all supported versions)  
_Original KB number:_ &nbsp; 953199

This article provides more information about the parameter `SubscriptionStreams`, best practices when using this parameter, and associated troubleshooting.

## Introduction

The parameter `SubscriptionStreams` can be used to control the number of connections. In a transactional replication in Microsoft SQL Server, you can use the parameter to enable multiple connections that the Distribution Agent uses to apply batches of changes in parallel to a Subscriber. This operation greatly enhances replication throughput. At the same time, the Distribution Agent can still maintain many of the same transactional characteristics as when the Distribution Agent uses a single connection to apply the changes. If one of the connections fails to execute or commit, all connections will abort the current batch, and the agent will use a single stream to retry the failed batches. Before this retry phase completes, there can be temporary transactional inconsistencies at the Subscriber. After the failed batches are successfully committed, the Subscriber is brought back to a state of transactional consistency.

When you specify a value of 2 or greater for the parameter `SubscriptionStreams`, the order in which transactions are received at the Subscriber may differ from the order in which they were made at the publisher. If this behavior causes constraint violations during synchronization, you should use the `NOT FOR REPLICATION` option to disable the enforcement of constraints during synchronization. For more information, see [Control Behavior of Triggers and Constraints in Synchronization](/sql/relational-databases/replication/control-behavior-of-triggers-and-constraints-in-synchronization).

## Factors to consider before enabling SubscriptionStreams

`SubscriptionStreams` mainly takes care of latency from Distributor to Subscriber, so before you decide to go for `SubscriptionStreams`, make sure that you're indeed running into latency from Distributor to Subscriber. You can either use **Tracer Tokens** in [Replication Monitor](/sql/relational-databases/replication/monitor/overview-of-the-replication-monitor-interface) or Performance Monitor counters like **SQLServer:Replication Dist.** > **Dist:Delivery Latency** to have an idea of the level of latency.

Latency from Distributor to Subscriber can be caused by many reasons like, but not limited to, the following ones:

- Blocking either at Distributor or Subscriber
- Any bottleneck, either at Distributor or Subscriber, like slow disk drives, slow network bandwidth, and stale statistics  
- Bulk transactions coming from Publisher
- Rate of incoming transactions from Publisher is too high
- Triggers or unnecessary indexes in the subscribed database

The Database Administrator (DBA) needs to take a call and test whether `SubscriptionStreams` is going to help them or not. For example, in case of blocking at Subscriber, increasing the number of concurrent connections won't help but might make the situation worse. Whereas in situations like the incoming transaction rate from Publisher is too high and you feel that one single thread for the Distribution Agent is unable to cope with the incoming load, you can consider increasing the value of the parameter `SubscriptionStreams` to >=2. It might also help in slow network and slow disk situations. Ideally, the max value for this parameter is 64, but the recommended value (or a good value to start with) equals the number of physical processors at the Destination (Subscriber).

## How to configure the parameter SubscriptionStreams

`SubscriptionStreams` is one of those parameters that isn't visible in Distribution Agent Profile in Replication Monitor. You can specify a value for this agent parameter by using `@subscriptionstreams` of [sp_addsubscription (Transact-SQL)](/sql/relational-databases/system-stored-procedures/sp-addsubscription-transact-sql) or add this parameter to the distribution agent job command section by using the following procedure:

1. Open Replication Monitor, expand **My Publisher**, and select your publication in the left pane window. In the right pane window, under the **All Subscriptions** section, you'll see the list of all the subscribers to this publication.

1. Right-click on the Subscriber that you want to enable the parameter `SubscriptionStreams` and select **View Details**. A new window will pop up with the Distribution Agent session details.

1. On this new window, select **Action** in the menu bar at top and select **Distribution Agent Job Properties**. This will open the **Job Properties** window for the Distribution Agent.

1. Select **Steps** in the left pane window, and then select **Run Agent** in the right pane window, and then select **Edit**. A new window will pop up.

1. Scroll to the end of the command section (the far-right side) and append this parameter *-SubscriptionStreams 6*.

1. Save the settings and restart the Distribution Agent job. A restart of Distribution Agent is required to implement the changes.

> [!NOTE]
> In the above example, `SubscriptionStreams` is to set to *6*, which means that we are looking for six parallel connections for Distribution Agent at the Subscriber. You can set this number as per your environment and testing.

## Determining the number of streams

You may notice performance improvements by using the parameter `SubscriptionStreams`. If there's an improvement, the improvement may be nominal. It's difficult to determine what kind of performance improvement each disk subsystem on the market will provide by using `SubscriptionStreams`. Therefore, we recommend that you prepare a test environment that simulates the production environment. You can test scenarios that use `SubscriptionStreams` by using various configuration values and a scenario that doesn't use `SubscriptionStreams`.

We recommend that you perform load testing against the publication and subscription to determine the performance improvements that you can obtain by using `SubscriptionStreams`.
You should perform the performance baseline testing to understand the expected throughput of the disk subsystem. Before you perform each test, apply many changes to create a load at the Publisher. When creating the load, make sure that Distribution Agent doesn't run. When the replication has sufficient latency, run the Distribution Agent to test the performance for the following configurations:

- Don't use the parameter `SubscriptionStreams`.
- Set the value of `SubscriptionStreams` to be equal to the number of processors on the server. For example, if the server has eight processors, set the value of `SubscriptionStreams` to 8.
- Specify different values for `SubscriptionStreams` to obtain the optimal configuration.

When you perform the test, you can monitor the following performance counters of the Distribution Agent:

- **Dist: Delivered Cmds/sec**
- **Dist: Delivery Latency**

## Behavior of the Distribution Agent after you specify the parameter SubscriptionStreams

The Distribution Agent maintains the number of sessions/connections that you specify in `SubscriptionStreams`. The Distribution Agent uses these sessions to apply changes at the Subscriber.  

However, after you specify `SubscriptionStreams` and the Distribution Agent runs for some time, the Distribution Agent may switch to using only one session to apply changes to the Subscriber.

## Reasons for the Distribution Agent to switch to using only one session

The Distribution Agent may switch to using only one session for many reasons. The following are the most common reasons:

- When the Distribution Agent is applying changes, one of the sessions raises an error.

    For example, the Distribution Agent inserts a row into a child table by using one session. If this occurs before the Distribution Agent inserts the corresponding row into the parent table by using another session, a foreign key constraint violation raises an error message.

- The blocking monitor thread detects blocking. Blocking may occur for one of the following reasons:

  - The Distribution Agent performs an `INSERT` and an `UPDATE` operation on a table at the Subscriber by using different sessions. If the table contains a unique nonclustered index, blocking between the two sessions may occur when the Distribution Agent updates the index keys of the table.

  - At the Subscriber, the Distribution Agent runs Data Manipulation Language (DML) statements on multiple tables. If an indexed view is defined on these tables, blocking between the two sessions may occur when the indexed view updates the shared index keys.

  - The Distribution Agent runs a DML statement against a table at the Subscriber by using one session. DML triggers are defined on this table. The DML triggers run DML statements on another table that is being updated by using another session. In this situation, blocking between the two sessions may occur.

We highly recommend that you don't use the following database objects in the subscriber database:

- Foreign key constraints
- Unique nonclustered indexes
- Indexed views
- DML triggers that can cause blocking between sessions

## How to determine whether the Distribution Agent has switched to using only one session

To do this, use one of the following methods:

> [!NOTE]
> Although you can confirm that the Distribution Agent has not switched to using one session by using Method 1, you must use Method 2 or Method 3 to confirm that the Distribution Agent has switched to using one session.

- Method 1

    Query the Dynamic Management View (DMV) [sys.dm_exec_sessions](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-sessions-transact-sql) for the connection sessions to the subscription database. If you see only one connection session, the Distribution Agent may have switched to using one session. If you see more than one connection session, the Distribution Agent is still using the specified number of sessions.

    To confirm that the Distribution Agent has switched to using one session, use Method 2 or Method 3.

- Method 2

    Query the column `comments` of the table [msdistribution_history](/sql/relational-databases/system-tables/msdistribution-history-transact-sql) in the distribution database. If the result of the query contains the following entry, the Distribution Agent has switched to using one session:

    > The process failed to complete last batch in multi-streaming mode, it has been reset to single connection mode and is retrying the operation.

- Method 3

    Examine the output file of the Distribution Agent. The Distribution Agent has switched to using only one session if the output file contains the same error message as Method 2.

    The following output file is an example:

    ```Output
    Date/Time 100 transaction(s) with 1181 command(s) were delivered. 
    Date/Time 100 transaction(s) with 2672 command(s) were delivered. 
    Date/Time Bucket 6 aborted the wait for Ready To Commit event, deadlock found between spid 117 and 114 
    Date/Time Bucket 1 aborted the wait for Ready To Commit event, deadlock found between spid 117 and 114 
    Date/Time Bucket 3 aborted the wait for Ready To Commit event, deadlock found between spid 117 and 114 
    Date/Time Bucket 0 aborted the wait for Ready To Commit event, deadlock found between spid 117 and 114 
    Date/Time Bucket 5 aborted the wait for Ready To Commit event, deadlock found between spid 117 and 114 
    Date/Time Bucket 2 aborted the wait for Ready To Commit event, deadlock found between spid 117 and 114 
    Date/Time Bucket 7 aborted the wait for Ready To Commit event, deadlock found between spid 117 and 114 
    Date/Time Bucket 4 aborted the wait for Ready To Commit event, due to thread shutdown event 
    ... 
    Date/Time Number of subscription streams has been reset from 8 to 1, state 4. 
    Date/Time Disconnecting from Subscriber 
    SQLInstance 
    Date/Time Disconnecting from Subscriber 
    SQLInstance 
    
    Date/Time Disconnecting from Subscriber 
    SQLInstance 
    
    Date/Time Disconnecting from Subscriber 
    SQLInstance 
    
    Date/Time Disconnecting from Subscriber 
    SQLInstance 
    
    Date/Time Disconnecting from Subscriber 
    SQLInstance 
    
    Date/Time Disconnecting from Subscriber 
    SQLInstance 
    
    Date/Time Disconnecting from Subscriber 
    SQLInstance 
    
     
    Date/Time Connecting to Subscriber 
    SQLInstance 
    
    Date/Time The process failed to complete last batch in multi-streaming mode, it has been reset to single connection mode and is retrying the operation. 
    Date/Time 21 transaction(s) with 390 command(s) were delivered.
    ```

## How to troubleshoot a Distribution Agent that switches to using only one session

1. Run the SQL Server Profiler at the Subscriber to capture the Blocked process report event and the Exception event. These events record blocking and errors that occur when the Distribution Agent applies changes.

    > [!NOTE]
    > The Exception event can be caused by any kind of error that may be associated with the problem. For example, the error may be caused by a foreign key constraint violation.

1. Use one of the methods in the [How to determine whether the Distribution Agent has switched to using only one session](#how-to-determine-whether-the-distribution-agent-has-switched-to-using-only-one-session) section to monitor the Distribution Agent.

1. If the Distribution Agent has switched to using one session, stop the trace.

1. From the output file of the Distribution Agent or from the column `start_time` of the table [msdistribution_history](/sql/relational-databases/system-tables/msdistribution-history-transact-sql), obtain the time stamp of the following entry:

   > The process failed to complete last batch in multi-streaming mode, it has been reset to single connection mode and is retrying the operation.

1. Open the trace (.trc) file from the Subscriber. Locate a blocking script or an exception event whose time stamp is the same as or very close to the time stamp that you obtained in Step 4.

1. If you notice an exception, examine the details of the exception to determine the cause. For example, the exception may be caused by a foreign key constraint violation. If so, we recommend that you remove the foreign key constraint in the Subscriber database.

    If you notice a blocking script, the problem is caused by blocking. The following is a sample blocking script:

    ```XML
    <blocked-process-report monitorLoop="41589"> 
        <blocked-process> 
            <process id="process3a6d438" taskpriority="0" logused="24592" waitresource="KEY: 6:72057594375700480 (0100e420fa5a)" waittime="9937" ownerId="568644832" transactionname="user_transaction" lasttranstarted="2008-05-05T04:55:04.430" XDES="0xa5619e370" lockMode="X" schedulerid="11" kpid="6104" status="suspended" spid="58" sbid="0" ecid="0" priority="0" transcount="2" lastbatchstarted="2008-05-05T04:55:04.553" lastbatchcompleted="2008-05-05T04:55:04.430" clientapp=<DistributionAgentProgram> hostname=<servername> hostpid="3980" loginname=<SQLAgentAcct>  isolationlevel="read committed (2)" xactid="568644832" currentdb="6" lockTimeout="4294967295" clientoption1="671090784" clientoption2="128056"> 
                <executionStack> 
                <frame line="5" stmtstart="642" stmtend="1600" sqlhandle="0x0300060057a14477a8c6dd00609a00000100000000000000"/> 
                </executionStack> 
                <inputbuf> 
                Proc [Database Id = 6 Object Id = 2000986455]
                </inputbuf> 
            </process> 
        </blocked-process> 
        <blocking-process> 
            <process status="sleeping" spid="68" sbid="0" ecid="0" priority="0" transcount="1" lastbatchstarted="2008-05-05T04:55:04.570" lastbatchcompleted="2008-05-05T04:55:05.103" clientapp=<DistributionAgentProgram> hostname=<servername> hostpid="3980" loginname=<SQLAgentAcct> isolationlevel="read committed (2)" xactid="568644998" currentdb="6" lockTimeout="4294967295" clientoption1="671090784" clientoption2="128056"> 
            <executionStack/> 
            <inputbuf> 
            Proc [Database Id = 6 Object Id = 1172459501]
            </inputbuf> 
            </process> 
        </blocking-process> 
    </blocked-process-report> 
    ```

    The blocking script records a blocked session and a blocking session. The blocked session starts from the tag `<blocked-process>`. The blocking session starts from the tag `<blocking-process>`.

1. Locate the `Object Id` of the object `Proc` in the blocked session and in the blocking session.

    In the sample blocking script, the `Object Id` of `Proc` in the blocked session is `2000986455`. The `Object Id` of `Proc` in the blocking session is `1172459501`.

1. In the subscription database, query the view [sys.objects](/sql/relational-databases/system-catalog-views/sys-objects-transact-sql) by specifying the column `object_id` to be equal to the Object Ids that you obtained in Step 7. When you do this, you can determine the object names.

    For example, run the following query in the context of the subscription database:

    ```sql
    USE <SubDBName> 
    GO 
    SELECT name FROM sys.objects 
    WHERE object_id = 1172459501 OR object_id = 2000986455 
    ```

    > [!NOTE]
    >
    > - The  placeholder `<SubDBName>` represents the name of the subscription database.
    > - Usually, these objects are stored procedures that are used in the replication.

1. Determine the index or the indexed view that causes blocking. To do this, follow these steps:

   1. In the blocking script, locate the value of the property `waitresource`.

      In the sample blocking script, the value of `waitresource` is `72057594375700480`.

   1. Query the view [sys.partitions](/sql/relational-databases/system-catalog-views/sys-partitions-transact-sql) to obtain the object ID and the index ID by specifying the column `PARTITION_ID` to be equal to the value of the `waitresource` that you obtained in Step 9a.

      For example, run the following query:

      ```sql
      SELECT object_id, index_id FROM SYS.PARTITIONS WHERE PARTITION_ID=72057594375700480
      ```

   1. In the subscription database, query the view [sys.indexes](/sql/relational-databases/system-catalog-views/sys-indexes-transact-sql) to determine the index by using the object ID and the index ID that you obtained in Step 9b.

      For example, run the following query:

      ```sql
      USE <SubDBName> 
      GO 
      SELECT name, type_desc, is_unique FROM sys.indexes 
      WHERE object_id = <objID> and index_id = <idxID>
      ```

        > [!NOTE]
        >
        > - The placeholder `<objID>` represents the object ID that you obtained in Step 9b.
        > - The placeholder `<idxID>` represents the index ID that you obtained in Step 9b.

1. If blocking is caused by an indexed view, we recommend that you drop the indexed view. If blocking is caused by a unique nonclustered index, we recommend that you drop the index, and then re-create a non-unique index.

## Description of the blocking monitor thread

The Distribution Agent maintains a blocking monitor thread that detects blocking between the sessions. If the blocking monitor thread detects blocking between the sessions, the Distribution Agent switches to using one session to reapply the current batch of commands that the Distribution Agent couldn't apply previously.

For more information about the blocking monitor thread, review [Blocking Monitor Thread](/sql/relational-databases/replication/administration/enhance-transactional-replication-performance#blocking-monitor-thread).

## How the Distribution Agent resumes multiple sessions

Before the Distribution Agent can resume multiple sessions, the Distribution Agent must execute the stored procedure `sp_MSget_repl_commands` to requery the distribution database for the commands that haven't been applied at the Subscriber. Then, the Distribution Agent must apply all these commands at the Subscriber before the Distribution Agent can resume multiple sessions. In a latent replication environment, the Distribution Agent can't resume multiple sessions because the Distribution Agent must apply many commands at the Subscriber before the Distribution Agent can resume multiple sessions.

To track the entire process, examine the output file of the Distribution Agent.
