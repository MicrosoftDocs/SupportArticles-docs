---
title: Troubleshoot UpgradeFailed errors due to eviction failures caused by PDBs
description: Troubleshoot UpgradeFailed errors caused by Pod Disruption Budgets during AKS upgrades and restore cluster health. Follow steps to complete upgrade successfully.
ms.date: 06/09/2026
editor: v-jsitser
ms.reviewer: chiragpa, jotavar, v-leedennis, v-weizhu, andraciobanu
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
#Customer intent: As an Azure Kubernetes Services (AKS) user, I want to troubleshoot an Azure Kubernetes Service cluster upgrade that failed because of eviction failures caused by Pod Disruption Budgets so that I can upgrade the cluster successfully.
---

# Troubleshoot UpgradeFailed errors due to eviction failures caused by PDBs

## Summary

This article explains how to identify and resolve `UpgradeFailed` errors due to eviction failures caused by Pod Disruption Budgets (PDBs) that occur when you try to upgrade an Azure Kubernetes Service (AKS) cluster.

## Prerequisites

This article requires Azure CLI version 2.67.0 or a later version. To find the version number, run `az --version`. If you need to install or upgrade Azure CLI, see [How to install the Azure CLI](/cli/azure/install-azure-cli).

For more detailed information about the upgrade process, see the "Upgrade an AKS cluster" section in [Upgrade an Azure Kubernetes Service (AKS) cluster](/azure/aks/upgrade-cluster#upgrade-an-aks-cluster).

> [!TIP]
> Before starting an AKS upgrade, run the **Upgrade readiness** check in the Azure portal:
>
> **AKS cluster** > **Settings** > **Upgrades** > **Upgrade version**
>
> After selecting the target Kubernetes version, select **Check** next to **Upgrade readiness**. This pre-validation can identify potential upgrade blockers, including Pod Disruption Budget (PDB) configurations that might prevent successful node draining during the upgrade.

## Symptoms

An AKS cluster upgrade operation fails with one of the following error messages:

- > (UpgradeFailed) Drain `node aks-<nodepool-name>-xxxxxxxx-vmssxxxxxx` failed when evicting pod `<pod-name>` failed with Too Many Requests error. This error is often caused by a restrictive Pod Disruption Budget (PDB) policy. See https://aka.ms/aks/debugdrainfailures. Original error: Cannot evict pod as it would violate the pod's disruption budget.. PDB debug info: `<namespace>/<pod-name>` blocked by pdb `<pdb-name>` with 0 unready pods.

- > Code: UpgradeFailed  
  > Message: Drain node `aks-<nodepool-name>-xxxxxxxx-vmssxxxxxx` failed when evicting pod `<pod-name>` failed with Too Many Requests error. This error is often caused by a restrictive Pod Disruption Budget (PDB) policy. See https://aka.ms/aks/debugdrainfailures. Original error: Cannot evict pod as it would violate the pod's disruption budget.. PDB debug info: `<namespace>/<pod-name>` blocked by pdb `<pdb-name>` with 0 unready pods.


## Cause

This error occurs if a pod is protected by the Pod Disruption Budget (PDB) policy. In this situation, the pod resists being drained. After several attempts, the upgrade operation fails, and the cluster or node pool falls into a `Failed` state.

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

You can also check for any entries in Kubernetes events by using the command `kubectl get events | grep -i drain`. A similar output shows the message "Eviction blocked by Too Many Requests (usually a pdb)":

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

1. Adjust the PDB to enable pod draining. Generally, the allowed disruption is controlled by the `Min Available / Max unavailable` or `Running pods / Replicas` parameter. Modify the `Min Available / Max unavailable` parameter at the PDB level or increase the number of `Running pods / Replicas` to push the Allowed Disruption value to **1** or greater.
2. Try again to upgrade the AKS cluster to the same version that you tried to upgrade to previously. This process triggers a reconciliation.

   ```console
   $ az aks upgrade --name <aksName> --resource-group <resourceGroupName>
   Are you sure you want to perform this operation? (y/N): y
   Cluster currently in failed state. Proceeding with upgrade to existing version 1.28.3 to attempt resolution of failed cluster state.
   Since control-plane-only argument is not specified, this will upgrade the control plane AND all nodepools to version . Continue? (y/N): y
   ```

## Solution 2: Back up, delete, and redeploy the PDB

> [!NOTE]
> Use this solution if editing the PDB resource isn't a viable option.

1. Back up the PDBs by running the following command:
   
   `kubectl get pdb <pdb-name> -n <pdb-namespace> -o yaml > pdb-name-backup.yaml`and 

2. Delete the PDB by running the following command:
 
   `kubectl delete pdb <pdb-name> -n <pdb-namespace>`
   
3. After the new upgrade attempt finishes, redeploy the PDB by applying the backup file using the following command:
   
   `kubectl apply -f pdb-name-backup.yaml`.
   
4. Try to upgrade the AKS cluster to the same version again that you tried to upgrade to previously. This process triggers a reconciliation.

   ```console
   $ az aks upgrade --name <aksName> --resource-group <resourceGroupName>
   Are you sure you want to perform this operation? (y/N): y
   Cluster currently in failed state. Proceeding with upgrade to existing version 1.28.3 to attempt resolution of failed cluster state.
   Since control-plane-only argument is not specified, this will upgrade the control plane AND all nodepools to version . Continue? (y/N): y
   ```

## Solution 3: Delete the pods that you can't drain or scale the workload down to zero

1. Delete the pods that you can't drain.
   
> [!NOTE]
> If a Deployment or StatefulSet creates the pods, a ReplicaSet controls them. If that's the case, you might need to delete or scale the workload replicas to zero for the Deployment or StatefulSet. Before you make this change, back up the resource by running: `kubectl get <deployment.apps -or- statefulset.apps> <name> -n <namespace> -o yaml > backup.yaml`.

2. To scale down the workload, use `kubectl scale --replicas=0 <deployment.apps -or- statefulset.apps> <name> -n <namespace>`.

3. Try again to upgrade the AKS cluster to the same version that you tried to upgrade to previously. This process triggers a reconciliation.

   ```console
   $ az aks upgrade --name <aksName> --resource-group <resourceGroupName>
   Are you sure you want to perform this operation? (y/N): y
   Cluster currently in failed state. Proceeding with upgrade to existing version 1.28.3 to attempt resolution of failed cluster state.
   Since control-plane-only argument is not specified, this will upgrade the control plane AND all nodepools to version . Continue? (y/N): y
   ```

 
