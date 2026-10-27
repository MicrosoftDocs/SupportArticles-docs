---
title: Troubleshoot cluster-level FIPS errors in AKS (preview)
description: Resolve errors when you enable or use cluster-level FIPS on an AKS cluster. Learn how to diagnose each cause and apply the fix to restore compliance.
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: gaojing, shasb
ms.service: azure-kubernetes-service
ms.topic: troubleshooting
ms.date: 10/27/2026
ms.custom: sap:Identity and Security Management
ai-usage: ai-assisted
#customer intent: As an AKS cluster administrator, I want to resolve errors when I enable or use cluster-level FIPS so that my cluster meets Federal Information Processing Standards (FIPS) compliance requirements.
---

# Troubleshoot cluster-level FIPS errors in Azure Kubernetes Service (preview)

[!INCLUDE [preview features callout](~/reusable-content/ce-skilling/azure/includes/aks/includes/preview/preview-callout.md)]

## Summary

This article helps you resolve errors that occur when you enable cluster-level Federal Information Processing Standards (FIPS) on an Azure Kubernetes Service (AKS) cluster, or when you change a cluster that already has cluster-level FIPS enabled.

When you enable cluster-level FIPS (the `enableFIPS` property of the managed cluster), AKS enforces the following rules:

- Every node pool in the cluster must have FIPS enabled.
- The cluster must run a supported Kubernetes version.
- You can't enable or install components and cluster extensions that aren't FIPS-compliant.

AKS checks these rules on every create or update operation while cluster-level FIPS is enabled, not only when you enable FIPS. AKS rejects any operation that breaks one of these rules and returns an error message that names the cause. Most errors include a link to `https://aka.ms/aks/ClusterFips`.

For more information about the feature, see [Enable FIPS for AKS clusters (preview)](/azure/aks/enable-fips-cluster). For FIPS on individual node pools, see [Enable FIPS for AKS node pools](/azure/aks/enable-fips-nodes).

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli) version 2.86.0 or later. To check your version, run `az --version`.
- The latest version of the `aks-preview` Azure CLI extension. The `--enable-fips` and `--disable-fips` parameters are available only in this extension.

  ```azurecli
  az extension add --upgrade --name aks-preview
  ```

- The `k8s-extension` Azure CLI extension, which you use to list and remove cluster extensions.

  ```azurecli
  az extension add --upgrade --name k8s-extension
  ```

- The `EnableFIPSPreview` feature flag registered in your subscription. For more information, see [Issue 9: The preview feature isn't registered](#issue-9-the-preview-feature-isnt-registered).

The commands in this article use the following environment variables. Replace the placeholder values, and then run the commands in your shell:

```bash
export RESOURCE_GROUP="<resource-group-name>"
export CLUSTER_NAME="<cluster-name>"
export NODE_POOL_NAME="<node-pool-name>"
```

## Check the cluster FIPS state

Before you troubleshoot an error, check the current FIPS state of the cluster, its node pools, and its extensions.

1. Check whether cluster-level FIPS is enabled and which Kubernetes version the cluster runs:

   ```azurecli
   az aks show \
       --resource-group $RESOURCE_GROUP \
       --name $CLUSTER_NAME \
       --query "{enableFips:enableFips, kubernetesVersion:kubernetesVersion}" \
       --output table
   ```

   If `enableFips` is `True`, cluster-level FIPS is enabled. If the value is `False`, cluster-level FIPS isn't enabled. If the value is empty, ensure that the `aks-preview` extension is installed, and then run the command again. Without the extension, Azure CLI doesn't return the cluster-level `enableFips` property.

1. Check whether FIPS is enabled on each node pool:

   ```azurecli
   az aks show \
       --resource-group $RESOURCE_GROUP \
       --name $CLUSTER_NAME \
       --query "agentPoolProfiles[].{Name:name, enableFips:enableFips, osType:osType, osSku:osSku}" \
       --output table
   ```

1. List the cluster extensions and their provisioning state:

   ```azurecli
   az k8s-extension list \
       --resource-group $RESOURCE_GROUP \
       --cluster-name $CLUSTER_NAME \
       --cluster-type managedClusters \
       --query "[].{name:name, extensionType:extensionType, state:provisioningState}" \
       --output table
   ```

## Common issues and solutions

Use the following table to find the issue that matches the error message or symptom that you see.

| Error message contains or symptom | Issue |
| --- | --- |
| `is not supported on clusters where .properties.enableFIPS is set to true` | [Issue 1](#issue-1-a-component-isnt-supported-on-a-fips-enabled-cluster) |
| `Kubernetes extension '<extension-name>' is not supported on clusters where .properties.enableFIPS is set to true`, or an extension shows a `Failed` provisioning state on a FIPS-enabled cluster | [Issue 1](#issue-1-a-component-isnt-supported-on-a-fips-enabled-cluster) |
| `Cannot enable cluster-level FIPS because an incompatible component is enabled` | [Issue 2](#issue-2-an-incompatible-component-blocks-cluster-level-fips) |
| `Cannot set .properties.enableFIPS to true at the managed cluster scope because extension` | [Issue 3](#issue-3-a-cluster-extension-isnt-fips-compliant) |
| `All node pools in a FIPS-enabled cluster must also have FIPS enabled`, or a similar node pool message | [Issue 4](#issue-4-a-node-pool-doesnt-have-fips-enabled) |
| `FIPS cannot be enabled on a managed cluster that contains Kata workload-runtime node pools` | [Issue 5](#issue-5-the-cluster-contains-kata-node-pools) |
| `are below the minimum required revision asm-1-26 for enabling FIPS` | [Issue 6](#issue-6-the-istio-revision-is-earlier-than-asm-1-26) |
| `the cluster must be running Kubernetes version 1.35.0 or later`, even for an unrelated update such as a tag change, or `--enable-fips requires Kubernetes version` | [Issue 7](#issue-7-the-kubernetes-version-isnt-supported) |
| You created the cluster by using `--enable-fips`, but `enableFips` isn't `true` | [Issue 8](#issue-8-cluster-level-fips-isnt-enabled-after-you-create-the-cluster) |
| `Preview feature Microsoft.ContainerService/EnableFIPSPreview not registered` | [Issue 9](#issue-9-the-preview-feature-isnt-registered) |
| Node pools still have FIPS enabled after you disable cluster-level FIPS, or `FIPS cannot be disabled in Windows` | [Issue 10](#issue-10-node-pools-still-have-fips-enabled-after-you-disable-cluster-level-fips) |
| `has .properties.enableCustomCATrust set to true` | [Issue 11](#issue-11-a-node-pool-uses-node-pool-level-custom-ca-trust) |
| Azure Monitor resources, such as data collection rules whose names start with `MSProm-` or `MSCI-`, remain after AKS rejects an Azure Monitor feature | [Issue 12](#issue-12-azure-monitor-resources-remain-after-aks-rejects-an-azure-monitor-feature) |

### Issue 1: A component isn't supported on a FIPS-enabled cluster

**Error message contains:**

```output
is not supported on clusters where .properties.enableFIPS is set to true at the managed cluster scope.
```

The message starts with the component that's blocked, such as `.properties.ingressProfile.webAppRouting.enabled` or `.properties.networkProfile.networkPolicy`. If AKS rejects the installation of a cluster extension, the message starts with `Kubernetes extension '<extension-name>'`, and the `az k8s-extension create` command returns the message inside an `ExtensionOperationFailed` error.

**Cause:** Cluster-level FIPS is enabled, and you tried to enable a component or install a cluster extension that isn't FIPS-compliant. You also get this error if you create a cluster by using `--enable-fips` together with a blocked component, such as Cilium. AKS blocks the operation to keep the cluster FIPS-compliant. For the list of blocked components, see [Blocked components](/azure/aks/enable-fips-cluster#blocked-components).

When AKS rejects the installation of a cluster extension, the extension stays on the cluster in the `Failed` provisioning state. A failed extension doesn't block other operations on the cluster, and cluster-level FIPS stays enabled. If you install the extension by using `--no-wait`, the command returns before AKS validates the request, so you don't see the error. Check the provisioning state of the extension instead.

Cluster extensions can also be installed automatically, for example, by an Azure Policy assignment that deploys an extension to every cluster in its scope. On a FIPS-enabled cluster, the installation of an extension that isn't FIPS-compliant fails in the same way, and the extension shows a `Failed` provisioning state.

**Solution:**

- Don't enable the component on a FIPS-enabled cluster. Where possible, use a supported alternative. For example, use [Application Gateway for Containers](/azure/application-gateway/for-containers/overview) instead of the Application Gateway Ingress Controller (AGIC) add-on, or use the [Istio-based service mesh add-on](/azure/aks/istio-about) instead of Open Service Mesh.
- If you must use the component, disable cluster-level FIPS first, and then enable the component. Your node pools keep FIPS enabled, but AKS no longer enforces cluster-level FIPS rules. To enable cluster-level FIPS again later, you must first remove the component.

  ```azurecli
  az aks update \
      --resource-group $RESOURCE_GROUP \
      --name $CLUSTER_NAME \
      --disable-fips
  ```

- Remove the failed extension. If an Azure Policy assignment installed the extension, exempt the cluster from that assignment first. Otherwise, the assignment might install the extension again, for example, after you disable cluster-level FIPS. If you installed the extension yourself, go to step 3.

  1. Get the cluster resource ID, and then list the policy assignments that apply to the cluster:

     ```azurecli
     export CLUSTER_ID=$(az aks show \
         --resource-group $RESOURCE_GROUP \
         --name $CLUSTER_NAME \
         --query id \
         --output tsv)

     az policy assignment list \
         --scope $CLUSTER_ID \
         --disable-scope-strict-match true \
         --query "[].{name:name, displayName:displayName, id:id}" \
         --output table
     ```

  1. Create a policy exemption for the assignment that installs the extension. Replace `<policy-assignment-id>` with the `id` value of that assignment.

     ```azurecli
     az policy exemption create \
         --name "fips-cluster-exemption" \
         --policy-assignment "<policy-assignment-id>" \
         --exemption-category Waiver \
         --scope $CLUSTER_ID \
         --description "Cluster-level FIPS is enabled on this cluster."
     ```

     For more information, see [Azure Policy exemption structure](/azure/governance/policy/concepts/exemption-structure).

  1. Remove the failed extension. Replace `<extension-name>` with the extension name from the `az k8s-extension list` output.

     ```azurecli
     az k8s-extension delete \
         --resource-group $RESOURCE_GROUP \
         --cluster-name $CLUSTER_NAME \
         --cluster-type managedClusters \
         --name <extension-name> \
         --yes
     ```

### Issue 2: An incompatible component blocks cluster-level FIPS

**Error message contains:**

```output
Cannot enable cluster-level FIPS because an incompatible component is enabled: <component>.
```

The `<component>` value is the property of the component, such as `.properties.storageProfile.blobCSIDriver.enabled`.

**Cause:** You tried to enable cluster-level FIPS on a cluster that has a component that isn't FIPS-compliant. The error message names the component.

If the cluster also has a cluster extension that isn't FIPS-compliant, you might get the error in [Issue 3](#issue-3-a-cluster-extension-isnt-fips-compliant) first. After you remove the extension, the next attempt can fail with this error.

**Solution:** Disable the component, and then try again to enable cluster-level FIPS. Use the command for the component from the following table. Run each `az aks` command with `--resource-group $RESOURCE_GROUP --name $CLUSTER_NAME`.

| Component | Command to disable the component |
| --- | --- |
| Cost analysis | `az aks update --disable-cost-analysis` |
| Application routing add-on | `az aks approuting disable` |
| Microsoft Defender for Containers | `az aks update --disable-defender` |
| Azure Monitor managed service for Prometheus | `az aks update --disable-azure-monitor-metrics` |
| Container insights | `az aks disable-addons --addons monitoring` |
| Azure Monitor Application Insights for AKS | `az aks update --disable-azure-monitor-app-monitoring` |
| Azure Blob storage Container Storage Interface (CSI) driver | `az aks update --disable-blob-driver` |
| Intel Software Guard Extensions (SGX) device plugin (`confcom` add-on) | `az aks disable-addons --addons confcom` |
| Application Gateway Ingress Controller (AGIC) add-on | `az aks disable-addons --addons ingress-appgw` |
| Calico or Azure Network Policy Manager network policy | `az aks update --network-policy none` |
| Cilium | You can't remove Cilium from an existing cluster. Create a new cluster that doesn't use Cilium. |
| Advanced Container Networking Services observability | `az aks update --disable-acns`, or `az aks update --disable-acns-observability` to disable only observability |
| Open Service Mesh add-on | `az aks disable-addons --addons open-service-mesh` |
| AI toolchain operator (KAITO) add-on | `az aks update --disable-ai-toolchain-operator` |
| GPU driver installation on Windows node pools | You can't change this setting on an existing node pool. Delete the Windows GPU node pool, or replace it with a node pool that [skips GPU driver installation](/azure/aks/use-windows-gpu#skip-gpu-driver-installation) by using `--gpu-driver none`. |

After you disable the component, enable cluster-level FIPS:

```azurecli
az aks update \
    --resource-group $RESOURCE_GROUP \
    --name $CLUSTER_NAME \
    --enable-fips
```

If the cluster has more than one incompatible component, the operation can fail again with the next component. To avoid repeated failures, review the cluster for all blocked components before you retry. For more information, see [Prepare your cluster for FIPS](/azure/aks/enable-fips-cluster#prepare-your-cluster-for-fips).

### Issue 3: A cluster extension isn't FIPS-compliant

**Error message contains:**

```output
Cannot set .properties.enableFIPS to true at the managed cluster scope because extension '<extension-name>' is not FIPS-compliant.
```

**Cause:** A cluster extension on the cluster isn't marked as FIPS-compliant by its publisher. The extension can be one that you installed, or one that AKS installs when you enable an AKS feature. Extensions that AKS installs have names that start with `aks-managed-`. To check whether an extension is FIPS-compliant, see the **FIPS** column in the [extension capability matrix](/azure/aks/cluster-extensions#extension-capability-matrix). For example, Flux (GitOps) isn't FIPS-compliant.

You also get this error in the following situations:

- You enable an Azure Monitor feature, such as managed service for Prometheus or Container insights, on a cluster that already has cluster-level FIPS enabled. The message names the `aks-managed-*` extension of the feature, for example `aks-managed-azure-monitor-metrics`. AKS doesn't install the extension, and cluster-level FIPS stays enabled. However, Azure CLI might have already created Azure Monitor resources for the feature. To remove them, see [Issue 12](#issue-12-azure-monitor-resources-remain-after-aks-rejects-an-azure-monitor-feature).
- You enable cluster-level FIPS again after you disabled it. While cluster-level FIPS is disabled, extensions that aren't FIPS-compliant can be installed, for example, by an Azure Policy assignment.

For some Azure Monitor features, the error names a component, such as `.properties.azureMonitorProfile.metrics.enabled`, instead of an extension. In that case, see [Issue 1](#issue-1-a-component-isnt-supported-on-a-fips-enabled-cluster) or [Issue 2](#issue-2-an-incompatible-component-blocks-cluster-level-fips).

**Solution:**

1. List the extensions on the cluster:

   ```azurecli
   az k8s-extension list \
       --resource-group $RESOURCE_GROUP \
       --cluster-name $CLUSTER_NAME \
       --cluster-type managedClusters \
       --query "[].{name:name, extensionType:extensionType, state:provisioningState}" \
       --output table
   ```

1. Remove each extension that isn't FIPS-compliant:

   - For an extension whose name starts with `aks-managed-`, disable the AKS feature that installed it. Don't delete the extension directly. For example:

     | Extension name | Command to disable the feature |
     | --- | --- |
     | `aks-managed-azure-monitor-metrics` | `az aks update --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME --disable-azure-monitor-metrics` |
     | `aks-managed-azure-monitor-logs` | `az aks disable-addons --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME --addons monitoring` |
     | `aks-managed-app-monitoring` | `az aks update --resource-group $RESOURCE_GROUP --name $CLUSTER_NAME --disable-azure-monitor-app-monitoring` |

     After the command finishes, list the extensions again. If the `aks-managed-*` extension is still listed, run the command again.

   - For any other extension, delete the extension:

     ```azurecli
     az k8s-extension delete \
         --resource-group $RESOURCE_GROUP \
         --cluster-name $CLUSTER_NAME \
         --cluster-type managedClusters \
         --name <extension-name> \
         --yes
     ```

1. Enable cluster-level FIPS.

   ```azurecli
   az aks update \
       --resource-group $RESOURCE_GROUP \
       --name $CLUSTER_NAME \
       --enable-fips
   ```

The error names only the first extension that isn't FIPS-compliant, even if the cluster has more than one. If you remove only that extension, the next attempt fails with the next extension. Remove all extensions that aren't FIPS-compliant before you retry. List the extensions again right before you enable cluster-level FIPS, because extensions can be installed automatically.

> [!NOTE]
> A security or monitoring extension can be installed automatically by an Azure Policy assignment, often several minutes after you create or update the cluster. If such an extension is installed again after you remove it, exempt the cluster from the policy assignment, and then remove the extension again. For the steps, see [Issue 1](#issue-1-a-component-isnt-supported-on-a-fips-enabled-cluster).

### Issue 4: A node pool doesn't have FIPS enabled

**Error message contains** one of the following strings:

```output
All node pools in a FIPS-enabled cluster must also have FIPS enabled
Cannot add node pool <node-pool-name> with .properties.enableFIPS=false
Cannot disable FIPS on node pool <node-pool-name> because the managed cluster has .properties.enableFIPS=true
To enable FIPS on a managed cluster, all existing agent pools must have .properties.enableFIPS set to true
--enable-fips requires all node pools in the cluster to be FIPS-enabled. Enable FIPS on these node pools first: <node-pool-names>.
```

The last message comes from Azure CLI and lists the node pools that don't have FIPS enabled.

**Cause:** Cluster-level FIPS requires FIPS on every Linux and Windows node pool in the cluster. You tried one of the following operations:

- Enable cluster-level FIPS on a cluster that has a node pool without FIPS.
- Add a node pool without FIPS to a FIPS-enabled cluster.
- Disable FIPS on a node pool in a FIPS-enabled cluster.

When you create a cluster by using `az aks create --enable-fips`, AKS enables FIPS on the default node pool. When you add a node pool by using `az aks nodepool add`, you must specify `--enable-fips-image`. Otherwise, AKS rejects the request.

Windows Server 2022 node pools run with FIPS enabled in the operating system, but their `enableFips` property is `false` unless you set it. These node pools also block cluster-level FIPS until you set the property.

**Solution:**

- To enable FIPS on an existing node pool, run the following command for each node pool that doesn't have FIPS enabled. For Linux node pools, AKS reimages the nodes by using a FIPS-enabled node image, which can take several minutes.

  ```azurecli
  az aks nodepool update \
      --resource-group $RESOURCE_GROUP \
      --cluster-name $CLUSTER_NAME \
      --name $NODE_POOL_NAME \
      --enable-fips-image
  ```

  For Windows Server 2022 node pools, run the same command. The command sets the FIPS property on the node pool and doesn't change the node image.

- To add a node pool to a FIPS-enabled cluster, include `--enable-fips-image`:

  ```azurecli
  az aks nodepool add \
      --resource-group $RESOURCE_GROUP \
      --cluster-name $CLUSTER_NAME \
      --name $NODE_POOL_NAME \
      --enable-fips-image
  ```

- To disable FIPS on a node pool, first disable cluster-level FIPS by running `az aks update --disable-fips`.

For supported operating systems and other node pool requirements, see [Update an existing node pool to enable or disable FIPS](/azure/aks/enable-fips-nodes#update-an-existing-node-pool-to-enable-or-disable-fips).

### Issue 5: The cluster contains Kata node pools

**Error message contains** one of the following strings:

```output
FIPS cannot be enabled on a managed cluster that contains Kata workload-runtime node pools
FIPS is not supported on Kata workload-runtime agent pools
```

**Cause:** Node pools that use a Kata workload runtime (`KataVmIsolation`, `KataMshvVmIsolation`, or `KataCcIsolation`) run a node image that isn't FIPS-enabled. You get this error when you enable cluster-level FIPS on a cluster that has a Kata node pool, or when you add a Kata node pool to a FIPS-enabled cluster, even if you specify `--enable-fips-image`. You can't change the workload runtime of an existing node pool.

**Solution:** If your workloads need Kata VM isolation, keep cluster-level FIPS disabled. Otherwise, replace the Kata node pool:

1. Find the node pools that use a Kata workload runtime:

   ```azurecli
   az aks nodepool list \
       --resource-group $RESOURCE_GROUP \
       --cluster-name $CLUSTER_NAME \
       --query "[].{Name:name, workloadRuntime:workloadRuntime}" \
       --output table
   ```

1. Add a FIPS-enabled node pool that doesn't use Kata, and then move your workloads to the new node pool.
1. Delete the Kata node pool:

   ```azurecli
   az aks nodepool delete \
       --resource-group $RESOURCE_GROUP \
       --cluster-name $CLUSTER_NAME \
       --name <kata-node-pool-name>
   ```

1. Enable cluster-level FIPS by running `az aks update --enable-fips`.

### Issue 6: The Istio revision is earlier than asm-1-26

**Error message contains:**

```output
Istio revision(s) <revisions> are below the minimum required revision asm-1-26 for enabling FIPS.
```

**Cause:** The cluster uses the Istio-based service mesh add-on, and at least one installed Istio revision is earlier than `asm-1-26`. The message lists every installed revision that's earlier than `asm-1-26`. During a canary upgrade, the earlier revision stays installed until you complete the upgrade.

**Solution:** Upgrade the mesh to revision `asm-1-26` or later, and then try again to enable cluster-level FIPS.

1. List the available upgrades:

   ```azurecli
   az aks mesh get-upgrades \
       --resource-group $RESOURCE_GROUP \
       --name $CLUSTER_NAME
   ```

1. Start a canary upgrade to the target revision. Replace `<asm-revision>` with `asm-1-26` or a later revision from the previous output.

   ```azurecli
   az aks mesh upgrade start \
       --resource-group $RESOURCE_GROUP \
       --name $CLUSTER_NAME \
       --revision <asm-revision>
   ```

1. Restart your workloads to use the new revision, and then complete the upgrade so that the earlier revision is removed:

   ```azurecli
   az aks mesh upgrade complete \
       --resource-group $RESOURCE_GROUP \
       --name $CLUSTER_NAME
   ```

If `asm-1-26` isn't available as a direct upgrade, repeat these steps until the mesh runs `asm-1-26` or later. For more information, see [Upgrade the Istio-based service mesh add-on](/azure/aks/istio-upgrade).

### Issue 7: The Kubernetes version isn't supported

**Error message contains** one of the following strings:

```output
To enable FIPS on a managed cluster, the cluster must be running Kubernetes version 1.35.0 or later.
--enable-fips requires Kubernetes version
```

The second message comes from Azure CLI, which checks the version before it sends the request. Earlier versions of the `aks-preview` extension show an earlier minimum version in this message. AKS enforces version 1.35.0 or later.

**Cause:** Cluster-level FIPS requires Kubernetes version 1.35.0 or later.

This requirement also applies to clusters that already have cluster-level FIPS enabled. If a FIPS-enabled cluster runs an earlier Kubernetes version, AKS rejects every update to the cluster, including unrelated changes such as tag updates, until you upgrade the cluster or disable cluster-level FIPS. For these updates, the error message still starts with `To enable FIPS on a managed cluster`, and AKS doesn't apply any of the requested changes.

If you create a cluster by using `--enable-fips` but don't specify `--kubernetes-version`, Azure CLI doesn't check the version, and AKS uses the default Kubernetes version for the region. If the default version is earlier than 1.35.0, AKS rejects the request. Specify `--kubernetes-version` with version 1.35.0 or later.

**Solution:** Upgrade the cluster to Kubernetes version 1.35.0 or later.

1. List the available versions:

   ```azurecli
   az aks get-upgrades \
       --resource-group $RESOURCE_GROUP \
       --name $CLUSTER_NAME \
       --output table
   ```

1. Upgrade the cluster. Replace `<kubernetes-version>` with version 1.35.0 or later from the previous output.

   ```azurecli
   az aks upgrade \
       --resource-group $RESOURCE_GROUP \
       --name $CLUSTER_NAME \
       --kubernetes-version <kubernetes-version>
   ```

For more information, see [Upgrade an AKS cluster](/azure/aks/upgrade-aks-control-plane).

If you can't upgrade the cluster, disable cluster-level FIPS by running `az aks update --disable-fips`.

### Issue 8: Cluster-level FIPS isn't enabled after you create the cluster

**Symptoms:** You created the cluster by running `az aks create --enable-fips`, and the operation succeeded. However, `az aks show --query enableFips` doesn't return `true`, and only the default node pool has FIPS enabled.

**Cause:** You didn't install the `aks-preview` extension when you created the cluster. Without the extension, Azure CLI interprets `--enable-fips` as `--enable-fips-image`. This parameter enables FIPS only on the default node pool, not at the cluster level.

**Solution:**

1. Install or update the `aks-preview` extension.

   ```azurecli
   az extension add --upgrade --name aks-preview
   ```

1. Enable FIPS on every node pool that doesn't have it. For the command, see [Issue 4](#issue-4-a-node-pool-doesnt-have-fips-enabled).
1. Enable cluster-level FIPS.

   ```azurecli
   az aks update \
       --resource-group $RESOURCE_GROUP \
       --name $CLUSTER_NAME \
       --enable-fips
   ```

1. Verify that `enableFips` is `true`.

   ```azurecli
   az aks show \
       --resource-group $RESOURCE_GROUP \
       --name $CLUSTER_NAME \
       --query enableFips
   ```

### Issue 9: The preview feature isn't registered

**Error message contains:**

```output
Preview feature Microsoft.ContainerService/EnableFIPSPreview not registered.
```

**Cause:** The `EnableFIPSPreview` feature flag isn't registered in your subscription.

**Solution:**

1. Register the feature flag:

   ```azurecli
   az feature register \
       --namespace Microsoft.ContainerService \
       --name EnableFIPSPreview
   ```

1. Check the registration status. It takes a few minutes for the status to show `Registered`.

   ```azurecli
   az feature show \
       --namespace Microsoft.ContainerService \
       --name EnableFIPSPreview
   ```

1. When the status shows `Registered`, refresh the registration of the `Microsoft.ContainerService` resource provider.

   ```azurecli
   az provider register --namespace Microsoft.ContainerService
   ```

1. Retry the operation.

### Issue 10: Node pools still have FIPS enabled after you disable cluster-level FIPS

**Symptoms:** You ran `az aks update --disable-fips`, and `enableFips` is now `false` for the cluster. However, the node pools still show `enableFips` as `true`.

**Cause:** This behavior is by design. Disabling cluster-level FIPS doesn't change the FIPS setting of the node pools.

**Solution:** No action is required. If you also want to disable FIPS on a node pool, run the following command:

```azurecli
az aks nodepool update \
    --resource-group $RESOURCE_GROUP \
    --cluster-name $CLUSTER_NAME \
    --name $NODE_POOL_NAME \
    --disable-fips-image
```

You can't disable FIPS on Windows Server 2025 node pools. If you try, the command fails with the following error:

```output
FIPS cannot be disabled in Windows '2025' and later.
```

For more information, see [Disable FIPS on an existing node pool](/azure/aks/enable-fips-nodes#disable-fips-on-an-existing-node-pool).

**Enable cluster-level FIPS again:** While cluster-level FIPS is disabled, AKS doesn't block components and cluster extensions that aren't FIPS-compliant. For example, an Azure Policy assignment can install an extension that AKS rejected while FIPS was enabled. In the minutes after you disable cluster-level FIPS, other operations on the cluster might fail with an `Operation is not allowed because there's an in-progress` error while such an installation runs. Wait for the operation to finish, and then retry.

Before you enable cluster-level FIPS again, make sure that the cluster meets every requirement: all node pools have FIPS enabled, and no blocked components or cluster extensions that aren't FIPS-compliant are present. To check the cluster, see [Check the cluster FIPS state](#check-the-cluster-fips-state). To remove blocked components and extensions, see [Issue 2](#issue-2-an-incompatible-component-blocks-cluster-level-fips) and [Issue 3](#issue-3-a-cluster-extension-isnt-fips-compliant).

### Issue 11: A node pool uses node pool-level custom CA trust

**Error message contains:**

```output
is not supported when agent pool <node-pool-name> has .properties.enableCustomCATrust set to true
```

**Cause:** A node pool uses the preview node pool-level custom certificate authority (CA) trust setting, which isn't supported with cluster-level FIPS.

**Solution:** Remove the `enableCustomCATrust` property from the node pool by using an Azure Resource Manager (ARM) template or the REST API, or replace the node pool with one that doesn't use this setting. Then configure custom CA trust at the cluster level instead. Cluster-level custom CA trust (`--custom-ca-trust-certificates`) is supported on FIPS-enabled clusters, and AKS installs the certificates on the FIPS-enabled nodes. For more information, see [Custom certificate authority (CA) in AKS](/azure/aks/custom-certificate-authority).

### Issue 12: Azure Monitor resources remain after AKS rejects an Azure Monitor feature

**Symptoms:** You tried to enable an Azure Monitor feature, such as managed service for Prometheus (`--enable-azure-monitor-metrics`) or Container insights (`--addons monitoring`), on a FIPS-enabled cluster. AKS rejected the request, as described in [Issue 1](#issue-1-a-component-isnt-supported-on-a-fips-enabled-cluster) or [Issue 3](#issue-3-a-cluster-extension-isnt-fips-compliant). However, new Azure Monitor resources now exist in your subscription.

**Cause:** Azure CLI creates the Azure Monitor resources that the feature needs before it sends the request to AKS. When AKS rejects the request, Azure CLI doesn't remove these resources. They can include the following resources:

- Data collection rules and data collection endpoints in the cluster resource group, whose names start with `MSProm-` (managed service for Prometheus) or `MSCI-` (Container insights). The data collection rules are associated with the cluster.
- Prometheus recording rule groups in the cluster resource group, whose names contain `RecordingRulesRuleGroup`.
- A default Azure Monitor workspace or Log Analytics workspace in a resource group named `DefaultResourceGroup-<region>`, if one didn't already exist.

**Solution:** If you don't plan to enable the feature on this cluster, delete the resources that Azure CLI created for it. The `az monitor data-collection` commands require the `monitor-control-service` Azure CLI extension.

1. Install or update the extension:

   ```azurecli
   az extension add --upgrade --name monitor-control-service
   ```

1. List the data collection rules and data collection endpoints in the cluster resource group:

   ```azurecli
   az monitor data-collection rule list \
       --resource-group $RESOURCE_GROUP \
       --query "[?starts_with(name, 'MSProm-') || starts_with(name, 'MSCI-')].name" \
       --output tsv

   az monitor data-collection endpoint list \
       --resource-group $RESOURCE_GROUP \
       --query "[?starts_with(name, 'MSProm-') || starts_with(name, 'MSCI-')].name" \
       --output tsv
   ```

1. Delete each data collection rule that belongs to the cluster, together with its associations. The rule names include the cluster name. Replace `<data-collection-rule-name>` with a name from the previous output.

   ```azurecli
   az monitor data-collection rule delete \
       --resource-group $RESOURCE_GROUP \
       --name <data-collection-rule-name> \
       --delete-associations true \
       --yes
   ```

1. Delete each data collection endpoint that belongs to the cluster. Replace `<data-collection-endpoint-name>` with a name from the output of step 2.

   ```azurecli
   az monitor data-collection endpoint delete \
       --resource-group $RESOURCE_GROUP \
       --name <data-collection-endpoint-name> \
       --yes
   ```

1. In the Azure portal, delete the Prometheus rule groups in the cluster resource group whose names contain `RecordingRulesRuleGroup` and the cluster name.

Other clusters might use the default Azure Monitor workspace or Log Analytics workspace. Delete a default workspace only if no other resource uses it.

## Related content

- [Enable FIPS for AKS clusters (preview)](/azure/aks/enable-fips-cluster)
- [Enable FIPS for AKS node pools](/azure/aks/enable-fips-nodes)
- [Cluster extensions for AKS](/azure/aks/cluster-extensions)
- [Federal Information Processing Standard (FIPS) 140](/azure/compliance/offerings/offering-fips-140-2)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
