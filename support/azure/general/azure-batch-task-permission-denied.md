---
title: Azure Batch task fails giving access denied error
description: Provides the cause and some suggestions for issues where an Azure Batch task is failing with permission denied issue.
ms.date: 02/13/2024
ms.reviewer: biny, v-weizhu
ms.service: batch
---
# Azure Batch task fails giving access denied error

This article provides the cause and some suggestions for issues where an Azure Batch task is failing with **permission denied** issue.

## Scenario 1: Batch task fails with ‘permission denied.’

### Symptoms

Batch tasks fail with a non-zero exit code and standard error (stderr) as “Permission Denied.”
The following error message appears in stderr.txt:

:::image type="content" source="media/azure-batch-task-permission-denied/task-failure-permission-denied-error.png" alt-text="Screenshot that error in stderr file":::


### Cause

By default, tasks run in Batch under an auto-user account, as a standard user without elevated access, and with pool scope. Pool scope means that the task runs under an auto-user account that is available to any task in the pool.
Most likely the task runs the application with a non-privileged user, if not otherwise specified resulting in this error. Also, the /opt folder in Linux is one that requires admin privileges to be able to write to it. Hence, in most cases the issue is due to the user that is running the application does not have admin access to write to the destination.


### Solution: Add “Pool autouser, Admin” Elevation

To resolve this issue, provide your tasks with admin level elevation. Run the task again with a “pool auto-user, admin” elevation as shown below: 
 
:::image type="content" source="media/azure-batch-task-permission-denied/pool-autouser-admin-elevation.png" alt-text="Screenshot that shows elevation option":::


## Scenario 2: Batch start tasks fail with access denied while downloading the files.

### Symptoms

Batch start task fails with access denied error when downloading the files from storage account as part of start task command-line using Resource Files (Generated with SAS).
The following error message might appear.
>> **Error:** The specified signed resource is not allowed for this resource level.

### Cause
This usually happens when the right permission to perform an operation is not in place. 
SAS by default includes only ‘READ’ permission over the container which means the SAS token will have only "r" mentioned.

**Example:**

>> **sp=r&st=2024-02-12T09:55:58Z&se=2024-02-12T17:55:58Z&spr=https&sv=2022-11-02&sr=b&sig=<####>**

However, for any other operation, say for an entire download of file from storage account to the batch node, the operation that needs to be performed is ‘LIST’ at container level.

### Solution: Generate SAS token with the right permission

To resolve this issue, create a manual SAS with both Read and List permissions at the container level, and change it in the batch account start task “Resource File” option to successfully download the file.

:::image type="content" source="media/azure-batch-task-permission-denied/resource-file-option.png" alt-text="Screenshot that shows resource file option":::


:::image type="content" source="media/azure-batch-task-permission-denied/resource-file-sas-url.png" alt-text="Screenshot that shows option to manually enter sas value ":::


[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
