---
title: DeploymentFailed - InaccessibleImage error code in Azure Container Instances
description: Learn how to fix the DeploymentFailed and InaccessibleImage error when an Azure Container Instances deployment fails. Check registry credentials, firewall rules, and managed identity.
ms.date: 10/01/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: v-leedennis, v-weizhu, kegonzal, tysonfreeman, kaushika
ms.service: azure-container-instances
ms.custom: sap:Configuration and Setup
#Customer intent: As an Azure administrator, I want to learn how to resolve the "InaccessibleImage" error so that I can successfully deploy an image onto a container instance.
ai-usage: ai-assisted
---
# "DeploymentFailed" and "InaccessibleImage" error code in Azure Container Instances

This article describes how to resolve a deployment failure in Azure Container Instances (ACI) that generates a "DeploymentFailed" and "InaccessibleImage" error code.

## Symptoms

When you try to deploy a container instance, the deployment fails, and you receive an error message that resembles the following text.

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

This error commonly occurs for the following reasons:

- You try to use a service principal to access the Azure Container Registry (ACR).
- You specify incorrect credentials when you try to create the container instance.
- You specify the correct credentials, but the ACR firewall blocks the calls.

## Solution

Use a managed identity to allow the container instances trusted service to access the container registry. For more information, see [Allow trusted services to securely access a network-restricted container registry](/azure/container-registry/allow-access-trusted-services#about-trusted-services). You can also learn more at [Deploy to Azure Container Instances from Azure Container Registry using a managed identity](/azure/container-instances/using-azure-container-registry-mi).

> [!NOTE]
> The image pull phase happens before a container is created. If you deploy to a bring your own virtual network (BYOVNET), image pull occurs through a random platform public IP. Because of this, private registries other than ACR aren't supported even if there's private connectivity from the target subnet.

## References

- [Managed identities in Azure Container Apps](/azure/container-apps/managed-identity)
- [Azure Container Apps image pull with managed identity](/azure/container-apps/managed-identity-image-pull)
- [Tutorial: Deploy a multi-container group using a Resource Manager template](/azure/container-instances/container-instances-multi-container-group)
