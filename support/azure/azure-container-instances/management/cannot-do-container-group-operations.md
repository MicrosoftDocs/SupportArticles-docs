---
title: Can't do operations or the container group is in a bad state in Azure Container Instances
description: Learn how to fix a container group in a bad state in Azure Container Instances when delete or show operations fail. Resolve internal server errors now.
ms.date: 10/06/2026
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: chiragpa, v-rekhanain, v-leedennis, kennethgp, tysonfreeman, kaushika
ms.service: azure-container-instances
ms.topic: troubleshooting
ms.custom: sap:Management
ai-usage: ai-assisted
#Customer intent: As an Azure administrator, I want to learn how to fix a container group that's in a bad state so that I can successfully do operations on that container group.
---
# Container group in a bad state or operations fail in Azure Container Instances

## Summary

This article explains how to fix issues in Azure Container Instances (ACI) when operations fail because the container group is in a bad state.

## Symptoms

You encounter one or more of the following problems:

- You try to delete a container group, but the attempt causes an internal server error.
- You try to run the [az container show](/cli/azure/container#az-container-show) command in [Azure CLI](/cli/azure/install-azure-cli), but the command fails because of an internal server error.
- In the [Azure portal](https://portal.azure.com), you can view the container group resource, but you can't do any operations on it.
- The container group remains in a bad state (such as **Stopped** or **Failed**).

## Cause 1: Managed identity deleted before container group

You deleted the managed identity of the container group before deleting the associated container group. This scenario can occur if you try to delete these resources manually in this order. It can also occur if you have a regularly scheduled script that deletes all the resources within a development resource group but doesn't delete the resources in the correct order. The script first deletes the managed identity that's necessary to authenticate the container group and then tries to delete the container group itself.

## Cause 2: Customer-managed key (CMK) deleted before container group

You enabled CMK in a container group but deleted the key or the Azure Key Vault holding the key before deleting the container group.

## Solution 1: Managed identity deleted before container group

Delete the container group first, wait for the deletion operation to finish, and then delete the managed identity.

## Solution 2: CMK deleted before container group

Check whether the encryption key or the entire key vault was deleted. If Azure Key Vault has soft-delete enabled, you can recover the deleted key.

## Solution 3: Open a support ticket to get the container groups out of a bad state

Microsoft Support can stop the affected container groups and help you with the other necessary steps to delete your container group.

## References

- [Azure Container Instances states](/azure/container-instances/container-state)
- [Deploy to Azure Container Instances from Azure Container Registry using a managed identity](/azure/container-instances/using-azure-container-registry-mi)