---
title: Troubleshoot Managed Namespaces Errors
description: Learn how to resolve errors that occur when you try to enable Managed Namespaces on AKS.
ms.date: 08/05/2025
ms.reviewer: jackjiang
ms.service: azure-kubernetes-service
ms.custom: sap:Extensions, references_regions
---
# Troubleshoot Managed Namespace Errors

This article provides guidance on resolving errors when using Managed Namespaces (Preview) on Microsoft Azure Kubernetes Service (AKS).

## Prerequisites

Please make sure the following tools are installed and configured:

- [Azure CLI](/cli/azure/install-azure-cli)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/), the Kubernetes command-line client

## Issue 1 - I get a `FeatureNotFound` error when I try to registry the managed namespace flag  
 
If you receive an error like `(FeatureNotFound) The feature '<feature_name>' could not be found.`

Please ensure that the command is entered properly and the spelling is correct.

You can run az feature register command to register this preview feature.

`az feature register --namespace Microsoft.containerService -n ManagedNamespacePreview`

## Issue 2 - I get an error when I try to create a managed namespace or I'm unable to create a managed namespace. 
 
If you get a `(BadRequest) Managed namespace requires feature flag Microsoft.ContainerService/ManagedNamespacePreview to be registered.` error, that means the feature flag is not yet registered. If you're already ran the command to register the flag, verify the registration status

To verify the registration status, use the az feature show command.

`az feature show --namespace Microsoft.ContainerService -n ManagedNamespacePreview`

## Issue 3 - Some namespaces can't be changed/certain names can't be used

Users are not allowed to make change on certain namespaces, as they are utilized by system components/resources. These namespaces are: 

default, kube-system, kube-node-lease, kube-public, gatekeeper-system, cert-manager, calico-system, tigera-system, app-routing-system,aks-istio-system, istio-system, dapr-system, flux-system, prometheus-system, eraser-system

## Issue 4 - I can't update or delete my namespaces

Users are not allowed to create, update, or delete managed namespaces when the managed cluster is not in a running state. This behavior is expected and normal.

## Issue 5 - I can't ______ via `kubectl`

Since the managed namespace is managed by Microsoft Azure Resource Manager (ARM), changes to its metadata (e.g. labels/annotations) are restricted. Kubectl commands that are not allowed are inclusive of, but not limited to editing or deleting:

- A managed namespace via `kubectl edit ns <namespace-name>` or `kubectl delete ns <namespace name>`
- A namespace via `kubectl delete resourcequota defaultresourcequota --namespace <namespace-name>`
- A defaultresourcequota via `kubectl delete resourcequota defaultresourcequota --namespace <namespace-name>`
- A defaultnetworkpolicy via `kubectl delete networkpolicy defaultnetworkpolicy --namespace <namespace-name>`

When attempting any action that modifies a managed namespace via kubectl, users will the error `Updating resource quota defaultresourcequota is not allowed because it is managed by ARM. Please update this resource quota though ARM api.`

Modifications must be made through the ARM API to ensure consistency with the managed state. Users can manage their managed namespaces in the Azure portal, or via [CLI commands](https://learn.microsoft.com/en-us/cli/azure/aks/namespace?view=azure-cli-latest)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
