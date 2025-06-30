---
title: Troubleshoot Container Network Interface download failures
description: Learn how to resolve Container Network Interface download failures when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.topic: article
ms.date: 06/12/2024
author: v-jsitser
ms.author: v-jsitser
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool), innovation-engine
editor: v-jsitser
ms.reviewer: axelg, chiragpa, mariochaves, v-weizhu, v-leedennis
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the container network interface download failures so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
---

# Troubleshoot Container Network Interface download failures

This article discusses how to identify and resolve the `CniDownloadTimeoutVMExtensionError` error code (also known as error code `ERR_CNI_DOWNLOAD_TIMEOUT`, error number 41) or the `WINDOWS_CSE_ERROR_DOWNLOAD_CNI_PACKAGE` error code (error number 35) that occurs when you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- The [Curl](https://curl.se/download.html) command-line tool
- Network access from the same environment where AKS nodes will be deployed (same VNet, firewall rules, etc.)

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

First, attempt a test download of the Azure CNI package for Linux from the official mirror endpoint.

```bash
curl -I https://acs-mirror.azureedge.net/cni/azure-vnet-cni-linux-amd64-v1.0.25.tgz
```

Results:

<!-- expected_similarity=0.3 -->

```output
HTTP/2 200 
content-length: 970752
content-type: application/x-gzip
last-modified: Wed, 22 Jun 2022 00:00:00 GMT
etag: "0x8DA53F1234567"
server: ECAcc (dab/4B9E)
x-cache: HIT
cache-control: public, max-age=86400
accept-ranges: bytes
date: Thu, 05 Jun 2025 00:00:00 GMT
```

This command checks if the endpoint is reachable and returns the HTTP headers. If you see a `200 OK` response, it indicates that the endpoint is accessible.

Next, attempt a download with validation and save the file locally for further troubleshooting. This will help determine if SSL or outbound connectivity is correctly configured.

```bash
# Create a temporary directory for testing
mkdir -p /tmp/cni-test

# Download the CNI package to the temp directory
curl -L --fail https://acs-mirror.azureedge.net/cni/azure-vnet-cni-linux-amd64-v1.0.25.tgz --output /tmp/cni-test/azure-vnet-cni-linux-amd64-v1.0.25.tgz && echo "Download successful" || echo "Download failed"
```

Results:

<!-- expected_similarity=0.3 -->

```output
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 6495k  100 6495k    0     0  8234k      0 --:--:-- --:--:-- --:--:-- 8230k
Download successful
```

Verify the downloaded file:

```bash
ls -la /tmp/cni-test/
file /tmp/cni-test/azure-vnet-cni-linux-amd64-v1.0.25.tgz
```

Results:

<!-- expected_similarity=0.3 -->

```output
total 6500
drwxr-xr-x 2 user user    4096 Jun 20 10:30 .
drwxrwxrwt 8 root root    4096 Jun 20 10:30 ..
-rw-r--r-- 1 user user 6651392 Jun 20 10:30 azure-vnet-cni-linux-amd64-v1.0.25.tgz

/tmp/cni-test/azure-vnet-cni-linux-amd64-v1.0.25.tgz: gzip compressed data, from Unix, original size modulo 2^32 20070400
```

Clean up the test files:

```bash
rm -rf /tmp/cni-test/
```

If you can't download these files, make sure that traffic is allowed to the downloading endpoint. For more information, see [Azure Global required FQDN/application rules](/azure/aks/outbound-rules-control-egress#azure-global-required-fqdn--application-rules).

## References

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]