---
title: AKS upgrade not allowed or blocked due to unsupported Kubernetes version or node pool version skew
description: Learn how to troubleshoot AKS upgrade not allowed or blocked due to unsupported Kubernetes version or node pool version skew.
ms.date: 08/20/2025
editor: v-jsitser
ms.reviewer: v-liuamson
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot AKS upgrade not allowed or blocked due to unsupported Kubernetes version or node pool version skew so that I can successfully upgrade an AKS cluster by using the Azure CLI.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# AKS upgrade not allowed or blocked due to unsupported Kubernetes version or node pool version skew

## Prerequisites

This article requires Azure CLI version 2.67.0 or a later version.
To find the version number, run `az --version`. If you have to install or
upgrade Azure CLI, see [How to install the Azure CLI](/cli/azure/install-azure-cli).

For more detailed information about the upgrade process, see the "Upgrade an AKS cluster" section in
[Upgrade an Azure Kubernetes Service (AKS) cluster](/azure/aks/upgrade-cluster#upgrade-an-aks-cluster).

## Symptoms

When attempting to upgrade an AKS cluster using the Azure CLI, the upgrade operation is blocked with one or more of the following errors:

**K8sVersionNotSupported:** Managed cluster `<ClusterName>` is on version 1.25.6 which is not supported in this region.
Please use the `[azaks get-versions]` command to get the supported version list in this region.
For more information, see [Supported Kubernetes versions in Azure Kubernetes Service (AKS)](https://aka.ms/supported-version-list).

Or

**OperationNotAllowed:** Upgrading Kubernetes version 1.24.9 to 1.26.6
is not allowed. Available upgrades: [1.29.15 1.29.14 1.29.13 1.29.12
1.29.11 1.29.10 1.29.9 1.29.8 1.29.7 1.29.6 1.29.5 1.29.4 1.29.2
1.29.0]. For more information, see [AKS supported Kubernetes versions](https://aka.ms/aks-supported-k8s-ver) for version
details.

Or

**NodePoolMcVersionIncompatible:** Node pool version 1.24.9 and control
plane version 1.29.15 is incompatible. Minor version of node pool cannot
be more than 3 versions less than control plane's version. Minor
version of node pool is 24 and control plane is 29. For more information, see
[AKS upgrade version skew policy](https://aka.ms/aks/UpgradeVersionRules).

## Cause

The upgrade is not allowed due to one or more of the following reasons:

- The target Kubernetes version (e.g., 1.25 or 1.26) is no longer supported in the selected Azure region.

- Skipping minor versions during upgrades (e.g., from 1.24.x to 1.26.x or 1.27.x) is not allowed unless the current version is unsupported.

- A control plane and node pool version skew (**NodePoolMcVersionIncompatible**) occurred when attempting to
  upgrade only the control plane while the nodepool version is too far behind causing a big gap such that the
  node pool version is more than three minor versions behind the control plane version.

To understand more about these errors, you can refer to following articles:

- [AKS supported Kubernetes versions](https://aka.ms/aks-supported-k8s-ver)
- [AKS upgrade version skew policy](https://aka.ms/aks/UpgradeVersionRules)

## Solution

### Step 1: Confirm the current version and available upgrade paths

Run the following command to view the current Kubernetes version and supported upgrade targets:

```azurecli
az aks get-upgrades --resource-group <RG> --name <ClusterName> --output table`
```

If only newer versions such as 1.29.x are listed, and intermediate versions like 1.25.x, 1.26.x, or 1.27.x are missing, this indicates that
those versions are deprecated in your region.

### Step 2: Attempt full upgrade (control plane and node pool together)

Due to the version skew policy (**control planes cannot be more than three minor versions ahead of node pools**),
a separate control-plane-only upgrade may not be allowed. Instead, upgrade both the control plane and node pool together:

```azurecli
az aks upgrade --resource-group <RG> --name <ClusterName>
--kubernetes-version <available upgrade version> --yes
```

This will ensure compliance with the version skew policy, use of a supported Kubernetes version and upgrade of both components in a
coordinated manner.

### Additional Tips

- Always validate supported versions in your region using:

```azurecli
az aks get-versions --location <region> --output table
```

- Avoid attempting to upgrade to deprecated versions. AKS may enforce immediate skips to supported long-term versions (e.g., 1.29).

- **For AKS clusters running significantly outdated Kubernetes versions**, the recommended best practices include following:

  - **Create a New Cluster:** Spin up a new AKS cluster with a supported
    Kubernetes version.

  - **Migrate Workloads:** Transfer your workloads to the new cluster to
    ensure they run on supported versions.

  - **Avoid Upgrading Across Multiple Versions:** Instead of upgrading
    through several minor versions, moving to a new cluster minimizes
    complexity and potential issues.

  - **Backup and Validate Data:** Ensure all data is backed up and validated
    before migration.

  - **Test Thoroughly:** Perform thorough testing in a staging environment
    to identify and resolve any compatibility issues.

[!INCLUDE [azure-help-support](../../../includes/azure-help-support.md)]
