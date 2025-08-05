---
title: Troubleshoot the UpgradeFailed error code
description: Learn how to troubleshoot the UpgradeFailed error code when you attempt to upgrade an AKS cluster using the Azure CLI.
ms.date: 08/05/2025
editor: v-jsitser
ms.reviewer: v-liuamson
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the UpgradeFailed - AKS upgrade failed due to unsupported Kubernetes version or node pool version skew error code so that I can successfully upgrade an AKS cluster using the Azure CLI.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Error code: UpgradeFailed - AKS upgrade failed due to unsupported Kubernetes version or node pool version skew

## Prerequisites

This article requires Azure CLI version 2.67.0 or a later version. \
To find the version number, run az \--version. If you have to install or
upgrade Azure CLI, see [How to install the Azure
CLI](/cli/azure/install-azure-cli).

For more detailed information about the upgrade process, see the
\"Upgrade an AKS cluster\" section in [Upgrade an Azure Kubernetes
Service (AKS)
cluster](/azure/aks/upgrade-cluster#upgrade-an-aks-cluster).

## Symptoms

When attempting to upgrade an AKS cluster using the Azure CLI, the
upgrade operation fails with one or more of the following errors:

**(K8sVersionNotSupported)** Managed cluster `ClusterName` is on
version 1.25.6 which is not supported in this region.

Or  \
 \
**(OperationNotAllowed)** Upgrading Kubernetes version 1.24.9 to 1.26.6
is not allowed.

Or

**(NodePoolMcVersionIncompatible)** Node pool version 1.24.9 and control
plane version 1.29.15 are incompatible.

## Cause

The upgrade failures are due to one or more of the following reasons:

- The target Kubernetes version (e.g., 1.25 or 1.26) is no longer
  supported in the selected Azure region.

- Skipping minor versions during upgrades (e.g., from 1.24.x to 1.26.x
  or 1.27.x) is not allowed unless the current version is unsupported.

- A control plane and node pool version skew occurred when attempting
  to upgrade only the control plane, causing the following version skew
  error:

- Node pool version is more than 3 minor versions behind the control
  plane.

To understand more about these errors, you may check the following
articles:

- AKS supported Kubernetes versions:
  <https://aka.ms/aks-supported-k8s-ver>.

- AKS upgrade version skew policy:
  <https://aka.ms/aks/UpgradeVersionRules>.

## Solution

### Step 1: Confirm the current version and available upgrade paths

Run the following command to view the current Kubernetes version and
supported upgrade targets:

**az aks get-upgrades \--resource-group \<RG\> \--name \<ClusterName\>
\--output table**

If only newer versions such as 1.29.x are listed, and intermediate
versions like 1.25.x, 1.26.x, or 1.27.x are missing, this indicates that
those versions are deprecated in your region.

### Step 2: Attempt full upgrade (control plane and node pool together)

Due to the version skew policy (control planes cannot be more than 3
minor versions ahead of node pools), a separate control-plane-only
upgrade may fail. Instead, upgrade both the control plane and node pool
together: \
 \
**az aks upgrade \--resource-group \<RG\> \--name \<ClusterName\>
\--kubernetes-version \<available upgrade version\> \--yes**

This will ensure compliance with the version skew policy, use of a
supported Kubernetes version and upgrade of both components in a
coordinated manner

## Additional Tips

- Always validate supported versions in your region using: \
    az aks get-versions \--location \<region\> \--output table

- Avoid attempting to upgrade to deprecated versions. AKS may enforce
  immediate skips to supported long-term versions (e.g., 1.29)

- For AKS clusters running significantly outdated Kubernetes versions,
  the recommended best practices include:  

**Create a New Cluster:** Spin up a new AKS cluster with a supported
Kubernetes version.  

**Migrate Workloads:** Transfer your workloads to the new cluster to
ensure they run on supported versions.  

**Avoid Upgrading Across Multiple Versions:** Instead of upgrading
through several minor versions, moving to a new cluster minimizes
complexity and potential issues.  

**Backup and Validate Data:** Ensure all data is backed up and validated
before migration.  

**Test Thoroughly:** Perform thorough testing in a staging environment
to identify and resolve any compatibility issues.  

[!INCLUDE [azure-help-support](../../../includes/azure-help-support.md)]
