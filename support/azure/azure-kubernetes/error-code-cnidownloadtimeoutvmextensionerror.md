---
title: Troubleshoot the CniDownloadTimeoutVMExtensionError error code
description: Learn how to troubleshoot the CniDownloadTimeoutVMExtensionError error (41) when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 05/03/2023
editor: v-jsitser
ms.reviewer: axelg, chiragpa, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-create-operations
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the CniDownloadTimeoutVMExtensionError error code (error number 41) so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot the CniDownloadTimeoutVMExtensionError error code (41)

This article discusses how to identify and resolve the `CniDownloadTimeoutVMExtensionError` error (also known as error code `ERR_CNI_DOWNLOAD_TIMEOUT`, error number 41) that occurs when you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- The [Curl](https://curl.se/download.html) command-line tool

## Symptoms

When you try to create an AKS cluster, you receive the following error message:

> Message: We are unable to serve this request due to an internal error
>
> SubCode: CniDownloadTimeoutVMExtensionError;
>
> Message="VM has reported a failure when processing extension 'vmssCSE'.
>
> Error message: "**Enable failed: failed to execute command: command terminated with exit status=41**\n[stdout]\n{
>
> "ExitCode": "41",

## Cause

Your cluster nodes can't connect to the endpoint that's used to download the container network interface (CNI) libraries. In most cases, this issue occurs because a network virtual appliance is blocking Secure Sockets Layer (SSL) communication or an SSL certificate.

## Solution

Run a Curl command to verify that your nodes can download the binaries:

```bash
curl https://acs-mirror.azureedge.net/cni/azure-vnet-cni-linux-amd64-v1.0.25.tgz

curl --fail --ssl https://acs-mirror.azureedge.net/cni/azure-vnet-cni-linux-amd64-v1.0.25.tgz  --output /opt/cni/downloads/azure-vnet-cni-linux-amd64-v1.0.25.tgz
```

If you can't download these files, make sure that traffic is allowed to the downloading endpoint. For more information, see [Azure Global required FQDN / application rules](/azure/aks/outbound-rules-control-egress#azure-global-required-fqdn--application-rules).

## References

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
