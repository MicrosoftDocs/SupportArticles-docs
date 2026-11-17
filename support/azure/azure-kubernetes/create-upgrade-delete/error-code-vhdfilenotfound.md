---
title: Troubleshoot the ERR_VHD_FILE_NOT_FOUND error code in AKS
description: Learn how to troubleshoot the ERR_VHD_FILE_NOT_FOUND error (65) when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 11/16/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: axelg, chiragpa, lilypan, v-leedennis, kaushika
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the ERR_VHD_FILE_NOT_FOUND error code (or error code OutboundConnFailVMExtensionError, error number 50 - or error code ERR_K8S_API_SERVER_CONN_FAIL, error number 51) so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
ai-usage: ai-assisted
---
# Troubleshoot the "ERR_VHD_FILE_NOT_FOUND" error code (65) in Azure Kubernetes Service 

## Summary

This article discusses how to identify and resolve the `ERR_VHD_FILE_NOT_FOUND` error code (error code number 65) that occurs when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to create an AKS cluster, you receive the following error message.

> VMExtensionProvisioningError: VM has reported a failure when processing extension 'vmssCSE'.
>
> Error message: "Enable failed: failed to execute command: command terminated with exit status=65

## Cause

Under rare circumstances, the 65 exit code for the Azure Virtual Machine Scale Set custom script extension (`vmssCSE`) might happen instead of the following error codes.

| Error code name                             | Error code number |
|---------------------------------------------|-------------------|
| `OutboundConnFailVMExtensionError`          | 50                |
| `K8SAPIServerConnFailVMExtensionError`      | 51                |
| `K8SAPIServerDNSLookupFailVMExtensionError` | 52                |

This error occurs if a connectivity issue exists between your AKS cluster and the required Azure endpoints, such as `mcr.microsoft.com` or `acs-mirror.azureedge.net`.

## Solution

Review [outbound network and FQDN rules for Azure Kubernetes Service (AKS) clusters](/azure/aks/outbound-rules-control-egress) and ensure that you allow all API services' fully qualified domain names (FQDNs).

For detailed troubleshooting steps, refer to the following articles:

- [Troubleshoot the OutboundConnFailVMExtensionError error code (50)](error-code-outboundconnfailvmextensionerror.md)
- [Troubleshoot the K8SAPIServerConnFailVMExtensionError error code (51)](error-code-k8sapiserverconnfailvmextensionerror.md)
- [Troubleshoot the K8SAPIServerDNSLookupFailVMExtensionError error code (52)](error-code-k8sapiserverdnslookupfailvmextensionerror.md)

## References

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)
- [Outbound network and FQDN rules for Azure Kubernetes Service (AKS) clusters](/azure/aks/outbound-rules-control-egress)