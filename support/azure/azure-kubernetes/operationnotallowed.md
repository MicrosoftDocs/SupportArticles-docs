---
title: Cluster pending operation (OperationNotAllowed) errors
description: Learn to resolve OperationNotAllowed errors that occur when you try to start, upgrade, or scale an Azure Kubernetes Service (AKS) cluster.
ms.date: 02/21/2023
author: axelgMS
ms.author: axelg
editor: v-jsitser
ms.reviewer: chiragpa, jpalma, v-leedennis, v-weizhu
ms.service: azure-kubernetes-service
ms.subservice: common-issues
---
# Cluster pending operation (OperationNotAllowed) errors

This article discusses how to troubleshoot OperationNotAllowed errors that occur when you try to start, upgrade, or scale a Microsoft Azure Kubernetes Service (AKS) cluster.

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

In the example below, the error happens because the cluster is being updated from one client, and it is also being started by another client while the update is still operating:

```
az aks start  -n <myAKSCluster> -g <myResourceGroup>

(OperationNotAllowed) managed cluster is in Provisioning State(Updating) and Power State(Running), starting cannot be performed The previous operation started at '2024-02-21T13:33:55Z' and elapsed time is: '00:00:00' (RFC3339 format)
Code: OperationNotAllowed
Message: managed cluster is in Provisioning State(Starting) and Power State(Running), starting cannot be performed The previous operation started at '2024-02-21T13:33:55Z' and elapsed time is: '00:00:00' (RFC3339 format)
```

You can also try aborting the long running operation by using the [az aks operation-abort](/azure/aks/manage-abort-operations) command.


## Solution 2: Ensure you aren't performing two similar operations in a row

If you're executing an operation on a cluster that's already in the desired state, the "OperationNotAllowed" error can occur. For example, if a cluster is already stopped, executing another stop operation would trigger this error:

```azurecli
az aks stop -n <myAKSCluster> -g <myResourceGroup>

(OperationNotAllowed) managed cluster is not currently running, stopping cannot be performed; The stop operation started at '2024-02-13T15:01:15Z' and elapsed time is: '7 days and 01:16:37' (RFC3339 format)
Code: OperationNotAllowed
Message: managed cluster is not currently running, stopping cannot be performed; The stop operation started at '2024-02-13T15:01:15Z' and elapsed time is: '7 days and 01:16:37' (RFC3339 format)
```

You would need to start the cluster before attempting to stop it again.

## Solution 3: Get the current cluster status before you try an operation

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
