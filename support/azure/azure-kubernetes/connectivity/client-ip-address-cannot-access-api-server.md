---
title: Client IP address cant access the API server for AKS
description: Learn how to troubleshoot when a client IP address can't access the AKS API server and restore cluster connectivity quickly. Try these steps now.
ms.date: 10/30/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: rissing, chiragpa, jaewonpark, v-leedennis, v-weizhu, kaushika
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want the AKS API server to allow access to my client IP address so that I can successfully connect to my AKS cluster.
ms.custom: sap:Connectivity, innovation-engine
ai-usage: ai-assisted
---

# Client IP address can't access the API server for Azure Kubernetes Service

## Summary

This article explains how to troubleshoot when a client IP address can't access the API server for Azure Kubernetes Service (AKS) so you can restore connectivity to your cluster.

## Prerequisites

Ensure the following prerequisites are met before troubleshooting access to the AKS API server:

- [Azure CLI](/cli/azure/install-azure-cli).
- The client URL ([curl](https://techcommunity.microsoft.com/t5/containers/tar-and-curl-come-to-windows/ba-p/382409)) tool.

## Symptoms

The following symptoms indicate that your client IP address can't access the AKS API server.

### [Azure portal](#tab/azure-portal)

When you try to access Kubernetes resources such as namespaces and workloads from the [Azure portal](https://portal.azure.com), you might encounter the following error.

> Network error
>
> Unable to reach the api server 'https://\<API-server-FQDN>' or api server is too busy to respond. Check your network settings and refresh to try again.

:::image type="content" source="media/client-ip-address-cannot-access-api-server/network-error.png" alt-text="Screenshot of the AKS portal view showing a network error when connecting to the API server from namespaces and workloads." lightbox="media/client-ip-address-cannot-access-api-server/network-error.png":::

### [Azure CLI](#tab/azure-cli)

When you try to connect to a cluster by using Azure CLI, you might see the following errors.

```output
"Unhandled Error" err="couldn't get current server API group list: Get \"https://<API-SERVER-FQDN>:443/api?timeout=32s\": dial tcp <API-SERVER-IP>:443: i/o timeout"

Unable to connect to the server: dial tcp <API-SERVER-IP>:443: i/o timeout

Unable to connect to the server: dial tcp <API-SERVER-IP>:443: connectex: A connection attempt failed because the connected party did not properly respond after a period, or established connection failed because connected host has failed to respond.
```

---

## Cause

You might have enabled [API server-authorized IP ranges](/azure/aks/api-server-authorized-ip-ranges) on the cluster's API server, but you didn't include the client's IP address in the IP ranges. To check whether this feature is enabled, see if the following [az aks show](/cli/azure/aks#az-aks-show) command in Azure CLI returns a list of IP ranges.

```azurecli
az aks show --resource-group ${RG_NAME} \
    --name ${CLUSTER_NAME} \
    --query apiServerAccessProfile.authorizedIpRanges
```

## Solution

Look at the cluster's API server-authorized ranges, and add your client's IP address within that range.

> [!NOTE]
> Do you access the API server from a corporate network where traffic routes through a proxy server or firewall? If so, ask your network administrator before you add your client IP address to the list of authorized ranges for the API server.
> Also, ask your cluster administrator before you add your client IP address, because there might be security concerns with adding a temporary IP address to the list of authorized ranges.

### [Azure portal](#tab/azure-portal)

Follow these steps to add your client IP address to the authorized IP ranges for the AKS API server:

1. Go to the cluster in the Azure portal.
1. In the left menu, find **Settings** and then select **Networking**.
1. On the **Networking** page, select the **Overview** tab.
1. Select **Manage** under **Resource settings**.
1. In the **Authorized IP ranges** pane, add your client IP address as shown in the following screenshot.

    :::image type="content" source="media/client-ip-address-cannot-access-api-server/authorized-ip-ranges.png" alt-text="Screenshot of the Authorized IP ranges pane in the Azure portal where you add a client IP address to the AKS API server."  lightbox="media/client-ip-address-cannot-access-api-server/authorized-ip-ranges.png":::

### [Azure CLI](#tab/azure-cli)

Follow these steps to add your client IP address to the authorized IP ranges for the AKS API server using Azure CLI:

1. Get your client IP address by running this [curl](https://curl.se/docs/manpage.html) command.

    ```azurecli
    export CLIENT_IP=$(curl --silent https://ipinfo.io/ip | tr -d '\n')
    echo $CLIENT_IP
    ```

    Results:

    <!-- expected_similarity=0.3 -->

    ```output
    0.255.127.63
    ```

1. Update the API server-authorized range with the [az aks update](/cli/azure/aks#az-aks-update) command in Azure CLI, using your client IP address.

    ```azurecli
    az aks update --resource-group $RG_NAME \
        --name $CLUSTER_NAME \
        --api-server-authorized-ip-ranges $CLIENT_IP
    ```

    Results:

    <!-- expected_similarity=0.3 -->

    ```output
    {
      "apiServerAccessProfile": {
        "authorizedIpRanges": [
          "0.255.127.63/32"
        ],
        ...
      },
      ...
      "name": "aks-cluster-xxx",
      "resourceGroup": "aks-rg-xxx",
      ...
    }
    ```

---

 
