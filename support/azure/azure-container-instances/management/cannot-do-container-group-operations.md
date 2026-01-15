---
title: Can't do operations or the container group is in a bad state
description: Learn how to fix issues in Azure Container Instances when operations fail because container group is in a bad state.
ms.date: 02/21/2024
author: tysonfms
ms.author: tysonfreeman
editor: kennethgp
ms.reviewer: chiragpa, v-rekhanain, v-leedennis
ms.service: azure-container-instances
ms.topic: troubleshooting-problem-resolution
ms.custom: sap:Management
#Customer intent: As an Azure administrator, I want to learn how to fix a container group that's in a bad state so that I can successfully do operations on that container group.
---
# Can't do operations or the container group is in a bad state

This article explains how to fix issues in Azure Container Instances when operations fail because container group is in a bad state.

## Symptoms

You encounter one or more of the following problems:

- You try to delete a container group, but the attempt causes an internal server error.

- You try to run the [az container show](/cli/azure/container#az-container-show) command in [Azure CLI](/cli/azure/install-azure-cli), but the command fails because of an internal server error.

- In the [Azure portal](https://portal.azure.com), you can view the container group resource, but you can't do any operations on it.

- The container group remains in a bad state (such as **Stopped** or **Failed**).

## Cause 1: Managed identity deleted before container group

The managed identity of the container group was deleted before an attempt was made to delete the associated container group. This scenario can occur if you try to do this order of deletions manually. It can also occur if you have a regularly scheduled script that deletes all the resources within a development resource group. The script doesn't delete the resources in the correct order: It first deletes the managed identity that's necessary to authenticate the container group, and then it tries to delete the container group itself.

## Cause 2: CMK (Customer-Managed Key) deleted before container group

CMK is enabled in container group and key or Azure Keyvault holding key was deleted before deleting container group.

## Solution 1: Managed identity deleted before container group

Delete the container group first, wait for the deletion operation to finish, and then delete the managed identity.

## Solution 2: CMK (Customer-Managed Key) deleted before container group

Confirm if encryption key was deleted or entire keyvault was deleted. Azure Keyvault may have soft-delete enabled and key could be recovered.

## Solution 3: Open a support ticket to get the container groups out of a bad state

Microsoft Support can stop the affected container groups and help you work through the other necessary steps to delete your container group.

## More information

- [Azure Container Instances states](/azure/container-instances/container-state)

- [Deploy to Azure Container Instances from Azure Container Registry using a managed identity](/azure/container-instances/using-azure-container-registry-mi)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
