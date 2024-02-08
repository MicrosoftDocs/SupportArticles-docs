---
title: Deployment of private endpoints for Azure Cosmos DB fails
description: Troubleshoot failed Azure Resource Manager deployments that are related to private endpoints created inline for Azure Cosmos DB accounts.
author: seesharprun
editor: v-jsitser
ms.author: sidandrews
ms.reviewer: ouryba, v-jayaramanp
ms.service: cosmos-db
ms.topic: troubleshooting-problem-resolution
ms.date: 01/18/2024
ms.custom: devx-track-arm-template
---

# Deployment of private endpoints for Azure Cosmos DB fails

Azure Private Link endpoints can be deployed inline for an Azure Cosmos DB account through an Azure Resource Manager template (ARM template). However, this deployment might fail if particular prerequisites aren't met.

## Symptoms

When you try to deploy an ARM template, you receive an error message that states that the `Microsoft.Network/virtualNetworks/write` permission is required.

## Cause

The `Microsoft.Network/virtualNetworks/write` permission is required to deploy a private endpoint inline for an Azure Cosmos DB account. This permission isn't shown in the list of required permissions to deploy a private endpoint on its own. For more information, see [role-based access control permissions for private endpoints](/azure/private-link/rbac-permissions#private-endpoint).

This issue occurs only if the private endpoint is deployed inline for the Azure Cosmos DB account.

## Solution

Make sure that the deploying principal is granted the `Microsoft.Network/virtualNetworks/write` granular permission before you use an ARM template to deploy an Azure Cosmos DB account that has an inline private endpoint.

## Reference

- [What is a private endpoint?](/azure/private-link/private-endpoint-overview)
- [Create an Azure Cosmos DB Account with a private endpoint](/samples/azure/azure-quickstart-templates/cosmosdb-private-endpoint/)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
