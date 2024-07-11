---
title: Authentication required error message in Azure Container Registry
description: Understand how to resolve a scenario in which an authentication required error occurs when you try to access Azure Container Registry.
ms.date: 07/08/2024
author: AndreiBarbu95
ms.author: andbar
editor: v-jsitser
ms.reviewer: avtakkar, v-rekhanain, v-leedennis
ms.service: container-instances
ms.topic: troubleshooting-problem-resolution
ms.custom: sap:Image Pull Issues
#Customer intent: As an Azure Container Registry user, I want to fix an "unauthorized: authentication required" error so that I can pull a container image or artifact successfully.
---
# "Authentication required" error when trying to access Azure Container Registry

This article discusses how to resolve an "unauthorized: authentication required" error that occurs when you try to pull a container image or artifact from a Microsoft Azure Container Registry.

## Symptoms

You receive the following error message:

> Head "https\://\<container-registry-name>.azurecr.io/v2/\<repository>/manifests/\<tag>": unauthorized: authentication required, visit <https://aka.ms/acr/authorization> for more information.

## Cause

You aren't authenticated to the Azure Container Registry. Because Azure Container Registry is a private container registry, you have to be authenticated so that you can access and pull from the registry unless you use [anonymous pull](/azure/container-registry/anonymous-pull-access).

## Solution 1: Authenticate to the container registry

Make sure that you're authenticated to the container registry. Authentication methods include a service principal, managed identity, individual Microsoft Entra identity, the administrator user, or other method. For more information about available authentication options, see [Authenticate with an Azure container registry](/azure/container-registry/container-registry-authentication).

## Solution 2: Add authorization permission to pull from the container registry

Make sure that you're authorized to pull from the container registry. To do the pull action, you must have the [Microsoft.ContainerRegistry/registries/pull/read](/azure/role-based-access-control/permissions/containers#microsoftcontainerregistry) permission. Make sure that the entity that's used to authenticate to the container registry is granted that permission. The following Azure built-in roles contain the **Microsoft.ContainerRegistry/registries/pull/read** permission:

- AcrPull
- AcrPush
- Contributor
- Owner
- Reader

For more information, see [Azure Container Registry roles and permissions](/azure/container-registry/container-registry-roles).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
