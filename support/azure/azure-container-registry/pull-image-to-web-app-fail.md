---
title: Cannot pull image to Azure Web App from Azure Container Registry
description: Provides guidance for troubleshooting the most common errors that you encounter when you pull images from a container registry to Azure Web App for Containers.
ms.date: 08/12/2024
ms.reviewer: andbar; chiragpa; v-rekhanain 
ms.service: azure-container-instances
ms.custom: sap:Image Pull Issues
---

# Fail to pull images to Azure Web App from Azure Container Registry

This article provides guidance for troubleshooting the most common errors that you may encounter when pulling images from an Azure container registry to Azure Web App.

## Symptoms and initial troubleshooting

We recommend that you start troubleshooting by checking the [container registry's health](/azure/container-registry/container-registry-check-health).

To check the container registry's health, run the following command:

```azurecli
az acr check-health --name <myregistry> --ignore-errors --yes
```

If a problem is detected, it provides an error code and description. For more information about the errors and possible solutions, see [Health check error reference](/azure/container-registry/container-registry-health-error-reference).

> [!NOTE]
> If you get Helm-related or Notary-related errors, it doesn't mean that an issue is affecting Container Registry or AKS. It indicates only that Helm or Notary isn't installed, or that Azure CLI isn't compatible with the current installed version of Helm or Notary, and so on.

Next, identify the pull-related error message that is essential for troubleshooting:

1. Sign in to [Azure portal](https://portal.azure.com).
1. Move to your web app > **Deployment Center** > **Log**. Select the commit to view the log details. You can also view the logs for the image pull process in real time by checking **Log stream** under the **Monitoring** section.

The following sections help you troubleshoot the most common errors that are displayed in the Web App logs.

## Error 1: Unauthorized

> `Head \" https://<acr-name>.azurecr.io/v2/<repository>/manifests/<tag>\": unauthorized`

### Solution for Admin user based authentication

The unauthorized error can be caused by incorrect admin credentials. This includes the username, password, or login server you configured in the web app's environment variables.

To resolve the issue, follow these steps:

1. In the [Azure portal](https://portal.azure.com), navigate to your registry container. In the **Settings** section, select **Access keys**. Check the admin user credentials settings of the **Login server**, **Username**, and **password**.
1. Navigate to your web app. In the **Settings** section, Select **Environment variables**.
1. Ensure that the three variables you configured for the container registry's login server, username, and password align with the admin user credentials settings in the registry container.

### Solution for managed identity based on authentication

When you use Azure Web App’s managed identity based on the authentication, the `Microsoft.ContainerRegistry/registries/pull/read` permission must be assigned to the managed identity to perform the pull action.

Azure built-roles that contain the `Microsoft.ContainerRegistry/registries/pull/read` permission are:

- AcrPull
- AcrPush
- ReaderContributor
- Owner

For more information, see [Azure Container Registry roles and permissions](/azure/container-registry/container-registry-roles?tabs=azure-cli).

When you initiate a pull operation from the container registry, the AcrPull role is automatically assigned to the Azure Web App's managed identity. You don’t need to manually add permissions. However, you need to ensure that the role assignment creation isn't blocked, for example, by an Azure Policy. Additionally, verify that the role assignment hasn't been deleted.

## Error 2: manifest tagged by &lt;tag&gt; is not found

> `DockerApiException  : Docker API responded with status code=NotFound, response={"message":"manifest for <acr-name>.azurecr.io/<repository>:<tag> not found: manifest unknown: manifest tagged by \"<tag>\" is not found"}`

### Solution: Make sure the tag exists

The error indicates that the tag associated with the image you are trying to pull was not found. Make sure that the tag exists within the associated repository and registry.

To find the tags within the associated repository and registry using Azure CLI, run the following command:

```azurecli
az acr repository show-tags -n <ContainerRegistryName> --repository <RepositoryName>
```

To find the tags within the associated repository and registry using the Azure portal, follow these steps:

Navigate to your registry container. Under **Services**, select **Repositories**, open the associated repository, and then check the list of tags.

> [!NOTE]
> The `az acr repository show-tags` command or checking the Repositories from the Azure portal only works if the ACR network rules permit it.

## Error 3: client with IP is not allowed access

> `DockerApiException: Docker API responded with status code=InternalServerError, response={"message":"Head \"https:// <acr-name>.azurecr.io/v2/<repository>/manifests/<tag>\": denied: client with IP '<web-app-outbound-ip>' is not allowed access. Refer https://aka.ms/acr/firewall to grant access."}`

### Solution 1: Make sure the container registry built-in firewall allows your device’s IP address

A container registry by default accepts connections over the internet from all networks. To limit the public access, the container registry has a built-in firewall that can restrict access to specific IP addresses or CIDRs, or to fully disable public network access.

This issue can occur if the IP addresses of your web app are blocked by the container registry built-in firewall.

To resolve this issue, make sure the container registry's built-in firewall allows the outbound IP addresses of the web app that needs to pull the image. 

To find web app’s outbound IP addresses, follow these steps:

1. In the [Azure portal](https://portal.azure.com), navigate to your web app.
1. In the **Overview** page, locate **Outbound IP address**, and then select **Show More** to get the full list of the outbound IP addresses

To find web app’s outbound IP addresses by using Azure CLI, see [Find outbound IP addresses in Azure App Service](/azure/app-service/overview-inbound-outbound-ips#find-outbound-ips)

### Solution 2: Configure virtual network integration for the Web App

If you need to fully disable the public network access or to allow only selected networks at the container registry without manually adding the web app’s IP addresses, the alternative option is to pull the image privately. To pull images privately, you need to [configure the container registry with private endpoint](/azure/container-registry/container-registry-private-link) and [enable virtual network integration for the web app](/azure/app-service/configure-vnet-integration-enable).

You can configure virtual network integration at the web app side by using the following steps:

1. In the [Azure portal](https://portal.azure.com), navigate to your web app, and then select **Networking**.
1. Under **Outbound traffic configuration**, configure **Virtual Network integration**, select **Add virtual network integration**, and then specify the subscription, virtual network, and subnet.
1. In the **Virtual network configuration** page, make sure that the **Container image pull** option is selected.
    :::image type="content" source="media/pull-image-to-web-app-fail/container-image-pull-option.png" alt-text="Screenshot of the Container image pull option." lightbox="media/pull-image-to-web-app-fail/container-image-pull-option.png":::

To pull the image over the virtual network, you must enable **Pull image over VNet** in the **Deployment Center** of the web app. Additionally, if the container registry has the public access disabled or set to selected networks, you may get the **failed to load ACR Tags - failed** message, as shown in the following example. That is expected in this scenario. As a result, the drop-down options for **Image** and **Tag** won’t be available. You need to manually enter the image and tag.

:::image type="content" source="media/pull-image-to-web-app-fail/failed-to-load-acr-error.png" alt-text="Screenshot of the failed to load ACR Tags error message." lightbox="media/pull-image-to-web-app-fail/failed-to-load-acr-error.png":::
 
**Next steps**

If the troubleshooting guidance in this article doesn’t resolve the issue, consider the following:

Check the network security groups and route tables associated with your subnets.
If a virtual appliance, like a firewall, controls the traffic between subnets, review the firewall and its access rules.
Use the [Kudu service](/azure/app-service/resources-kudu) for additional troubleshooting. You can connect to the Kudu service. For example, use Bash to test DNS resolution by running `nslookup <acr-name>.azurecr.io` or check connectivity with `tcpping <acr-name>.azurecr.io`.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
