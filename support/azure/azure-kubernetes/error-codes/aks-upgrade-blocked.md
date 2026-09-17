---
title: Troubleshoot AKS upgrade errors because of version skew, incompatibility, or lack of support
description: Learn how to troubleshoot AKS upgrade errors caused by unsupported Kubernetes versions or node pool skew, and follow steps to upgrade successfully.
ms.date: 08/22/2025
editor: v-jsitser
ms.reviewer: v-liuamson
ms.service: azure-kubernetes-service
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot an AKS upgrade not allowed or blocked because of an unsupported Kubernetes version or node pool version skew so that I can successfully upgrade an AKS cluster by using the Azure CLI.
---
# Troubleshoot AKS upgrade errors because of version skew, incompatibility, or lack of support

## Summary

This article explains how to troubleshoot AKS upgrade errors that occur due to version skew, incompatibility, or lack of support. It provides guidance on identifying the cause of the error and steps to resolve it.

## Prerequisites

This article requires Azure CLI version 2.67.0 or a later version. To find the version number, run `az --version`. If you have to install or upgrade the Azure CLI, see [How to install the Azure CLI](/cli/azure/install-azure-cli).

For more detailed information about the upgrade process, see the "Upgrade an AKS cluster" section in [Upgrade options and recommendations for Azure Kubernetes Service (AKS) clusters](https://learn.microsoft.com/azure/aks/upgrade-aks-control-plane#upgrade-the-full-aks-cluster).

## Symptoms

When you try to upgrade an AKS cluster by using the Azure CLI, the upgrade operation is blocked and returns one or more of the following error messages.

**Error message 1: K8sVersionNotSupported**

> `<ClusterName>` is on version 1.25.6 which is not supported in this region. Please use the `[az aks get-versions]` command to get the supported version list in this region. For more information, see [Supported Kubernetes versions in Azure Kubernetes Service (AKS)](https://aka.ms/supported-version-list).

**Error message 2: OperationNotAllowed**

> Upgrading Kubernetes version 1.24.9 to 1.26.6 is not allowed. Available upgrades: [1.29.15 1.29.14 1.29.13 1.29.12 1.29.11 1.29.10 1.29.9 1.29.8 1.29.7 1.29.6 1.29.5 1.29.4 1.29.2 1.29.0]. For more information, see [AKS supported Kubernetes versions](https://aka.ms/aks-supported-k8s-ver) for version details.

**Error message 3: NodePoolMcVersionIncompatible**

> Node pool version 1.24.9 and control plane version 1.29.15 is incompatible. Minor version of node pool cannot be more than 3 versions less than control plane's version. Minor version of node pool is 24 and control plane is 29. For more information, see [AKS upgrade version skew policy](https://aka.ms/aks/UpgradeVersionRules).

The version numbers in these messages are historical examples, not recommended upgrade targets. Use the targets currently offered for your cluster. For current guidance, see the [AKS version support policy](https://learn.microsoft.com/azure/aks/supported-kubernetes-versions#can-i-skip-multiple-aks-versions-during-a-cluster-upgrade) and [Kubernetes version upgrade rules](https://learn.microsoft.com/azure/aks/upgrade-aks-control-plane#kubernetes-version-upgrade-rules).

## Cause

The upgrade isn't allowed for one or more of the following reasons:

- The target Kubernetes version is unavailable in the selected Azure region or is no longer supported for the cluster's support plan.

- The requested upgrade path isn't allowed for the cluster's support plan. Supported non-LTS clusters must upgrade one minor version at a time. LTS clusters can skip minor versions to a higher LTS target offered by AKS if version-skew requirements and validation checks are satisfied. Upgrades from unsupported versions follow the conditional recovery paths in the [AKS version support policy](https://learn.microsoft.com/azure/aks/supported-kubernetes-versions#can-i-skip-multiple-aks-versions-during-a-cluster-upgrade).

- A node pool version is incompatible with the control plane version. Node pools can't be newer than the control plane. Starting with Kubernetes 1.28, AKS allows the control plane to be up to three minor versions ahead of node pools. Check the applicable [version-skew policy](https://kubernetes.io/releases/version-skew-policy/) for older versions and compare every pool with the intended control plane version.

To understand more about these errors, refer to the following articles:

- [AKS supported Kubernetes versions](https://learn.microsoft.com/azure/aks/supported-kubernetes-versions)
- [AKS upgrade version skew policy](https://learn.microsoft.com/azure/aks/upgrade-aks-control-plane#kubernetes-version-upgrade-rules)

## Solution

Record the returned error code, requested target version, and whether the request used `--control-plane-only`. Use the solution that matches the cause.

### Solution 1: Choose a target available in the region and supported for the cluster

Check the cluster's region, current version, and support plan:

```azurecli
az aks show --resource-group <RG> --name <ClusterName> --query "{Location:location,RequestedVersion:kubernetesVersion,CurrentVersion:currentKubernetesVersion,State:provisioningState,SupportPlan:supportPlan,Tier:sku.tier,UpgradeChannel:autoUpgradeProfile.upgradeChannel}" --output json
```

Use that region to check version availability:

```azurecli
az aks get-versions --location <region> --output table
```

Compare the requested target with the returned versions and check the [AKS Kubernetes release calendar](https://learn.microsoft.com/azure/aks/supported-kubernetes-versions#aks-kubernetes-release-calendar-and-upcoming-versions) for its support status. If the target isn't available in the region or supported for the cluster's support plan, don't retry that target. Choose an available, supported target and use Solution 2 to verify the upgrade path for this cluster. Regional availability alone doesn't establish that a specific upgrade path is allowed.

### Solution 2: Follow an offered upgrade path

```azurecli
az aks get-upgrades --resource-group <RG> --name <ClusterName> --output table
```

Compare the offered targets with the current control plane version from Solution 1. The table output summarizes the control plane upgrade profile, not the versions of every node pool. A version missing from `get-upgrades` isn't, by itself, proof that it is deprecated in the region.

For a supported non-LTS cluster, upgrade one minor version at a time. If an offered target is one minor version newer than the current version, upgrade to that target, confirm completion, and rerun `get-upgrades` before the next step. Repeat until you reach the desired supported version. Don't request a version older than the current version or skip minor versions on a supported non-LTS cluster.

For LTS clusters or clusters already outside support, apply the conditional paths in the [AKS version support policy](https://learn.microsoft.com/azure/aks/supported-kubernetes-versions#can-i-skip-multiple-aks-versions-during-a-cluster-upgrade). For an unsupported non-LTS cluster with an eligible recovery target, use a full-cluster upgrade rather than `--control-plane-only`. See the LTS recovery tip below if you want to continue through supported LTS versions.

Review breaking changes, back up important data, and test workload compatibility before proceeding. The following command requests a full-cluster upgrade. AKS upgrades the control plane first and then the node pools sequentially; all validation checks still apply. Recovery from an unsupported version is outside support and isn't guaranteed to be safe.

```azurecli
az aks upgrade --resource-group <RG> --name <ClusterName> --kubernetes-version <AvailableUpgradeVersion>
```

If the cluster is unsupported and AKS offers no eligible target, create a new cluster on a supported version and migrate your workloads. Also consider migration when the recovery risk is unacceptable. Back up and validate data and test workloads before migration.

### Solution 3: Check node pool skew before a control-plane-only upgrade

Check the current control plane version and upgrade channel by using the command in Solution 1. Then inspect every node pool:

```azurecli
az aks nodepool list --resource-group <RG> --cluster-name <ClusterName> --query "[].{Name:name,RequestedVersion:orchestratorVersion,CurrentVersion:currentOrchestratorVersion,State:provisioningState}" --output table
```

Compare each pool's current version with the intended control plane target. For control plane version 1.N starting with Kubernetes 1.28, pool minor versions must be between N-3 and N, inclusive. Node pools can't be newer than the control plane. For older versions, check the applicable [version-skew policy](https://kubernetes.io/releases/version-skew-policy/).

If a pool would fall outside the applicable skew window, first [upgrade the node pool](https://learn.microsoft.com/azure/aks/upgrade-aks-node-pools-rolling) to an offered version compatible with the **current** control plane. Confirm that the pool upgrade completed before retrying the control plane upgrade. If no eligible sequence is available, use the recovery or migration guidance in Solution 2 instead of trying to bypass the skew check.

When the target is offered and all pools meet the applicable skew requirements, you can request a control-plane-only upgrade. This mode isn't supported for unsupported non-LTS recovery or when cluster autoupgrade is enabled; use the full-cluster path instead.

```azurecli
az aks upgrade --resource-group <RG> --name <ClusterName> --kubernetes-version <AvailableUpgradeVersion> --control-plane-only
```

### Confirm the upgrade result

After each upgrade, rerun the cluster inspection command in Solution 1 and the node-pool inspection command in Solution 3. Confirm that the control plane and each pool included in the upgrade report the intended current version and a `Succeeded` provisioning state. If an operation failed, record its returned error and troubleshoot that error before retrying; a requested version alone doesn't confirm completion. These checks confirm the upgrade result, not workload health. Validate your workloads separately.

### Additional tips

- Choose a target offered for your cluster and check its support status in the [AKS Kubernetes release calendar](https://learn.microsoft.com/azure/aks/supported-kubernetes-versions#aks-kubernetes-release-calendar-and-upcoming-versions). LTS requires the Premium tier and the `AKSLongTermSupport` support plan; upgrading to an LTS-compatible version alone doesn't enable LTS. See [Enable long-term support](https://learn.microsoft.com/azure/aks/long-term-support#enable-long-term-support).

- **Consider LTS for recovery followed by sequential upgrades:** If the current community version is unsupported, check the [supported LTS versions](https://learn.microsoft.com/azure/aks/supported-kubernetes-versions#lts-versions) and the targets offered for your cluster. If an eligible LTS recovery target is available, request a full-cluster upgrade to it with `--tier premium --k8s-support-plan AKSLongTermSupport`. This initial recovery remains outside support and subject to validation. After completion, you can upgrade one minor version at a time through supported LTS versions **if each next target is offered**, checking availability and completion at every step. LTS doesn't guarantee that every intermediate version is available. Once the control plane and pools reach the desired version, verify that it is still in community support before [disabling LTS](https://learn.microsoft.com/azure/aks/long-term-support#disable-long-term-support-on-an-existing-cluster) by selecting the Free or Standard tier and the `KubernetesOfficial` support plan.

- If cluster autoupgrade is enabled, control-plane-only upgrades aren't supported. See the [cluster autoupgrade control-plane upgrade constraints](https://learn.microsoft.com/azure/aks/auto-upgrade-cluster#control-plane-upgrade-constraints).

- If you use the managed Istio add-on, check [revision compatibility with the target Kubernetes version and support plan](https://learn.microsoft.com/azure/aks/istio-support-policy#aks-compatibility), and follow the [Istio upgrade guidance](https://learn.microsoft.com/azure/aks/istio-upgrade#minor-revision-upgrade) for the required upgrade order.
