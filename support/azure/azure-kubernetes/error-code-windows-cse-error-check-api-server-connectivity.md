---
title: Troubleshoot the WINDOWS_CSE_ERROR_CHECK_API_SERVER_CONNECTIVITY error code
description: Learn how to troubleshoot the WINDOWS_CSE_ERROR_CHECK_API_SERVER_CONNECTIVITY error (5) when you try to add Windows node pools in AKS cluster.
ms.date: 10/24/2023
editor: shtao
ms.reviewer: abelch, junjiezhang
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-create-operations
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the WINDOWS_CSE_ERROR_CHECK_API_SERVER_CONNECTIVITY error (5) so that I can successfully add Windows node pools in Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot the WINDOWS_CSE_ERROR_CHECK_API_SERVER_CONNECTIVITY error (5)

This article discusses how to identify and resolve the `WINDOWS_CSE_ERROR_CHECK_API_SERVER_CONNECTIVITY` error (5) that occurs when you try to add Windows node pools in Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- The `Powershell` on Windows nodes or the [Netcat](https://linuxcommandlibrary.com/man/netcat) (nc) command-line tool on Linux nodes.

## Symptoms

When you try to add an AKS Windows nodepool, you receive the following error message:

> Code="VMExtensionProvisioningError"
> Message="CSE Error: WINDOWS_CSE_ERROR_CHECK_API_SERVER_CONNECTIVITY. Exit Code: 5. Details: Unable to establish connection from agents to Kubernetes API server.

## Cause

Your cluster nodes can't connect to your cluster API server pod.

## Troubleshooting

Run a Test-NetConnection command to verify that your nodes can resolve the cluster's fully qualified domain name (FQDN):

If you have existing Windows nodes, you can run:
```powershell
Test-NetConnection -ComputerName <cluster-fqdn> -Port 443
```

Or you must have Linux nodes, you can run:
```shell
nc -vz <cluster-fqdn> 443
```

## Solution

You should check your network configuration if the above result shows "False" or "Timeout." For example, check whether you have `Deny` rules for API Server in VNet NSG (Network Security Groups).

If you're using egress filtering through a firewall, make sure that traffic is allowed to your cluster FQDN.

In rare cases, the firewall's outbound IP address can be blocked if you've authorized IP addresses that are enabled on your cluster. In this scenario, you must add the outbound IP address of your firewall to the list of authorized IP ranges for the cluster. For more information, see [Secure access to the API server using authorized IP address ranges in AKS](/azure/aks/api-server-authorized-ip-ranges).

## More information

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]
