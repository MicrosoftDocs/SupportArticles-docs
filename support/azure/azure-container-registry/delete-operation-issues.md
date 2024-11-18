---
title: Troubleshoot Azure Container Registry delete operation issues
description: Discusses some issues you might encounter during the ACR deletion process.
ms.date: 08/30/2024
ms.reviewer: kukondep, chiragpa, v-rekhanain, v-weizhu
ms.service: azure-container-registry
ms.custom: sap:Delete images from registry
---
# Troubleshoot Azure Container Registry delete operation issues

Azure Container Registry (ACR) is a private registry service for building, storing, and managing container images and related artifacts. To maintain the registry's health and reduce storage costs, you might delete images, artifacts, and repositories as necessary.

This article helps you troubleshoot some issues that occur when you delete images, artifacts, or repositories.

## Issue 1: Can't delete an empty repository

When you try to delete an empty repository from a container registry, an error message that resembles the following message is generated:

- Error when using the Azure portal: 

    > {'code':'NAME_UNKNOWN','message':'repository name not known to registry','detail':{'name':'mailhog'}}

- Error when using the Azure CLI: 

    > 2024-05-08 12:14:04.261355 Error: repository name not known to registry. Correlation ID: aaaa0000-bb11-2222-33cc-444444dddddd

This error occurs because some orphaned metadata is left behind when the images are initially deleted. To avoid this error, don't empty the repository. Instead, delete the entire repository. This process is more effective because it deletes all images in the repository, including all tags, unique layers, and manifests. 

Add a dummy image before you the entire repository.

## Issue 2: Can't delete a container registry associated with private endpoints

If an Azure container registry is associated with private endpoints, deleting the container registry fails. Before you can delete it, you must remove all private endpoints that are associated with it. To do this, use the Azure portal or the [az acr private-endpoint-connection delete](/cli/azure/acr/private-endpoint-connection#az-acr-private-endpoint-connection-delete) command. For more information, see [Manage private endpoint connections](/azure/container-registry/container-registry-private-link#manage-private-endpoint-connections).

## Issue 3: Delete operation doesn't clear used storage

When you run the `acr purge` command in an ACR task to delete lots of images, the storage usage doesn't decrease.

In ACR, each image has its corresponding unique manifest and manifest digest. However, different images might share the same layers. See the following screenshot for an example.

 :::image type="content" source="media/delete-operation-issues/container-image-manifest-layer.png" alt-text="Screenshot that shows how the container image is stored.":::

To save the storage space in ACR, layers that are referenced by multiple different manifests are stored only one time.

Based on the preceding screenshot, if you delete image B, the manifest and manifest digest will be cleaned up. At the layer level, only layer 4 will be deleted, and layers 1 and 2 will remain in the ACR storage because another manifest still references them. Therefore, the storage reduction will be less than expected.

## Issue 4: The operation is disallowed error when deleting ACR repository

You receive the following error message when you try to delete an ACR repository:

> `The operation is disallowed on this registry, repository or image.`

### Cause

This error occurs because a lock exists on your repository, manifest, or image layer. Use the following commands to check for locks.

> [!NOTE]
> In the following commands, you must replace the values of the `--name`, `--registry`, `--repository`, and `--image` parameters.

1. Check whether there are any locks at the repository level. 

    ```CLI
    az acr repository show --name myregistry --repository myrepo
    ```
2. Check locks at the repository manifest digest level:

    ```CLI

    az acr manifest list-metadata -registry myregistry -name myrepo      
    ```
3. Check locks at the repository image tag level:

    ```CLI
    az acr repository show --name myregistry --image imagename:tag
    ```
Example of the output:

```output
{
  "changeableAttributes": {
    "deleteEnabled": false,
    "listEnabled": true,
    "readEnabled": true,
    "writeEnabled": false
  },
  "createdTime": "2024-08-20T15:22:51.0355721Z",
  "imageName": "myImage_0a1c809cc2eb596028fcf7a68e498e09",
  "lastUpdateTime": "2024-08-20T15:23:01.2739647Z",
  "manifestCount": 1,
  "registry": "myACR.azurecr.io",
  "tagCount": 2
}
```

If the `writeEnabled` attribute is set to false, this means that the repository or image is locked against delete operations. 

### Solution

To resolve this issue, use the following commands to change `writeEnabled` to true:

1. Remove the lock at the repository level:

    ```CLI
    az acr repository update --name myregistry --repository myrepo --write-enabled true
    ```
2. Remove the lock at the manifest level:

    ```CLI
    az acr repository update --name myregistry --image myrepo@sha256:123456abcdefg --write-enabled true
    ```
3. Remove the lock at the image tag level:

    ```CLI
    az acr repository update --name myregistry --image hello-world:latest --write-enabled true
    ```
[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
