---
title: Azure Cosmos DB private endpoints deployment fails
description: Troubleshoot failed Azure Resource Manager deployments related to private endpoints created inline with Azure Cosmos DB accounts.
ms.service: cosmos-db
author: oury-msft
ms.author: ouryba
ms.reviewer: v-jayaramanp
ms.topic: landing-page
ms.date: 09/25/2023
---

# Azure Cosmos DB private endpoints deployment fails

Azure Private Link endpoints can be deployed inline with an Azure Cosmos DB account through an Azure Resource Manager template. This deployment may not succeed if particular prerequisites aren't met.

## Symptoms

When deploying the Azure Resource Manager template, you observe an error that the `microsoft.network/virtualnetworks/write` permission is required.

## Cause

This permission is required to deploy a private endpoint inline with an Azure Cosmos DB account. This permission isn't listed in the list of required permissions for deploying a private endpoint on its own. For more information, see [role-based access control permissions for private endpoints](/azure/private-link/rbac-permissions#private-endpoint).

This issue only occurs when the private endpoint is deployed inline with the Azure Cosmos DB account.

## Solution

Ensure the deploying principal is granted the `microsoft.network/virtualnetworks/write` granular permission prior to deploying an Azure Cosmos DB account with an inline private endpoint.
