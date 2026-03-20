---
title: VMExtensionError_VHDFileNotFound when creating AKS clusters
description: Learn how to troubleshoot the VMExtensionError_VHDFileNotFound message when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 10/14/2024
editor: v-jsitser
ms.reviewer: axelg, chiragpa, v-leedennis
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the VMExtensionError_VHDFileNotFound message (or message OutboundConnFailVMExtensionError, or message K8SAPIServerConnFailVMExtensionError, or message K8SAPIServerDNSLookupFailVMExtensionError) so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# VMExtensionError_VHDFileNotFound message when deploying an AKS cluster

## Summary

This article discusses how to identify and resolve the `VMExtensionError_VHDFileNotFound` message that occurs when you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to create an AKS cluster, you receive the following error message:

> VMExtensionProvisioningError: VM has reported a failure when processing extension 'vmssCSE'.
>
> Error message: "CSE failed with 'VMExtensionError_VHDFileNotFound'. There was a connectivity issue between your cluster and required azure endpoints,  please see https://learn.microsoft.com/troubleshoot/azure/azure-kubernetes/error-codes/vhdfilenotfound for more information."

## Cause

Under rare circumstances, the 65 exit code for the Azure Virtual Machine Scale Set custom script extension (`vmssCSE`) might happen instead of the following error codes:

| Error code name                             | Error code number |
|---------------------------------------------|-------------------|
| `OutboundConnFailVMExtensionError`          | 50                |
| `K8SAPIServerConnFailVMExtensionError`      | 51                |
| `K8SAPIServerDNSLookupFailVMExtensionError` | 52                |

This error occurs if a connectivity issue exists between your AKS cluster and the required Azure endpoints, such as `mcr.microsoft.com` or `acs-mirror.azureedge.net`.

## Solution

Review [outbound network and FQDN rules for Azure Kubernetes Service (AKS) clusters](/azure/aks/outbound-rules-control-egress) and make sure that all API services FQDN are allowed.

For detailed troubleshooting steps, refer to the troubleshooting guides in the following articles:

- [Troubleshoot the VMExtensionError_OutboundConnFail message](../error-codes/vmextensionerror-outboundconnfail.md)
- [Troubleshoot the VMExtensionError_K8SAPIServerConnFail message](../error-codes/vmextensionerror-k8sapiserverconnfail.md)
- [Troubleshoot the VMExtensionError_K8SAPIServerDNSLookupFail message](../error-codes/vmextensionerror-k8sapiserverdnslookupfail.md)


## References

- [General troubleshooting of AKS cluster creation issues](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md)

- [Outbound network and FQDN rules for Azure Kubernetes Service (AKS) clusters](/azure/aks/outbound-rules-control-egress)

 

