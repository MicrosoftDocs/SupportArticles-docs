---
title: AKS cluster upgrade fails because of NSG rules
description: Learn how to troubleshoot a Kubernetes upgrade failure because of network security group (NSG) rules. 
ms.date: 07/28/2022
editor: v-jsitser
ms.reviewer: chiragpa, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-upgrade-operations
#Customer intent: As an Azure Kubernetes Services (AKS) user, I want to troubleshoot an AKS cluster upgrade that failed because of network security group (NSG) rules so that I can upgrade successfully.
---

# AKS cluster upgrade fails because of NSG rules

This article discusses how to resolve issues if your Azure Kubernetes Service (AKS) cluster upgrade fails because of network security group (NSG) rules.

## Prerequisites

This article requires Azure CLI version 2.0.65 or a later version. To find the version number, run `az --version`. If you have to install or upgrade Azure CLI, see [How to install the Azure CLI](/cli/azure/install-azure-cli).

For more detailed information about the upgrade process, see the "Upgrade an AKS cluster" section in [Upgrade an Azure Kubernetes Service (AKS) cluster](/azure/aks/upgrade-cluster#upgrade-an-aks-cluster).

## Symptoms

An AKS cluster upgrade fails, and you receive an error message that indicates that an NSG rule is involved.

## Cause

An NSG rule is blocking the cluster from downloading required resources.

## Solution

To resolve this issue, follow these steps:

1. Run `az network nsg list -o table`, and then locate the NSG that's linked to your cluster. The NSG is located in a resource group that's named `MC_<RG name>_<your AKS cluster name>`.

1. Run the following command to view the NSG rules:

    ```azurecli
    az network nsg rule list --resource-group <Rg name> --nsg-name <nsg name> --include-default -o table
    ```

    The following screenshot shows the default rules.

    :::image type="content" source="./media/troubleshoot-upgrade-errors/default-nsg-rules.png" alt-text="Screenshot of the default NSG rules." lightbox="./media/troubleshoot-upgrade-errors/default-nsg-rules.png":::

1. If you have the default rules, skip this step. Otherwise, revise and remove the rules that are blocking the internet traffic. Then, run the following command to upgrade the AKS cluster to the same version that you previously tried to upgrade to. This process will trigger a reconciliation.

    ```azurecli
    az aks upgrade --resource-group <ResourceGroupName> --name <AKSClusterName> --kubernetes-version <KUBERNETES_VERSION>
    ```

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
