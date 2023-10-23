---
title: Troubleshoot UnsatisfiablePDB error code
description: Learn how to troubleshoot the "UnsatisfiablePDB" error that may occur when trying to upgrade an Azure Kubernetes Service (AKS) cluster.
ms.date: 10/23/2023
ms.reviewer: chiragpa
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-upgrade-operations
#Customer intent: As an Azure Kubernetes Services (AKS) user, I want to troubleshoot an Azure Kubernetes Service cluster upgrade that failed because of a UnsatisfiablePDB error so that I can upgrade the cluster successfully.
---

# Troubleshoot the "UnsatisfiablePDB" error code

This article discusses how to identify and resolve the "UnsatisfiablePDB" error that may occur when trying to upgrade an Azure Kubernetes Service (AKS) cluster.

## Prerequisites

This article requires Azure CLI version 2.53.0 or a later version. To find the version number, run `az --version`. If you have to install or upgrade Azure CLI, see [How to install the Azure CLI](/cli/azure/install-azure-cli).

For more detailed information about the upgrade process, see the "Upgrade an AKS cluster" section in [Upgrade an Azure Kubernetes Service (AKS) cluster](/azure/aks/upgrade-cluster#upgrade-an-aks-cluster).

## Symptoms

An AKS cluster upgrade fails with the following error message:

`Code: UnsatisfiablePDB
Message: 1 error occurred:
        * PDB <pdb-namespace>/<pdb-name> has maxunavailble == 0 can't proceed with put operation`

## Cause

Before allowing an upgrade operation to proceed, AKS will check the cluster for any existing [Pod Disruption Budgets (PDBs)](https://kubernetes.io/docs/concepts/workloads/pods/disruptions/#pod-disruption-budgets) which have maxUnavailable=0, as such PDBs will likely block node drain operations and therefore prevent the cluster upgrade operation from completing successfully, potentially leaving the cluster in a failed state.

Upon receiving the **UnsatisfiablePDB** error message you may confirm the PDB's status by running the following command:

> ```console
> $ kubectl get pdb <pdb-name> -n <pdb-namespace>
> ```

If the **Allowed Disruption** value is **0**, the node drain will fail during the upgrade process.

To resolve this issue, use one of the following solutions.

## Solution 1: Adjust the PDB's maxUnavailable parameter

1. Adjust the PDB's maxUnavailable parameter so that the value is **1** or greater. For more information, see [Specifying a PodDisruptionBudget](https://kubernetes.io/docs/tasks/run-application/configure-pdb/#specifying-a-poddisruptionbudget).
2. Retry the AKS cluster upgrade operation.

## Solution 2: Back up, delete, and redeploy the PDB

1. Take a backup of the PDB using the following command:

> ```console
> $ kubectl get pdb <pdb-name> -n <pdb-namespace> -o yaml > pdb_backup.yaml
> ```

2. Delete the PDB using the following command:

> ```console
> $ kubectl delete pdb <pdb-name> -n <pdb-namespace>
> ```

3. Retry the AKS cluster upgrade operation.

4. If the AKS cluster upgrade operation succeeds, re-deploy the PDB using the following command:

> ```console
> $ kubectl apply -f pdb_backup.yaml
> ```

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
