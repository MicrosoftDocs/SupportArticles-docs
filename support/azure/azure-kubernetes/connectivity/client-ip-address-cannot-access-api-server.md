---
title: Client IP address can't access the API server
description: Troubleshoot issues caused when the client IP address can't access the API server on an Azure Kubernetes Service (AKS) cluster.
ms.topic: article
ms.date: 06/11/2024
author: microsoftdocs
ms.author: microsoftdocs
ms.custom: sap:Connectivity, innovation-engine
---

# Client IP address can't access the API server

This article describes how to fix issues that occur when you can't connect to an Azure Kubernetes Service (AKS) cluster because your client IP address can't access the AKS API server.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli).
- The client URL ([curl](https://techcommunity.microsoft.com/t5/containers/tar-and-curl-come-to-windows/ba-p/382409)) tool.

## Symptoms

### [Azure portal](#tab/azure-portal)

When you try to access Kubernetes resources such as mamespaces and workloads from the Azure portal, you might encounter the following errors:

> Network error
>
> Unable to reach the api server 'https://\<API-server-FQDN>' or api server is too busy to respond. Check your network settings and refresh to try again.

:::image type="content" source="media/client-ip-address-cannot-access-api-server/network-error.png" alt-text="Screenshot of mamespaces in the AKS resource." lightbox="media/client-ip-address-cannot-access-api-server/network-error.png":::

### [Azure CLI](#tab/azure-cli)

When you try to connect to a cluster using the Azure CLI, you might see the following errors:

```output
"Unhandled Error" err="couldn't get current server API group list: Get \"https://<API-SERVER-FQDN>:443/api?timeout=32s\": dial tcp <API-SERVER-IP>:443: i/o timeout"

Unable to connect to the server: dial tcp <API-SERVER-IP>:443: i/o timeout

Unable to connect to the server: dial tcp <API-SERVER-IP>:443: connectex: A connection attempt failed because the connected party did not properly respond after a period, or established connection failed because connected host has failed to respond.
```

---

## Cause

[API server-authorized IP ranges](/azure/aks/api-server-authorized-ip-ranges) may have been enabled on the cluster's API server, but the client's IP address wasn't included in the IP ranges. To check whether this feature has been enabled, see if the following [az aks show](/cli/azure/aks#az-aks-show) command in Azure CLI produces a list of IP ranges:

```azurecli
az aks show --resource-group ${RG_NAME} \
    --name ${CLUSTER_NAME} \
    --query apiServerAccessProfile.authorizedIpRanges
```

## Solution

Look at the cluster's API server-authorized ranges, and add your client's IP address within that range.

> [!NOTE]
>
> 1. Do you access the API server from a corporate network where traffic is routed through a proxy server or firewall? Then ask your network administrator before you add your client IP address to the list of authorized ranges for the API server.
>
> 1. Also ask your cluster administrator before you add your client IP address, because there might be security concerns with adding a temporary IP address to the list of authorized ranges.

### [Azure portal](#tab/azure-portal)

1. Navigate to the cluster from the Azure portal.
2. In the left menu, locate **Settings** and then select **Networking**.
3. On the **Networking** page, select the **Overview** tab.
4. Select **Manage** under **Resource settings**.
5. In the **Authorized IP ranges** pane, add your client IP address as shown in the following screenshot:

    :::image type="content" source="media/client-ip-address-cannot-access-api-server/authorized-ip-ranges.png" alt-text="Screenshot of Authorized-ip-ranges pane."  lightbox="media/client-ip-address-cannot-access-api-server/authorized-ip-ranges.png":::

### [Azure CLI](#tab/azure-cli)

1. Get your client IP address by running this [curl](https://curl.se/docs/manpage.html) command:

    ```azurecli
    export CLIENT_IP=$(curl --silent https://ipinfo.io/ip | tr -d '\n')
    echo $CLIENT_IP
    ```

    Results:

    <!-- expected_similarity=0.3 -->

    ```output
    0.255.127.63
    ```

2. Update the API server-authorized range with the [az aks update](/cli/azure/aks#az-aks-update) command in Azure CLI, using your client IP address:

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

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]