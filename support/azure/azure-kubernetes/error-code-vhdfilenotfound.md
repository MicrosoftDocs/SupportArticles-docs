---
title: Troubleshoot the ERR_VHD_FILE_NOT_FOUND error code
description: Learn how to troubleshoot the ERR_VHD_FILE_NOT_FOUND error (124) when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 05/03/2023
editor: v-jsitser
ms.reviewer: axelg, chiragpa, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-create-operations
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the ERR_VHD_FILE_NOT_FOUND error code (or error code OutboundConnFailVMExtensionError, error number 50 - or error code ERR_K8S_API_SERVER_CONN_FAIL, error number 51) so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot the ERR_VHD_FILE_NOT_FOUND error code (124)

This article discusses how to identify and resolve the `ERR_VHD_FILE_NOT_FOUND` error code (error code number 124) that occurs when you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to create an AKS cluster, you receive the following error message:

> VMExtensionProvisioningError: VM has reported a failure when processing extension 'vmssCSE'.
>
> Error message: "Enable failed: failed to execute command: command terminated with exit status=124

## Cause

Under rare circumstances, the 124 exit code for the Azure Virtual Machine Scale Set custom script extension (`vmssCSE`) might happen instead of the following error codes:

| Error code name                             | Error code number |
|---------------------------------------------|-------------------|
| `OutboundConnFailVMExtensionError`          | 50                |
| `K8SAPIServerConnFailVMExtensionError`      | 51                |
| `K8SAPIServerDNSLookupFailVMExtensionError` | 52                |

It usually hides a network connectivity issue from the AKS node to `mcr.microsoft.com`, or to the API server's fully qualified domain name (FQDN) address.

## Solution

Follow the troubleshooting guides in the following articles:

- [Troubleshoot the OutboundConnFailVMExtensionError error code (50)](error-code-outboundconnfailvmextensionerror.md)

- [Troubleshoot the K8SAPIServerConnFailVMExtensionError error code (51)](error-code-k8sapiserverconnfailvmextensionerror.md)

- [Troubleshoot the K8SAPIServerDNSLookupFailVMExtensionError error code (52)](error-code-k8sapiserverdnslookupfailvmextensionerror.md)

## References

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
