---
title: Troubleshoot K8SAPIServerDNSLookupFailVMExtensionError error code (52) in AKS
description: Learn how to troubleshoot the K8SAPIServerDNSLookupFailVMExtensionError (52) DNS lookup failure when you start or create an AKS cluster. Follow these steps to fix it.
ms.date: 11/13/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: rissing, chiragpa, erbookbi, v-leedennis, jovieir, andraciobanu, ksadineni, kaushika
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the K8SAPIServerDNSLookupFailVMExtensionError error code (or error code ERR_K8S_API_SERVER_DNS_LOOKUP_FAIL, error number 52) so that I can successfully start or create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool),  innovation-engine
ai-usage: ai-assisted
---
# Troubleshoot the "K8SAPIServerDNSLookupFailVMExtensionError" error code (52) in Azure Kubernetes Service

## Summary

This article helps you troubleshoot the `K8SAPIServerDNSLookupFailVMExtensionError` error code (also known as `ERR_K8S_API_SERVER_DNS_LOOKUP_FAIL`, error number 52) so that you can successfully start or create and deploy an Azure Kubernetes Service (AKS) cluster.

## Prerequisites

Ensure you have the following prerequisites installed and configured:

- The [nslookup](/windows-server/administration/windows-commands/nslookup) DNS lookup tool for Windows nodes or the [dig](https://linuxize.com/post/how-to-use-dig-command-to-query-dns-in-linux/) tool for Linux nodes.

- [Azure CLI](/cli/azure/install-azure-cli), version 2.0.59 or a later version. If Azure CLI is already installed, you can find the version number by running `az --version`.

## Symptoms

When you try to start or create an AKS cluster, you receive the following error message.

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

The cluster nodes can't resolve the cluster's fully qualified domain name (FQDN). This issue can occur when the DNS configuration available to the node doesn't return a valid response for the Kubernetes API server FQDN.

The following table shows the DNS lookup command to use for each node OS.

| Node OS | Command                   |
| ------- | ------------------------- |
| Linux   | `dig <cluster-fqdn>`      |
| Windows | `nslookup <cluster-fqdn>` |

## Solution

On your Domain Name System (DNS) servers and firewall, ensure that nothing blocks the resolution to your cluster's FQDN. Your custom DNS server might be incorrectly configured if something blocks resolution even after you run the `nslookup` or `dig` command and apply any necessary fixes. For help configuring your custom DNS server, review the following articles:

- [Create a private AKS cluster](/azure/aks/private-clusters)
- [Private Azure Kubernetes service with custom DNS server](https://github.com/Azure/terraform/tree/00d15e09c54f25fb6387330c36aa4366122c5aaa/quickstart/301-aks-private-cluster)
- [What is IP address 168.63.129.16?](/azure/virtual-network/what-is-ip-address-168-63-129-16)

When you use a private cluster that has a custom DNS, a DNS zone is created. You must link the DNS zone to the virtual network. This linkage occurs after the cluster is created. Creating a private cluster that has a custom DNS fails during creation. However, you can restore the creation process to a `success` state by reconciling the cluster. To do this, run the [az resource update](/cli/azure/resource#az-resource-update) command in Azure CLI, as follows:

Set your AKS cluster and resource group names, and then run the update command to reconcile the cluster. You declare the environment variables that make your resource names unique just before use.

```azurecli-interactive
az resource update --resource-group $RESOURCE_GROUP_NAME \
    --name $CLUSTER_NAME \
    --namespace Microsoft.ContainerService \
    --resource-type ManagedClusters
```

The following example shows the output.

<!-- expected_similarity=0.3 -->

```output
{
  "id": "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/myResourceGroupxxx/providers/Microsoft.ContainerService/ManagedClusters/myAksClusterxxx",
  "location": "eastus",
  "name": "myAksClusterxxx",
  "properties": {
      // ...other properties...
  },
  "resourceGroup": "myResourceGroupxxx",
  "type": "Microsoft.ContainerService/ManagedClusters"
}
```

Also verify that your DNS server is configured correctly for your private cluster as previously described.

> [!NOTE]
> Conditional Forwarding doesn't support subdomains.

Because the affected node might be in a failed provisioning state and unavailable through Secure Shell (SSH) or Remote Desktop Protocol (RDP), use `az vmss run-command invoke` to run the DNS lookup directly on the virtual machine scale set instance.

### Test DNS resolution from a Linux node

Run `dig` against the cluster FQDN.

```azurecli
az vmss run-command invoke \
  --resource-group <mc-resource-group-name> \
  --name <vmss-name> \
  --instance-id <instance-id> \
  --command-id RunShellScript \
  --scripts "dig <cluster-fqdn>"
```

### Test DNS resolution from a Windows node

Run `nslookup` against the cluster FQDN.

```azurecli
az vmss run-command invoke \
  --resource-group <mc-resource-group-name> \
  --name <vmss-name> \
  --instance-id <instance-id> \
  --command-id RunPowerShellScript
```

## References

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)
 
