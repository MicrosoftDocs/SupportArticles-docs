---
title: Manifest unknown - manifest tagged by "<tag>" is not found
description: Learn to resolve a scenario in which a manifest that has a certain tag isn't found in an Azure Container Registry or the associated repository.
ms.date: 07/08/2024
author: AndreiBarbu95
ms.author: andbar
editor: v-jsitser
ms.reviewer: avtakkar, v-rekhanain, v-leedennis
ms.service: container-instances
ms.topic: troubleshooting-problem-resolution
ms.custom: sap:Image Pull Issues
#Customer intent: As an Azure Container Registry user, I want to know how to resolve a 'manifest unknown: manifest tagged by "<tag>" is not found' error so that I can pull an image successfully.
---
# "Manifest unknown: manifest tagged by '\<tag>' is not found" error

This article discusses a scenario in which Microsoft Azure Container Registry responds to a pull request by sending an error message that states that a manifest tag isn't found.

## Symptoms

You receive the following error message:

> Manifest for \<container-registry-name>.azurecr.io/v2/\<repository>/manifests/\<tag> not found: manifest unknown: manifest tagged by "\<tag>" is not found.

## Cause

The tag that's associated with the image that you're trying to pull isn't found.

## Solution

Make sure that the tag exists within the associated repository and registry.

To find the tags within the associated repository and registry, use one of the following methods:

- In the [Azure portal](https://portal.azure.com), follow these steps:

  1. Search for and select **Container registries**.

  1. In the list of container registries, select the name of your container registry.
  
  1. In the menu pane of your container registry, select **Services** > **Repositories**.
  
  1. In the list of repositories within your container registry, select the name of the repository in which the tag should exist.
  
  1. Check whether the tag in question is shown within the list of tags in the repository.

- In Azure CLI, run the [az acr repository show-tags](/cli/azure/acr/repository#az-acr-repository-show-tags) command:

  ```azurecli
  az acr repository show-tags --name <my-registry> --repository <my-repository>
  ```

> [!NOTE]
> Checking the repositories from the [Azure portal](https://portal.azure.com) or running the `az acr repository show-tags` command works successfully only if the Azure Container Registry network rules allows these actions.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
