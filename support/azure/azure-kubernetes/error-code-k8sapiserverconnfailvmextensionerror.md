---
title: Troubleshoot the K8SAPIServerConnFailVMExtensionError error code
description: Learn how to troubleshoot the K8SAPIServerConnFailVMExtensionError error (51) when you try to start or create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 01/08/2024
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis, jovieir
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-create-operations
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the K8SAPIServerConnFailVMExtensionError error code (or error code ERR_K8S_API_SERVER_CONN_FAIL, error number 51) so that I can successfully start or create and deploy an Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot the K8SAPIServerConnFailVMExtensionError error code (51)

This article discusses how to identify and resolve the `K8SAPIServerConnFailVMExtensionError` error (also known as error code ERR_K8S_API_SERVER_CONN_FAIL, error number 51) that occurs when you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- The [Netcat](https://linuxcommandlibrary.com/man/netcat) (nc) command-line tool

## Symptoms

When you try to start or create an AKS cluster, you receive the following error message:

> Unable to establish connection from agents to Kubernetes API server, please see <https://aka.ms/aks-required-ports-and-addresses> for more information.
>
> Details: Code="VMExtensionProvisioningError"
>
> Message="VM has reported a failure when processing extension 'vmssCSE'.
>
> Error message: "**Enable failed: failed to execute command: command terminated with exit status=51**\n[stdout]\n{
>
> "ExitCode": "51",
>
> "Output": "Thu Oct 14 18:07:37 UTC 2021,aks-nodepool1-18315663-vmss000000\\nConnection to

## Cause

Your cluster nodes can't connect to your cluster API server pod.

## Solution

Run a Netcat command to verify that your nodes can resolve the cluster's fully qualified domain name (FQDN):

```shell
nc -vz <cluster-fqdn> 443
```

If you're using egress filtering through a firewall, make sure that traffic is allowed to your cluster FQDN.

In rare cases, the firewall's outbound IP address can be blocked if you've authorized IP addresses that are enabled on your cluster. In this scenario, you must add the outbound IP address of your firewall to the list of authorized IP ranges for the cluster. For more information, see [Secure access to the API server using authorized IP address ranges in AKS](/azure/aks/api-server-authorized-ip-ranges).

## More information

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
