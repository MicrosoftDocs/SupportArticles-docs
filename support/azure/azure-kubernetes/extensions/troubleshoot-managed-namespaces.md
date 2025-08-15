---
title: Troubleshoot Managed Namespaces Errors
description: Learn how to resolve errors that occur when you try to enable managed namespaces on AKS.
ms.date: 08/05/2025
ms.reviewer: jackjiang
ms.service: azure-kubernetes-service
ms.custom: sap:Extensions, references_regions
---
# Troubleshoot managed namespace errors

This article provides guidance for resolving errors that occur in Microsoft Azure Kubernetes Service (AKS) when you use the `ManagedNamespacePreview` flag.

## Prerequisites

The following tools must be installed and configured:

- [Azure CLI](/cli/azure/install-azure-cli)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/), the Kubernetes command-line client

## Error 1: Feature not found

### Symptom

When you try to register the `ManagedNamespacePreview` flag, you receive the following error message:

*(FeatureNotFound) The feature '<feature_name>' could not be found.*

### Resolution
 
Make sure that the command is entered correctly and uses correct spelling.

To register this preview feature, run the `as feature register` command:

`az feature register --namespace Microsoft.containerService -n ManagedNamespacePreview`

## Error 2 - Can't create a managed namespace

### Symptom

When you try to create a managed namespace, you receive the following error message:

*(BadRequest) Managed namespace requires feature flag Microsoft.ContainerService/ManagedNamespacePreview to be registered.*

### Resolution
 
This message indicates that the feature flag is not yet registered. If you already ran the command to register the flag, verify the registration status by running the the `az feature show` command:

`az feature show --namespace Microsoft.ContainerService -n ManagedNamespacePreview`

## Error 3: Can't use or change some namespaces

### Symptom

You receive the following error message:

*The namespace name cannot be the same as the name of a system namespace.*

### Resolution

Users are not allowed to change certain namespaces or create managed namespaces that use certain names because the names are used by system components or resources. This list includes the following namespaces: 

- default
- kube-system
- kube-node-lease
- kube-public
- gatekeeper-system
- cert-manager
- calico-system
- tigera-system
- app-routing-system
- aks-istio-system
- istio-system
- dapr-system
- flux-system
- prometheus-system
- eraser-system

## Error 4 - Can't update or delete managed namespaces

### Symptom

You can't create, update, or delete managed namespaces.

### Resolution
 
This behavior is by design. Users are not allowed to create, update, or delete managed namespaces if the managed cluster is not in a running state. 

## Error 5: Can't use some kubectl commands

### Symptom

When you try to modify a managed namespace through kubectl, you receive the following error message:

*Updating resource quota defaultresourcequota is not allowed because it is managed by ARM. Please update this resource quota though ARM api.*

### Resolution
 
Because a managed namespace is managed by Microsoft Azure Resource Manager (ARM), changes to its metadata (labels and annotations) through kubectl commands are restricted. The affected actions include, but are not limited to, edits and deletions to:

- A managed namespace through `kubectl edit ns <namespace-name>` or `kubectl delete ns <namespace name>`
- A namespace through `kubectl delete resourcequota defaultresourcequota --namespace <namespace-name>`
- A defaultresourcequota through `kubectl delete resourcequota defaultresourcequota --namespace <namespace-name>`
- A defaultnetworkpolicy through `kubectl delete networkpolicy defaultnetworkpolicy --namespace <namespace-name>`

Modifications to namespaces must be made through the ARM API to maintain consistency with the managed state. You can manage your managed namespaces in the Azure portal or through [CLI commands](/cli/azure/aks/namespace).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
