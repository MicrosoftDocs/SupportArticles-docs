---
title: AADSTS7000222 - BadRequest or InvalidClientSecret error
description: Learn how to troubleshoot the BadRequest or InvalidClientSecret error when you try to create or upgrade an Azure Kubernetes Service (AKS) cluster.
author: axelgMS
ms.author: axelg
ms.date: 12/19/2023
editor: v-jsitser
ms.reviewer: v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-create-operations
ms.topic: troubleshooting-problem-resolution
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the BadRequest or InvalidClientSecret error code so that I can successfully create or upgrade an Azure Kubernetes Service (AKS) cluster.
---
# AADSTS7000222 - BadRequest or InvalidClientSecret error

This article discusses how to identify and resolve the `AADSTS7000222` error (`BadRequest` or `InvalidClientSecret`) that occurs when you try to create or upgrade a Microsoft Azure Kubernetes Service (AKS) cluster.

## Prerequisites

- [Azure CLI](/cli/azure/install-azure-cli)

## Symptoms

When you try to create or upgrade an AKS cluster, you receive one of the following error messages.

| Error code | Message |
|--|--|
| `BadRequest` | **The credentials in ServicePrincipalProfile were invalid.** Please see <https://aka.ms/aks-sp-help> for more details. (Details: adal: Refresh request failed. Status Code = '401'. Response body: {"error": "invalid_client", "error_description": "**AADSTS7000222: The provided client secret keys for app '\<application-id>' are expired.** Visit the Azure portal to create new keys for your app: <https://aka.ms/NewClientSecret>, or consider using certificate credentials for added security: <https://aka.ms/certCreds>." |
| `InvalidClientSecret` | **Customer auth is not valid for tenant: \<tenant-id>**: adal: Refresh request failed. Status Code = '401'. Response body: {"error": "invalid_client", "error_description": "**AADSTS7000222: The provided client secret keys for app '\<application-id>' are expired.** Visit the Azure portal to create new keys for your app: <https://aka.ms/NewClientSecret>, or consider using certificate credentials for added security: <https://aka.ms/certCreds>." |

## Cause

The issue that generates this service principal alert usually occurs for one of the following reasons:

- The client secret expired.

- Incorrect credentials were provided.

- The service principal doesn't exist within the Microsoft Entra ID tenant of the subscription.

#### Verify the cause

Run the following Azure CLI code to retrieve the service principal profile for your AKS cluster and [check the expiration date of the service principal](/azure/aks/update-credentials#check-the-expiration-date-of-your-service-principal):

```azurecli
SP_ID=$(az aks show --resource-group <rg-name> \
    --name <aks-cluster-name> \
    --query servicePrincipalProfile.clientId \
    --output tsv)
az ad app credential list --id "$SP_ID"
```

Alternatively, you can verify that the service principal name and secret are correct and aren't expired. To do this, follow these steps:

1. In the [Azure portal](https://portal.azure.com), search for and select **Microsoft Entra ID**.

1. In the navigation pane of Microsoft Entra ID, select **App registrations**.

1. On the **Owned applications** tab, select the affected application.

1. Find the service principal name and secret information, and verify that the information is correct and current.

## Solution

1. In the [Update or rotate the credentials for an AKS cluster](/azure/aks/update-credentials) article, follow the instructions in one of the following article sections, as appropriate:

   - [Reset the existing service principal credentials](/azure/aks/update-credentials#reset-the-existing-service-principal-credentials)
   - [Create a new service principal](/azure/aks/update-credentials#create-a-new-service-principal)

1. Using your new service principal credentials, follow the instructions in the [Update AKS cluster with service principal credentials](/azure/aks/update-credentials#update-aks-cluster-with-service-principal-credentials) section of that article.

## More information

- [Use a service principal with Azure Kubernetes Service (AKS)](/azure/aks/kubernetes-service-principal) (especially the [Troubleshoot](/azure/aks/kubernetes-service-principal#troubleshoot) section)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
