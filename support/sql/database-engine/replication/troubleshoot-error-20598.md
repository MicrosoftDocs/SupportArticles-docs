---
title: Troubleshoot error 20598 
description: This article describes how to troubleshoot error 20598 in transactional replication and provides workarounds for the problem.
ms.date: 11/05/2020
ms.custom: sap:Replication, change tracking, change data capture
ms.reviewer: SYELE, TZAKIR
---

# Troubleshoot error 20598 in transactional replication

This article describes how to troubleshoot error 20598 in transactional replication and provides workarounds for the problem.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 3066750

## Troubleshoot

To troubleshoot this issue, follow these steps:

1. In the replication monitor on the Distribution Agent for the subscriber, extract the transaction sequence number and command ID that encountered the error:

   :::image type="content" source="media/troubleshoot-error-20598/error-message.png" alt-text="Screenshot of the error message in the replication monitor." border="false":::

   > [!NOTE]
   > You can obtain the same transaction sequence number from the distributor server by using the following query:

   :::image type="content" source="media/troubleshoot-error-20598/error-message-from-query.png" alt-text="Screenshot of the query entry and the result.":::

2. Extract the commands that map to the transaction sequence number on the distributor server. Use the transaction sequence number from step 1 as the parameter for this command:

   :::image type="content" source="media/troubleshoot-error-20598/get-command.png" alt-text="Screenshot of the commands that map to the transaction sequence number on the distributor server.":::

3. From the output of step 2, identify the command that is failing by using the command ID from step 1. Refer to the `command_id` column in the result set.

4. Validate the article information on the publisher. Use the article ID that you obtain from step 2, and check the details of the article that you are trying to update:

   :::image type="content" source="media/troubleshoot-error-20598/check-detail.png" alt-text="Screenshot of the article information detail on the publisher.":::

5. Validate the primary key on the publisher.

   You have two pieces of information: the table on which you are trying to perform the update, and the primary key value. You can query the table by using the primary key value, and locate the row on the publisher database. For example:

   ```sql
   SELECT * FROM tbl_sample WHERE column_name = <primary_key_value>
   ```

6. Check the problem at the subscriber.

   Execute the same query on the subscriber database, and compare it to the result that you receive from the publisher database.

## Workaround

To work around this issue, use the following two methods:

- Manually insert the missing row at the subscriber. This may enable the Distribution Agent to retry the failed command and move forward with the replication.

   > [!NOTE]
   > There may be other rows that are missing and that have to be manually inserted at the subscriber if there are more failures.

- Instruct the Distribution Agent to skip this error and continue to replicate the rest of the changes. The Distribution Agent accepts the `skiperrors` parameter. You can use this parameter to pass error code 20598. This may keep the replication setup intact while you wait for an opportunity to manually synchronize the missing rows.

  > [!NOTE]
  > You have to carefully evaluate the downstream effects of referential integrity and the triggers that are present on the affected table before you continue.

## Data collection to investigate the cause of this issue

If this problem occurs repeatedly, you should collect the following data for analysis by the Microsoft SQL Server support team so that they can try to identify the cause of the problem:

- The backup of the distribution database when this problem occurs. (This should be after the error is reported and before the subscription is reinitialized.)

- Transaction log backups of the publisher and the subscriber. (Collect the data for a minimum of 24 hours prior to the time when the problem occurred.)

- Profiler traces that show the activity of the replication agents on the publisher, the subscriber, and the distributor. (Make sure that the profiler is running even before the problem starts. Ideally, you need to start the profiler around the same time as the reindex job start time).

- Outputs from the previous five steps for identifying the affected table and the primary key value that is missing.

- Output of the catalog views from both the publisher and the subscriber databases:

  - sys.partitions
  - sys.allocation_units
  - sys.objects

- Verbose outputs of replication agent logs.

## Known issues that are addressed

The following problems occur in older versions of SQL Server:

- [KB 982857 Fix: Distribution Agent fails with error code 20598 when a publication database is configured with the Read Committed Snapshot option](https://support.microsoft.com/help/982857)

- [KB 2484392 FIX: "xact_seqno" column in the "MSrepl_errors" table does not record a skipped row in SQL Server 2008 or in SQL Server 2008 R2 if you use the "-SkipErrors" parameter in the Distribution Agent](https://support.microsoft.com/help/2484392)

- [Troubleshooter: Find errors with SQL Server transactional replication](/sql/relational-databases/replication/troubleshoot-tran-repl-errors)
