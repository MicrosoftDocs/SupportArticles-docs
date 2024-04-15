---
title: Troubleshoot activity timed out
description: Troubleshooting article for the activity timed out error in Business Central cloud migration
ms.author: jswymer 
ms.reviewer: jswymer 
ms.topic: troubleshooting 
ms.date: 04/15/2024
ms.custom: bap-template
---

# Activity timed out

## Prerequisites

## Symptom

You get the **Activity timed out** error message.

## Cause

If an activity times out during Cloud Migration Setup, it might happen either because Integration Runtime couldn't establish a connection to SQL Server or because of index defragmentation in large on-premises databases. If it times out during a migration run, the reason is most likely a weak or busy on-premises SQL Server.

## Resolution

- If SQL connection is permanently broken, check that .NET 4.72 or higher is running on the host of the Integration Runtime.
- Check other Integration Runtime requirements on the Azure Data Factory page. 
- For the database performance problems, we recommend updating statistics and reorganize indexes in the on-premises database before setting up cloud migration.

  - To update statistics, run the following query (for example, in Microsoft SQL Management Studio connected to the on-premises database):

    ```sql
    EXEC sp_updatestats;
    ```

  - To reorganize indexes, execute the following query:

    ```sql
    EXEC sys.sp_MSforeachtable 'ALTER INDEX ALL ON ? REORGANIZE'
    ```
