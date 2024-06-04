---
title: Troubleshoot Azure App Configuration extension (Preview) installation errors 
description: Troubleshoot errors that occur while installing the Azure App Configuration extension (Preview) for Azure Kubernetes Service (AKS).
author: RichardChen820
ms.author: junbchen
editor: v-jsitser
ms.reviewer: v-leedennis
ms.service: azure-kubernetes-service
ms.date: 05/28/2024
ms.custom: sap:Extensions, Policies and Add-Ons
---
# Troubleshoot Azure App Configuration extension (Preview) installation errors

This article discusses some common error scenarios that you might encounter when you install or update the [Azure App Configuration extension](/azure/aks/azure-app-configuration) for Microsoft Azure Kubernetes Service (AKS).

> [!NOTE]
>
> - This issue applies to only the Preview version of the extension.
>
> - If the Azure App Configuration extension was successfully installed but you experience issues while using it, see the [Azure App Configuration Kubernetes Provider troubleshooting guide](/azure/azure-app-configuration/quickstart-azure-kubernetes-service#troubleshooting).

## Scenario 1: Azure App Configuration Kubernetes Provider is already installed

You try to install the Azure App Configuration extension for AKS, but you receive an error message that indicates that the Azure App Configuration Kubernetes Provider is already installed through the `helm install` command. The error message might resemble either of the following error messages.

**Message 1**

> (ExtensionOperationFailed) The extension operation failed with the following error:  Error: [ InnerError: [**Helm installation failed : Resource already existing in your cluster** : Recommendation Manually delete the resource(s) that currently exist in your cluster and try installation again. To delete these resources run the following commands: `kubectl delete {resource type} -n {resource namespace} {resource name}` : InnerError [rendered manifests contain a resource that already exists. Unable to continue with install: CustomResourceDefinition "azureappconfigurationproviders.azconfig.io" in namespace "" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-name" must equal "azureappconfig": current value is "azureappconfiguration.kubernetesprovider"; annotation validation error: key "meta.helm.sh/release-namespace" must equal "kube-system": current value is "azappconfig-system"]]] occurred while doing the operation : [Create] on the config, For general troubleshooting visit: https://aka.ms/k8s-extensions-TSG.

**Message 2**

> (ExtensionOperationFailed) The extension operation failed with the following error:  Error: [ InnerError: [**Helm installation failed : Resource already existing in your cluster** : Recommendation Manually delete the resource(s) that currently exist in your cluster and try installation again. To delete these resources run the following commands: `kubectl delete {resource type} -n {resource namespace} {resource name}` : InnerError [rendered manifests contain a resource that already exists. Unable to continue with install: ServiceAccount "az-appconfig-k8s-provider" in namespace "azappconfig-system" exists and cannot be imported into the current release: invalid ownership metadata; annotation validation error: key "meta.helm.sh/release-name" must equal "azureappconfig": current value is "azureappconfiguration.kubernetesprovider"]]] occurred while doing the operation : [Create] on the config, For general troubleshooting visit: https://aka.ms/k8s-extensions-TSG.

### Solution 1: Uninstall Azure App Configuration Kubernetes Provider first

Uninstall the Azure App Configuration Kubernetes Provider before you install the Azure App Configuration extension. For more information, see [Clean up resources](/azure/azure-app-configuration/quickstart-azure-kubernetes-service#clean-up-resources).

## Scenario 2: Targeted Azure App Configuration extension version doesn't exist

When you try to install the Azure App Configuration extension to [target a specific version](/azure/aks/azure-app-configuration#targeting-a-specific-version), you receive an error message that states that the Azure App Configuration version doesn't exist:

> (ExtensionOperationFailed) The extension operation failed with the following error:  **Failed to resolve the extension version from the given values.** Please refer https://aka.ms/k8s-extension-type-versions to find the correct version for your installation, For general troubleshooting visit: https://aka.ms/k8s-extensions-TSG.
>
> Code: ExtensionOperationFailed
>
> Message: The extension operation failed with the following error:  **Failed to resolve the extension version from the given values.** Please refer https://aka.ms/k8s-extension-type-versions to find the correct version for your installation, For general troubleshooting visit: https://aka.ms/k8s-extensions-TSG.

### Solution 2: Install again for a supported Azure App Configuration extension version

Try again to install the extension. Make sure that you use a [supported version of the Azure App Configuration extension](/azure/aks/azure-app-configuration#extension-versions).

## Scenario 3: The targeted Azure App Configuration extension version exists but not in the specified region

Because some versions of Azure App Configuration extension aren't available in all regions, you might receive the following error message:

> (ExtensionTypeRegistrationGetFailed) Extension type microsoft.appconfiguration is not registered in region \<region-name>.
>
> Code: ExtensionTypeRegistrationGetFailed
>
> Message: Extension type microsoft.appconfiguration is not registered in region \<region-name>

### Solution 3: Install in a different region

Run the installation in a [region in which your Azure App Configuration extension is supported](/azure/aks/azure-app-configuration#regions).

## Next steps

If you still experience installation issues, explore the [AKS troubleshooting guide](/azure/aks/troubleshooting).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
