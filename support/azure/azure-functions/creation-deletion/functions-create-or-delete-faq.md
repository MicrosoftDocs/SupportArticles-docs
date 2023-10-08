---
title: Create, delete, or restore Azure function app resources
description: Describes some common issues and solutions for creating, deleting, or restoring Azure function apps.
ms.date: 08/24/2023
ms.reviewer: gasridha, v-sidong
---
# Resolve issues when creating, deleting, or restoring Azure function apps

This article lists some common issues that may occur when you create, delete, or restore Azure function apps, and steps to resolve the issues.

## Create function apps

Azure function apps use the Azure App Service infrastructure. You can create an Azure function app by using:

- [Azure portal](/azure/azure-functions/functions-create-function-app-portal)
- [Azure CLI](/azure/azure-functions/functions-create-first-azure-function-azure-cli#create-a-function-app)
- [PowerShell](/powershell/module/az.functions/)
- [Azure Resource Manager template or Bicep template](/azure/azure-functions/functions-infrastructure-as-code)

You can also create an app while deploying a function project from Visual Studio or Visual Studio Code.

### Considerations for an Azure Storage account used by Azure Functions

When creating a function app, you can create or link to a general-purpose Azure Storage account that supports blob, queue, and table storage. Azure Functions relies on Azure Storage for operations, such as managing triggers and logging function executions. For more information, see [Storage considerations for Azure Functions](/azure/azure-functions/storage-considerations).

- Make sure that you have permissions to create a storage account and other resources. There can be no role-based access control (RBAC), policy, or scope violations.
- Use Managed Identity for Azure Storage account connection string, only for `AzureWebJobsStorage`. For more information, see [Connecting to host storage with an identity (Preview)](/azure/azure-functions/functions-reference#connecting-to-host-storage-with-an-identity-preview).

### Secure the Azure Storage account used by Azure Functions

You can create an Azure function app and a new storage account secured with private endpoints. Host the function app on a plan supporting virtual-network integration.

- For information on creation from the portal, see the [networking tutorial](/azure/azure-functions/functions-create-vnet).
- For Azure Resource Manager templates, see [Azure/azure-quickstart-templates](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.web/function-app-storage-private-endpoints).
- You can also update an existing Functions app to point to a new secure storage account. For more information, see [Restrict your storage account to a virtual network](/azure/azure-functions/configure-networking-how-to#restrict-your-storage-account-to-a-virtual-network).

### Migrate an Azure function app across different hosting plans

In Windows, you can use Azure CLI commands to migrate a function app between a [Consumption](/azure/azure-functions/consumption-plan) and a [Premium plan](/azure/azure-functions/functions-premium-plan), or vice versa. For more information, see [Plan migration](/azure/azure-functions/functions-how-to-use-azure-function-app-settings#plan-migration).

- Direct migration from/to a dedicated (App Service) plan to/from a Consumption/Premium plan isn't supported because features for event-driven scaling and using serverless features differ across hosting plans.

> [!NOTE]
> Linux doesn't support migrating hosting plans.

Review hosting plan (Consumption, Premium, Dedicated) offerings like virtual network connectivity, time-out, billing, and so on. For more information, see [Azure Functions hosting options](/azure/azure-functions/functions-scale).

### Resolve the error "This region has quota of 0 instances for your subscription. Try selecting different region or SKU"

If you're consistently experiencing resource creation issues in a particular region, try to create the resource in a geographically paired region if your business allows it. For example, *West US 2* and *West Central US* are paired regions. *East Asia (Hong Kong SAR)* and *Southeast Asia (Singapore)* are also paired regions.

For more information, see:

- [Azure regions decision guide - Cloud Adoption Framework](/azure/cloud-adoption-framework/migrate/azure-best-practices/multiple-regions)
- [Cross-region replication in Azure](/azure/availability-zones/cross-region-replication-azure#azure-cross-region-replication-pairings-for-all-geographies)

### Resolve the error "The pricing tier is not allowed in this resource group" or "SkuNotAllowedForResourceGroup"

We recommend that you create the plan in a new resource group. Different SKUs require unique machines. When you create an app in a resource group, it's mapped and assigned to a pool of resources. If you create another plan in that resource group and the mapped pool lacks the required resources, the error appears.

For more information, see [Creating function apps in an existing resource group](https://github.com/Azure/Azure-Functions/wiki/Creating-Function-Apps-in-an-existing-Resource-Group).

### Creation of a function app content file share fails with: "The remote server returned an error: (403) Forbidden"

For function apps in [Consumption plan](/azure/azure-functions/consumption-plan) or [Elastic Premium plan](/azure/azure-functions/functions-premium-plan), a file share is created on the storage account and referenced by using the app setting `WEBSITE_CONTENT_SHARE`. This error may occur because the storage account has a firewall, private endpoints, or other virtual network security restrictions such as network security group (NSG) rules.

To resolve the error, create a file share in advance on the secure storage account, and configure it to `WEBSITE_CONTENT_SHARE`. For more information, see [Restrict your storage account to a virtual network](/azure/azure-functions/configure-networking-how-to#restrict-your-storage-account-to-a-virtual-network).

### Alternative tools for creation

You can use alternative tools like Azure CLI, PowerShell, and `Az.Functions`. Make sure to use the latest versions of the tools. If there's an issue when using one of the tools, like Azure portal, try using another, like Azure CLI.

### Set the function runtime version for Windows and Linux

For Windows apps, set the runtime version in the Azure portal (**Settings** > **Configuration** > **Function runtime Settings** > **Runtime version**), or create an application setting `FUNCTIONS_EXTENSION_VERSION` and set it to the major runtime version, for example, `~4` to target V4. For more information, see [How to target Azure Functions runtime versions](/azure/azure-functions/set-runtime-version). Pin it to a minor version based on host releases by setting `FUNCTIONS_EXTENSION_VERSION` to a minor version. Also see [Azure Functions host releases](https://github.com/Azure/azure-functions-host/releases).

For Linux apps, see [Manual version updates on Linux](/azure/azure-functions/set-runtime-version#manual-version-updates-on-linux).

### Troubleshoot HTTP 429 errors

Throttling happens at two levels: Azure Resource Manager and resource provider (Microsoft.Web). The level depends on the subscription type and the hosting plan.
For more information, see:

- [Azure Resource Manager throttling](/azure/azure-resource-manager/management/request-limits-and-throttling)
- [Azure subscription and service limits, quotas, and constraints](/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-functions-limits)
- [Azure App Services limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#app-service-limits)

> [!NOTE]
> If the issue is infrequent, wait and retry after some time to see if the issue resolves. If the issue is frequent, you can buy a different subscription or update the hosting plan to resolve the error.

## Delete or restore function apps

After you publish code from Visual Studio and use `WEBSITE_RUN_FROM_PACKAGE`, the Azure portal sets functions as *read-only* to prevent editing precompiled assets in the portal. To delete functions in a function app, remove the unwanted functions from your code, enable the **Remove additional files at destination** option in profile settings, and redeploy your code.

Restoring Azure function apps hosted on a [Consumption plan](/azure/azure-functions/consumption-plan) or [Elastic Premium plan](/azure/azure-functions/functions-premium-plan) isn't supported. If you have the function app content or can access the storage account, update the app settings or create a new function app, and use the content. You can restore Azure function apps on a Dedicated App service plan if it isn't using Azure Files for content storage.

For more information, see [Restore (undelete) deleted web apps](https://techcommunity.microsoft.com/t5/apps-on-azure-blog/restore-undelete-deleted-web-apps/ba-p/2922088).

Make sure that you have sufficient permissions to delete an Azure function app. There can be no role-based access control (RBAC), policy, or scope violations.

## Collect data before contacting Microsoft support

If the function app creation or deletion fails, collect and share the following data when creating a support ticket:

- Azure portal: Reproduce the issue and [capture a browser trace](/azure/azure-portal/capture-browser-trace).
- Azure CLI or Azure PowerShell: Share the command that reported the error and verbose logging.
- For Azure Resource Manager deployment failures, find the error message in the Azure portal:

  1. Select **Resource Group** > **Deployments**.
  1. Share the failed task correlation ID.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
