---
title: DeploymentFailed - InaccessibleImage error code
description: Learn how to resolve the "InaccessibleImage" error during a deployment failure on Azure Container Instances.
ms.date: 01/18/2024
author: tysonfms
ms.author: tysonfreeman
editor: v-jsitser
ms.reviewer: v-leedennis, v-weizhu, kegonzal
ms.service: azure-container-instances
ms.custom: sap:Configuration and Setup
#Customer intent: As an Azure administrator, I want to learn how to resolve the "InaccessibleImage" error so that I can successfully deploy an image onto a container instance.
---
# DeploymentFailed - InaccessibleImage error code

This article discusses how to resolve a deployment failure on Microsoft Azure Container Instances that generates an "InaccessibleImage" error code.

## Symptoms

When you try to deploy a container instance, the deployment fails, and you receive an error message that resembles the following text:

> {
>
> > **"code":**"DeploymentFailed",  
> > **"message":**"At least one resource deployment operation failed. Please list deployment operations for details. Please see <https://aka.ms/DeployOperations> for usage details.",  
> > **"details":**\[
> >
> > > {
> > >
> > > > **"code":**"InaccessibleImage",  
> > > > **"message":**"The image '\<container-registry-name>.azurecr.io/\<image-name>:\<version-name>' in container group '\<container-group-name>' is not accessible. Please check the image and registry credential."
> > >
> > > }
> >
> > \]
>
> }

## Cause

- You're trying to use a service principal to access the Azure Container Registry.
- You specified incorrect credentials when you tried to create the container instance.
- You specified the correct credentials, but the Azure Container Registry firewall blocks the calls.

## Solution

You must use a managed identity to allow the Container Instances trusted service to access the container registry. For more information, see [Allow trusted services to securely access a network-restricted container registry](/azure/container-registry/allow-access-trusted-services#about-trusted-services). You can also learn more at [Deploy to Azure Container Instances from Azure Container Registry using a managed identity](/azure/container-instances/using-azure-container-registry-mi).

> [!NOTE]
> Image pull phase happens before container is created. If you're deploying to a Virtual Network (BYOVNET), image pull occurs through a random platform public IP. Because of this, private registries other than Azure Container Registry aren't supported even if there's private connectivity from the target subnet.

## Resources

- [Managed identities in Azure Container Apps](/azure/container-apps/managed-identity)
- [Azure Container Apps image pull with managed identity](/azure/container-apps/managed-identity-image-pull)
- [Tutorial: Deploy a multi-container group using a Resource Manager template](/azure/container-instances/container-instances-multi-container-group)
