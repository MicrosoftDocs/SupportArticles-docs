---
title: Troubleshoot data replication issues in cloud migration
description: Troubleshooting article for data replication process in Business Central cloud migration
ms.author: jswymer 
ms.reviewer: jswymer 
ms.topic: troubleshooting 
ms.date: 01/02/2024
ms.custom: bap-template
---

# Troubleshoot data replication issues in cloud migration

This article explains how to fix errors that you might encounter when you run data replication during cloud migration.

## Prerequisites

You need administrator permissions in Business Central.

## Symptoms

The symptom can be one of the following:

- The Self-hosted Integration Runtime is offline
- A database operation failed with the following error: 'Invalid object name … '
- A database operation failed with the following error: 'Couldn't find stored procedure ' … '

## Resolution

- Make sure that the machine hosting Integration Runtime stays online all the time.
- Shutting down the Integration Runtime host temporarily can be used to cancel an ongoing migration run, but if the host stays offline for too long, all cloud migration infrastructure might be automatically cleaned up, making resuming migrations impossible.
- Make sure to wait before replacing the source database, or restoring it from a backup, until the migration run has completed.


## Next steps

[Run data replication](migrate-data-replication-run.md)  