---
title: Troubleshoot the UnsatisfiablePDB error code
description: Describes how to troubleshoot the UnsatisfiablePDB error that might occur when you try to upgrade an Azure Kubernetes Service (AKS) cluster.
ms.date: 10/27/2023
ms.reviewer: chiragpa, v-weizhu
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-upgrade-operations
#Customer intent: As an Azure Kubernetes Services (AKS) user, I want to troubleshoot an Azure Kubernetes Service cluster upgrade that failed because of a UnsatisfiablePDB error so that I can upgrade the cluster successfully.
---

# Troubleshoot the "UnsatisfiablePDB" error during an AKS cluster upgrade

This article discusses how to identify and resolve the "UnsatisfiablePDB" error that might occur when you try to [upgrade an Azure Kubernetes Service (AKS) cluster](/azure/aks/upgrade-aks-cluster).

## Prerequisites

This article requires Azure CLI version 2.53.0 or a later version. Run `az --version` to find your installed version. If you need to install or upgrade the Azure CLI, see [How to install the Azure CLI](/cli/azure/install-azure-cli).

## Symptoms

An AKS cluster upgrade operation fails with the following error message:

> Code: UnsatisfiablePDB  
> Message: 1 error occurred:  
> \* PDB \<pdb-namespace>/\<pdb-name> has maxunavailble == 0 can't proceed with put operation

## Cause

Before starting an upgrade operation, AKS checks the cluster for any existing [Pod Disruption Budgets (PDBs)](https://kubernetes.io/docs/concepts/workloads/pods/disruptions/#pod-disruption-budgets) that have the `maxUnavailable` parameter set to 0. Such PDBs are likely to block node drain operations. If node drain operations are blocked, the cluster upgrade operation can't complete successfully. This might potentially cause the cluster to be in a failed state.

After receiving the "UnsatisfiablePDB" error, you can confirm the PDB's status by running the following command:

```console
$ kubectl get pdb <pdb-name> -n <pdb-namespace>
```

The output of this command should be similar to the following one:

```output
NAME         MIN AVAILABLE   MAX UNAVAILABLE   ALLOWED DISRUPTIONS   AGE
<pdb-name>   N/A             0                 0                     49s
```

If the value of `MAX UNAVAILABLE` is 0, the node drain fails during the upgrade process.

To resolve this issue, use one of the following solutions.

## Solution 1: Adjust the PDB's "maxUnavailable" parameter

> [!NOTE]
> Use this solution if you can edit the PDB resource directly.

1. Set the PDB's `maxUnavailable` parameter to `1` or a greater value. For more information, see [Specifying a PodDisruptionBudget](https://kubernetes.io/docs/tasks/run-application/configure-pdb/#specifying-a-poddisruptionbudget).
2. Retry the AKS cluster upgrade operation.

## Solution 2: Back up, delete, and redeploy the PDB

> [!NOTE]
> Use this solution if directly editing the PDB resource isn't viable.

1. Back up the PDB using the following command:

   ```console
   $ kubectl get pdb <pdb-name> -n <pdb-namespace> -o yaml > pdb_backup.yaml
   ```

2. Delete the PDB using the following command:

   ```console
   $ kubectl delete pdb <pdb-name> -n <pdb-namespace>
   ```

3. Retry the AKS cluster upgrade operation.

4. If the AKS cluster upgrade operation succeeds, redeploy the PDB using the following command:

   ```console
   $ kubectl apply -f pdb_backup.yaml
   ```

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
