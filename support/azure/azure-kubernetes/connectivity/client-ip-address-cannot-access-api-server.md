---
title: Client IP address can't access the API server
description: Troubleshoot issues caused when the client IP address can't access the API server on an Azure Kubernetes Service (AKS) cluster.
ms.date: 09/20/2024
ms.reviewer: rissing, chiragpa, v-leedennis
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want the AKS API server to allow access to my client IP address so that I can successfully connect to my AKS cluster.
ms.custom: sap:Connectivity
---
# Client IP address can't access the API server

This article describes how to fix issues that occur when you can't connect to an Azure Kubernetes Service (AKS) cluster because your client IP address can't access the AKS API server.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli).
- The client URL ([curl](https://techcommunity.microsoft.com/t5/containers/tar-and-curl-come-to-windows/ba-p/382409)) tool.

## Symptoms

### Azure CLI

You may see such errors as:

```output
"Unhandled Error" err="couldn't get current server API group list: Get \"https://<API-SERVER-FQDN>:443/api?timeout=32s\": dial tcp <API-SERVER-IP>:443: i/o timeout"

Unable to connect to the server: dial tcp <API-SERVER-IP>:443: i/o timeout

Unable to connect to the server: dial tcp <API-SERVER-IP>:443: connectex: A connection attempt failed because the connected party did not properly respond after a period, or established connection failed because connected host has failed to respond.
```

### Azure Portal

When you try to access Kubernetes resources such as Namespaces and Workloads, you may encounter the following errors:

```output
Network error

Unable to reach the api server 'https://<API-SERVER-FQDN>' or api server is too busy to respond. Check your network settings and refresh to try again.
```

  :::image type="content" source="media/client-ip-address-cannot-access-api-server/network-error.png" alt-text="Screenshot of Namespaces in the AKS resource."  lightbox="media/client-ip-address-cannot-access-api-server/network-error.png":::

## Cause

[API server-authorized IP ranges](/azure/aks/api-server-authorized-ip-ranges) may have been enabled on the cluster's API server, but the client's IP address wasn't included in the IP ranges. To check whether this feature has been enabled, see if the following [az aks show](/cli/azure/aks#az-aks-show) command in Azure CLI produces a list of IP ranges:

```azurecli
az aks show --resource-group <cluster-resource-group> \
    --name <cluster-name> \
    --query apiServerAccessProfile.authorizedIpRanges
```

## Solution

Look at the cluster's API server-authorized ranges, and add your client's IP address within that range using the following steps:

> [!NOTE]
>
> 1. Do you access the API server from a corporate network where traffic is routed through a proxy server or firewall? Then ask your network administrator before you add your client IP address to the list of authorized ranges for the API server.
>
> 1. Also ask your cluster administrator before you add your client IP address, because there might be security concerns with adding a temporary IP address to the list of authorized ranges.

### Azure CLI

1. Get your client IP address by running this [curl](https://curl.se/docs/manpage.html) command:

    ```output
    $ curl --silent checkip.dyndns.org
    <html><head><title>Current IP Check</title></head><body>Current IP Address: 0.255.127.63</body></html>
    ```

2. Update the API server-authorized range with the [az aks update](/cli/azure/aks#az-aks-update) command in Azure CLI, using your client IP address:

    ```azurecli
    az aks update --resource-group <cluster-resource-group> \
        --name <cluster-name> \
        --api-server-authorized-ip-ranges <ip-ranges-that-include-your-client-ip-address>
    ```

### Azure Portal

Update the API server-authorized range as shown in the screenshot below.

  :::image type="content" source="media/client-ip-address-cannot-access-api-server/authorized-ip-ranges.png" alt-text="Screenshot of Authorized-ip-ranges pane."  lightbox="media/client-ip-address-cannot-access-api-server/authorized-ip-ranges.png":::

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
