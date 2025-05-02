---
title: OrasPullUnauthorizedVMExtensionError when creating AKS clusters
description: Learn how to troubleshoot the OrasPullUnauthorizedVMExtensionError error (212) and when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 05/02/2025
ms.reviewer: xinhl, v-weizhu
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the OrasPullUnauthorizedVMExtensionError error code (OrasPullUnauthorizedVMExtensionError (212)) so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# OrasPullUnauthorizedVMExtensionError error code (212) when deploying an AKS cluster

This article discusses how to identify and resolve the `OrasPullUnauthorizedVMExtensionError` error (error code 212) that occurs when you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to create an AKS cluster with the outbound type `none` or `block`, you receive the following error message:

> VMExtensionProvisioningError: VM has reported a failure when processing extension 'vmssCSE'.
>
> Error message: "Enable failed: failed to execute command: command terminated with exit status=212
>
> Bootstrap Container Registry authorization failed. Please ensure kubelet identity has pull access to the registry.

## Cause

For [network isolated cluster](/azure/aks/concepts-network-isolated), egress traffic is limited. The feature introduces private acr cache rule as proxy to download necessary binary/images from MAR for AKS to bootstrap. It's suggested to disable anonymous access to the ACR. The AKS node will use the kubelet identity to access the ACR. If the `acrpull` permission is not set correctly or the kubelet identity is not bound to the VM instance, an unauthorized error will occur.

## Solution

To resolve this issue, follow these steps:

1. Access the VM instance using SSH to get the log file`/var/log/azure/cluster-provision.log`. Review the log to determine if the issue is related to a 401 error, Azure Instance Metadata Service (IMDS) connection timeout, or an identity not found with HTTP code 400.

2. Retrieve the ACR resource ID that AKS uses as the bootstrap ACR by running the folllowing command:

    ```console
    export REGISTRY_ID=$(az aks show -g ${RESOURCE_GROUP} -n ${CLUSTER_NAME} --query 'bootstrapProfile.containerRegistryId' -o tsv)
    ```

3. If the issue is related to a 401 error, check if the kubelet identity has the `acrpull` permission to the ACR by running the folllowing command:

    ```console
    export KUBELET_IDENTITY_PRINCIPAL_ID=$(az aks show -g ${RESOURCE_GROUP} -n ${CLUSTER_NAME} --query 'identityProfile.kubeletidentity.clientId' -o tsv)
    ```

    If not, run the following command:

    ```console
    az role assignment create --role AcrPull --scope ${REGISTRY_ID} --assignee-object-id ${KUBELET_IDENTITY_PRINCIPAL_ID} --assignee-principal-type ServicePrincipal
    ```

4. If the log error indicates that the identity isn't found, manually bind the kubelet identity to the VMSS for a quick fix.

5. If the issue is related to IMDS connection timeout, submit a support ticket.
6. Reconcile the cluster if the preceding operations are completed.

## References

- [General troubleshooting of AKS cluster creation issues](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md)

- [Network isolated Azure Kubernetes Service (AKS) clusters](/azure/aks/concepts-network-isolated)

- [container registry authentication managed identity](/azure/container-registry/container-registry-authentication-managed-identity)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]