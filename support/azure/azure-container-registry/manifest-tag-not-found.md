---
title: Manifest unknown - manifest tagged by <tag> is not found in Azure Container Registry
description: Learn how to resolve the manifest unknown error when a tagged manifest isn't found in Azure Container Registry. Verify tags and pull your image.
ms.date: 11/26/2026
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: avtakkar, v-rekhanain, v-leedennis, andbar, kaushika
ms.service: azure-container-registry
ms.topic: troubleshooting
ms.custom: sap:Image Pull Issues
ai-usage: ai-assisted
#Customer intent: As an Azure Container Registry user, I want to know how to resolve a 'manifest unknown: manifest tagged by "<tag>" is not found' error so that I can pull an image successfully.
---
# "Manifest unknown: manifest tagged by '\<tag>' is not found" error in Azure Container Registry

## Summary

This article helps you resolve the "manifest unknown" error that Azure Container Registry (ACR) returns when a pull request references a manifest tag that isn't found.

## Symptoms

You receive the following error message.

> Manifest for \<container-registry-name>.azurecr.io/v2/\<repository>/manifests/\<tag> not found: manifest unknown: manifest tagged by "\<tag>" is not found.

## Cause

The requested tag isn't found in the specified repository and registry. The manifest can still exist without that tag, for example after the image is untagged.

## Solution

Ensure that the tag exists within the associated repository and registry. Verify the registry hostname, repository path, and tag in the image reference that you're trying to pull.

To find the tags within the associated repository and registry, use one of the following methods.

### Azure portal

In the [Azure portal](https://portal.azure.com), follow these steps:

1. Search for and select **Container registries**.
1. In the list of container registries, select the name of your container registry.
1. In the menu pane of your container registry, select **Services** > **Repositories**.
1. In the list of repositories within your container registry, select the name of the repository where the tag should exist.
1. Check whether the tag appears in the list of tags in the repository.

### Azure CLI

In Azure CLI, run the [az acr repository show-tags](/cli/azure/acr/repository#az-acr-repository-show-tags) command.

```azurecli
  az acr repository show-tags --name <my-registry> --repository <my-repository>
```

> [!NOTE]
> Checking the repositories from the [Azure portal](https://portal.azure.com) or running the `az acr repository show-tags` command works only if the Azure Container Registry network rules allow these actions.

If the requested tag is missing, correct the image reference to use the intended existing tag, or push or import the intended image with the required tag. Then retry the pull.
