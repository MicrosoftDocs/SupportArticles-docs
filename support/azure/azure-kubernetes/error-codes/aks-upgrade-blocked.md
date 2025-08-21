---
title: AKS upgrade not allowed or blocked because of unsupported Kubernetes version or node pool version skew
description: Learn how to troubleshoot AKS upgrade not allowed or blocked because of unsupported Kubernetes version or node pool version skew.
ms.date: 08/21/2025
editor: v-jsitser
ms.reviewer: v-liuamson
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot an AKS upgrade not allowed or blocked because of an unsupported Kubernetes version or node pool version skew so that I can successfully upgrade an AKS cluster by using the Azure CLI.
---
# Troubleshoot AKS upgrade errors because of version skew, incompatibility, or lack of support

## Prerequisites

This article requires Azure CLI version 2.67.0 or a later version. To find the version number, run `az --version`. If you have to install or upgrade the Azure CLI, see [How to install the Azure CLI](/cli/azure/install-azure-cli).

For more detailed information about the upgrade process, see the "Upgrade an AKS cluster" section in [Upgrade options and recommendations for Azure Kubernetes Service (AKS) clusters](/azure/aks/upgrade-cluster#upgrade-an-aks-cluster).

## Symptoms

When you try to upgrade an AKS cluster by using the Azure CLI, the upgrade operation is blocked and returns one or more of the following error messages.

**Error message 1: K8sVersionNotSupported**

> `<ClusterName>` is on version 1.25.6 which is not supported in this region. Please use the `[azaks get-versions]` command to get the supported version list in this region. For more information, see [Supported Kubernetes versions in Azure Kubernetes Service (AKS)](https://aka.ms/supported-version-list).

**Error message 2: OperationNotAllowed**

> Upgrading Kubernetes version 1.24.9 to 1.26.6 is not allowed. Available upgrades: [1.29.15 1.29.14 1.29.13 1.29.12 1.29.11 1.29.10 1.29.9 1.29.8 1.29.7 1.29.6 1.29.5 1.29.4 1.29.2 1.29.0]. For more information, see [AKS supported Kubernetes versions](https://aka.ms/aks-supported-k8s-ver) for version details.

**Error message 3: NodePoolMcVersionIncompatible**

> Node pool version 1.24.9 and control plane version 1.29.15 is incompatible. Minor version of node pool cannot be more than 3 versions less than control plane's version. Minor version of node pool is 24 and control plane is 29. For more information, see [AKS upgrade version skew policy](https://aka.ms/aks/UpgradeVersionRules).

## Cause

The upgrade isn't allowed for one or more of the following reasons:

- The target Kubernetes version (for example, 1.26 or 1.25) is no longer supported in the selected Azure region.

- You aren't allowed to skip minor versions during upgrades (for example, from 1.24.*x* to 1.26.*x* or 1.27.*x*) unless the current version is unsupported.

- A version skew between the control plane and node pool (**NodePoolMcVersionIncompatible**) occurs if you try to upgrade only the control plane. In this situation, the node pool version becomes more than three minor versions behind the control plane version. A gap of this size or greater causes the error.

To understand more about these errors, refer to following articles:

- [AKS supported Kubernetes versions](https://aka.ms/aks-supported-k8s-ver)
- [AKS upgrade version skew policy](https://aka.ms/aks/UpgradeVersionRules)

## Solution

### Step 1: Verify the current version and available upgrade paths

To view the current Kubernetes version and supported upgrade targets, run the following command:

```azurecli
az aks get-upgrades --resource-group <RG> --name <ClusterName> --output table
```

If only newer versions, such as 1.29.*x*, are listed, and intermediate versions, such as 1.27.*x*, 1.26.*x*, or 1.25.*x*, are missing, this indicates that
those versions are deprecated in your region.

### Step 2: Try a full upgrade (control plane and node pool together)

Because the version skew policy dictates that control planes can't be more than three minor versions ahead of node pools,
a separate control-plane-only upgrade might not be allowed. Instead, upgrade both the control plane and node pool together:

```azurecli
az aks upgrade --resource-group <RG> --name <ClusterName> --kubernetes-version <available upgrade version> --yes
```

This method makes sure that the following conditions apply:

- You're in compliance with the version skew policy.
- You use a supported Kubernetes version.
- You upgrade both components in a coordinated manner.

### Additional tips

- Always validate supported versions in your region by using the following command:

```azurecli
az aks get-versions --location <region> --output table
```

- Avoid trying to upgrade to deprecated versions. In this situation, AKS might enforce an immediate skip to a supported long-term version (for example, to version 1.29).

- If AKS clusters are running outdated Kubernetes versions that violate the skew policy, the recommended best practices are as follows:

  - **Create a new cluster:** create an AKS cluster by using a supported Kubernetes version.

  - **Migrate workloads:** To make sure that your workloads run on supported versions, transfer them to the new cluster.

  - **Avoid upgrading across multiple versions:** Instead of upgrading through several minor versions, move to a new cluster to minimize complexity and avoid potential issues.

  - **Back up and validate data:** Make sure that all data is backed up and validated before a migration.

  - **Test thoroughly:** To identify and resolve any compatibility issues, perform thorough testing in a staging environment.

[!INCLUDE [azure-help-support](../../../includes/azure-help-support.md)]
