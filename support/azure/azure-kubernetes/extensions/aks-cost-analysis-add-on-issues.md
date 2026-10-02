---
title: Troubleshoot Azure Kubernetes Service cost analysis add-on issues
description: Troubleshoot AKS cost analysis add-on errors during cluster creation or updates, and follow fixes to restore functionality quickly. Get started now.
ms.date: 09/25/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: pram, chiragpa, joharder, cssakscic, dafell, v-leedennis, v-weizhu, addobres, kaysieyu
ms.service: azure-kubernetes-service
ms.custom: sap:Extensions, Policies and Add-Ons, references_regions, innovation-engine
ai-usage: ai-assisted
---

# Troubleshoot AKS cost analysis add-on issues

## Summary

This article discusses how to troubleshoot problems that you might experience when you enable the Azure Kubernetes Service (AKS) cost analysis add-on during cluster creation or a cluster update.

## Prerequisites

Ensure you have [Azure CLI](/cli/azure/install-azure-cli) installed.

Define environment variables for resource group and cluster name:

```
export RESOURCE_GROUP="<your-resource-group>" 
export AKS_CLUSTER="<your-aks-cluster>"
```


## Symptoms

After you create or update an AKS cluster, you receive an error message. The following table lists possible error codes and their causes.

| Error code | Cause |
|--|--|
| `InvalidDiskCSISettingForCostAnalysis` | [Cause 1: Azure Disk CSI driver is disabled](#cause-1-azure-disk-csi-driver-is-disabled) |
| `InvalidManagedIdentitySettingForCostAnalysis` | [Cause 2: Managed identity is disabled](#cause-2-managed-identity-is-disabled) |
| `CostAnalysisNotEnabledInRegion` | [Cause 3: The add-on is unavailable in your region](#cause-3-the-add-on-is-unavailable-in-your-region) |
| `InvalidManagedClusterSKUForFeature` | [Cause 4: The add-on is unavailable on the free pricing tier](#cause-4-the-add-on-is-unavailable-on-the-free-pricing-tier) |
| Pod `OOMKilled` | [Cause 5: The cost-analysis-agent pod gets the OOMKilled error](#cause-5-the-cost-analysis-agent-pod-gets-the-oomkilled-error) |
| Pod `Pending` | [Cause 6:The cost-analysis-agent pod is stuck in the Pending state](#cause-6-the-cost-analysis-agent-pod-is-stuck-in-the-pending-state) | 
| Pod `Running` but not Ready | [Cause 7:The cost-analysis-agent pod is running but not all containers are ready](#cause-7-the-cost-analysis-agent-pod-is-running-but-not-all-containers-are-ready) |

## Cause 1: Azure Disk CSI driver is disabled

You can't enable the Cost Analysis add-on on a cluster in which the [Azure Disk Container Storage Interface (CSI) driver](/azure/aks/azure-disk-csi) is disabled.

### Solution: Update the cluster to enable the Azure Disk CSI driver

Run the [az aks update][aks-update] command, and specify the `--enable-disk-driver` parameter. This parameter enables the Azure Disk CSI driver in AKS.

First, define the environment variables for your resource group and AKS cluster (See Prerequisites).

Use Azure CLI to run the following command.

```azurecli
az aks update --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER --enable-disk-driver
```

For more information, see [CSI drivers on AKS](/azure/aks/csi-storage-drivers).

## Cause 2: Managed identity is disabled

You can enable the cost analysis add-on only on a cluster that has a system-assigned or user-assigned managed identity.

### Solution: Update the cluster to enable managed identity

Run the [az aks update][aks-update] command, and specify the `--enable-managed-identity` parameter.

Use Azure CLI to run the following command.

```azurecli
az aks update --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER --enable-managed-identity
```

For more information, see [Use a managed identity in AKS](/azure/aks/use-managed-identity).

> [!IMPORTANT]
> AKS supports both managed identities (system-assigned or user-assigned) and [Microsoft Entra Workload ID](/azure/aks/workload-identity-overview?tabs=dotnet). Microsoft recommends Microsoft Entra Workload ID for Kubernetes workload authentication
>
> [Microsoft Entra pod-managed identity (AAD Pod Identity)](/azure/aks/use-azure-ad-pod-identity?tabs=azurecni) is deprecated, and the open-source project has been archived. Microsoft recommends migrating workloads to Microsoft Entra Workload ID.

## Cause 3: The add-on is unavailable in your region

The cost analysis add-on isn't currently enabled in your region.

> [!NOTE]  
> The AKS Cost Analysis add-on is currently unavailable in the following regions:
>
> - `usnateast`
> - `usnatwest`
> - `usseceast`
> - `ussecwest`


## Cause 4: The add-on is unavailable on the free pricing tier

You can't enable the cost analysis add-on on AKS clusters that are on the free pricing tier.

### Solution: Update the cluster to use the Standard or Premium pricing tier

Upgrade the AKS cluster to the Standard or Premium pricing tier. To do this, run the following [az aks update][aks-update] command that specifies the `--tier` parameter. Set the `--tier` parameter to either `standard` or `premium` (the following example sets it to `standard`).

Use Azure CLI to run the following command.

```azurecli
az aks update --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER --tier standard
```

For more information, see [Free and Standard pricing tiers for AKS cluster management](/azure/aks/free-standard-pricing-tiers).

## Cause 5: The cost-analysis-agent pod gets the OOMKilled error

The current memory limit for the `cost-analysis-agent` pod is set to 4 GB.

The pod's usage depends on the number of deployed containers, which can be roughly 200 MB plus 0.5 MB per container. The current memory limit supports approximately 7000 containers per cluster.

When the pod's usage exceeds the allocated 4 GB limit, large clusters may experience the `OOMKilled` error.

### Solution: Disable the add-on

Currently, customizing or manually increasing memory limits for the add-on isn't supported. To resolve this issue, disable the add-on.

## Cause 6: The cost-analysis-agent pod is stuck in the Pending state

If the pod is stuck in the Pending state with the FailedScheduling error, the nodes in the cluster have exhausted memory capacity.

### Solution: Ensure there's sufficient allocatable memory

The current memory request of the `cost-analysis-agent` pod is set to 500 MB. Ensure that there's sufficient allocatable memory for the pod to be scheduled

## Cause 7: The cost-analysis-agent pod is running but not all containers are ready

The `cost-analysis-agent` pod is scheduled and shows a `Running` status, but never becomes fully ready (for example, `2/3`). One container repeatedly restarts and fails its readiness or liveness probes, while the remaining containers stay healthy.
 
`kubectl describe pod` shows a termination reason of `Error` with a nonzero exit code.
 
If the termination reason is `OOMKilled`, see [Cause 5: The cost-analysis-agent pod gets the OOMKilled error](#cause-5-the-cost-analysis-agent-pod-gets-the-oomkilled-error).
 
### Solution: Collect logs from the previous container instance

Because the container restarts continuously, current logs often show only a fresh startup sequence and might not contain the original failure. Retrieve logs from the terminated container instance.

Use a command-line interface (CLI) tool to run the following command.
 
```bash
kubectl logs <cost-analysis-pod-name> \
-n kube-system \
-c <container-name> \
--previous
```
 
Review the logs for errors related to startup, health probes, authentication, or communication with Azure services.

[aks-update]: /cli/azure/aks#az-aks-update
