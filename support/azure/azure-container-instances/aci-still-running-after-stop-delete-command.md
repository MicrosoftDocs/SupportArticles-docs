---
title: Container instance continues to run after the stop or delete command
description: Provides a solution to an issue where an Azure container instance continues to run even after being stopped or deleted.
ms.date: 01/22/2024
ms.reviewer: tysonfreeman, v-weizhu
ms.service: container-instances
---
# Azure container instance continues to run after the stop or delete command

This article provides a solution to an issue where an Azure container instance continues to run even after the `stop` or `delete` command has been executed.

## Symptoms

Despite executing the `stop` or `delete` command, an Azure container instance continues to run and is still billed.

## Cause

This issue might occur due to potential bugs in the container stop or delete process.

## Solution

To resolve this issue, follow these steps:

1. Verify that the `stop` or `delete` command was executed.
2. Verify that the container instance is still billed.
3. Create a new container instance with the same resource ID in the same region. Upon successful creation, the old container instance will be deleted immediately.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
