---
title: Troubleshoot the OutboundConnFailVMExtensionError error code (50)
description: Learn how to troubleshoot the OutboundConnFailVMExtensionError error (50) when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 3/22/2022
author: DennisLee-DennisLee
ms.author: v-dele
editor: v-jsitser
ms.reviewer: rissing, chiragpa, erbookbi
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-create-operations
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the OutboundConnFailVMExtensionError error code (or error code ERR_OUTBOUND_CONN_FAIL, error number 50) so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot the OutboundConnFailVMExtensionError error code (50)

This article describes how to identify and resolve the `OutboundConnFailVMExtensionError` error (also known as error code `ERR_OUTBOUND_CONN_FAIL`, error number 50) that might occur if you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- The [Netcat](https://linuxcommandlibrary.com/man/netcat) (nc) command-line tool

- The [dig](https://linux.die.net/man/1/dig) command-line tool

## Symptoms

When you try to create an AKS cluster, you receive the following error message:

> Unable to establish outbound connection from agents, please see <https://aka.ms/aks-required-ports-and-addresses> for more information.
>
> Details: Code="VMExtensionProvisioningError"
>
> Message="VM has reported a failure when processing extension 'vmssCSE'.
>
> Error message: "**Enable failed: failed to execute command: command terminated with exit status=50**\n[stdout]\n\n[stderr]\nnc: connect to mcr.microsoft.com port 443 (tcp) failed: Connection timed out\nCommand exited with non-zero status

## Cause

The custom script extension that downloads the necessary components to provision the nodes couldn't establish the necessary outbound connectivity to obtain packages. For public clusters, the nodes try to communicate with the Microsoft Container Registry (MCR) endpoint (`mcr.microsoft.com`) on port 443. There are many reasons why the traffic might be blocked. In any of these situations, the best way to test connectivity is to use the Secure Shell protocol (SSH) to connect to the node. To make the connection, follow the instructions in [Connect to Azure Kubernetes Service (AKS) cluster nodes for maintenance or troubleshooting](/azure/aks/node-access).

After you connect to the node, run the `nc` and `dig` commands to test the connectivity on the cluster:

```shell
nc -vz mcr.microsoft.com 443 
dig mcr.microsoft.com 443
```

## Solution

The following table lists specific reasons why traffic might be blocked, and the corresponding solution for each reason.

| Issue | Solution |
| ----- | -------- |
| Traffic is blocked by firewall rules | In this scenario, a firewall does egress filtering. To verify that all required domains and ports are allowed, see [Control egress traffic for cluster nodes in Azure Kubernetes Service (AKS)](/azure/aks/limit-egress-traffic). |
| Traffic is blocked by a cluster network security group (NSG) | On any NSGs that are attached to your cluster, verify that there's no blocking on port 443, port 53, or any other port that might have to be used to connect to the endpoint. For more information, see [Control egress traffic for cluster nodes in Azure Kubernetes Service (AKS)](/azure/aks/limit-egress-traffic). |
| The AAAA (IPv6) record is blocked on the firewall | On your firewall, verify that there's nothing that would block the endpoint from resolving in Azure DNS. |
| Private cluster can't resolve internal Azure resources | In private clusters, the Azure DNS IP address (`168.63.129.16`) must be added as an upstream DNS server if custom DNS is being used. Verify that the address is set on your DNS servers. For more information, see [Create a private AKS cluster](/azure/aks/private-clusters) and [What is IP address 168.63.129.16?](/azure/virtual-network/what-is-ip-address-168-63-129-16) |

## More information

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]
