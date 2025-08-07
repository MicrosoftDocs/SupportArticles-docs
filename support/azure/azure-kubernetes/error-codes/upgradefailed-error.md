---
title: Troubleshoot a failed AKS cluster upgrade
description: Learn how to troubleshoot error codes related to upgrade failure when you try to upgrade an AKS cluster by using the Azure CLI.
ms.date: 08/07/2025
editor: v-jsitser
ms.reviewer: v-liuamson
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the "AKS upgrade failed due to unsupported Kubernetes version or node pool version skew" error so that I can successfully upgrade an AKS cluster by using the Azure CLI.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot a failed AKS cluster upgrade

## Prerequisites

This article requires Azure CLI version 2.67.0 or a later version. To find the version number, run `az \--version`. If you have to install or upgrade Azure CLI, see [How to install the Azure CLI](/cli/azure/install-azure-cli).

For more detailed information about the upgrade process, see the \"Upgrade an AKS cluster\" section in [Upgrade an Azure Kubernetes Service (AKS) cluster](/azure/aks/upgrade-cluster#upgrade-an-aks-cluster).

## Symptoms

When you try to upgrade an AKS cluster by using the Azure CLI, the upgrade operation fails and returns one or more of the following error messages:

> **(K8sVersionNotSupported)** Managed cluster `ClusterName` is on version 1.25.6 which is not supported in this region.
>
> **(OperationNotAllowed)** Upgrading Kubernetes version 1.24.9 to 1.26.6 is not allowed.
>
> **(NodePoolMcVersionIncompatible)** Node pool version 1.24.9 and control plane version 1.29.15 are incompatible.

## Cause

The upgrade failures occur for one or more of the following reasons:

- The target Kubernetes version (for example, 1.26 or 1.25) is no longer supported in the selected Azure region.

- A minor version is skipped. Skipping minor versions during upgrades (for example, from 1.24.*x* to 1.26.*x* or 1.27.*x*) isn't allowed unless the current version is unsupported.

- A control plane and node pool version skew occurs when you try to upgrade only the control plane. This condition causes the following version skew  error:

- The node pool version is more than three minor versions behind the control plane.

To understand more about these errors, see [AKS supported Kubernetes versions](https://aka.ms/aks-supported-k8s-ver) and [AKS upgrade version skew policy](https://aka.ms/aks/UpgradeVersionRules).

## Resolution

To resolve this issue, follow these steps.

**Step 1:** Verify the current version and available upgrade paths. To view the current Kubernetes version and supported upgrade targets, run the following command:

```azurecli
az aks get-upgrades --resource-group <RG> --name <ClusterName> --output table
```

If only newer versions, such as 1.29.*x*, are listed, and intermediate versions, such as 1.27.*x*, 1.26.*x*, or 1.25.*x*, are missing, the missing versions are deprecated in your region.

**Step 2:** Try to run a full upgrade (control plane and node pool together). Because of the version skew policy (control planes can't be more than three minor versions ahead of node pools), a separate control plane-only upgrade might fail. Instead, upgrade both the control plane and node pool together:

```azurecli
az aks upgrade \--resource-group \<RG\> \--name \<ClusterName\> \--kubernetes-version \<available upgrade version\> \--yes
```

This action ensures compliance with the version skew policy by coordinating a supported Kubernetes version and an upgrade of both components.

## More information

- Always verify the supported versions in your region by running the following command:

```azurecli
az aks get-versions \--location \<region\> \--output table
```

- Avoid trying to upgrade to deprecated versions. AKS might enforce immediate skips of supported long-term versions (for example, 1.29).

- For AKS clusters that are running outdated Kubernetes versions, the recommended best practices include:  

   **Create a new cluster:** Create an AKS cluster that has a supported Kubernetes version.  

   **Migrate workloads:** To make sure that your workloads run on supported versions, transfer the workloads to the new cluster.

   **Avoid upgrading across multiple versions:** Instead of upgrading through several minor versions, move to a new cluster to minimize complexity and potential issues.  

   **Back up and verify data:** Make sure that all data is backed up and verified before the migration.  

   **Test thoroughly:** To identify and resolve any compatibility issues, perform thorough testing in a staging environment.

[!INCLUDE [azure-help-support](../../../includes/azure-help-support.md)]
