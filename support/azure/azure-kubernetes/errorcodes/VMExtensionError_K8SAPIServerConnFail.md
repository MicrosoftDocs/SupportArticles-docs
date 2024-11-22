---
title: VMExtensionError_K8SAPIServerConnFail error code 
description: Learn how to troubleshoot the VMExtensionError_K8SAPIServerConnFail error when you try to start or create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 01/24/2024
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis, jovieir
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the VMExtensionError_K8SAPIServerConnFail error code so that I can successfully start or create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the VMExtensionError_K8SAPIServerConnFail error code

This article discusses how to identify and resolve the `VMExtensionError_K8SAPIServerConnFail` error (also known as error code ERR_K8S_API_SERVER_CONN_FAIL, error number 51) that occurs when you try to start or create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- The [Netcat](https://linuxcommandlibrary.com/man/netcat) (nc) command-line tool

## Symptoms

When you try to start or create an AKS cluster, you receive the following error message:

> **Code**: VMExtensionError_K8SAPIServerConnFail
>
> **Message**: Unable to establish connection from agents to Kubernetes API server. Please see https://aka.ms/aks-error/VMExtensionError_K8SAPIServerConnFail and https://aka.ms/aks-required-ports-and-addresses for more information.  
> 
>
> **Details** </br>
> &ensp;**Code**: VMExtensionProvisioningError</br>
> &ensp;**Message**:  VM has reported a failure when processing extension 'vmssCSE' (publisher 'Microsoft.Azure.Extensions' and type 'CustomScript'). Error message: 'Enable failed: failed to execute command: command terminated with exit status=51\n[stdout]...

## Cause

Your cluster nodes cannot connect to your cluster API server pod.

## Solution

Run a Netcat command to verify that your nodes can resolve the cluster's fully qualified domain name (FQDN):

```shell
nc -vz <cluster-fqdn> 443
```

If you're using egress filtering through a firewall, make sure that traffic is allowed to your cluster FQDN.

In rare cases, the firewall's outbound IP address can be blocked if you've authorized IP addresses that are enabled on your cluster. In this scenario, you must add the outbound IP address of your firewall to the list of authorized IP ranges for the cluster. For more information, see [Secure access to the API server using authorized IP address ranges in AKS](/azure/aks/api-server-authorized-ip-ranges).

## More information

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
