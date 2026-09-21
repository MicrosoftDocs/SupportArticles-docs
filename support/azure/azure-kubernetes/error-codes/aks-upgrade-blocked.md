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

For more detailed information about the upgrade process, see the "Upgrade an AKS cluster" section in [Upgrade options and recommendations for Azure Kubernetes Service (AKS) clusters](/azure/aks/upgrade-cluster#upgrade-an-aks-cluster).

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

## Troubleshooting flow

Confirm the current and target versions and support plans. Record the returned error code and whether the failed request used `--control-plane-only`. For every cluster, first [collect cluster details and verify target availability](#collect-cluster-details-and-verify-target-availability). Use the following flow to troubleshoot an upgrade that is already blocked. Check support status against the applicable support plan, not just the version number.

:::image type="content" source="media/aks-upgrade-blocked/upgrade-troubleshooting-flow.png" alt-text="Flowchart starting with target and current version support, then minor-version distance and LTS status. The control-plane-only decision branches to the right. The decisions and outcomes are described in the following table." lightbox="media/aks-upgrade-blocked/upgrade-troubleshooting-flow.png":::

| Decision | Action |
| --- | --- |
| Is the target version supported? | **No:** Upgrading to a target outside the supported list isn't allowed. **Yes:** Check whether the current version is still supported. |
| Is the current version still supported? | **No:** For non-LTS recovery to community support, use the **oldest supported GA target offered by AKS**, or consider an eligible supported LTS target. For unsupported LTS, use an eligible supported LTS target. See [Recovery from unsupported versions](#recovery-from-unsupported-versions). **Yes:** Check the minor-version distance. |
| Is the target more than 1 minor version ahead? | **No:** Check whether the request is control-plane-only. **Yes:** Check whether the current AKS cluster has LTS enabled. |
| Is this an upgrade for the control plane only? | **Yes:** Check whether the target control plane is **more than 3 minor versions ahead** of any pool, applying the [version-specific skew guidance](#check-node-pool-skew-for-control-plane-only-upgrades). **No:** Ask Azure support for further analysis of the blocked upgrade. |
| Does the current AKS cluster have LTS enabled? | **Yes:** Ask Azure support for further troubleshooting of the blocked upgrade. **No:** For a community-supported version, upgrade to the next minor version. See [Supported community upgrades](#supported-community-upgrades). |

A supported target must also be available and offered for this cluster; support status alone doesn't make the path eligible. LTS-to-LTS minor-version skips can be allowed, so the support branch is for an unexplained blocked request, not a requirement to contact support before every LTS upgrade. Follow [If the upgrade remains blocked](#if-the-upgrade-remains-blocked) to provide the diagnostic details.

The oldest-supported-community-target rule applies to non-LTS recovery; an eligible LTS target isn't necessarily the oldest supported LTS version. Recovery from an unsupported version remains outside support. Being exactly three minor versions ahead isn't itself a violation when the applicable policy allows that skew.

## Troubleshooting and resolution

### Collect cluster details and verify target availability

Check the cluster's region, support plan, and the configured and current versions of the control plane and every node pool. `ConfiguredVersion` is the version recorded on the resource; it isn't necessarily the target of the failed request. Obtain that attempted target from the original command or error message.

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

Compare the current version and attempted target with the [AKS Kubernetes release calendar](https://learn.microsoft.com/azure/aks/supported-kubernetes-versions#aks-kubernetes-release-calendar-and-upcoming-versions), using the LTS calendar for an LTS support plan. Then check the upgrade targets offered for this cluster:

```azurecli
az aks get-upgrades --resource-group <RG> --name <ClusterName> --output table
```

The `get-upgrades` table summarizes the control plane upgrade profile, not the versions of every node pool. Regional availability alone doesn't establish that a specific upgrade path is allowed. Conversely, a version missing from `get-upgrades` isn't, by itself, proof that it is deprecated in the region.

If the attempted target fails any of these checks, don't retry that target. Use the following scenario guidance to choose an eligible target. If the checks and applicable path don't explain the rejection, follow [If the upgrade remains blocked](#if-the-upgrade-remains-blocked).

### Select the upgrade path for your scenario

Use the cluster state and offered targets collected above to select the applicable path. For a control-plane-only request, also complete the [node-pool skew checks](#check-node-pool-skew-for-control-plane-only-upgrades) before retrying. Unsupported non-LTS recovery requires a full-cluster upgrade.

#### Supported community upgrades

For a supported non-LTS cluster, upgrade one minor version at a time. If an offered target is one minor version newer than the current version, upgrade to that target, confirm completion, and rerun `get-upgrades` before the next step. Repeat until you reach the desired supported version. Don't request a version older than the current version or skip minor versions on a supported non-LTS cluster.

#### Supported LTS upgrades

Minor-version skips to a higher LTS version can be allowed if the target is offered and satisfies skew and validation checks. LTS enrollment alone doesn't make every skip eligible. Apply the [AKS version support policy](https://learn.microsoft.com/azure/aks/supported-kubernetes-versions#can-i-skip-multiple-aks-versions-during-a-cluster-upgrade). If an apparently eligible path is rejected, collect the error and follow the support guidance below.

#### Recovery from unsupported versions

Choose a recovery path based on the current and intended support plans:

- **Unsupported non-LTS to community support:** Select the oldest supported generally available (GA) target returned by `get-upgrades`, and request a full-cluster upgrade rather than `--control-plane-only`. Don't choose an arbitrary newer target or an unavailable historical intermediate version. After recovery, follow the one-minor-at-a-time rule for subsequent community upgrades.
- **Unsupported non-LTS to LTS:** Use an offered, eligible supported LTS target and a full-cluster upgrade with explicit LTS enrollment, as described in the LTS recovery route below.
- **Unsupported LTS to supported LTS:** Select a supported LTS target offered by AKS and satisfy the applicable validation checks. This is still an unsupported recovery path.

For the LTS recovery route:

1. Check the [supported LTS versions](https://learn.microsoft.com/azure/aks/supported-kubernetes-versions#lts-versions) and select an eligible target offered for your cluster. Request a full-cluster upgrade to it with `--tier premium --k8s-support-plan AKSLongTermSupport`. LTS requires both the Premium tier and explicit support-plan selection; choosing an LTS-compatible version alone doesn't enable it. See [Enable long-term support](https://learn.microsoft.com/azure/aks/long-term-support#enable-long-term-support).
1. After recovery, you can upgrade one minor version at a time through supported LTS versions **if each next target is offered**. Check availability and completion at every step. LTS doesn't guarantee that every intermediate version is available.
1. Once the control plane and pools reach the desired version, verify that it is still in community support before [disabling LTS](https://learn.microsoft.com/azure/aks/long-term-support#disable-long-term-support-on-an-existing-cluster) by selecting the Free or Standard tier and the `KubernetesOfficial` support plan.

Recovery from an unsupported version is outside support and isn't guaranteed to be safe. If AKS offers no eligible recovery target, create a new cluster on a supported version and migrate your workloads. Also consider migration when the recovery risk is unacceptable. Back up and validate data and test workloads before migration.

#### Perform a full-cluster upgrade

Review breaking changes, back up important data, and test workload compatibility before proceeding. For a full-cluster request, use the following command with the target selected for your scenario. When enabling LTS as part of recovery, also include the tier and support-plan flags described above. AKS upgrades the control plane first and then the node pools sequentially; all validation checks still apply.

```azurecli
az aks upgrade --resource-group <RG> --name <ClusterName> --kubernetes-version <AvailableUpgradeVersion>
```

After each upgrade, [confirm completion](#confirm-the-upgrade-result) before starting another upgrade.

### Check node-pool skew for control-plane-only upgrades

Use the current control plane version, upgrade channel, and per-pool results from the shared diagnostic commands above.

Compare each pool's current version with the intended control plane target. For control plane version 1.N starting with Kubernetes 1.28, pool minor versions must be between N-3 and N, inclusive. Node pools can't be newer than the control plane. For older versions, check the applicable [version-skew policy](https://kubernetes.io/releases/version-skew-policy/).

If a pool would be too many minor versions behind the target, first [upgrade the node pool](https://learn.microsoft.com/azure/aks/upgrade-aks-node-pools-rolling) to an offered version compatible with the **current** control plane. Confirm that the pool upgrade completed before retrying the control plane upgrade. If no eligible sequence is available, use the [recovery or migration guidance](#recovery-from-unsupported-versions) instead of trying to bypass the skew check.

If a pool is newer than the attempted control plane target, recheck the recorded versions and select an eligible target that isn't older than the current control plane or any pool. Don't try to correct this mismatch by upgrading the pool further or requesting a control plane downgrade.

When the target is offered and all pools meet the applicable skew requirements, you can request a control-plane-only upgrade. This mode isn't supported for unsupported non-LTS recovery or when cluster autoupgrade is enabled; use the full-cluster path instead.

```azurecli
az aks upgrade --resource-group <RG> --name <ClusterName> --kubernetes-version <AvailableUpgradeVersion> --control-plane-only
```

If every pool is within the applicable window but the upgrade is still rejected, retain the target version, request mode, and per-pool results and follow [If the upgrade remains blocked](#if-the-upgrade-remains-blocked). Meeting the skew rule doesn't bypass other upgrade validations.

### Confirm the upgrade result

After each upgrade, rerun the shared cluster and node-pool inspection commands. Confirm that the control plane and each pool included in the upgrade report the intended current version and a `Succeeded` provisioning state. If an operation failed, record its returned error and troubleshoot that error before retrying; a configured version alone doesn't confirm completion. These checks confirm the upgrade result, not workload health. Validate your workloads separately.

### If the upgrade remains blocked

If the preceding checks don't explain the version-policy rejection, [create an Azure support request](https://learn.microsoft.com/azure/azure-portal/supportability/how-to-create-azure-support-request). Include the error code and full message, failure time, operation or correlation ID if available, region, current and requested versions, support plan, request mode, and results of the cluster, node-pool, and offered-target checks. Submit these details through the support request rather than a public issue.

Azure support can help investigate an unexplained rejection, but contacting support doesn't guarantee an upgrade exception or make unsupported recovery supported. If no eligible recovery path exists or its risk is unacceptable, use the [migration guidance](#recovery-from-unsupported-versions).

### Additional tips

- If cluster autoupgrade is enabled, control-plane-only upgrades aren't supported. See the [cluster autoupgrade control-plane upgrade constraints](https://learn.microsoft.com/azure/aks/auto-upgrade-cluster#control-plane-upgrade-constraints).

- If you use the managed Istio add-on, check [revision compatibility with the target Kubernetes version and support plan](https://learn.microsoft.com/azure/aks/istio-support-policy#aks-compatibility), and follow the [Istio upgrade guidance](https://learn.microsoft.com/azure/aks/istio-upgrade#minor-revision-upgrade) for the required upgrade order.
