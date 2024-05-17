---
title: Activity times out in Business Central cloud migration
description: Provides troubleshooting steps for an issue where an activity times out in Business Central cloud migration.
ms.author: jswymer
ms.reviewer: jswymer 
ms.date: 05/17/2024
---
# An activity times out in Business Central cloud migration

This article provides troubleshooting steps for an issue where an activity times out during [Business Central cloud migration](/dynamics365/business-central/dev-itpro/administration/migration-manage).

## Symptoms

An activity times out during Business Central cloud migration.

## Cause

If an activity times out during the [cloud migration setup](/dynamics365/business-central/dev-itpro/administration/migration-setup-overview), it might happen either because Integration Runtime couldn't establish a connection to SQL Server or because of index defragmentation in large on-premises databases. If it times out during a migration run, the reason is most likely a weak or busy on-premises SQL Server.

## Resolution

- If the SQL connection is permanently broken, check if .NET 4.72, or higher is running on the host of the [integration runtime](/dynamics365/business-central/dev-itpro/administration/migrate-business-central-on-premises#components-involved).
- Check other Integration Runtime requirements on the **Azure Data Factory** page.
- For the database performance problems, we recommend updating statistics and reorganizing indexes in the on-premises database before setting up cloud migration.

  - To update statistics, run the following query (for example, in Microsoft SQL Management Studio connected to the on-premises database):

    ```sql
    EXEC sp_updatestats;
    ```

  - To reorganize indexes, execute the following query:

    ```sql
    EXEC sys.sp_MSforeachtable 'ALTER INDEX ALL ON ? REORGANIZE'
    ```

## More information

- [Managing cloud migration](/dynamics365/business-central/dev-itpro/administration/migration-manage)
- [Run cloud migration setup](/dynamics365/business-central/dev-itpro/administration/migration-setup)
