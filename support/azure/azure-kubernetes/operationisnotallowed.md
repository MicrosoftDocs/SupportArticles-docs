---
title: Cluster pending operation (OperationIsNotAllowed) errors
description: Learn to resolve OperationIsNotAllowed errors that occur when you try to start, upgrade, or scale an Azure Kubernetes Service (AKS) cluster.
ms.date: 08/17/2023
author: axelgMS
ms.author: axelg
editor: v-jsitser
ms.reviewer: chiragpa, jpalma, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: common-issues
---
# Cluster pending operation (OperationIsNotAllowed) errors

This article discusses how to troubleshoot OperationIsNotAllowed errors that occur when you try to start, upgrade, or scale a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli)

## Symptoms

You experience multiple symptoms that include one of the following error messages:

> Operation is not allowed: Another operation (\<operation-name>) is in progress, please wait for it to finish before starting a new operation. See <https://aka.ms/aks-pending-operation> for more details

Or, if it's an operation on an agent pool:

> Operation is not allowed: Another agentpool operation (\<operation-name>) is in progress, please wait for it to finish before starting a new operation. See <https://aka.ms/aks-pending-operation> for more details

Or:

> Managed Cluster operation is not allowed: Another operation (\<operation-name>) is in progress on agent pool (\<agent-pool-name>), please wait for it to finish before starting a new operation. See <https://aka.ms/aks-pending-operation> for more details

## Cause

Some operations take time to run. Those operations block other operations if they aren't finished.

## Solution 1: Wait until the operation finishes

To resolve these issues, you usually have to wait until the blocking operation finishes.

## Solution 2: Get the current cluster status before you try an operation

You can also determine the current status of the cluster before you try an operation. To help diagnose the issue, run the following [az aks show](/cli/azure/aks#az-aks-show) command to retrieve detailed status about the cluster.

```azurecli
az aks show --resource-group <myResourceGroup> --name <myAKSCluster> --output table
```

Then, use the following table to take the appropriate action based on the command results. (See the `ProvisioningState` column in the `az aks show` command output table.)

| Command result               | Action                                                        |
|------------------------------|---------------------------------------------------------------|
| Cluster is actively updating | Wait until the operation finishes.                            |
| Cluster update failed        | Locate the reason for the failure in the activity logs.       |
| Cluster update succeeded     | Retry the start, scale, or other previously failed operation. |

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
