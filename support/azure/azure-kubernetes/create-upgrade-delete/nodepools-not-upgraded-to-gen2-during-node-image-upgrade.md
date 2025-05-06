---
title: Windows nodepools not upgraded to Gen2 during cluster node image upgrade
description: Troubleshoot why Windows Server nodepools don't get upgraded automatically from Gen1 to Gen2 when a cluster node image is upgraded in Azure Kubernetes Service.
ms.date: 04/17/2025
editor: v-jsitser,momajed
ms.reviewer: chiragpa, cssakscic, v-leedennis,momajed
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes Services (AKS) user, I want to troubleshoot why Windows Server nodepools don't get upgraded automatically from Gen1 to Gen2 virtual machines (VMs) when a cluster node image is upgraded in Azure Kubernetes Service (AKS).
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---

# Windows Server nodepools not upgraded to Gen2 during cluster node image upgrade

This article discusses how to troubleshoot a scenario in which Windows Server nodepools don't get upgraded automatically from Gen1 to Gen2 virtual machines (VMs) when a cluster node image is upgraded in Microsoft Azure Kubernetes Service (AKS).

> [!NOTE]  
> This scenario doesn't apply to Gen2 VMs on Linux nodepools.

## Prerequisites

- Azure CLI version 2.0.81 or later. See [Install Azure CLI](/cli/azure/install-azure-cli) for installation instructions.

## Symptoms

Existing Windows Server nodepools don't get upgraded from Gen1 to Gen2 when you [upgrade the node image](/azure/aks/node-image-upgrade) by using one of the following methods in Azure CLI:

- An entire cluster upgrade (by using the [az aks upgrade](/cli/azure/aks#az-aks-upgrade) command)

- A specific nodepool upgrade (by using the [az aks nodepool upgrade](/cli/azure/aks/nodepool#az-aks-nodepool-upgrade) command)

## Cause

### Cause 1: Existing nodepools aren't automatically upgraded to Gen2 VMs

By design, a node image upgrade doesn't support updating or upgrading existing nodepools. The `az aks upgrade` and `az aks nodepool upgrade` commands upgrade only the node image (to a later node image version). Those commands don't upgrade the corresponding VM generation.

### Cause 2: Cluster upgrade to Kubernetes version 1.25 or a later version upgrades only the OS

When you upgrade your cluster to Kubernetes version 1.25 or a later version, only the operating system (OS) is upgraded (to Windows Server 2022). Existing nodepools aren't affected. The associated VM scale set will contain VMs that have the same Gen1 VM.

### Cause 3: Cluster upgraded and new nodepool created by using Windows Server 2022 without specifying a valid VM size

After you upgrade the cluster to Kubernetes version 1.25 or a later version, you specify Windows Server 2022 as the OS to use on the nodepool's VMs. However, the VMs don't use a Gen2 node image reference because of one of the following reasons:

- You don't specify a VM size, and the default VM size in the region doesn't support Gen2 VMs.

- You specify a Gen1-only VM size.

When you upgrade the default OS from Windows Server 2019 (`Windows2019`) to Windows Server 2022 (`Windows2022`), the existing nodepools aren't automatically upgraded to a different VM generation.

## Solution

Upgrade the cluster, and then create a new Windows Server nodepool that supports [Gen2 VM sizes](/azure/virtual-machines/generation-2) on that cluster according to the following guidelines.


| Kubernetes cluster upgrade version | Cluster creation guidelines |
|---|---|
| 1.25 or a later version | When you run the [az aks create](/cli/azure/aks#az-aks-create) command to create a cluster, set the `--node-vm-size` parameter to a [Gen2 VM size](/azure/virtual-machines/generation-2). |
| Earlier version than 1.25 | When you run the [az aks create](/cli/azure/aks#az-aks-create) command to create a cluster, set the `--os-sku` parameter value to `Windows2022`, and set the `--node-vm-size` parameter value to a [Gen2 VM size](/azure/virtual-machines/generation-2). |


> [!NOTE]  
> If you specify a Gen2 VM size and the operating system as Windows Server 2019, you receive an `ErrorCode_Windows2019NotSupportedWithGen2VM` error code that's accompanied by the following error message:
>
> > \<virtual-machine-size> is a Gen 2-only VM. Windows2019 does not support Gen 2 VMs. However, you can select a Gen 1 VM size or set os_sku to 2022.
>
> To avoid this problem, choose one of the following options when you create the cluster:
>
> - Pick a Gen1 VM size to use together with Windows Server 2019.
>
> - Set the operating system SKU to **Windows Server 2022** to use together with your Gen2 VM.
>
> - Before you create a new nodepool, verify that the VM size supports Gen2 VMs in your region by running `az vm list-sizes --location <region> --query "[?contains(name, 'v2')].name" --output table`.
>
> - To confirm the current and available node image versions, run `az aks nodepool show --resource-group <resource-group> --cluster-name <cluster-name> --name <nodepool-name> --query nodeImageVersion` to check the current version, and `az aks nodepool get-upgrades --resource-group <resource-group> --cluster-name <cluster-name> --nodepool-name <nodepool-name> --query latestNodeImageVersion` to check the latest available version.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
