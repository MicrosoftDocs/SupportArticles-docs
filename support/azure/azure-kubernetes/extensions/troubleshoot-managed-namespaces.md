---
title: Troubleshoot Managed Namespaces Errors
description: Learn how to resolve errors that occur when you try to enable Managed Namespaces on AKS.
ms.date: 08/05/2025
ms.reviewer: jackjiang
ms.service: azure-kubernetes-service
ms.custom: sap:Extensions, references_regions
---
# Troubleshoot AKS AI toolchain operator add-on errors

This article provides guidance on resolving errors when using Managed Namespaces (Preview) on Microsoft Azure Kubernetes Service (AKS).

## Prerequisites

Please make sure the following tools are installed and configured:

- [Azure CLI](/cli/azure/install-azure-cli)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/), the Kubernetes command-line client

## Issue 1 - I get an error when I try to create a managed namespace or I'm unable to create a managed namespace. 
 
This can be because you haven't registered the feature flag yet. 

You can run az feature register command to register this preview feature:

`az feature register --namespace Microsoft.containerService -n ManagedNamespacePreview`

To verify the registration status, use the az feature show command:

`az feature show --namespace Microsoft.ContainerService -n ManagedNamespacePreview`

## Issue 2 - Some namespaces can't be changed/certain names can't be used

Users are not allowed to make change on certain namespaces, as they are utilized by system components/resources. These namespaces are: 

default, kube-system, kube-node-lease, kube-public, gatekeeper-system, cert-manager, calico-system, tigera-system, app-routing-system,aks-istio-system, istio-system, dapr-system, flux-system, prometheus-system, eraser-system

## Issue 3 - I can't update or delete my namespaces

Users are not allowed to create, update, or delete managed namespaces when the managed cluster is not in a running state. This behavior is expected and normal.

## Issue 4 - I can't do ______ via `kubectl`

Since the managed namespace is managed by Microsoft Azure Resource Manager (ARM), changes to its metadata (e.g. labels/annotations) are restricted.

Modifications must be made through the ARM API to ensure consistency with the managed state. 

### Can't edit a managed namespace using the Kubernetes API

When attempting to edit a managed namespace using the command: `kubectl edit ns <namespace-name>`, the user should encounter an error along the lines of `Updating/deleting namespace ns1 labels is not allowed because it is managed by ARM. Please update this namespace through the ARM API.`.

### Can't edit or delete the defaultresourcequota

When attempting to edit a defaultresourcequota using the command: `kubectl delete resourcequota defaultresourcequota --namespace <namespace-name>` the user will encounter the following error: `Updating resource quota defaultresourcequota is not allowed because it is managed by ARM. Please update this resource quota though ARM api.`

### Can't edit or delete the  defaultnetworkpolicy

When attempting to edit a defaultnetworkpolicy using the command: `kubectl delete networkpolicy defaultnetworkpolicy --namespace <namespace-name>` the user will encounter the following error: `Updating default network policy defaultnetworkpolicy is not allowed because it is managed by ARM. Please update this network policy though ARM api`.

### Can't delete a namespace using the Kubernetes API

When attempting to delete a Kubernetes namespace using the command: `kubectl delete ns <namespace name>` the user will encounter the following error: `Deleting namespace ns1 is not allowed because it is managed by ARM. Please delete this namespace though ARM api.`

## Can't edit or delete the defaultresourcequota

When attempting to delete a defaultresourcequota using the command: `kubectl delete resourcequota defaultresourcequota --namespace <namespace-name>` the user will encounter the following error: `Deleting resource quota defaultresourcequota is not allowed because it is managed by ARM.`

## Can't edit or delete the defaultnetworkpolicy

When attempting to delete a defaultnetworkpolicy using the command: `kubectl delete networkpolicy defaultnetworkpolicy --namespace <namespace-name>` You will encounter the following error: `Deleting default network policy defaultnetworkpolicy is not allowed because it is managed by ARM.`

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
