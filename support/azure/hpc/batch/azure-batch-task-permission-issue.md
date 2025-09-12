---
title: Azure Batch task fails due to permission issues
description: Provides causes and solutions for issues where an Azure Batch task fails due to permission issues.
ms.date: 05/23/2025
ms.reviewer: biny, v-weizhu
ms.service: azure-batch
ms.custom: sap:HPC Pack
---
# Azure Batch tasks fail due to permission issues 

This article provides solutions to an issue where an Azure Batch task fails due to permission issues.

## Scenario 1: Batch tasks fail with the "Permission denied" error

### Symptoms

Batch tasks fail with a nonzero exit code, and a standard error (stderr) "Permission denied" appears in the *stderr.txt* file:

:::image type="content" source="media/azure-batch-task-permission-denied/permission-denied-error.png" alt-text="Screenshot that shows the 'Permission denied' error in the stderr.txt file.":::

### Cause

By default, tasks run in Batch under an auto-user account as a standard user, without elevated access, and with pool scope. Pool scope means that the task runs under an auto-user account that's available to any task in the pool.

Unless specified otherwise, the task likely runs the application as a non-privileged user, which can lead to this error. Writing to the */opt* folder in Linux requires admin privileges. Therefore, in most cases, the issue occurs because the user executing the application lacks admin access to write to the destination.

### Solution: Set the "Pool autouser, Admin" elevation level for the task

To resolve this issue, provide your task with the "Pool autouser, Admin" elevation level and then rerun the task.

:::image type="content" source="media/azure-batch-task-permission-denied/pool-autouser-admin-elevation.png" alt-text="Screenshot that shows the elevation level options." lightbox="media/azure-batch-task-permission-denied/pool-autouser-admin-elevation.png":::

## Scenario 2: Batch start task fails due to access being denied while downloading files

### Symptoms

When downloading files from a storage account using a start task's resource files (generated with a shared access signature (SAS)), the start task fails due to access being denied.

The following error message might appear:

> **Error:** The specified signed resource is not allowed for this resource level.

### Cause

This issue usually happens when you don't have the right permission to perform the operation. By default, SAS includes only the "Read" permission for the container, which means the SAS token only specifies "r."

Here's an example:

`sp=r&st=2024-02-12T09:55:58Z&se=2024-02-12T17:55:58Z&spr=https&sv=2022-11-02&sr=b&sig=<####>`

However, for other operations, such as downloading an entire file from a storage account to a Batch node, the "List" permission is required at the container level.

### Solution: Generate a SAS token with the right permissions

To resolve this issue, create a manual SAS with both "Read" and "List" permissions at the container level, and then use it in the **Resource files** option of the Batch account **Start task** to successfully download the file.

:::image type="content" source="media/azure-batch-task-permission-denied/resource-file-option.png" alt-text="Screenshot that shows the 'Resource files' option." lightbox="media/azure-batch-task-permission-denied/resource-file-option.png":::

:::image type="content" source="media/azure-batch-task-permission-denied/resource-file-sas-url.png" alt-text="Screenshot that shows options to manually enter the SAS value." lightbox="media/azure-batch-task-permission-denied/resource-file-sas-url.png":::

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
