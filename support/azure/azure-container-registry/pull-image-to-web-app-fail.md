---
title: Cant pull image to Azure Web App from Azure Container Registry
description: Fix errors when you can't pull an image from Azure Container Registry to Azure Web App. Learn how to troubleshoot authorization, tag, and firewall issues.
ms.date: 10/12/2026
ms.topic: troubleshooting
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.reviewer: andbar; chiragpa; v-rekhanain, kaushika
ms.service: azure-container-registry
ms.custom: sap:Image Pull Issues
ai-usage: ai-assisted
---

# Can't pull image from Azure Container Registry to Azure Web App

## Summary

This article provides guidance for troubleshooting the most common errors that you might encounter when you pull images from an Azure Container Registry (ACR) to Azure Web App.

## Symptoms and initial troubleshooting

Start your troubleshooting by checking the [container registry health](/azure/container-registry/container-registry-check-health).

To check the container registry health, run the following command.

```azurecli
az acr check-health --name <myregistry> --ignore-errors --yes
```

If an issue is detected, the results include an error code and description. For more information about these errors and possible solutions, see [Health check error reference](/azure/container-registry/container-registry-health-error-reference).

> [!NOTE]
> If you receive Helm-related or Notary-related errors, it doesn't mean that your ACR or Azure Kubernetes Service (AKS) isn't working or has a problem. It indicates there might be other issues, such as that Helm or Notary isn't installed, or that Azure CLI isn't compatible with the currently installed version of Helm or Notary.

Next, identify the pull-related error message that's essential for troubleshooting. Follow these steps:

1. Sign in to the [Azure portal](https://portal.azure.com).
1. In your web app, select **Deployment Center** > **Log**. Select the commit to view the log details. You can also view the logs for the image pull process in real time by checking **Log stream** in the **Monitoring** section.

The following sections help you troubleshoot the most common errors that are displayed in the Azure Web App logs.

## Error 1: Unauthorized error message

The following example shows an error message in the web app logs when the image pull fails because of unauthorized access.

> `Head \" https://<acr-name>.azurecr.io/v2/<repository>/manifests/<tag>\": unauthorized`

### Solution for admin user authentication

The "unauthorized" error can occur if you enter incorrect admin credentials. This error includes the sign-in server, username, or password that you set in the web app environment variables.

To fix the error, follow these steps:

1. In the [Azure portal](https://portal.azure.com), go to your registry container. In the **Settings** section, select **Access keys**. Check the admin user credentials for the **Sign-in server**, **Username**, and **password**.
1. Go to your web app. In the **Settings** section, select **Environment variables**.
1. Ensure that the three variables you set for the container registry (sign-in server, username, and password) match the admin user credentials in the registry container.

### Solution for managed identity-based authentication

When you use Azure Web App's managed identity-based authentication, you must assign the `Microsoft.ContainerRegistry/registries/pull/read` permission to the managed identity to perform the pull action.

The Azure built-in roles that contain the `Microsoft.ContainerRegistry/registries/pull/read` permission include the following roles:

- AcrPull
- AcrPush
- ReaderContributor
- Owner

For more information, see [Azure Container Registry roles and permissions](/azure/container-registry/container-registry-roles?tabs=azure-cli).

When you initiate a pull operation from the container registry, the AcrPull role is automatically assigned to the Azure Web App managed identity. You don't have to manually add permissions. However, you must ensure that the role assignment creation isn't blocked by, for example, an Azure policy. Also, verify that the role assignment wasn't deleted.

## Error 2: Manifest tagged by `<tag>` is not found

The following error message is an example of the message that you might see.

> `DockerApiException  : Docker API responded with status code=NotFound, response={"message":"manifest for <acr-name>.azurecr.io/<repository>:<tag> not found: manifest unknown: manifest tagged by \"<tag>\" is not found"}`

### Solution: Make sure the tag exists

The error message indicates that the tag you associated with the image you want to pull wasn't found. Ensure the tag exists within the associated repository and registry.

To use Azure CLI to find the tags within the associated repository and registry, run the following command.

```azurecli
az acr repository show-tags -n <ContainerRegistryName> --repository <RepositoryName>
```

To use the Azure portal to find the tags within the associated repository and registry, follow these steps:

1. Navigate to your registry container. 
1. In **Services**, select **Repositories**, open the associated repository, and then check the list of tags.

> [!NOTE]
> The [az acr repository show-tags](/cli/azure/acr/repository?view=azure-cli-latest#az-acr-repository-show-tags&preserve-view=true) command, or checking the repositories from the Azure portal works only if the [container registry network rules](/azure/container-registry/container-registry-access-selected-networks) permit it.

## Error 3: Client with IP is not allowed access

The following example shows an error message that you might see when the client with a specific IP isn't allowed access.

> `DockerApiException: Docker API responded with status code=InternalServerError, response={"message":"Head \"https:// <acr-name>.azurecr.io/v2/<repository>/manifests/<tag>\": denied: client with IP '<web-app-outbound-ip>' is not allowed access. Refer https://aka.ms/acr/firewall to grant access."}`

### Solution 1: Ensure the container registry built-in firewall allows your device's IP address

By default, a container registry accepts connections over the internet from all networks. The container registry has a built-in firewall that can restrict access to specific IP addresses or Classless Inter-Domain Routings (CIDRs), or fully disable public network access.

This issue can occur if the container registry's built-in firewall blocks the IP addresses of your web app.

To resolve this issue, ensure that the built-in firewall allows the outbound IP addresses of the web app that pulls the image. 

To find the web app's outbound IP addresses, follow these steps:

1. In the [Azure portal](https://portal.azure.com), navigate to your web app.
1. On the **Overview** page, locate **Outbound IP address**, and then select **Show More** to get the full list of the outbound IP addresses.

To use Azure CLI to find the web app's outbound IP addresses, see [Find outbound IP addresses in Azure App Service](/azure/app-service/overview-inbound-outbound-ips#find-outbound-ips).

### Solution 2: Configure virtual network integration for the web app

If you need to fully disable public network access or allow only selected networks at the container registry without manually adding the web app's IP addresses, pull the image privately. To pull images privately, [configure the container registry by using a private endpoint](/azure/container-registry/container-registry-private-link) and [enable virtual network integration for the web app](/azure/app-service/configure-vnet-integration-enable) at the web app side.

Configure virtual network integration at the web app side by following these steps:

1. In the [Azure portal](https://portal.azure.com), navigate to your web app, and then select **Networking**.
1. In **Outbound traffic configuration**, configure **Virtual Network integration**, select **Add virtual network integration**, and then specify the subscription, virtual network, and subnet.
1. On **Virtual network configuration**, make sure that the **Container image pull** option is selected.

    :::image type="content" source="media/pull-image-to-web-app-fail/container-image-pull-option.png" alt-text="Screenshot of the Container image pull option." lightbox="media/pull-image-to-web-app-fail/container-image-pull-option.png":::

To pull the image over the virtual network, you must enable **Pull image over VNet** in the **Deployment Center** of the web app. If the container registry has public access disabled or set to specific networks, you might receive the "Failed to load ACR Tags - failed" message, as shown in the following example. That error is expected in this scenario. If this error occurs, the drop-down options for **Image** and **Tag** aren't available. You must manually enter the image and tag.

:::image type="content" source="media/pull-image-to-web-app-fail/failed-to-load-acr-error.png" alt-text="Screenshot of the failed to load ACR Tags error message." lightbox="media/pull-image-to-web-app-fail/failed-to-load-acr-error.png":::
 
## Next steps

If this troubleshooting guidance doesn't resolve the issue, consider the following:

- Check the network security groups and route tables that are associated with your subnets.
- If a virtual appliance, such as a firewall, controls the traffic between subnets, review the firewall and its access rules.

Use the [Kudu service](/azure/app-service/resources-kudu) for additional troubleshooting. You can connect to the Kudu service. For example, use Bash to test Domain Name System (DNS) resolution by running `nslookup <acr-name>.azurecr.io`, or check connectivity by using `tcpping <acr-name>.azurecr.io`.