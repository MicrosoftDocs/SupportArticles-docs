---
title: Can't do operations or the container group is in a bad state
description: Learn how to resolve an issue in Azure Container Instances in which you can't do a container group operation or the container group is in a bad state.
ms.date: 01/31/2024
author: tysonfms
ms.author: tysonfreeman
editor: v-jsitser
ms.reviewer: chiragpa, v-rekhanain, v-leedennis
ms.service: container-instances
ms.topic: troubleshooting-problem-resolution
#Customer intent: As an Azure administrator, I want to learn how to fix a container group that's in a bad state so that I can successfully do operations on that container group.
---
# Can't do operations or the container group is in a bad state

This article discusses how to resolve a scenario in Microsoft Azure Container Instances in which you can't do container group operations or the container group is in a bad state.

## Symptoms

You encounter one or more of the following problems:

- You try to delete a container group, but the attempt causes an internal server error.

- You try to run the [az container show](/cli/azure/container#az-container-show) command in [Azure CLI](/cli/azure/install-azure-cli), but the command fails because of an internal server error.

- In the [Azure portal](https://portal.azure.com), you can view the container group resource, but you can't do any operations on it.

- The container group remains in a bad state (such as **Stopped** or **Failed**).

## Cause

The managed identity of the container group was deleted before an attempt was made to delete the associated container group. This scenario can occur if you try to do this order of deletions manually. It can also occur if you have a regularly scheduled script (such as a nightly script run) that deletes all the resources within a development resource group, including all managed identities and container groups. The script doesn't delete the resource in the correct order because it deleted the managed identity that's necessary to authenticate the container group before it tried to delete the container group itself.

## Solution 1: Delete the container group before you delete the managed identity

Delete the container group first, wait for the deletion operation to finish, and then delete the managed identity.

## Solution 2: Open a support ticket to get the container groups out of a bad state

If you have any container groups that remain in a bad state because you first deleted the managed identities that are required for container group authentication, open a support ticket. Microsoft Support can stop the affected container groups and help you work through the other necessary steps to fix your container group setup.

## More information

- [Azure Container Instances states](/azure/container-instances/container-state)

- [Deploy to Azure Container Instances from Azure Container Registry using a managed identity](/azure/container-instances/using-azure-container-registry-mi)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
