---
title: Troubleshoot Dapr extension installation errors 
description: Troubleshoot errors that occur while installing the Distributed Application Runtime (Dapr) extension for Azure Kubernetes Service (AKS) or Arc for Kubernetes.
editor: v-jsitser
ms.reviewer: nigreenf, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-extensions-add-ons
ms.date: 06/16/2023
---

# Troubleshoot Dapr extension installation errors

This article discusses some common error messages that you may receive when you install or update the [Distributed Application Runtime (Dapr)](https://dapr.io/) extension for Microsoft Azure Kubernetes Service (AKS) or Arc for Kubernetes.

## Scenario 1: Installation fails but doesn't show an error message

If the extension generates an error message when you create or update it, you can inspect where the creation failed by running the [az k8s-extension list](/cli/azure/k8s-extension#az-k8s-extension-list) command:

```azurecli
az k8s-extension list --resource-group <my-resource-group-name> \
    --cluster-name <my-cluster-name> \
    --cluster-type managedClusters
```

If a wrong key is used in the configuration settings, such as `global.ha=false` instead of `global.ha.enabled=false`, the following JSON status is returned. The error message is captured in the `message` property.

```json
"statuses": [
  {
    "code": "InstallationFailed",
    "displayStatus": null,
    "level": null,
    "message": "Error: {failed to install chart from path [] for release [dapr-1]: err [template: dapr/charts/dapr_sidecar_injector/templates/dapr_sidecar_injector_poddisruptionbudget.yaml:1:17: executing \"dapr/charts/dapr_sidecar_injector/templates/dapr_sidecar_injector_poddisruptionbudget.yaml\" at <.Values.global.ha.enabled>: can't evaluate field enabled in type interface {}]} occurred while doing the operation : {Installing the extension} on the config",
    "time": null
  }
],
```

Here's another example of a JSON error message:

```json
"statuses": [
  {
    "code": "InstallationFailed",
    "displayStatus": null,
    "level": null,
    "message": "The extension operation failed with the following error: unable to add the configuration with configId {extension:microsoft-dapr} due to error: {error while adding the CRD configuration: error {failed to get the immutable configMap from the elevated namespace with err: configmaps 'extension-immutable-values' not found }}. (Code: ExtensionOperationFailed)",
    "time": null
  }
]
```

### Solution 1: Restart the cluster, register the service provider, or delete and reinstall Dapr

To fix this issue, try the following methods:

- [Restart your AKS or Arc for Kubernetes cluster](/azure/aks/start-stop-cluster).

- [Register the KubernetesConfiguration service provider](/azure/aks/dapr#register-the-kubernetesconfiguration-service-provider).

- Force delete and [reinstall the Dapr extension](/azure/aks/dapr).

## Scenario 2: Targeted Dapr version doesn't exist

When you try to install the Dapr extension to [target a specific version](/azure/aks/dapr#targeting-a-specific-dapr-version), you receive an error message that states that the Dapr version doesn't exist:

> (ExtensionOperationFailed) The extension operation failed with the following error:  Failed to resolve the extension version from the given values.
>
> Code: ExtensionOperationFailed
>
> Message: The extension operation failed with the following error:  Failed to resolve the extension version from the given values.

### Solution 2: Install again for a supported Dapr version

Try again to install the extension. Make sure that you use a [supported version of Dapr](/azure/aks/dapr#dapr-versions).

## Scenario 3: The targeted Dapr version exists but not in the specified region

Because some versions of Dapr aren't available in all regions, you might receive the following error message:

> (ExtensionTypeRegistrationGetFailed) Extension type microsoft.dapr is not registered in region \<regionname>.
>
> Code: ExtensionTypeRegistrationGetFailed
>
> Message: Extension type microsoft.dapr is not registered in region \<regionname>

### Solution 3: Install in a different region

Install in a [region in which your Dapr version is supported](/azure/aks/dapr#cloudsregions).

## Scenario 4: Dapr is already installed

You try to install the Dapr extension for AKS or Arc for Kubernetes, but you receive an error message that indicates that the `dapr-system` namespace already exists. This error message resembles the following text:

> (ExtensionOperationFailed) The extension operation failed with the following error:  Error: {failed to install chart from path [] for release [dapr-ext]: err [rendered manifests contain a resource that already exists. Unable to continue with install: ServiceAccount "dapr-operator" in namespace "dapr-system" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-name" must equal "dapr-ext": current value is "dapr"]} occurred while doing the operation : {Installing the extension} on the config

### Solution 4: Uninstall Dapr OSS first

Uninstall the Dapr OSS before you install the Dapr extension. For more information, see [Migrate from Dapr OSS to the Dapr extension for AKS](/azure/aks/dapr-migration).

## Scenario 5: The placement server pod is in a bad state

You encounter the following error:

> 0/4 nodes are available: 1 node(s) were unschedulable, 3 node(s) had volume node affinity conflict. preemption: 0/4 nodes are available: 4 Preemption is not helpful for scheduling.

This issue might happen when the placement server pod tries to use the persistent volume that's created in a different zone from the placement server pod itself.

### Solution 5: Install Dapr in multiple availability zones or limit the placement service to a particular availability zone

To resolve this issue, use one of the following methods:

- Follow the recommended approach in [Install Dapr in multiple availability zones while in HA mode](/azure/aks/dapr-settings#install-dapr-in-multiple-availability-zones-while-in-ha-mode).

- Limit the placement service to a particular availability zone by creating a custom storage class and using it for the placement service, and then run the following command:

   ```azurecli
   az k8s-extension create --cluster-type managedClusters
   --cluster-name <clustername>
   --resource-group <resourcegroup>
   --name <name>
   --extension-type Microsoft.Dapr
   --auto-upgrade-minor-version <minorversion>
   --version <version>
   --configuration-settings "dapr_placement.volumeclaims.storageClassName=zone-restricted"
   ```

    Here's an example of creating a custom storage class:
    
    ```yaml
    kind: StorageClass
    apiVersion: storage.k8s.io/v1
    metadata:
     name: zone-restricted
    provisioner: disk.csi.azure.com
    reclaimPolicy: Delete
    allowVolumeExpansion: true
    volumeBindingMode: WaitForFirstConsumer
    allowedTopologies:
    - matchLabelExpressions:
     - key: topology.kubernetes.io/zone
       values:
       - centralus-1
    parameters:
     storageaccounttype: StandardSSD_LRS
    ```
   
## Next steps

If you're still experiencing installation issues, explore the [AKS troubleshooting guide](/azure/aks/troubleshooting) and the [Dapr OSS troubleshooting guide](https://docs.dapr.io/operations/troubleshooting/common_issues/).

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
