---
title: Troubleshoot UpgradeFailed errors due to eviction failures caused by PDBs
description: Learn how to troubleshoot UpgradeFailed errors due to eviction failures caused by Pod Disruption Budgets when you try to upgrade an Azure Kubernetes Service cluster.
ms.date: 03/06/2025
editor: v-jsitser
ms.reviewer: chiragpa, jotavar, v-leedennis, v-weizhu
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
#Customer intent: As an Azure Kubernetes Services (AKS) user, I want to troubleshoot an Azure Kubernetes Service cluster upgrade that failed because of eviction failures caused by Pod Disruption Budgets so that I can upgrade the cluster successfully.
---

# Troubleshoot UpgradeFailed errors due to eviction failures caused by PDBs

This article discusses how to identify and resolve UpgradeFailed errors due to eviction failures caused by Pod Disruption Budgets (PDBs) that occur when you try to upgrade an Azure Kubernetes Service (AKS) cluster.

## Prerequisites

This article requires Azure CLI version 2.67.0 or a later version. To find the version number, run `az --version`. If you have to install or upgrade Azure CLI, see [How to install the Azure CLI](/cli/azure/install-azure-cli).

For more detailed information about the upgrade process, see the "Upgrade an AKS cluster" section in [Upgrade an Azure Kubernetes Service (AKS) cluster](/azure/aks/upgrade-cluster#upgrade-an-aks-cluster).

## Symptoms

An AKS cluster upgrade operation fails with one of the following error messages:

- > (UpgradeFailed) Drain `node aks-<nodepool-name>-xxxxxxxx-vmssxxxxxx` failed when evicting pod `<pod-name>` failed with Too Many Requests error. This is often caused by a restrictive Pod Disruption Budget (PDB) policy. See https://aka.ms/aks/debugdrainfailures. Original error: Cannot evict pod as it would violate the pod's disruption budget.. PDB debug info: `<namespace>/<pod-name>` blocked by pdb `<pdb-name>` with 0 unready pods.

- > Code: UpgradeFailed  
  > Message: Drain node `aks-<nodepool-name>-xxxxxxxx-vmssxxxxxx` failed when evicting pod `<pod-name>` failed with Too Many Requests error. This is often caused by a restrictive Pod Disruption Budget (PDB) policy. See https://aka.ms/aks/debugdrainfailures. Original error: Cannot evict pod as it would violate the pod's disruption budget.. PDB debug info: `<namespace>/<pod-name>` blocked by pdb `<pdb-name>` with 0 unready pods.

## Cause

This error might occur if a pod is protected by the Pod Disruption Budget (PDB) policy. In this situation, the pod resists being drained, and after several attempts, the upgrade operation fails, and the cluster/node pool falls into a `Failed` state.

Check the PDB configuration: `ALLOWED DISRUPTIONS` value. The value should be `1` or greater. For more information, see [Plan for availability using pod disruption budgets](/azure/aks/operator-best-practices-scheduler#plan-for-availability-using-pod-disruption-budgets). For example, you can check the workload and its PDB as follows. You should observe the `ALLOWED DISRUPTIONS` column doesn't allow any disruption. If the `ALLOWED DISRUPTIONS` value is `0`, the pods aren't evicted and node drain fails during the upgrade process:

```console
$ kubectl get deployments.apps nginx
NAME    READY   UP-TO-DATE   AVAILABLE   AGE
nginx   2/2     2            2           62s

$ kubectl get pod
NAME                     READY   STATUS    RESTARTS   AGE
nginx-7854ff8877-gbr4m   1/1     Running   0          68s
nginx-7854ff8877-gnltd   1/1     Running   0          68s

$ kubectl get pdb
NAME        MIN AVAILABLE   MAX UNAVAILABLE   ALLOWED DISRUPTIONS   AGE
nginx-pdb   2               N/A               0                     24s

```

You can also check for any entries in Kubernetes events using the command `kubectl get events | grep -i drain`. A similar output shows the message "Eviction blocked by Too Many Requests (usually a pdb)":

```console
$ kubectl get events | grep -i drain
LAST SEEN   TYPE      REASON                    OBJECT                                   MESSAGE
(...)
32m         Normal    Drain                     node/aks-<nodepool-name>-xxxxxxxx-vmssxxxxxx   Draining node: aks-<nodepool-name>-xxxxxxxx-vmssxxxxxx
2m57s       Warning   Drain                     node/aks-<nodepool-name>-xxxxxxxx-vmssxxxxxx   Eviction blocked by Too Many Requests (usually a pdb): <pod-name>
12m         Warning   Drain                     node/aks-<nodepool-name>-xxxxxxxx-vmssxxxxxx   Eviction blocked by Too Many Requests (usually a pdb): <pod-name>
32m         Warning   Drain                     node/aks-<nodepool-name>-xxxxxxxx-vmssxxxxxx   Eviction blocked by Too Many Requests (usually a pdb): <pod-name>
32m         Warning   Drain                     node/aks-<nodepool-name>-xxxxxxxx-vmssxxxxxx   Eviction blocked by Too Many Requests (usually a pdb): <pod-name>
31m         Warning   Drain                     node/aks-<nodepool-name>-xxxxxxxx-vmssxxxxxx   Eviction blocked by Too Many Requests (usually a pdb): <pod-name>
```


To resolve this issue, use one of the following solutions.

## Solution 1: Enable pods to drain

1. Adjust the PDB to enable pod draining. Generally, The allowed disruption is controlled by the `Min Available / Max unavailable` or `Running pods / Replicas` parameter. You can modify the `Min Available / Max unavailable` parameter at the PDB level or increase the number of `Running pods / Replicas` to push the Allowed Disruption value to **1** or greater.
2. Try again to upgrade the AKS cluster to the same version that you tried to upgrade to previously. This process triggers a reconciliation.

   ```console
   $ az aks upgrade --name <aksName> --resource-group <resourceGroupName>
   Are you sure you want to perform this operation? (y/N): y
   Cluster currently in failed state. Proceeding with upgrade to existing version 1.28.3 to attempt resolution of failed cluster state.
   Since control-plane-only argument is not specified, this will upgrade the control plane AND all nodepools to version . Continue? (y/N): y
   ```

## Solution 2: Back up, delete, and redeploy the PDB

1. Take a backup of the PDB(s) using the command `kubectl get pdb <pdb-name> -n <pdb-namespace> -o yaml > pdb-name-backup.yaml`, and then delete the PDB using the command `kubectl delete pdb <pdb-name> -n <pdb-namespace>`. After the new upgrade attempt is finished, you can redeploy the PDB just applying the backup file using the command `kubectl apply -f pdb-name-backup.yaml`.
2. Try again to upgrade the AKS cluster to the same version that you tried to upgrade to previously. This process triggers a reconciliation.

   ```console
   $ az aks upgrade --name <aksName> --resource-group <resourceGroupName>
   Are you sure you want to perform this operation? (y/N): y
   Cluster currently in failed state. Proceeding with upgrade to existing version 1.28.3 to attempt resolution of failed cluster state.
   Since control-plane-only argument is not specified, this will upgrade the control plane AND all nodepools to version . Continue? (y/N): y
   ```

## Solution 3: Delete the pods that can't be drained or scale the workload down to zero (0)

1. Delete the pods that can't be drained.
   
   > [!NOTE]
   > If the pods are created by a Deployment or StatefulSet, they'll be controlled by a ReplicaSet. If that's the case, you might have to delete or scale the workload replicas to zero (0) of the Deployment or StatefulSet. Before you do that, we recommend that you make a backup: `kubectl get <deployment.apps -or- statefulset.apps> <name> -n <namespace> -o yaml > backup.yaml`.

2. To scale down, you can use `kubectl scale --replicas=0 <deployment.apps -or- statefulset.apps> <name> -n <namespace>` before the reconciliation

3. Try again to upgrade the AKS cluster to the same version that you tried to upgrade to previously. This process triggers a reconciliation.

   ```console
   $ az aks upgrade --name <aksName> --resource-group <resourceGroupName>
   Are you sure you want to perform this operation? (y/N): y
   Cluster currently in failed state. Proceeding with upgrade to existing version 1.28.3 to attempt resolution of failed cluster state.
   Since control-plane-only argument is not specified, this will upgrade the control plane AND all nodepools to version . Continue? (y/N): y
   ```

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
