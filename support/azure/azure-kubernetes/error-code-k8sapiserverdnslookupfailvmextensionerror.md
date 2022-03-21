---
title: Troubleshoot the K8SAPIServerDNSLookupFailVMExtensionError error code (52)
description: Learn how to troubleshoot the K8SAPIServerDNSLookupFailVMExtensionError error (52) when you try to create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.date: 3/10/2022
author: DennisLee-DennisLee
ms.author: v-dele
editor: v-jsitser
ms.reviewer: rissing, chiragpa, erbookbi
ms.service: container-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the K8SAPIServerDNSLookupFailVMExtensionError error code (or error code ERR_K8S_API_SERVER_DNS_LOOKUP_FAIL, error number 52) so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot the K8SAPIServerDNSLookupFailVMExtensionError error code (52)

This article describes how to identify and resolve the `K8SAPIServerDNSLookupFailVMExtensionError` error (also known as error code ERR_K8S_API_SERVER_DNS_LOOKUP_FAIL, error number 52), which might occur if you try to create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- The [nslookup](/windows-server/administration/windows-commands/nslookup) command-line tool.

- [Azure CLI](/cli/azure/install-azure-cli), version 2.0.59 or higher. If Azure CLI is already installed, you can find the version number by entering `az --version`.

## Symptoms

When you try to create the cluster, you receive the following error message:

> Agents are unable to resolve Kubernetes API server name. It's likely custom DNS server is not correctly configured, please see <https://aka.ms/aks/private-cluster#hub-and-spoke-with-custom-dns> for more information.
>
> Details: Code="VMExtensionProvisioningError"
>
> Message="VM has reported a failure when processing extension 'vmssCSE'.
>
> Error message: "**Enable failed: failed to execute command: command terminated with exit status=52**\n[stdout]\n{
>
> "ExitCode": "52",
>
> "Output": "Fri Oct 15 10:06:00 UTC 2021,aks- nodepool1-36696444-vmss000000\\nConnection to mcr.microsoft.com 443 port [tcp/https] 

## Cause

The cluster nodes can't resolve the cluster's fully qualified domain name (FQDN) in Azure DNS. Enter the `nslookup` command on the failed cluster node to find DNS resolutions that are valid.

```shell
nslookup <cluster-fqdn>
```

## Solution

On your DNS servers and firewall, make sure that nothing blocks the resolution to your cluster's FQDN. Your custom DNS server might be incorrectly configured if something is blocking even after you ran the `nslookup` command and applied any necessary fixes. For help in configuring your custom DNS server, review the following articles:

- [Create a private AKS cluster](/azure/aks/private-clusters)
- [Private Azure Kubernetes service with custom DNS server](https://github.com/Azure/terraform/tree/00d15e09c54f25fb6387330c36aa4366122c5aaa/quickstart/301-aks-private-cluster)
- [What's IP address 168.63.129.16?](/azure/virtual-network/what-is-ip-address-168-63-129-16)

When you use a private cluster with custom DNS, a DNS zone is created. The DNS zone must be linked to the virtual network, which will happen after the cluster is created. Creating a private cluster with custom DNS will fail at creation time, but you can bring it back to a succeeded state by reconciling the cluster. Enter the [az resource update](/cli/azure/resource#az-resource-update) command in Azure CLI, as follows:

```azurecli-interactive
az resource update --resource-group <resource-group-name> \
    --name <cluster-name> \
    --namespace Microsoft.ContainerService \
    --resource-type ManagedClusters
```

Also verify that your DNS server is configured correctly for your private cluster, as described earlier.

## More information

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)
