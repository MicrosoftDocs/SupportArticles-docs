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

For the upgrade procedure, see [Upgrade the full AKS cluster](/azure/aks/upgrade-aks-control-plane#upgrade-the-full-aks-cluster).

## Symptoms

When you try to upgrade an AKS cluster by using the Azure CLI, the upgrade operation is blocked and returns one or more of the following error messages.

**Error message 1: K8sVersionNotSupported**

> `<ClusterName>` is on version 1.25.6 which is not supported in this region. Please use the `[az aks get-versions]` command to get the supported version list in this region. For more information, see [Supported Kubernetes versions in Azure Kubernetes Service (AKS)](https://aka.ms/supported-version-list).

**Error message 2: OperationNotAllowed**

> Upgrading Kubernetes version 1.24.9 to 1.26.6 is not allowed. Available upgrades: [1.29.15 1.29.14 1.29.13 1.29.12 1.29.11 1.29.10 1.29.9 1.29.8 1.29.7 1.29.6 1.29.5 1.29.4 1.29.2 1.29.0]. For more information, see [AKS supported Kubernetes versions](https://aka.ms/aks-supported-k8s-ver) for version details.

**Error message 3: NodePoolMcVersionIncompatible**

> Node pool version 1.24.9 and control plane version 1.29.15 is incompatible. Minor version of node pool cannot be more than 3 versions less than control plane's version. Minor version of node pool is 24 and control plane is 29. For more information, see [AKS upgrade version skew policy](https://aka.ms/aks/UpgradeVersionRules).

The version numbers in these messages are historical examples, not recommended upgrade targets. Use the targets currently offered for your cluster. For current guidance, see the [AKS version support policy](/azure/aks/supported-kubernetes-versions#can-i-skip-multiple-aks-versions-during-a-cluster-upgrade) and [Kubernetes version upgrade rules](/azure/aks/upgrade-aks-control-plane#kubernetes-version-upgrade-rules).

## Cause

The upgrade isn't allowed for one or more of the following reasons:

- The target Kubernetes version is unavailable in the selected Azure region or is no longer supported for the cluster's support plan.

- The requested upgrade path isn't allowed for the cluster's support plan. Supported non-LTS clusters must upgrade one minor version at a time. LTS clusters can skip minor versions to a higher LTS target offered by AKS if version-skew requirements and validation checks are satisfied. Upgrades from unsupported versions follow the conditional recovery paths in the [AKS version support policy](/azure/aks/supported-kubernetes-versions#can-i-skip-multiple-aks-versions-during-a-cluster-upgrade).

- A node pool version is incompatible with the control plane version. Node pools can't be newer than the control plane. Starting with Kubernetes 1.28, AKS allows the control plane to be up to three minor versions ahead of node pools. Check the applicable [version-skew policy](https://kubernetes.io/releases/version-skew-policy/) for older versions and compare every pool with the intended control plane version.

## Solution

### Step 1: Verify the current version and available upgrade paths

Record the returned error code, requested target version, and whether the request used `--control-plane-only`. Inspect the cluster's support plan and the versions and provisioning states of the control plane and every node pool:

```azurecli
az aks show --resource-group <RG> --name <ClusterName> --query "{RequestedVersion:kubernetesVersion,CurrentVersion:currentKubernetesVersion,State:provisioningState,SupportPlan:supportPlan,Tier:sku.tier,UpgradeChannel:autoUpgradeProfile.upgradeChannel}" --output json

az aks nodepool list --resource-group <RG> --cluster-name <ClusterName> --query "[].{Name:name,RequestedVersion:orchestratorVersion,CurrentVersion:currentOrchestratorVersion,State:provisioningState}" --output table
```

To identify offered upgrade targets, run the following command. Its table output summarizes the control plane upgrade profile, not the versions of every node pool.

```azurecli
az aks get-upgrades --resource-group <RG> --name <ClusterName> --output table
```

Use the following command to inspect regional version availability, and check the [AKS Kubernetes release calendar](/azure/aks/supported-kubernetes-versions#aks-kubernetes-release-calendar-and-upcoming-versions) for support status. A version missing from `get-upgrades` isn't, by itself, proof that it is deprecated in the region.

```azurecli
az aks get-versions --location <region> --output table
```

### Step 2: Choose an eligible upgrade path

Use an upgrade target returned for your cluster by `az aks get-upgrades`, and apply the support-plan rules in the [AKS version support policy](/azure/aks/supported-kubernetes-versions#can-i-skip-multiple-aks-versions-during-a-cluster-upgrade). For an unsupported non-LTS cluster with an eligible recovery target, use a full-cluster upgrade rather than `--control-plane-only`.

The following command requests a full-cluster upgrade. AKS upgrades the control plane first and then the node pools sequentially; the operation remains subject to validation checks. An upgrade from an unsupported version is an unsupported recovery path and isn't guaranteed to be safe. Review breaking changes, back up important data, and test workload compatibility before proceeding.

```azurecli
az aks upgrade --resource-group <RG> --name <ClusterName> --kubernetes-version <AvailableUpgradeVersion>
```

If the cluster is unsupported and AKS offers no eligible target, create a new cluster on a supported version and migrate your workloads. Also consider migration when the recovery risk is unacceptable. Back up and validate data and test workloads before migration.

### Step 3: Confirm the upgrade result

Rerun the cluster and node-pool inspection commands from Step 1. Confirm that the control plane and each pool included in the upgrade report the intended current version and a `Succeeded` provisioning state. If an operation failed, record its returned error and troubleshoot that error before retrying; a requested version alone doesn't confirm completion. These checks confirm the upgrade result, not workload health. Validate your workloads separately.

### Additional tips

- Choose a target offered for your cluster and check its support status in the [AKS Kubernetes release calendar](/azure/aks/supported-kubernetes-versions#aks-kubernetes-release-calendar-and-upcoming-versions). LTS requires the Premium tier and the `AKSLongTermSupport` support plan; upgrading to an LTS-compatible version alone doesn't enable LTS. See [Enable long-term support](/azure/aks/long-term-support#enable-long-term-support).

- If cluster autoupgrade is enabled, control-plane-only upgrades aren't supported. See the [cluster autoupgrade control-plane upgrade constraints](/azure/aks/auto-upgrade-cluster#control-plane-upgrade-constraints).

- If you use the managed Istio add-on, check [revision compatibility with the target Kubernetes version and support plan](/azure/aks/istio-support-policy#aks-compatibility), and follow the [Istio upgrade guidance](/azure/aks/istio-upgrade#minor-revision-upgrade) for the required upgrade order.
