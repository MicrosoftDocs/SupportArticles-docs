---
title: OrasPullNetworkTimeoutVMExtensionError When Creating AKS Clusters
description: Troubleshoot OrasPullNetworkTimeoutVMExtensionError (211) in AKS. Fix private link and network issues, then create your cluster successfully—start now.
ms.date: 07/21/2026
author: kaushika-msft
ms.author: kaushika
ms.reviewer: xinhl, v-weizhu, mhedhbisaber
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the OrasPullNetworkTimeoutVMExtensionError error code (OrasPullNetworkTimeoutVMExtensionError (211)) so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# OrasPullNetworkTimeoutVMExtensionError error code 211 when deploying an AKS cluster

## Summary

This article explains how to identify and resolve the `OrasPullNetworkTimeoutVMExtensionError` error (error code 211) that occurs when you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to create an AKS cluster with the outbound type `none` or `block`, you receive the following error message:

> VMExtensionProvisioningError: VM reported a failure when processing extension 'vmssCSE'.
>
> Error message: "Enable failed: failed to execute command: command terminated with exit status=211
>
> Bootstrap Container Registry isn't reachable. Check the network configuration and try again.

## Cause

For [network isolated cluster](/azure/aks/concepts-network-isolated), egress traffic is limited. The feature introduces a private Azure Container Registry (ACR) cache that acts as a proxy to download necessary binaries or images from Microsoft Artifact Registry (MAR) for AKS bootstrap. VM instances connect to the private ACR through a private link. Incorrect configuration of the private link causes VM bootstrap Custom Script Extension (CSE) to fail.

## Solution

To resolve this issue, follow these steps:

1. Retrieve the ACR resource ID that AKS uses as the bootstrap ACR by running the following command:

    ```console
    az aks show -g ${RESOURCE_GROUP} -n ${CLUSTER_NAME} --query 'bootstrapProfile.containerRegistryResourceId'
    ```

1. Verify the ACR cache rule. It should include `aks-managed-rule` with source repo `mcr.microsoft.com/*` and target repo `aks-managed-repository/*`. Ensure no other cache rule exists with source or target repo as `*`, which override `aks-managed-rule`.

1. Review the [container registry private link](/azure/container-registry/container-registry-private-link) to ensure that the connection configuration is correct, including the private Domain Name System (DNS) zone and private link.

1. Verify that the AKS kubelet identity has `AcrPull` access to the bootstrap ACR:                   
AKS requires permission to pull images and artifacts from the bootstrap Azure Container Registry (ACR). Verify that the AKS kubelet identity has the required permissions (AcrPull) on the bootstrap Azure Container Registry (ACR).

1. Access any failed VM instance using Secure Shell (SSH) and run curl on the ACR host. If successful, reconcile the cluster. If it still fails, return to step 3.

## References

- [General troubleshooting of AKS cluster creation issues](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md)

- [Network isolated Azure Kubernetes Service (AKS) clusters](/azure/aks/concepts-network-isolated)

- [Container registry private link](/azure/container-registry/container-registry-private-link)
  
- [The AKS-ACR integration](/azure/aks/cluster-container-registry-integration?pivots=azure-cli)
