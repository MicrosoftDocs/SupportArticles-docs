---
title: Data replication issue or errors in Business Central cloud migration
description: Resolves an issue or errors that might occur during the data replication process in Business Central cloud migration.
ms.author: jswymer 
ms.reviewer: jswymer 
ms.date: 05/08/2024
---
# Self-hosted Integration Runtime is offline or a database operation fails in Business Central cloud migration

This article resolves an issue or errors that might occur when you run data replication during [Business Central cloud migration](/dynamics365/business-central/dev-itpro/administration/migration-manage).

## Symptoms

When you run data replication during Business Central cloud migration, the following issue or error might occur:

- The [self-hosted Integration Runtime](/azure/data-factory/create-self-hosted-integration-runtime?tabs=data-factory) is offline.
- A database operation fails with the "Invalid object name" error message.
- A database operation fails with the "Couldn't find stored procedure" error message.

## Resolution

> [!NOTE]
> You need administrator permissions in Business Central.

- Make sure that the machine hosting Integration Runtime stays online all the time.
- You can shut down the Integration Runtime host temporarily to cancel an ongoing migration run. But if the host stays offline for too long, all cloud migration infrastructure might be automatically cleaned up, making resuming migrations impossible.
- Make sure to wait before replacing the source database, or restoring it from a backup, until the migration run has completed.

## More information

[Run data replication](/dynamics365/business-central/dev-itpro/administration/migrate-data-replication-run)
