---
title: CustomPrivateDNSZoneMissingPermissionError error code
description: Learn how to fix the CustomPrivateDNSZoneMissingPermissionError error that occurs when you try to create or update an Azure Kubernetes Service (AKS) cluster.
ms.date: 11/28/2023
author: jotavar
ms.author: jotavar
editor: v-jsitser
ms.reviewer: cssakscic, v-leedennis
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
#Customer intent: As an Azure Kubernetes Services (AKS) user, I want to fix a CustomPrivateDNSZoneMissingPermissionError error so that I can create or update an AKS cluster successfully.
---

# Troubleshoot the "CustomPrivateDNSZoneMissingPermissionError" error code

This article discusses how to identify and resolve the "CustomPrivateDNSZoneMissingPermissionError" error code that occurs when you try to create or update a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli), version 2.53.0 or a later version. To find your installed version, run `az --version`.

## Symptoms

An AKS cluster create or update operation fails and returns the following error message:

> **Code: CustomPrivateDNSZoneMissingPermissionError**  
> Message: Service principal or user-assigned identity must be given permission to read and write to custom private dns zone \<custom-private-dns-zone-resource-id>. Check access result not allowed for action Microsoft.Network/privateDnsZones/read.

## Cause

Before AKS runs a cluster create or update operation for a private cluster that uses a [custom private DNS zone](/azure/aks/private-clusters#configure-a-private-dns-zone), it checks whether the cluster's managed identity or service principal has the required permissions to control the private DNS zone. If AKS doesn't find the necessary permissions, it blocks the operation so that the cluster doesn't enter a failed state.

## Solution

To create the missing role assignment, follow these steps:

1. Get the resource ID of the cluster's private DNS zone by running the [az aks show](/cli/azure/aks#az-aks-show) command, and store it as the `CUSTOM_PRIVATE_DNS_ZONE_ID` variable:

    ```azurecli-interactive
    CUSTOM_PRIVATE_DNS_ZONE_ID=$(az aks show \
        --resource-group <aks-resource-group> \
        --name <aks-cluster-name> \
        --query apiServerAccessProfile.privateDnsZone \
        --output tsv)
    ```

   > [!NOTE]  
   > Because the resource ID of the custom private DNS zone was also shown in the original error message, you can alternatively assign that resource ID to the variable instead of running the `az aks show` command.

2. Assign the [Private DNS Zone Contributor](/azure/role-based-access-control/built-in-roles#private-dns-zone-contributor) role to the cluster's managed identity or service principal by running the [az role assignment create](/cli/azure/role/assignment#az-role-assignment-create) command:

    ```azurecli-interactive
    az role assignment create --role "Private DNS Zone Contributor" \
        --scope $CUSTOM_PRIVATE_DNS_ZONE_ID \
        --assignee <control-plane-principal-id>
    ```

> [!NOTE]
> It can take up to 60 minutes to finish granting permissions to your cluster's managed identity or service principal.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
