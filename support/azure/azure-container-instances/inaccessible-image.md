---
title: DeploymentFailed - InaccessibleImage error code
description: Learn how to resolve the "InaccessibleImage" error during a deployment failure on Azure Container Instances.
ms.date: 11/22/2023
author: tysonfms
ms.author: tysonfreeman
editor: v-jsitser
ms.reviewer: v-leedennis
ms.service: container-instances
ms.topic: troubleshooting-problem-resolution
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

You're trying to use a service principal to access the Azure container registry. This scenario can occur because of one of the following reasons:

- You specified incorrect credentials when you tried to create the container instance.

- You specified the correct credentials, but the service calls on Container Instances are blocked by firewall rules in the Azure container registry.

## Solution

You must use a managed identity to allow the Container Instances trusted service to access the container registry. For more information, see [Allow trusted services to securely access a network-restricted container registry](/azure/container-registry/allow-access-trusted-services#about-trusted-services). You can also learn more at [Deploy to Azure Container Instances from Azure Container Registry using a managed identity](/azure/container-instances/using-azure-container-registry-mi).

## More information

- [Managed identities in Azure Container Apps](/azure/container-apps/managed-identity)

- [Azure Container Apps image pull with managed identity](/azure/container-apps/managed-identity-image-pull)

- [Tutorial: Deploy a multi-container group using a Resource Manager template](/azure/container-instances/container-instances-multi-container-group)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

## Next Steps 
If the previous checks did not resolve the incident, please submit a [support request](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/newsupportrequest) 
Azure Container Registry ResourceURI 
Container Group ARM template (or other reference used to deetermine the ACI configuration deployed). 
