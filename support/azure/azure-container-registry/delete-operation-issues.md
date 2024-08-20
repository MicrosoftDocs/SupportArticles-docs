---
title: Troubleshoot Azure Container Registry delete operation issues
description: Discusses some issues you might come across during the ACR deletion process.
ms.date: 08/20/2024
ms.reviewer: kukondep, chiragpa, v-rekhanain, v-weizhu
ms.service: azure-container-instances
ms.custom: sap:Delete images from registry
---
# Troubleshoot Azure Container Registry delete operation issues

Azure Container Registry (ACR) is a private registry service for building, storing, and managing container images and related artifacts. To maintain the registry health and reduce storage cost, you might delete the images/artifacts and repositories as per requirement.

This article helps you troubleshoot some issues that occur when you delete images/artifacts or repositories.

## Issue 1: Unable to delete an empty repository

When you try to delete an empty repository from a container registry, an error like the following one is thrown:

- Error when using the Azure portal: 

    > {'code':'NAME_UNKNOWN','message':'repository name not known to registry','detail':{'name':'mailhog'}}

- Error when using the Azure CLI: 

    > 2024-05-08 12:14:04.261355 Error: repository name not known to registry. Correlation ID: dc9f5ca9-4d6a-4ad3-9d31-0bc08c980e55

So, we don't recommend emptying the repository completely. When you try to delete the repository, there might be some orphaned metadata left over from the original deletion, which causes deletion errors. Deleting a repository deletes all the images in the repository, including all tags, unique layers, and manifests. Deleting the entire repository is always simpler than removing individual images.

To avoid this issue, we recommend using a test or prod repository. In this case, you can delete/create the test repository as per the requirement.

## Issue 2: Unable to delete a container registry associated with private endpoints

If an Azure container registry is associated with private endpoints, deleting the container registry fails. Before deleting it, you must remove all private endpoints associated with it. You can do this using the Azure portal or the [az acr private-endpoint-connection delete](/cli/azure/acr/private-endpoint-connection#az-acr-private-endpoint-connection-delete) command. For more information, see [Manage private endpoint connections](/azure/container-registry/container-registry-private-link#manage-private-endpoint-connections).

## Issue 3: Delete operation doesn't clear used storage

While running the `acr purge` command in an ACR task to delete lots of images, the storage usage doesn't decrease.

In ACR, an image has its corresponding unique manifest and manifest digest. However, different images might share same layers. See the following image for an example:

 :::image type="content" source="media/delete-operation-issues/container-image-manifest-layer.png" alt-text="A screenshot that shows how the container image is stored.":::

To save the storage in ACR, the layers referenced by multiple different manifests will only be stored once.

Based on the previous image, if you delete the image B, the manifest and the manifest digest will be cleaned up. And on the layer level, only layer 4 will be deleted and the layer 1 and layer 2 will still remain in the ACR storage as they're still referenced by another manifest. Hence, the decreased storage will be less than expected.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
