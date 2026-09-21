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

Use this guide when an AKS upgrade fails because of an unsupported Kubernetes version, a disallowed upgrade path, or node-pool version skew.

## Prerequisites

This article requires Azure CLI version 2.67.0 or a later version. To find the version number, run `az --version`. If you have to install or upgrade the Azure CLI, see [How to install the Azure CLI](/cli/azure/install-azure-cli).

For more detailed information about the upgrade process, see the "Upgrade an AKS cluster" section in [Upgrade options and recommendations for Azure Kubernetes Service (AKS) clusters](/azure/aks/upgrade-cluster#upgrade-an-aks-cluster).

## Symptoms

The upgrade fails with one or more of these errors:

**Error message 1: K8sVersionNotSupported**

> `<ClusterName>` is on version 1.25.6 which is not supported in this region. Please use the `[az aks get-versions]` command to get the supported version list in this region. For more information, see [Supported Kubernetes versions in Azure Kubernetes Service (AKS)](https://aka.ms/supported-version-list).

**Error message 2: OperationNotAllowed**

> Upgrading Kubernetes version 1.24.9 to 1.26.6 is not allowed. Available upgrades: [1.29.15 1.29.14 1.29.13 1.29.12 1.29.11 1.29.10 1.29.9 1.29.8 1.29.7 1.29.6 1.29.5 1.29.4 1.29.2 1.29.0]. For more information, see [AKS supported Kubernetes versions](https://aka.ms/aks-supported-k8s-ver) for version details.

**Error message 3: NodePoolMcVersionIncompatible**

> Node pool version 1.24.9 and control plane version 1.29.15 is incompatible. Minor version of node pool cannot be more than 3 versions less than control plane's version. Minor version of node pool is 24 and control plane is 29. For more information, see [AKS upgrade version skew policy](https://aka.ms/aks/UpgradeVersionRules).

The version numbers are historical examples, not upgrade targets. For current guidance, see the [AKS version support policy](https://learn.microsoft.com/azure/aks/supported-kubernetes-versions#can-i-skip-multiple-aks-versions-during-a-cluster-upgrade) and [Kubernetes version upgrade rules](https://learn.microsoft.com/azure/aks/upgrade-aks-control-plane#kubernetes-version-upgrade-rules).

## Cause

The upgrade isn't allowed for one or more of the following reasons:

- The target Kubernetes version is unavailable in the selected Azure region or is no longer supported for the cluster's support plan.

- The requested upgrade path isn't allowed for the support plan. See [Upgrade-path combinations](#upgrade-path-combinations).

- A node pool version is too far behind or newer than the target control plane version. See [Node-pool skew checks](#check-node-pool-skew-for-control-plane-only-upgrades).

See also:

- [AKS supported Kubernetes versions](https://learn.microsoft.com/azure/aks/supported-kubernetes-versions)
- [AKS upgrade version skew policy](https://learn.microsoft.com/azure/aks/upgrade-aks-control-plane#kubernetes-version-upgrade-rules)

## Troubleshooting flow

Record the error, target version, support plan, and whether the request used `--control-plane-only`. Start with the [version and support checks](#collect-cluster-details-and-verify-target-availability).

:::image type="content" source="media/aks-upgrade-blocked/upgrade-troubleshooting-flow.png" alt-text="Flowchart for a blocked upgrade: check target and current version support, then minor-version distance and LTS status. The control-plane-only decision branches right to node-pool skew checks or Azure support. Recovery paths and escalation guidance follow below." lightbox="media/aks-upgrade-blocked/upgrade-troubleshooting-flow.png":::

### Upgrade-path combinations

Check the [AKS upgrade policy](https://learn.microsoft.com/azure/aks/supported-kubernetes-versions#can-i-skip-multiple-aks-versions-during-a-cluster-upgrade) for the current and target versions. Non-LTS (community) uses `KubernetesOfficial`; LTS uses `AKSLongTermSupport`. Check support status under the applicable plan.

| Current version | Target version | Upgrade |
| --- | --- | --- |
| Unsupported non-LTS | Supported LTS | Allowed |
| Unsupported LTS | Supported LTS | Allowed |
| Unsupported non-LTS | Lowest supported GA non-LTS version offered by AKS | Allowed |
| Supported LTS | Higher supported LTS | Allowed |
| Supported non-LTS | Next supported non-LTS minor version | Allowed |
| Supported non-LTS | Supported non-LTS more than one minor version ahead | Not allowed |
| Any current version | Unsupported target version | Not allowed |

**Conditions for "Allowed":** AKS must offer the target, and all skew and validation checks must pass. Unsupported non-LTS recovery requires a full-cluster upgrade. LTS requires Premium and explicit `AKSLongTermSupport` enrollment. **Unsupported recovery remains outside support and isn't guaranteed safe.**

For support-plan changes, see [LTS support-plan transitions](https://learn.microsoft.com/azure/aks/long-term-support). A plan change alone doesn't upgrade Kubernetes or make a version skip eligible.

## Troubleshooting and resolution

### Collect cluster details and verify target availability

Get the region, support plan, and control plane and pool versions. Use the failed command or error to identify the target; `ConfiguredVersion` is the resource setting, not necessarily the failed target.

```azurecli
az aks show --resource-group <RG> --name <ClusterName> --query "{Location:location,ConfiguredVersion:kubernetesVersion,CurrentVersion:currentKubernetesVersion,State:provisioningState,SupportPlan:supportPlan,Tier:sku.tier,UpgradeChannel:autoUpgradeProfile.upgradeChannel}" --output json
```

```azurecli
az aks nodepool list --resource-group <RG> --cluster-name <ClusterName> --query "[].{Name:name,ConfiguredVersion:orchestratorVersion,CurrentVersion:currentOrchestratorVersion,State:provisioningState}" --output table
```

Use that region to check version availability:

```azurecli
az aks get-versions --location <region> --output table
```

Check current and target support dates in the [AKS release calendar](https://learn.microsoft.com/azure/aks/supported-kubernetes-versions#aks-kubernetes-release-calendar-and-upcoming-versions), including the LTS calendar when applicable. List the cluster's offered targets:

```azurecli
az aks get-upgrades --resource-group <RG> --name <ClusterName> --output table
```

`get-upgrades` shows control plane targets, not every pool's version. A missing target doesn't prove regional deprecation. Check regional availability, support status, and cluster-offered targets separately.

If the target isn't available, supported, or offered, don't retry it. Choose an allowed path below.

### Select the upgrade path for your scenario

Choose a path from the [upgrade-path combinations](#upgrade-path-combinations). For control-plane-only requests, also [check node-pool skew](#check-node-pool-skew-for-control-plane-only-upgrades).

> [!IMPORTANT]
> A gapped upgrade skips one or more minor versions and can accumulate API removals and breaking changes. An allowed upgrade doesn't guarantee workload or add-on compatibility.

> [!NOTE]
> Before upgrading, read the [Kubernetes release notes](https://kubernetes.io/releases/notes/) for the target and intervening versions, [AKS release notes](https://github.com/Azure/AKS/releases), and [AKS compatibility checks](https://learn.microsoft.com/azure/aks/upgrade-options#validations-used-in-the-upgrade-process). Follow [AKS production upgrade guidance](https://learn.microsoft.com/azure/aks/aks-production-upgrade-strategies): test workloads and add-ons in nonproduction, back up data, and plan for disruption.

#### Supported community upgrades

Upgrade to the next offered minor version. [Confirm completion](#confirm-the-upgrade-result), rerun `get-upgrades`, and repeat until you reach the target. Don't skip minor versions or downgrade.

#### Supported LTS upgrades

For LTS benefits, including extended support, see [Long-term support for AKS versions](https://learn.microsoft.com/azure/aks/long-term-support).

Select a higher supported LTS target offered by AKS. Minor-version skips are allowed only if skew and validation checks pass. If an eligible upgrade remains blocked, [contact Azure support](#if-the-upgrade-remains-blocked).

#### Recovery from unsupported versions

For non-LTS to community recovery, select the **oldest supported GA target offered by AKS** and use a **full-cluster upgrade**. Then upgrade one minor version at a time.

For the LTS recovery route:

1. Choose an offered [supported LTS target](https://learn.microsoft.com/azure/aks/supported-kubernetes-versions#lts-versions). Run a full-cluster upgrade with `--tier premium --k8s-support-plan AKSLongTermSupport`. See [Enable long-term support](https://learn.microsoft.com/azure/aks/long-term-support#enable-long-term-support).
1. Continue through supported LTS versions one minor at a time **only if each next target is offered**. Confirm completion and rerun `get-upgrades` at each step.
1. When the control plane and pools reach the desired **community-supported** version, [disable LTS](https://learn.microsoft.com/azure/aks/long-term-support#disable-long-term-support-on-an-existing-cluster) with Free or Standard and `KubernetesOfficial`.

If no eligible recovery target is offered or the risk is unacceptable, migrate to a new cluster on a supported version. Back up and validate data, and test workloads before migration.

#### Perform a full-cluster upgrade

Run a full-cluster upgrade with the selected target. For LTS recovery, include the tier and support-plan flags above. AKS upgrades the control plane, then the pools sequentially; all validation checks still apply.

```azurecli
az aks upgrade --resource-group <RG> --name <ClusterName> --kubernetes-version <AvailableUpgradeVersion>
```

[Confirm completion](#confirm-the-upgrade-result) before the next upgrade.

### Check node-pool skew for control-plane-only upgrades

For unsupported non-LTS recovery or cluster autoupgrade, use a [full-cluster upgrade](#perform-a-full-cluster-upgrade), not control-plane-only. Otherwise, compare each pool's **current** version with the control plane **target**.

For control plane version 1.N starting with Kubernetes 1.28, pool minor versions must be between **N-3 and N, inclusive**. Pools can't be newer than the control plane. For older versions, check the applicable [version-skew policy](https://kubernetes.io/releases/version-skew-policy/).

- **Pool too old:** [Upgrade the pool](https://learn.microsoft.com/azure/aks/upgrade-aks-node-pools-rolling) to an offered version compatible with the **current** control plane. Confirm completion before retrying the control plane upgrade.

- **Pool newer than the target:** Recheck the versions. Select an offered target that isn't older than the current control plane or any pool. Don't upgrade the pool further or downgrade the control plane.

If no eligible sequence exists, use the [recovery or migration guidance](#recovery-from-unsupported-versions). Otherwise, retry with an offered target after every pool meets the skew requirements:

```azurecli
az aks upgrade --resource-group <RG> --name <ClusterName> --kubernetes-version <AvailableUpgradeVersion> --control-plane-only
```

Other upgrade checks still apply. If the request is rejected, follow [If the upgrade remains blocked](#if-the-upgrade-remains-blocked).

### Confirm the upgrade result

Rerun the cluster and node-pool commands. For the control plane and each upgraded pool, verify that `CurrentVersion` matches the target and `State` is `Succeeded`. Don't use `ConfiguredVersion` alone to confirm completion.

If an upgrade failed, troubleshoot the returned error before retrying. Check workload health separately.

### If the upgrade remains blocked

[Create an Azure support request](https://learn.microsoft.com/azure/azure-portal/supportability/how-to-create-azure-support-request) if the checks don't explain the failure. Include the error code and message, failure time, operation or correlation ID, region, current and target versions, support plan, request mode, and diagnostic output. Submit these details privately, not in a public issue.

Contacting support doesn't guarantee an upgrade exception or make unsupported recovery supported.

### Additional tips

- If cluster autoupgrade is enabled, use a full-cluster upgrade. See [autoupgrade restrictions](https://learn.microsoft.com/azure/aks/auto-upgrade-cluster#control-plane-upgrade-constraints).

- If you use the managed Istio add-on, check [revision compatibility](https://learn.microsoft.com/azure/aks/istio-support-policy#aks-compatibility) with the target version and support plan, then follow the [required upgrade order](https://learn.microsoft.com/azure/aks/istio-upgrade#minor-revision-upgrade).
