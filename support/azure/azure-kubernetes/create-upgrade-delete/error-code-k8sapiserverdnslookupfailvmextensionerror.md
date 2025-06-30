---
title: Troubleshoot the K8SAPIServerDNSLookupFailVMExtensionError error code (52)
description: Learn how to troubleshoot the K8SAPIServerDNSLookupFailVMExtensionError error (52) when you try to start or create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.topic: article
ms.date: 06/14/2024
author: MicrosoftDocsExec
ms.author: MicrosoftDocsExec
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool), innovation-engine
---

# Troubleshoot the K8SAPIServerDNSLookupFailVMExtensionError error code (52)

This article discusses how to identify and resolve the `K8SAPIServerDNSLookupFailVMExtensionError` error (also known as error code ERR_K8S_API_SERVER_DNS_LOOKUP_FAIL, error number 52) that occurs when you try to start or create and deploy a Microsoft Azure Kubernetes Service (AKS) cluster.

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
> Error message: "**Enable failed: failed to execute command: command terminated with exit status=52**\n[stdout]\n{
>
> "ExitCode": "52",
>
> "Output": "Fri Oct 15 10:06:00 UTC 2021,aks- nodepool1-36696444-vmss000000\\nConnection to mcr.microsoft.com 443 port [tcp/https]

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

Below, set your AKS cluster and resource group names, then run the update command to reconcile the cluster. The environment variables will make your resource names unique and are declared just before use.

```azurecli-interactive
az resource update --resource-group $RESOURCE_GROUP_NAME \
    --name $CLUSTER_NAME \
    --namespace Microsoft.ContainerService \
    --resource-type ManagedClusters
```

Results: 

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

Also verify that your DNS server is configured correctly for your private cluster, as described earlier.

> [!NOTE]
> Conditional Forwarding doesn't support subdomains.

## More information

- [General troubleshooting of AKS cluster creation issues](troubleshoot-aks-cluster-creation-issues.md)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]