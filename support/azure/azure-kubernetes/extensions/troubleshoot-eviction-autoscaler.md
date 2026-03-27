---
title: Troubleshoot upgrade failure because of conflicting PodDisruptionBudgets
description: Learn how to troubleshoot AKS upgrade failures caused by conflicting PodDisruptionBudgets that block node drain. Use this guide to fix the issue fast.
ms.date: 03/11/2026
author: JarrettRenshaw
ms.author: jarrettr
editor: v-jsitser
ms.reviewer: v-leedennis
ms.service: azure-kubernetes-service
ms.topic: troubleshooting-problem-resolution
ms.custom: sap:Extensions, Policies and Add-Ons
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot upgrade failures that are caused by conflicting PodDisruptionBudgets so that I can successfully upgrade my AKS cluster.
---

# Troubleshoot failed upgrades from conflicting PodDisruptionBudgets in AKS

## Summary

This article explains how to troubleshoot AKS upgrade failures caused by conflicting `PodDisruptionBudgets` (PDBs). Use these steps to unblock node drain and complete your cluster or node pool upgrade.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli).

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool. To install kubectl by using Azure CLI, run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

## Symptoms

During a cluster or node pool upgrade, AKS drains each node by evicting pods. If a pod is covered by more than one `PodDisruptionBudget` (PDB), the Kubernetes eviction API doesn't support it, and the eviction is blocked. This behavior causes the upgrade to fail and return an error message that resembles the following example:

```text
{
  "code": "UpgradeFailed",
  "message": "Upgrade failed due to one or more node errors. See details for more information.",
  "details": [
    {
      "code": "KubernetesAPICallFailed",
      "message": "Drain node aks-agentpool0-26528033-vmss000001 failed when
        evicting pod ea-demo-7d8898f6df-pc8vz.
        Evict blocked by conflicting disruption budgets.
        See http://aka.ms/aks/debugdrainfailures.
        Original error: This pod has more than one PodDisruptionBudget,
        which the eviction subresource does not support.
        PDB debug info:
          ea-upgrade/ea-demo-7d8898f6df-pc8vz blocked by pdb ea-demo
          (MinAvailable: 1) (CurrentHealthy: 1) (DesiredHealthy: 1) (ExpectedPods: 2)
          with 1 unready pods:(log at most 5 pods)
          [ea-upgrade/ea-demo-7d8898f6df-fz89v:Pending_]."
    }
  ]
}
```

**Key indicators**

- Error code: `UpgradeFailed` plus detail code `KubernetesAPICallFailed`
- Message contains: **"Evict blocked by conflicting disruption budgets"**
- Message contains: **"This pod has more than one PodDisruptionBudget"**

### Verify the issue

1. Identify the affected pod and namespace from the error message (for example, `ea-upgrade/ea-demo-7d8898f6df-pc8vz`).
2. List all PDBs in the namespace.
3. Run the following command to verify that the pod's labels match multiple PDBs:

```bash
kubectl get pdb -n <namespace>
kubectl describe pdb -n <namespace>
```

4. Check which PDBs select the affected pod:

```bash
kubectl get pod <pod-name> -n <namespace> --show-labels
```

5. Compare the pod labels against the `.spec.selector` of each PDB in the namespace. If the pod matches more than one PDB, the following cause applies.

## Cause: Pods covered by multiple PDBs

The Kubernetes eviction subresource doesn't support pods that are covered by multiple PDBs. When AKS tries to evict such a pod during a node drain, the API server rejects the eviction request, and the upgrade can't proceed.

## Solution: Remove conflicting PDBs and retry the upgrade

### Step 1: Identify the conflicting PDBs

Run the following command:

```bash
kubectl get pdb -n <namespace> -o wide
```

### Step 2: Delete a PDB and reconcile

If a pod is matched by multiple PDBs, delete one of the conflicting PDBs. The goal is to make sure that each pod is covered by no more than one PDB.

1. List the PDBs, and pick one to delete:

```bash
kubectl get pdb -n <namespace> -o wide
kubectl delete pdb <pdb-name-to-remove> -n <namespace>
```

1. After you delete the PDB, reconcile the deployment to make sure that pods are healthy and ready:

```bash
kubectl rollout status deployment/<deployment-name> -n <namespace>
kubectl get pods -n <namespace>
```

1. If pods are stuck in the `Pending` state, check for resource constraints or scheduling issues:

```bash
kubectl describe pod <pending-pod-name> -n <namespace>
```

### Step 3: Reconcile and retry the upgrade

Verify that all pods are healthy and only one PDB covers each pod. Then, use one of the following options to reconcile and retry the upgrade.

#### Option 1: Retry using Azure CLI

Reissue the upgrade command:

```bash
az aks upgrade -g <resource-group> -n <cluster-name> --kubernetes-version <version>
```

For a node pool upgrade, run the following command:

```bash
az aks nodepool upgrade -g <resource-group> --cluster-name <cluster-name> -n <nodepool-name> --kubernetes-version <version>
```

#### Option 2: Use a Geneva action – `Reconcile Managed Cluster` or `Reconcile Agent Pool` 

If the cluster is stuck in an `Upgrading` provisioning state:

1. Use `hcpdebug` or a Geneva action to set the provisioning state to `Failed` for the managed cluster or agent pool.
2. Use either Geneva action, `Reconcile Managed Cluster` or `Reconcile Agent Pool`, to retrigger the upgrade.
3. Verify that the reconciliation finished successfully. To check the status, use the `Get Managed Cluster` Geneva action.

#### Option 3: Empty `az aks update` 

To trigger back-end reconciliation without changing the configuration:

```bash
az aks update -g <resource-group> -n <cluster-name>
```

This command issues an empty `PutManagedCluster` request that retriggers the back-end reconciliation logic.

#### Option 4: Use `az resource update` 

To trigger a resource-level reconciliation:

```bash
az resource update --ids /subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.ContainerService/managedClusters/<cluster-name>
```

#### Option 5: Perform a scale operation 

If the upgrade left nodes in a bad state, reimage the problematic nodes, and run a scale operation to the desired count. This action automatically retriggers the failed upgrade:

```bash
az aks nodepool scale -g <resource-group> --cluster-name <cluster-name> -n <nodepool-name> --node-count <desired-count>
```

## More information

To prevent this issue from reoccurring, make sure that each pod is matched by no more than one PDB. Avoid overlapping label selectors across multiple PDBs in the same namespace.

### Automatic PDB creation with the Eviction Autoscaler extension

The [Eviction Autoscaler](https://github.com/Azure/eviction-autoscaler) extension can automatically create and manage PDBs for your deployments. This setup helps you to avoid misconfigured or conflicting PDBs.

When installed together with `controllerConfig.pdb.create=true`, the extension automatically creates PDBs for deployments that don't already have one. You can control this behavior per deployment by using the `eviction-autoscaler.azure.com/pdb-create` annotation.

- To **prevent** automatic PDB creation for a specific deployment, set the annotation to `"false"`:

  ```yaml
  metadata:
    annotations:
      eviction-autoscaler.azure.com/pdb-create: "false"
  ```

- By default, deployments without this annotation (or that have it set to `"true"`) get an automatically created PDB if `pdb.create=true` is enabled.

You can also control which namespaces the extension operates in by using the `eviction-autoscaler.azure.com/enable` annotation on the namespace.

- In opt-in mode (`enabledByDefault=false`: the default setting), add the annotation to enable a namespace:

  ```yaml
  metadata:
    annotations:
      eviction-autoscaler.azure.com/enable: "true"
  ```

- In opt-out mode (`enabledByDefault=true`), add the annotation to disable a namespace:

  ```yaml
  metadata:
    annotations:
      eviction-autoscaler.azure.com/enable: "false"
  ```

For more information, see [Eviction Autoscaler README](https://github.com/Azure/eviction-autoscaler).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
