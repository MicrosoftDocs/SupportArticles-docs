---
title: Troubleshoot upgrade failure caused by conflicting PodDisruptionBudgets in AKS
description: Learn how to troubleshoot an AKS cluster or node pool upgrade failure caused by conflicting PodDisruptionBudgets (PDBs) that block node drain.
ms.date: 03/11/2026
ms.reviewer: v-leedennis
editor: skuchipudi_microsoft
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot upgrade failures caused by conflicting PodDisruptionBudgets so that I can successfully upgrade my AKS cluster.
ms.custom: sap:Extensions, Policies and Add-Ons
---

# Troubleshoot upgrade failure caused by conflicting PodDisruptionBudgets in AKS

This article discusses how to troubleshoot an upgrade failure in Microsoft Azure Kubernetes Service (AKS) that occurs when a pod is covered by more than one PodDisruptionBudget (PDB), which blocks node drain during the upgrade.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli)

- The Kubernetes [kubectl](https://kubernetes.io/docs/reference/kubectl/overview/) tool. To install kubectl by using Azure CLI, run the [az aks install-cli](/cli/azure/aks#az-aks-install-cli) command.

## Symptoms

During a cluster or node pool upgrade, AKS drains each node by evicting pods. If a pod is covered by more than one `PodDisruptionBudget` (PDB), the Kubernetes eviction API doesn't support it and the eviction is blocked, causing the upgrade to fail with an error like:

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

Key indicators:
- Error code: `UpgradeFailed` with detail code `KubernetesAPICallFailed`
- Message contains: **"Evict blocked by conflicting disruption budgets"**
- Message contains: **"This pod has more than one PodDisruptionBudget"**

### Confirm the issue

1. Identify the affected pod and namespace from the error message (for example, `ea-upgrade/ea-demo-7d8898f6df-pc8vz`).
2. List all PDBs in the namespace and verify that the pod's labels match multiple PDBs:

```bash
kubectl get pdb -n <namespace>
kubectl describe pdb -n <namespace>
```

3. Check which PDBs select the affected pod:

```bash
kubectl get pod <pod-name> -n <namespace> --show-labels
```

Compare the pod labels against the `.spec.selector` of each PDB in the namespace. If the pod matches more than one PDB, the following cause applies.

## Cause: Pods covered by multiple PodDisruptionBudgets

The Kubernetes eviction subresource doesn't support pods covered by multiple PodDisruptionBudgets. When AKS attempts to evict such a pod during a node drain, the API server rejects the eviction request, and the upgrade can't proceed.

### Solution: Remove conflicting PDBs and retry the upgrade

#### Step 1: Identify the conflicting PDBs

```bash
kubectl get pdb -n <namespace> -o wide
```

#### Step 2: Delete a PDB and reconcile

When a pod is matched by multiple PDBs, delete one of the conflicting PDBs. The goal is to ensure each pod is covered by at most one PDB.

List the PDBs and pick one to delete:

```bash
kubectl get pdb -n <namespace> -o wide
kubectl delete pdb <pdb-name-to-remove> -n <namespace>
```

After deleting the PDB, reconcile the deployment to ensure pods are healthy and ready:

```bash
kubectl rollout status deployment/<deployment-name> -n <namespace>
kubectl get pods -n <namespace>
```

If pods are stuck in `Pending` state, check for resource constraints or scheduling issues:

```bash
kubectl describe pod <pending-pod-name> -n <namespace>
```

#### Step 3: Reconcile and retry the upgrade

Once all pods are healthy and only one PDB covers each pod, use one of the following options to reconcile and retry the upgrade.

##### Option 1: Retry via CLI

Re-issue the upgrade command:

```bash
az aks upgrade -g <resource-group> -n <cluster-name> --kubernetes-version <version>
```

Or for a node pool upgrade:

```bash
az aks nodepool upgrade -g <resource-group> --cluster-name <cluster-name> -n <nodepool-name> --kubernetes-version <version>
```

##### Option 2: Geneva Action – Reconcile Managed Cluster / Agent Pool (internal)

If the cluster is stuck in `Upgrading` provisioning state:

1. Use hcpdebug or Geneva Action to set the provisioning state to `Failed` for the managed cluster and/or agent pool.
2. Use Geneva Action **`Reconcile Managed Cluster`** or **`Reconcile Agent Pool`** to retrigger the upgrade.
3. Verify the reconciliation completed successfully using the **`Get Managed Cluster`** Geneva Action.

##### Option 3: Empty `az aks update` (no-op PutMC)

Trigger backend reconciliation without changing config:

```bash
az aks update -g <resource-group> -n <cluster-name>
```

This issues an empty `PutManagedCluster` request, which retriggers the backend reconciliation logic.

##### Option 4: `az resource update` (resource-level reconcile)

```bash
az resource update --ids /subscriptions/<subscription-id>/resourceGroups/<resource-group>/providers/Microsoft.ContainerService/managedClusters/<cluster-name>
```

##### Option 5: Scale operation (retriggers failed upgrade)

If the upgrade left nodes in a bad state, reimage the problematic nodes and run a scale operation to the desired count. This automatically retriggers the failed upgrade:

```bash
az aks nodepool scale -g <resource-group> --cluster-name <cluster-name> -n <nodepool-name> --node-count <desired-count>
```

## More information

To prevent this issue from recurring:

- Ensure each pod is matched by **at most one** PDB. Avoid overlapping label selectors across multiple PDBs in the same namespace.
- Avoid setting `minAvailable` equal to the total replica count, as this prevents any eviction.
- Use `maxUnavailable` instead of `minAvailable` when possible, as it's easier to reason about during upgrades.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
