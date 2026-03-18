---
title: Troubleshoot the VMExtensionError_K8SAPIServerConnFail message
description: Learn how to troubleshoot the VMExtensionError_K8SAPIServerConnFail message when you try to start or create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 01/24/2024
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis, jovieir
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the VMExtensionError_K8SAPIServerConnFail error code (or error code ERR_K8S_API_SERVER_CONN_FAIL, error number 51) so that I can successfully start or create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the VMExtensionError_K8SAPIServerConnFail message

## Summary

This article explains how to identify and resolve the `VMExtensionError_K8SAPIServerConnFail` message (also known as error code ERR_K8S_API_SERVER_CONN_FAIL) so that you can successfully start or create and deploy an Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- The [Netcat](https://linuxcommandlibrary.com/man/netcat) command-line tool.

## Symptoms

When you try to start or create an AKS cluster, you receive the following error message:

> Unable to establish connection from agents to Kubernetes API server, please see <https://aka.ms/aks-required-ports-and-addresses> for more information.
>
> Details: Code="VMExtensionProvisioningError"
>
> Message="VM has reported a failure when processing extension 'vmssCSE'.
>
> Error message: "CSE failed with 'VMExtensionError_K8SAPIServerConnFail'. Agents are unable to establish connection to Kubernetes API server, please see https://aka.ms/aks/vmextensionerror_k8sapiserverconnfail and https://aka.ms/aks-required-ports-and-addresses for more information.
>
> “In some logs, this may also appear as exit status=51 / ExitCode: 51"

## Cause

Your cluster nodes can't connect to your cluster API server pod.

## Solution

Run a Netcat command to verify that your nodes can resolve the cluster's fully qualified domain name (FQDN):

```shell
nc -vz <cluster-fqdn> 443
```

If you're using egress filtering through a firewall, make sure that traffic is allowed to your cluster FQDN.

In rare cases, the firewall's outbound IP address can be blocked if you authorized IP addresses that are enabled on your cluster. In this scenario, you must add the outbound IP address of your firewall to the list of authorized IP ranges for the cluster. For more information, see [Secure access to the API server using authorized IP address ranges in AKS](/azure/aks/api-server-authorized-ip-ranges).

## More information

- [General troubleshooting of AKS cluster creation issues](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md)

 
