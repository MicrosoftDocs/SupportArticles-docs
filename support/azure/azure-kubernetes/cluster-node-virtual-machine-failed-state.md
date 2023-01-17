---
title: Cluster node virtual machine in a failed state
description: Troubleshoot why a node virtual machine on your Azure Kubernetes Service (AKS) cluster is in a failed state.
ms.date: 6/10/2022
author: DennisLee-DennisLee
ms.author: v-dele
ms.reviewer: chiragpa, nickoman
ms.service: azure-kubernetes-service
ms.subservice: common-issues
keywords:
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot why attach my node virtual machine is in a failed state so that I can successfully use my Azure Kubernetes Service (AKS) cluster.
---
# Cluster node virtual machine in a failed state

This article discusses how to troubleshoot a node virtual machine (VM) that's entered a failed state on your Microsoft Azure Kubernetes Service (AKS) cluster.

## Cause

In some edge cases, an Azure Disk detach operation may partially fail, which leaves the node VM in a failed state.

## Solution

Manually update the VM status by using one of the following options:

- For a cluster that's based on an availability set, run the following [az vm update](/cli/azure/vm#az-vm-update) command:

  ```azurecli
  az vm update --resource-group <resource-group-name> --name <vm-name>
  ```

- For a cluster that's based on a virtual machine scale set, run the following [az vmss update-instances](/cli/azure/vmss#az-vmss-update-instances) command:

  ```azurecli
  az vmss update-instances --resource-group <resource-group-name> \
      --name <scale-set-name> \
      --instance-id <vm-or-scale-set-id>
  ```

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
