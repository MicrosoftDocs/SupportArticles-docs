---
title: Troubleshoot Container Network Interface download failures
description: Learn how to resolve Container Network Interface download failures when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 05/05/2025
editor: v-jsitser
ms.reviewer: axelg, chiragpa, mariochaves, v-weizhu, v-leedennis
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the container network interface download failures so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot Container Network Interface download failures

This article discusses how to identify and resolve the `CniDownloadTimeoutVMExtensionError` error code (also known as error code `ERR_CNI_DOWNLOAD_TIMEOUT`, error number 41) or the `WINDOWS_CSE_ERROR_DOWNLOAD_CNI_PACKAGE` error code (error number 35) that occurs when you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- The [Curl](https://curl.se/download.html) command-line tool

## Symptoms

When you try to create a Linux-based AKS cluster, you receive the following error message:

```output
Message: We are unable to serve this request due to an internal error
SubCode: CniDownloadTimeoutVMExtensionError;
Message="VM has reported a failure when processing extension 'vmssCSE'.
Error message: "Enable failed: failed to execute command: command terminated with exit status=41\n[stdout]\n{
"ExitCode": "41",
```

When you try to create a Windows-based AKS cluster, you receive the following error message:

```output
Message="VM has reported a failure when processing extension 'vmssCSE' (publisher 'Microsoft.Compute' and type 'CustomScriptExtension').
Error message: 'Command execution finished, but failed because it returned a non-zero exit code of: '1'. The command had an error output of: 'ExitCode: |35|,
Output: |WINDOWS_CSE_ERROR_DOWNLOAD_CNI_PACKAGE|, Error: |Failed in downloading \r\nhttps://acs-mirror.azureedge.net/azure-cni/v1.4.56/binaries/azure-vnet-cni-overlay-windows-amd64-v1.4.56.zip.
Error: \r\nUnable to connect to the r|\r\nAt line:1 ...'
For more information, check the instance view by executing Get-AzVmssVm or Get-AzVm (https://aka.ms/GetAzVm). These commands can be executed using CloudShell (https://aka.ms/CloudShell)'. More information on troubleshooting is available at https://aka.ms/VMExtensionCSEWindowsTroubleshoot.
```

## Cause

Your cluster nodes can't connect to the endpoint that's used to download the Container Network Interface (CNI) libraries. In most cases, this issue occurs because a network virtual appliance is blocking Secure Sockets Layer (SSL) communication or an SSL certificate.

## Solution

Run a Curl command to verify that your nodes can download the binaries:

```bash
curl https://acs-mirror.azureedge.net/cni/azure-vnet-cni-linux-amd64-v1.0.25.tgz

curl --fail --ssl https://acs-mirror.azureedge.net/cni/azure-vnet-cni-linux-amd64-v1.0.25.tgz  --output /opt/cni/downloads/azure-vnet-cni-linux-amd64-v1.0.25.tgz
```

If you can't download these files, make sure that traffic is allowed to the downloading endpoint. For more information, see [Azure Global required FQDN/application rules](/azure/aks/outbound-rules-control-egress#azure-global-required-fqdn--application-rules).

## References

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
