---
title: Troubleshoot the VirtualNetworkNotInSucceededState error code
description: Learn how to troubleshoot the VirtualNetworkNotInSucceededState error code when you create, upgrade or scale an Azure Kubernetes Service (AKS) cluster or node pool.
ms.date: 08/05/2025
editor: v-jsitser
ms.reviewer: v-liuamson
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the VirtualNetworkNotInSucceededState error code so that I can successfully create upgrade or scale an Azure Kubernetes Service (AKS) cluster or node pool.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the VirtualNetworkNotInSucceededState error code

## Symptoms

When you create, upgrade or scale an Azure Kubernetes Service (AKS)
cluster or node pool, the deployment fails with an error like the
following:

*Status=400 Code=\"VirtualNetworkNotInSucceededState\"*

*Message=\"Set virtual network ownership failed. Subscription:
\<SUBSCRIPTION\>; resource group: \<RESOURCE GROUP\>; virtual network
name: \<VNET NAME\>. autorest/azure: Service returned an error.
Status=400 Code=\"VirtualNetworkNotInSucceededState\" Message=\"Virtual
network /subscriptions/\<SUBSCRIPTION\>/resourceGroups/\<RESOURCE
GROUP\>/providers/Microsoft.Network/virtualNetworks/\<VNET\> is in
Updating state. It needs to be in Succeeded state in order to set
resource ownership.*

## Cause

AKS can set ownership on a virtual network only when the
`provisioningState` of the VNet is **Succeeded**. The request fails if the
VNet is in **Updating, Deleting or Failed**. Common reasons include:

- Another create, update, or delete operation is still running on the
  VNet.

- A previous network operation failed and left the VNet in the **Failed**
  state.

- Multiple parallel cluster or node‑pool deployments are trying to
  modify the same VNet at the same time.

## Resolution

Check the current provisioning state of the VNET:

*az network vnet show -g \<resource-group\> -n \<vnet-name\> \--query
\"provisioningState\" -o tsv*

If the command returns **Succeeded**, retry your AKS operation. If it
returns any other value. For more guidance, you may follow the troubleshooting steps described in [Troubleshoot Azure Microsoft.Network failed provisioning state](/azure/networking/troubleshoot-failed-state).

[!INCLUDE [azure-help-support](../../../includes/azure-help-support.md)]