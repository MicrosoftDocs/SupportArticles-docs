---
title: OrasPullNetworkTimeoutVMExtensionError when creating AKS clusters
description: Learn how to troubleshoot the OrasPullNetworkTimeoutVMExtensionError error (211) and when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 28/03/2025
editor: xinhl
ms.reviewer: 
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the OrasPullNetworkTimeoutVMExtensionError error code (OrasPullNetworkTimeoutVMExtensionError (211)) so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# OrasPullNetworkTimeoutVMExtensionError error code (211) when deploying an AKS cluster

This article discusses how to identify and resolve the `OrasPullNetworkTimeoutVMExtensionError` error code (error code number 211) that occurs when you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to create an AKS cluster with outbound type `none` or `block`, you receive the following error message:

> VMExtensionProvisioningError: VM has reported a failure when processing extension 'vmssCSE'.
>
> Error message: "Enable failed: failed to execute command: command terminated with exit status=211
>
> Bootstrap Container Registry is not reachable. Please check the network configuration and try again.

## Cause

For [network isolated cluster](https://aka.ms/aks/ni), egress traffic is limited. The feature introduces private acr cache rule as proxy to download necessary binary/images from MAR for AKS to bootstrap. VM instance connect ot private acr via private link. If the private link is configured incorrectly, VM bootstrap CSE will fail.

## Solution
1. Obtain the acr resource id that AKS leverages as bootstrap acr. `az aks show -g ${RESOURCE_GROUP} -n ${CLUSTER_NAME} --query 'bootstrapProfile.containerRegistryResourceId`
1. Check the acr cache rule. It should contains cache rule named `aks-managed-rule` with source repo `mcr.microsoft.com/*` and target repo `aks-managed-reposity/*`. And also make sure there is no other cache rule with source repo or target repo as `*`, which would override the `aks-managed-rule`
1. Review [container registry private link](/azure/container-registry/container-registry-private-link) to make sure the connection configuration including private dns zone, private link, are correct.
1. SSH into any of the failed vm instance, try curl the acr host. If succeess, reconcile the cluster. If still failed pleas back to track step 3.


## References

- [General troubleshooting of AKS cluster creation issues](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md)

- [Network isolated Azure Kubernetes Service (AKS) clusters](https://aka.ms/aks/ni)

- [Container registry private link](/azure/container-registry/container-registry-private-link)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

