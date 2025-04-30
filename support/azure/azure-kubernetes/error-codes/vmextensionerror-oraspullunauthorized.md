---
title: OrasPullUnauthorizedVMExtensionError when creating AKS clusters
description: Learn how to troubleshoot the OrasPullUnauthorizedVMExtensionError error (212) and when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 28/03/2025
editor: xinhl
ms.reviewer: 
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the OrasPullUnauthorizedVMExtensionError error code (OrasPullUnauthorizedVMExtensionError (212)) so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# OrasPullUnauthorizedVMExtensionError error code (212) when deploying an AKS cluster

This article discusses how to identify and resolve the `OrasPullUnauthorizedVMExtensionError` error code (error code number 212) that occurs when you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to create an AKS cluster with outbound type `none` or `block`, you receive the following error message:

> VMExtensionProvisioningError: VM has reported a failure when processing extension 'vmssCSE'.
>
> Error message: "Enable failed: failed to execute command: command terminated with exit status=212
>
> Bootstrap Container Registry authorization failed. Please ensure kubelet identity has pull access to the registry.

## Cause

For [network isolated cluster](https://aka.ms/aks/ni), egress traffic is limited. The feature introduces private acr cache rule as proxy to download necessary binary/images from MAR for AKS to bootstrap. The acr is suggested to disable anonymous access. The AKS node will leverage the kubelet identity to access the ACR. If the permission (acrpull) is not setup corretly, or kubelet identity is not bound to the vm instance, it will report related unauthorized error

## Solution
1. SSH into the vm instance to get log file. `/var/log/azure/cluster-provision.log`. Check the log to find if the issue is about 401 or imds connection timeout, or identity not found with http code 400.
1. Obtain the acr resource id that AKS leverages as bootstrap acr. `export REGISTRY_ID=$(az aks show -g ${RESOURCE_GROUP} -n ${CLUSTER_NAME} --query 'bootstrapProfile.containerRegistryId' -o tsv)`
1. If it is about 401. Check if the kubelet identity has the acrpull permission to the acr.
`export KUBELET_IDENTITY_PRINCIPAL_ID=$(az aks show -g ${RESOURCE_GROUP} -n ${CLUSTER_NAME} --query 'identityProfile.kubeletidentity.clientId' -o tsv)`
If not, run `az role assignment create --role AcrPull --scope ${REGISTRY_ID} --assignee-object-id ${KUBELET_IDENTITY_PRINCIPAL_ID} --assignee-principal-type ServicePrincipal`
1. If the log error shows identity not found, please bind the kubelet identity to the vmss manually for quick fix.
1. If it is IMDS connection timeout, please raise ticket.
1. Reconcile the cluster if above operation is done.


## References

- [General troubleshooting of AKS cluster creation issues](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md)

- [Network isolated Azure Kubernetes Service (AKS) clusters](https://aka.ms/aks/ni)

- [container registry authentication managed identity](/azure/container-registry/container-registry-authentication-managed-identity)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

