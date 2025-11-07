---
title: Troubleshoot Issues Configuring Transactional Replication on Multiple SQL Server Linux Containers
description: Learn about a known issue when configuring transactional replication in SQL Server on Linux containers, including symptoms, cause, workaround, and resolution.
ms.reviewer: pijocoder, mlandzic, randolphwest, v-shaywood
ms.custom: sap:Replication, Change Tracking, Change Data Capture\Errors or unexpected results during operation
ms.date: 11/03/2025
---

# Configuring transactional replication on multiple SQL Server Linux containers fails

This article provides troubleshooting guidance for an issue that might occur when configuring two SQL Servers running in Linux containers on the same machine as replication subscribers.

## Symptoms

When configuring **Transactional Replication** on SQL Server 2022 running in Linux containers, you might encounter the following error message:

> The subscription already exists.

This issue usually occurs when:

- Two SQL Server instances are hosted in separate containers on the same Linux machine.
- Both instances are added as subscribers to the same publisher.
- The connection strings use the same hostname but different port numbers (for example, `LINUXHOST,5455` and `LINUXHOST,5465`).

## Cause

The issue occurs because subscriber metadata doesn't honor port numbers during persistence. Only the hostname is stored, causing the second subscriber to be seen as a duplicate of the first.
This behavior is specific to Linux container environments where named instances don't exist and connections rely on hostname and port mapping.

## Workaround

To successfully add multiple subscribers on the same machine but in different containers:

1. Install [Cumulative Update 20 (CU20) for SQL Server 2022](https://www.catalog.update.microsoft.com/Search.aspx?q=KB5059390).

1. Enable trace flag [15005](/sql/t-sql/database-console-commands/dbcc-traceon-trace-flags-transact-sql#tf15005). This trace flag enables using a Subscriber with a nondefault port for transactional replication.

1. Perform the following manual cleanup and configuration steps in Transact-SQL. Make sure to replace the `@hostname`, `@port_sub1`, `@port_sub2`, `@PublicationName`, `@SubscriberDb_Sub1`, and `@SubscriberDb_Sub2` variables with values specific to your environment:

   ```sql
   DECLARE @hostname AS SYSNAME = 'LinuxSubscriberHostName',
           @port_sub1 AS NVARCHAR (10) = '5455',
           @port_sub2 AS NVARCHAR (10) = '5465',
           @host_and_port_sub1 AS NVARCHAR (100),
           @host_and_port_sub2 AS NVARCHAR (100),
           @PublicationName AS SYSNAME = 'PublicationName',
           @SubscriberDb_Sub1 AS SYSNAME = 'SubscriberDB1',
           @SubscriberDb_Sub2 AS SYSNAME = 'SubscriberDB2';

   -- Concatenate the hostname and port for each subscriber (for example 'LinuxSubscriberHostName,5455')
   SET @host_and_port_sub1 = CONCAT(@hostname, ',', @port_sub1);
   SET @host_and_port_sub2 = CONCAT(@hostname, ',', @port_sub2);

   -- Step 1: Remove subscription metadata
   USE [PublicationDb];

   EXECUTE sp_dropsubscription
       @publication = @PublicationName,
       @article = 'all',
       @subscriber = @hostname,
       @destination_db = @SubscriberDb_Sub1;

   -- Step 2: Remove subscriber from publication
   EXECUTE sp_dropsubscriber @subscriber = @hostname;

   -- Step 3: Remove server entry for the first subscriber with no port information captured (on Publisher side)
   DELETE FROM distribution..MSreplservers
   WHERE UPPER(srvname COLLATE database_default) = UPPER(@hostname COLLATE database_default);

   IF EXISTS (SELECT 1 FROM sys.servers WHERE name = @hostname)
       EXECUTE sp_dropserver @hostname, 'droplogins';

   -- Step 4: Re-add linked server on Publisher side
   EXECUTE sp_addlinkedserver @server = @host_and_port_sub1;
   EXECUTE sp_serveroption @server = @host_and_port_sub1, @optname = 'sub', @optvalue = true;

   EXECUTE sp_addlinkedserver @server = @host_and_port_sub2;
   EXECUTE sp_serveroption @server = @host_and_port_sub2, @optname = 'sub', @optvalue = true;

   --Ensure entries are successful
   SELECT * FROM master..sysservers;

   --Step 5. Insert information about the subscribers to the Msreplservers table.
   INSERT INTO [distribution]..MSreplservers (srvid, srvname)
   SELECT srvid, srvname
   FROM master.dbo.sysservers
   WHERE UPPER(srvname COLLATE database_default) = UPPER(@host_and_port_sub1 COLLATE database_default);

   INSERT INTO [distribution]..MSreplservers (srvid, srvname)
   SELECT srvid, srvname
   FROM master.dbo.sysservers
   WHERE UPPER(srvname COLLATE database_default) = UPPER(@host_and_port_sub2 COLLATE database_default);

   --Verify entries
   SELECT * FROM [distribution]..MSreplservers;

   --Step 6. Create subscribers (push subscription)
   -----------------BEGIN: Script to be run at Publisher @hostname-----------------;;

   --Create subscriber to the first Linux container
   USE [PublicationDb];

   EXECUTE sp_addsubscription
       @publication = @PublicationName,
       @subscriber = @host_and_port_sub1,
       @destination_db = @SubscriberDb_Sub1,
       @subscription_type = N'Push',
       @sync_type = N'automatic',
       @article = N'all',
       @update_mode = N'read only',
       @subscriber_type = 0;

   EXECUTE sp_addpushsubscription_agent
       @publication = @PublicationName,
       @subscriber = @host_and_port_sub1,
       @subscriber_db = @SubscriberDb_Sub1,
       @job_login = NULL,
       @job_password = NULL,
       @subscriber_security_mode = 1,
       @frequency_type = 64,
       @frequency_interval = 0,
       @frequency_relative_interval = 0,
       @frequency_recurrence_factor = 0,
       @frequency_subday = 0,
       @frequency_subday_interval = 0,
       @active_start_time_of_day = 0,
       @active_end_time_of_day = 235959,
       @active_start_date = 20250711,
       @active_end_date = 99991231,
       @enabled_for_syncmgr = N'False',
       @dts_package_location = N'Distributor';

   --Create subscriber to the second Linux container
   USE [PublicationDb];

   EXECUTE sp_addsubscription
       @publication = @PublicationName,
       @subscriber = @host_and_port_sub2,
       @destination_db = @SubscriberDb_Sub2,
       @subscription_type = N'Push',
       @sync_type = N'automatic',
       @article = N'all',
       @update_mode = N'read only',
       @subscriber_type = 0;

   EXECUTE sp_addpushsubscription_agent
       @publication = @PublicationName,
       @subscriber = @host_and_port_sub2,
       @subscriber_db = @SubscriberDb_Sub2,
       @job_login = NULL,
       @job_password = NULL,
       @subscriber_security_mode = 1,
       @frequency_type = 64,
       @frequency_interval = 0,
       @frequency_relative_interval = 0,
       @frequency_recurrence_factor = 0,
       @frequency_subday = 0,
       @frequency_subday_interval = 0,
       @active_start_time_of_day = 0,
       @active_end_time_of_day = 235959,
       @active_start_date = 20250711,
       @active_end_date = 99991231,
       @enabled_for_syncmgr = N'False',
       @dts_package_location = N'Distributor';
   ```

## Resolution

Currently, no permanent fix is available. The previous [workaround](#workaround) is the recommended approach.

The product team is evaluating potential fixes for future releases. Once a permanent fix is available, this article will be updated.

## Related content

- [Transactional Replication](/sql/relational-databases/replication/transactional/transactional-replication)
- [Quickstart: Run SQL Server Linux container images with Docker](/sql/linux/quickstart-install-connect-docker)
