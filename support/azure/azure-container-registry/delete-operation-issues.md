---
title: Troubleshoot Azure Container Registry delete operation issues
description: Discusses some issues you might encounter during the ACR deletion process.
ms.date: 08/30/2024
ms.reviewer: kukondep, chiragpa, v-rekhanain, v-weizhu
ms.service: azure-container-instances
ms.custom: sap:Delete images from registry
---
# Troubleshoot Azure Container Registry delete operation issues

Azure Container Registry (ACR) is a private registry service for building, storing, and managing container images and related artifacts. To maintain the registry's health and reduce storage costs, you might delete images, artifacts, and repositories as needed.

This article helps you troubleshoot some issues that occur when you delete images, artifacts, or repositories.

## Issue 1: Unable to delete an empty repository

When you try to delete an empty repository from a container registry, an error like the following one is thrown:

- Error when using the Azure portal: 

    > {'code':'NAME_UNKNOWN','message':'repository name not known to registry','detail':{'name':'mailhog'}}

- Error when using the Azure CLI: 

    > 2024-05-08 12:14:04.261355 Error: repository name not known to registry. Correlation ID: aaaa0000-bb11-2222-33cc-444444dddddd

This error occurs because some orphaned metadata is left behind when the images were initially deleted. To avoid this error, don't completely empty the repository. Instead, deleting the entire repository is always simpler, as it deletes all images in the repository, including all tags, unique layers, and manifests. 

If you want to delete the repository, you can add a dummy image and then delete the entire repository.

## Issue 2: Unable to delete a container registry associated with private endpoints

If an Azure container registry is associated with private endpoints, deleting the container registry fails. Before deleting it, you must remove all private endpoints associated with it. You can do this using the Azure portal or the [az acr private-endpoint-connection delete](/cli/azure/acr/private-endpoint-connection#az-acr-private-endpoint-connection-delete) command. For more information, see [Manage private endpoint connections](/azure/container-registry/container-registry-private-link#manage-private-endpoint-connections).

## Issue 3: Delete operation doesn't clear used storage

When you run the `acr purge` command in an ACR task to delete lots of images, the storage usage doesn't decrease.

In ACR, each image has its corresponding unique manifest and manifest digest. However, different images might share the same layers. See the following screenshot for an example:

 :::image type="content" source="media/delete-operation-issues/container-image-manifest-layer.png" alt-text="Screenshot that shows how the container image is stored.":::

To save the storage in ACR, layers referenced by multiple different manifests are stored only once.

Based on the preceding screenshot, if you delete image B, the manifest and manifest digest will be cleaned up. At the layer level, only layer 4 will be deleted, and the layers 1 and 2 will remain in the ACR storage as another manifest still references them. Hence, the storage reduction will be less than expected.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
