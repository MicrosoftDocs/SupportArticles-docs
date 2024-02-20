---
title: Azure Batch task fails with access denied error
description: Provides the cause and some suggestions for issues where an Azure Batch task fails with permission denied issue.
ms.date: 02/19/2024
ms.reviewer: biny, v-weizhu
ms.service: batch
---
# Azure Batch task fails with access denied error

This article provides a solution to an issue where an Azure Batch task fails due to permission issues.

## Scenario 1: Batch tasks fail with "Permission denied" error

### Symptoms

Batch tasks fail with a non-zero exit code and a standard error (stderr) "Permission denied" appears in the *stderr.txt* file:

:::image type="content" source="media/azure-batch-task-permission-denied/permission-denied-error.png" alt-text="Screenshot that shows the 'Permission denied' error in the stderr.txt file":::

### Cause

By default, tasks run in Batch under an auto-user account, as a standard user without elevated access, and with pool scope. Pool scope means that the task runs under an auto-user account that is available to any task in the pool.
Most likely the task runs the application with a non-privileged user, if not otherwise specified resulting in this error. Also, to write to the */opt* folder in Linux, the user requires admin privileges. Therefore, in most cases the issue occurs due to the user that is running the application doesn't have admin access to write to the destination.

### Solution: Add "Pool autouser, Admin" elevation for the task

To resolve this issue, provide your tasks with a "Pool autouser, Admin" elevation level and then run the task again.

:::image type="content" source="media/azure-batch-task-permission-denied/pool-autouser-admin-elevation.png" alt-text="Screenshot that shows elevation level options":::


## Scenario 2: Batch start tasks fail with "access denied" error while downloading files

### Symptoms

When downloading files from a storage account (as part of the start task command line) using resource files that are generated with shared access signature (SAS), a Batch start task fails with "access denied" error.

The following error message might appear:

> **Error:** The specified signed resource is not allowed for this resource level.

### Cause

This issue usually happens when there isn't the right permission to perform an operation. SAS by default includes only "READ" permission over the container which means the SAS token will have only "r" mentioned.

Here's an example:

`sp=r&st=2024-02-12T09:55:58Z&se=2024-02-12T17:55:58Z&spr=https&sv=2022-11-02&sr=b&sig=<####>`

However, for any other operations, such as downloading an entire file from a storage account to the batch node, "LIST" permission is required at the container level.

### Solution: Generate SAS token with the right permission

To resolve this issue, create a manual SAS with both "Read" and "List" permissions at the container level, and change it in the **Resource files** option of the Batch account **Start task** to successfully download the file.

:::image type="content" source="media/azure-batch-task-permission-denied/resource-files-option.png" alt-text="Screenshot that shows the 'Resource files' option":::


:::image type="content" source="media/azure-batch-task-permission-denied/resource-file-sas-url.png" alt-text="Screenshot that shows option to manually enter sas value ":::


[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]