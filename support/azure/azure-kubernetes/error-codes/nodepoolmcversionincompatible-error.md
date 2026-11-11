---
title: NodePoolMcVersionIncompatible error - Node pool version 1.x and control plane version 1.y are incompatible
description: Discusses how to resolve the NodePoolMcVersionIncompatible error that occurs when the node pool and control plane versions of an Azure Kubernetes Service (AKS) cluster are outside the supported version skew.
ms.date: 11/11/2026
editor: v-jsitser
ms.reviewer: axelg, chiragpa, cssakscic, v-leedennis, jenimanda
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Can't upgrade AKS cluster because of the NodePoolMcVersionIncompatible error

## Summary

This article discusses how to resolve the "NodePoolMcVersionIncompatible - Node pool version 1.x.y and control plane version 1.a.b are incompatible" error. This error occurs when an operation on a Microsoft Azure Kubernetes Service (AKS) cluster would leave a node pool and the control plane outside the supported version skew. For example, the error can occur when you upgrade only the control plane, upgrade a node pool, or add a node pool.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli), version 2.34.1 or a later version.
- The Azure Kubernetes Service Contributor role, or equivalent permissions, to upgrade the cluster or its node pools.

## Symptoms

When you upgrade the control plane, upgrade a node pool, or add a node pool in an AKS cluster, you receive one of the following error messages:

- The node pool version is too far behind the control plane version:

    ```output
    BadRequest - NodePoolMcVersionIncompatible
    Error: Node pool version 1.x.y and control plane version 1.a.b are incompatible. Minor version of node pool cannot be more than <n> versions less than control plane's version. Minor version of node pool is x and control plane is a. For more information, please check https://aka.ms/version-skew-policy.
    Resource ID: /subscriptions/<subscription_id>/resourcegroups/<aks_cluster_resource_group>/providers/Microsoft.ContainerService/managedClusters/<aks_cluster_name>.
    ```

- The node pool version is newer than the control plane version:

    ```output
    BadRequest - NodePoolMcVersionIncompatible
    Error: Node pool version 1.x.y and control plane version 1.a.b are incompatible. Minor version of node pool version x is bigger than control plane version a. For more information, please check https://aka.ms/version-skew-policy.
    Resource ID: /subscriptions/<subscription_id>/resourcegroups/<aks_cluster_resource_group>/providers/Microsoft.ContainerService/managedClusters/<aks_cluster_name>.
    ```

## Cause

AKS validates the version skew between the control plane and every node pool. The operation is rejected if it doesn't meet both of the following conditions:

- The node pool version can't be greater than the control plane version. You must upgrade the control plane before you upgrade the node pools.
- The node pool minor version must be within the supported skew of the control plane minor version. Starting with Kubernetes 1.28, the control plane can be up to three minor versions ahead of node pools. For example, if the control plane is at 1.35.x, node pools can be at 1.32.x, 1.33.x, 1.34.x, or 1.35.x. On clusters that run Kubernetes versions earlier than 1.28, the limit is two minor versions.

The following scenarios commonly cause this error:

- You run a control-plane-only upgrade (`az aks upgrade --control-plane-only`) while one or more node pools are already at the oldest version that the skew allows. The new control plane version would leave those node pools too far behind.
- You upgrade a node pool, or add a new node pool, and specify a Kubernetes version that's either older than the skew allows or newer than the control plane version.

For more information, see [Kubernetes version upgrade rules](/azure/aks/upgrade-aks-control-plane#kubernetes-version-upgrade-rules) and [What is the allowed difference in versions between the control plane and node pools?](/azure/aks/supported-kubernetes-versions#what-is-the-allowed-difference-in-versions-between-the-control-plane-and-node-pools).

## Solution

To resolve this error, follow these steps.

### Step 1: Identify the error variant

Check the error message to determine which condition the operation doesn't meet:

- If the message contains "cannot be more than \<n> versions less than control plane's version," a node pool is too far behind the control plane version. Use [Solution 1](#solution-1-the-node-pool-version-is-too-far-behind-the-control-plane-version).
- If the message contains "Minor version of node pool version x is bigger than control plane version a," a node pool would run a newer version than the control plane. Use [Solution 2](#solution-2-the-node-pool-version-is-newer-than-the-control-plane-version).

### Step 2: Identify the operation that failed

The following operations can trigger this error:

- A control-plane-only upgrade (`az aks upgrade --control-plane-only`). This is the most common scenario.
- A node pool upgrade (`az aks nodepool upgrade --kubernetes-version <version>`).
- Adding a node pool (`az aks nodepool add --kubernetes-version <version>`).
- An Azure Resource Manager (ARM) template, Bicep, or Terraform deployment. In this case, compare the `kubernetesVersion` value of the cluster with the `orchestratorVersion` value of every agent pool in the template.

If you aren't sure which operation failed, check the [activity log](/azure/azure-monitor/essentials/activity-log) of the cluster for the failed write operation.

### Step 3: Check the control plane and node pool versions

Get the current control plane version by running the [az aks show](/cli/azure/aks#az-aks-show) command:

```azurecli
az aks show \
    --resource-group <resource-group> \
    --name <cluster-name> \
    --query "{ControlPlane:currentKubernetesVersion, State:provisioningState}" \
    --output table
```

Get the version of each node pool by running the [az aks nodepool list](/cli/azure/aks/nodepool#az-aks-nodepool-list) command:

```azurecli
az aks nodepool list \
    --resource-group <resource-group> \
    --cluster-name <cluster-name> \
    --query "[].{Name:name, Version:orchestratorVersion, State:provisioningState}" \
    --output table
```

To view the versions that are available for upgrade, run the [az aks get-upgrades](/cli/azure/aks#az-aks-get-upgrades) command:

```azurecli
az aks get-upgrades --resource-group <resource-group> --name <cluster-name> --output table
```

### Step 4: Check the version skew

Compare only the minor versions (the middle number of the version). For example, the minor version of 1.33.5 is 33. Use the control plane version that the cluster would have *after* the operation. The following table shows the rules for Kubernetes 1.28 and later versions, for a control plane that runs 1.33:

| Node pool minor version compared to control plane | Allowed? | Example (control plane 1.33) |
|---|---|---|
| Greater than the control plane | No ("bigger than" error) | Node pool 1.34 is rejected. |
| Equal to, or up to three minor versions less than, the control plane | Yes | Node pools 1.30, 1.31, 1.32, and 1.33 are allowed. |
| Four or more minor versions less than the control plane | No ("cannot be more than \<n> versions less" error) | Node pool 1.29 is rejected. |

For example, a cluster has a control plane at version 1.33 and a node pool at version 1.30. If you run `az aks upgrade --control-plane-only --kubernetes-version 1.34`, the node pool would be four minor versions behind the control plane after the upgrade. Therefore, AKS rejects the operation and returns the `NodePoolMcVersionIncompatible` error.

### Step 5: Apply the solution

#### Solution 1: The node pool version is too far behind the control plane version

Upgrade every node pool that's outside the supported skew to the current control plane version by running the [az aks nodepool upgrade](/cli/azure/aks/nodepool#az-aks-nodepool-upgrade) command. Then, retry the operation that failed.

```azurecli
az aks nodepool upgrade \
    --resource-group <resource-group> \
    --cluster-name <cluster-name> \
    --name <node-pool-name> \
    --kubernetes-version <current-control-plane-version>
```

If the error occurred during a control-plane-only upgrade, you can instead upgrade the control plane and all node pools together. To do this, run the [az aks upgrade](/cli/azure/aks#az-aks-upgrade) command without the `--control-plane-only` parameter:

```azurecli
az aks upgrade \
    --resource-group <resource-group> \
    --name <cluster-name> \
    --kubernetes-version <next-minor-version>
```

> [!NOTE]
> You can't skip Kubernetes minor versions when you upgrade the control plane of a non-LTS cluster. Upgrade one minor version at a time, and make sure that the node pools stay within the supported skew after each control plane upgrade.

#### Solution 2: The node pool version is newer than the control plane version

When you add or upgrade a node pool, specify a Kubernetes version that's less than or equal to the control plane version. We recommend that you use the same version as the control plane:

```azurecli
az aks nodepool add \
    --resource-group <resource-group> \
    --cluster-name <cluster-name> \
    --name <node-pool-name> \
    --kubernetes-version <current-control-plane-version>
```

If the node pool must run a newer version, upgrade the control plane first, and then upgrade the node pool:

```azurecli
az aks upgrade \
    --resource-group <resource-group> \
    --name <cluster-name> \
    --control-plane-only \
    --kubernetes-version <target-version>

az aks nodepool upgrade \
    --resource-group <resource-group> \
    --cluster-name <cluster-name> \
    --name <node-pool-name> \
    --kubernetes-version <target-version>
```

If you deploy the cluster by using an ARM template, Bicep, or Terraform, set the `orchestratorVersion` value of each agent pool to a version that's less than or equal to the `kubernetesVersion` value of the cluster and within the supported skew. Then, redeploy the template.

### Step 6: Verify the result

1. Run the `az aks nodepool list` command from [Step 3](#step-3-check-the-control-plane-and-node-pool-versions) again. Make sure that every node pool is within the supported skew and that its state is `Succeeded`.
1. Retry the operation that failed, and make sure that it completes successfully.

## More information

- [Upgrade the Azure Kubernetes Service (AKS) cluster control plane](/azure/aks/upgrade-aks-control-plane)
- [Supported Kubernetes versions in AKS](/azure/aks/supported-kubernetes-versions)
- [Kubernetes version skew policy](https://kubernetes.io/releases/version-skew-policy/)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
