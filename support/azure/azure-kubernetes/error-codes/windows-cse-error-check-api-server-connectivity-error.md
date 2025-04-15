---
title: Troubleshoot WINDOWS_CSE_ERROR_CHECK_API_SERVER_CONNECTIVITY error (5)
description: Learn how to troubleshoot the WINDOWS_CSE_ERROR_CHECK_API_SERVER_CONNECTIVITY error (5) when you try to add Windows node pools in an AKS cluster.
ms.date: 10/31/2023
ms.reviewer: shtao, abelch, junjiezhang, v-weizhu
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the WINDOWS_CSE_ERROR_CHECK_API_SERVER_CONNECTIVITY error (5) so that I can successfully add Windows node pools in an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot WINDOWS_CSE_ERROR_CHECK_API_SERVER_CONNECTIVITY error code (5)

This article discusses how to identify and resolve the "WINDOWS_CSE_ERROR_CHECK_API_SERVER_CONNECTIVITY" error (5) that occurs when you try to add a Windows node pool in an Azure Kubernetes Service (AKS) cluster.

## Prerequisites

One of the following tools is required:

- The PowerShell command-line shell for Windows nodes.
- The [Netcat](https://linuxcommandlibrary.com/man/netcat) (`nc`) command-line tool for Linux nodes.

## Symptoms

When you try to add a Windows node pool in an AKS cluster, you receive the following error message:

> Code="VMExtensionProvisioningError"  
> Message="CSE Error: WINDOWS_CSE_ERROR_CHECK_API_SERVER_CONNECTIVITY." Exit Code: 5. Details: Unable to establish connection from agents to Kubernetes API server.

## Cause

Your cluster nodes can't connect to the cluster API server pod.

## Troubleshooting steps

1. Verify that your nodes can resolve the cluster's fully qualified domain name (FQDN):

    On existing Windows nodes, run the following command:

    ```powershell
    Test-NetConnection -ComputerName <cluster-fqdn> -Port 443
    ```

    Or, on existing Linux nodes, run the following command:

    ```bash
    nc -vz <cluster-fqdn> 443
    ```

2. If the command output shows `False` or `Timeout`, check your network configuration. For example, check whether you set "Deny" rules for the API server in network security groups (NSGs) of the virtual network.

3. If you're using egress filtering through a firewall, make sure that traffic is allowed to your cluster FQDN.

4. If you've authorized IP addresses that are enabled on your cluster, the firewall's outbound IP address can be blocked. In this scenario, you must add the outbound IP address of the firewall to the list of authorized IP ranges for the cluster. For more information, see [Secure access to the API server using authorized IP address ranges in AKS](/azure/aks/api-server-authorized-ip-ranges).

## References

[General troubleshooting of AKS cluster creation issues](./create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
