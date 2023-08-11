---
title: Create or Delete Function app resources FAQ
description: Get answers to frequently asked questions about creating or deleting Azure Functions.
author: gasridha
ms.author: gasridha
ms.service: cloud-services
ms.date: 11/08/2023
ms.reviewer: 
---
# FAQ on creating, deleting, or restoring Azure function apps

Use the following guidance to learn more about function apps, including considerations for an Azure Storage account, securing the storage account, solutions for specific error messages, and more.

Scan the following section headings and select one or more that will help resolve your issue.

[!INCLUDE [support-disclaimer](../../includes/support-disclaimer.md)]

## I'm just getting started with Azure Function apps. How do I How to create function apps?

Azure function apps use the Azure App Service infrastructure. You can create an Azure Functions app using the following:
* [Azure portal](https://docs.microsoft.com/azure/azure-functions/functions-create-function-app-portal)
* [Azure CLI](https://docs.microsoft.com/azure/azure-functions/functions-create-first-azure-function-azure-cli#create-a-function-app)
* [PowerShell](https://docs.microsoft.com/powershell/module/az.functions/)
* [Azure Resource Manager template or Bicep template](https://docs.microsoft.com/azure/azure-functions/functions-infrastructure-as-code)
* You can also create an app while deploying a function project from Visual Studio or Visual Studio Code.
 
## What are the considerations for an Azure Storage account used by Azure functions ?
 
When creating a function app, you can create or link to a general-purpose Azure Storage account that supports blob, queue, and table storage. Azure Functions relies on Azure Storage for operations, such as managing triggers and logging function executions. For more information, see [Storage considerations for Azure Functions](https://docs.microsoft.com/azure/azure-functions/storage-considerations).
- Make sure that you have permissions to create a storage account and other resources. There can be no role-based access control (RBAC), policy, or scope violations.
- Use Managed Identity for Azure Storage account connection string, only for `AzureWebJobsStorage`. 
  - For more information, see [Connecting to host storage with an identity (Preview)](https://docs.microsoft.com/azure/azure-functions/functions-reference?tabs=blob#connecting-to-host-storage-with-an-identity-preview).
 
## How can I secure the Azure Storage account used by Azure functions ?
 
You can create an Azure Functions app and a new storage account secured with private endpoints. Host the Functions app on a plan supporting virtual-network integration.
- For creation from the portal, see [networking tutorial](https://learn.microsoft.com/en-us/azure/azure-functions/functions-create-vnet).
- For Azure Resource Manager templates, go to [Azure/azure-quickstart-templates](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.web/function-app-storage-private-endpoints).
- You can also update an existing Functions app to point to a new secure storage account. For more information, see [Restrict your storage account to a virtual network](https://docs.microsoft.com/azure/azure-functions/configure-networking-how-to#restrict-your-storage-account-to-a-virtual-network).
 
## Is it possible to migrate an Azure Functions app across different hosting plans ?
 
In Windows, you can use Azure CLI commands to migrate a Functions app between a Consumption and a Premium plan, or vice versa. For more information, see [Plan migration](https://docs.microsoft.com/azure/azure-functions/functions-how-to-use-azure-function-app-settings?tabs=portal#plan-migration).
- Direct migration from/to a dedicated (App Service) plan to/from a Consumption/Premium plan isn't supported because features for event-driven scaling and using serverless features differ across hosting plans.
 
> **Note**: Migrating hosting plans isn't supported in Linux.
 
Review hosting plan (Consumption, Premium, Dedicated) offerings like virtual network connectivity, time-out, billing, and so on. For more information, see [Azure Functions hosting options](https://docs.microsoft.com/azure/azure-functions/functions-scale).
 
## How can I resolve the error "This region has quota of 0 instances for your subscription. Try selecting different region or SKU" ?
 
If you're consistently experiencing resource creation issues in a particular region, you might also try to create the resource in a geographically paired region, if your business allows for it. For example, *West US 2* and *West Central US* are paired regions. *East Asia (Hong Kong)* and *Southeast Asia (Singapore)* are also paired regions. 

For more information, see:
- [Azure regions decision guide - Cloud Adoption Framework](https://docs.microsoft.com/azure/cloud-adoption-framework/migrate/azure-best-practices/multiple-regions)
- [Cross-region replication in Azure](https://docs.microsoft.com/azure/availability-zones/cross-region-replication-azure#azure-cross-region-replication-pairings-for-all-geographies)

## How can I resolve the error "The pricing tier is not allowed in this resource group" or "SkuNotAllowedForResourceGroup"
 
We recommend creating the plan in a new resource group. Differing SKUs require unique machines. When you create an app in a resource group, it's mapped and assigned to a pool of resources. If you create another plan in that resource group and the mapped pool lacks the required resources, the error appears.
 
For more information, see [Creating Function apps in an existing resource group](https://github.com/Azure/Azure-Functions/wiki/Creating-Function-Apps-in-an-existing-Resource-Group).

## What can I do if creation of Function app content file share fails with: "The remote server returned an error: (403) Forbidden" ?

For function apps in Consumption or Elastic Premium, a file share is created on the storage account and referenced with the app setting `WEBSITE_CONTENT_SHARE`. This error occurs because the storage account has a firewall or private endpoints configured, or other virtual network security restrictions such as network security group (NSG) rules, and so on.

To resolve the error, create a file share in advance on the secure storage account, and configure it to `WEBSITE_CONTENT_SHARE`. For more information, see [Restrict your storage account to a virtual network](https://docs.microsoft.com/azure/azure-functions/configure-networking-how-to#restrict-your-storage-account-to-a-virtual-network).

##  Are there any alternate tools for creation ?
 
You can use alternate tools like Az CLI, PowerShell, and Az.Functions. Use the latest versions of Azure CLI or Azure PowerShell and the Az.Functions module. Also, for example, if there's an issue in the Azure portal, try using Azure CLI.
 
##  How can I set the function runtime version for Windows and Linux ?
 
For Windows apps, set it with the Azure portal (**Settings** > **Configuration** > **Function runtime Settings** > **Runtime version**), or create an application setting `FUNCTIONS_EXTENSION_VERSION` and set it to the major runtime version, for example, ~4 to target V4. 
* For more information, see [How to target Azure Functions runtime versions](https://docs.microsoft.com/azure/azure-functions/set-runtime-version).
* Pin it to a minor version based on host releases by setting `FUNCTIONS_EXTENSION_VERSIO` to a minor version. 
  * Also see [Azure Functions host releases](https://github.com/Azure/azure-functions-host/releases).
 
For Linux apps, see [Manual version updates on Linux](https://docs.microsoft.com/azure/azure-functions/set-runtime-version?tabs=azurecli#manual-version-updates-on-linux).
 
## I am receiving HTTP 429 errors. How can I troubleshoot ?
 
Throttling happens at two levels—Azure Resource Manager and resource provider (Microsoft.Web). The level depends on the subscription type and the hosting plan. 
For more information, see:
* [Azure Resource Manager throttling](https://docs.microsoft.com/azure/azure-resource-manager/management/request-limits-and-throttling)
* [Azure subscription and service limits, quotas, and constraints](https://docs.microsoft.com/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-functions-limits)
* [Azure App Services](https://docs.microsoft.com/azure/azure-resource-manager/management/azure-subscription-service-limits#app-service-limits)
 
**Note**: If the issue is frequent, you can buy a different subscription or update the hosting plan to resolve the error. Otherwise, wait and retry.

## How can i resolve issues occuring during Function app deletion or restore ?

After publishing code from Visual Studio and using `WEBSITE_RUN_FROM_PACKAGE`, Azure portal sets functions as *read-only* to prevent editing precompiled assets in the portal. To delete functions in a Functions app, remove the unwanted functions from your code, enable the **Remove additional files at destination** option in profile settings, and redeploy your code.
 
Restoring Azure Functions apps hosted on a Consumption plan or Elastic Premium plan isn't supported. If you have the Functions app content or can access the storage account, you can update app settings or create a new function app and use the content. You can restore Azure Functions apps on a Dedicated App service plan if it isn't using Azure Files for content storage. 

For more information, see [Restore (undelete) deleted web apps](https://techcommunity.microsoft.com/t5/apps-on-azure-blog/restore-undelete-deleted-web-apps/ba-p/2922088).
 
Make sure that you have sufficient permissions to delete an Azure Functions app. There can be no role-based access control (RBAC), policy, or scope violations.
 
## Is there anything else I can do before contacting Microsoft support? 

You can collect some data before opening support ticket. If Functions app creation or deletion fails in: 
 * Azure portal: Reproduce the issue and capture an F12 trace.
 * Azure CLI or Azure PowerShell: Share the command that reported the error, with verbose logging.
* For Azure Resource Manager deployment failure, find the error message in the Azure portal:
  1. Select **Resource Group** > **Deployments**. 
  2. Share the failed-task correlation ID.


[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
