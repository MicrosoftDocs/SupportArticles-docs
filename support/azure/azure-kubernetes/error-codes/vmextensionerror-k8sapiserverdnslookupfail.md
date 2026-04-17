---
title: Troubleshoot the VMExtensionError_K8SAPIServerDNSLookupFail error message 
description: Fix the VMExtensionError_K8SAPIServerDNSLookupFail error in AKS. Learn how to resolve DNS lookup failures and successfully create or deploy your AKS cluster.
ms.date: 03/12/2025
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis, jovieir, mariusbutuc
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the VMExtensionError_K8SAPIServerDNSLookupFail error code (or error code ERR_K8S_API_SERVER_DNS_LOOKUP_FAIL) so that I can successfully start or create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the VMExtensionError_K8SAPIServerDNSLookupFail error in AKS

## Summary

This article explains how to identify and resolve the `VMExtensionError_K8SAPIServerDNSLookupFail` error (also known as error code ERR_K8S_API_SERVER_DNS_LOOKUP_FAIL) in Azure Kubernetes Service (AKS) when you try to start, create, or deploy a cluster.

## Prerequisites

- The [nslookup](/windows-server/administration/windows-commands/nslookup) DNS lookup tool for Windows nodes or the [dig](https://linuxize.com/post/how-to-use-dig-command-to-query-dns-in-linux/) tool for Linux nodes.

- [Azure CLI](/cli/azure/install-azure-cli), version 2.0.59 or a later version. If Azure CLI is already installed, you can find the version number by running `az --version`.

## Symptoms

When you try to start or create an AKS cluster, you receive the following error message:

> Agents are unable to resolve Kubernetes API server name. It's likely custom DNS server is not correctly configured, please see <https://aka.ms/aks/private-cluster#hub-and-spoke-with-custom-dns> for more information.
>
> Details: Code="VMExtensionProvisioningError"
>
> Message="VM has reported a failure when processing extension 'vmssCSE'.
>
> Error message: **CSE failed with 'VMExtensionError_K8SAPIServerDNSLookupFail'. Agents are unable to resolve Kubernetes API server name. It's likely custom DNS server is not correctly configured, please see https://aka.ms/aks/vmextensionerror_k8sapiserverdnslookupfail and https://aka.ms/aks/private-cluster#hub-and-spoke-with-custom-dns for more information.**

## Cause

The cluster nodes can't resolve the cluster's fully qualified domain name (FQDN) in Azure DNS. Run the following DNS lookup command on the failed cluster node to find DNS resolutions that are valid.

| Node OS | Command                   |
| ------- | ------------------------- |
| Linux   | `dig <cluster-fqdn>`      |
| Windows | `nslookup <cluster-fqdn>` |

## Solution

On your DNS servers and firewall, make sure that nothing blocks the resolution to your cluster's FQDN. Your custom DNS server might be incorrectly configured if something is blocking even after you run the `nslookup` or `dig` command and apply any necessary fixes. For help to configure your custom DNS server, review the following articles:

- [Create a private AKS cluster](/azure/aks/private-clusters)
- [Private Azure Kubernetes service with custom DNS server](https://github.com/Azure/terraform/tree/00d15e09c54f25fb6387330c36aa4366122c5aaa/quickstart/301-aks-private-cluster)
- [What is IP address 168.63.129.16?](/azure/virtual-network/what-is-ip-address-168-63-129-16)

When you use a private cluster that has a custom DNS, a DNS zone is created. The DNS zone must be linked to the virtual network. This occurs after the cluster is created. Creating a private cluster that has a custom DNS fails during creation. However, you can restore the creation process to a "success" state by reconciling the cluster. To do this, run the [az resource update](/cli/azure/resource#az-resource-update) command in Azure CLI, as follows:

```azurecli-interactive
az resource update --resource-group <resource-group-name> \
    --name <cluster-name> \
    --namespace Microsoft.ContainerService \
    --resource-type ManagedClusters
```

Also verify that your DNS server is configured correctly for your private cluster, as described earlier.

> [!NOTE]
> Conditional Forwarding doesn't support subdomains.

## More information

- [General troubleshooting of AKS cluster creation issues](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md)

 
