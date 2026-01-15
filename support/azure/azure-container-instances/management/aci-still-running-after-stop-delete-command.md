---
title: Container instance continues to run after the stop or delete command
description: Provides a solution to an issue where an Azure container instance continues to run even after being stopped or deleted.
ms.date: 01/25/2024
ms.reviewer: tysonfreeman, v-weizhu
ms.service: azure-container-instances
ms.custom: sap:Management
editor: kennethgp
---
# Azure container instance continues to run after the stop or delete command

This article provides a solution to an issue where an Azure container instance continues to run even after the `stop` or `delete` command are executed.

## Symptoms

Despite executing the `stop` or `delete` command, an Azure container instance continues to run and is still billed.

## Cause

This issue might occur due to stuck deactivations or errors in underlying platform during stop or delete operations.

## Solution

Possible mitigation:

1. Verify that the `stop` or `delete` command was executed.
2. Verify that the container instance is still billed.
3. Create a new container instance with the same resource ID in the same region. Upon successful creation, the old container instance should be removed immediately.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
