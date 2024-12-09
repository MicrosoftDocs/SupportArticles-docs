---
title: Troubleshoot the VMExtensionError_CNIDownloadTimeout error code
description: Learn how to troubleshoot the VMExtensionError_CNIDownloadTimeout error when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 05/03/2023
editor: v-jsitser
ms.reviewer: axelg, chiragpa, v-leedennis
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the VMExtensionError_CNIDownloadTimeout error code so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the VMExtensionError_CNIDownloadTimeout error code

This article discusses how to identify and resolve the `VMExtensionError_CNIDownloadTimeout` error (also known as error code `ERR_CNI_DOWNLOAD_TIMEOUT`, error number 41) that occurs when you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- The [Curl](https://curl.se/download.html) command-line tool

## Symptoms

When you try to create an AKS cluster, you receive the following error message:

> **Code**: VMExtensionError_CNIDownloadTimeout
>
> **Message**: Agents are unable to connect to the endpoint that's used to download the container network interface libraries. It's likely that a network virtual appliance is blocking SSL communication or an SSL certificate, please see https://aka.ms/aks-error/VMExtensionError_CNIDownloadTimeout for more information  
> 
>
> **Details** </br>
> &ensp;**Code**: VMExtensionProvisioningError</br>
> &ensp;**Message**:  VM has reported a failure when processing extension 'vmssCSE' (publisher 'Microsoft.Azure.Extensions' and type 'CustomScript'). Error message: 'Enable failed: failed to execute command: command terminated with exit status=41\n[stdout]...


## Cause

Your cluster nodes cannot connect to the endpoint that are used to download the container network interface (CNI) libraries. In most cases, this issue occurs because a network virtual appliance is blocking Secure Sockets Layer (SSL) communication or an SSL certificate.

## Solution

Run Curl commands to verify that your nodes can download the binaries:

```bash
curl https://acs-mirror.azureedge.net/cni/azure-vnet-cni-linux-amd64-v1.0.25.tgz

curl --fail --ssl https://acs-mirror.azureedge.net/cni/azure-vnet-cni-linux-amd64-v1.0.25.tgz  --output /opt/cni/downloads/azure-vnet-cni-linux-amd64-v1.0.25.tgz
```

If you cannot download these files, make sure that traffic is allowed to the downloading endpoint. For more information, see [Azure Global required FQDN / application rules](/azure/aks/outbound-rules-control-egress#azure-global-required-fqdn--application-rules).

## References

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
