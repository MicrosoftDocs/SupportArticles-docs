---
title: Create or Delete Resources - Frequently asked questions (FAQ) - Azure App Services (Web Apps)
description: Troubleshoot creation and deletion related issues in Azure App Service.
ms.date: 6/16/2022
author: amolmehrotra
ms.author: amehrot
ms.reviewer: amehrot, rimarr
ms.service: app-service
keywords:
#Customer intent: As an Azure App Service user, I want to troubleshoot the creation and deletion related issues.
---

# Create or Delete Resources - Frequently asked questions (FAQ) - Azure App Services (Web Apps)

This article has answers to frequently asked questions (FAQs) about creating and deleting resources for [Web Apps feature of Azure App Service](https://azure.microsoft.com/services/app-service/web/).

[!INCLUDE [support-disclaimer](../../includes/support-disclaimer.md)]

## What if I want to create a Web App with the same name as another one?

You won't be able to create a Web App with a name that already exists in the platform. The Web App name becomes part of the Web App’s URL, so it must be unique among all Azure App Service Web Apps.

## What if I want to create a Web App in a region that is unavailable?

Certain Azure regions require customers to go through a request process in order to gain access. See the [Azure region access request process](https://docs.microsoft.com/troubleshoot/azure/general/region-access-request-process) to request access or [Azure App Service available by region](https://azure.microsoft.com/global-infrastructure/services/?products=app-service&regions=all) to see onboard regions.

## If I delete all my Web Apps will I still be charged?

Yes, you will. Unless you choose to delete the App Service Plans along with all Web Apps during the delete operation.

To stop all billing associated with your App Service, you need to delete the App Service Plan or scale the App Service Plan back to the free tier. Check this for more on [How much does my App Service Plan cost?](https://docs.microsoft.com/azure/app-service/overview-hosting-plans#how-much-does-my-app-service-plan-cost) and [Plan and manage costs for Azure App Service](https://docs.microsoft.com/azure/app-service/overview-manage-costs).

## I'm not able to create or delete a Web App due to a permission error. What are the permissions I need to be able to create or delete a Web App?

You would need minimum Contributor access on the Resource Group to be successfully able to deploy App Services. Only with the Web plan and the web site contributor access on the Resource Group, it doesn't allow to create the app service in the Resource Group.
You can see more on the Azure built-in roles on [Azure built-in roles](https://docs.microsoft.com/azure/role-based-access-control/built-in-roles).

## What if the requested SKU of the App Service Plan isn't available in the Resource Group?

There are App Service deployment that do not have specific SKUs available due to internal constraints (for example, isn't available for a location or zone). If the requested SKU is not available in the Resource Group, you must create a new App Service Plan in a new Resource Group in the same region or in the same Resource Group using a different region.

If you want to re-use the same Resource Group and region, it is required to delete all the App Services, App Service Plans, and `Microsoft.Web/Certificates` resources in this Resource Group, then create the desired SKU in this Resource Group. **Please note:** migrate App Services originating in this Resource Group to another Resource Group won’t unblock the creation.

## I am trying to delete my App Service Plan but I'm getting the following error "Storage usage quota exceeded. Cannot update or delete a server farm. Please make sure your file system storage is below the limit of the target pricing tier". What and where should I check this?

During the deletion process we calculate usage of the remaining App Service Plans, if they are above the remaining limit then this error is presented.
The storage limit is the total content size across all apps in the same App Service Plan. The total content size of all apps across all App Service Plans in a single Resource Group and region cannot exceed 500 GB. The file system quota for App Service hosted apps is determined by the aggregate of App Service Plans created in a region and Resource Group.

Please check this [App Service limits - Item 5](https://docs.microsoft.com/azure/azure-resource-manager/management/azure-subscription-service-limits#app-service-limits)  and [App Service pricing](https://azure.microsoft.com/pricing/details/app-service/windows/) for more information.

## Is there any way to list deleted Web Apps for my Subscription?

To get the collection of deleted Web Apps that were deleted within 30 days inside your Subscription ID you can use `Get-AzDeletedWebApp`  to retrieve the Web Apps and its details. Deleted apps are purged from the system 30 days after the initial deletion. After an app is purged, it can't be recovered. Please check [List deleted apps](https://docs.microsoft.com/azure/app-service/app-service-undelete#list-deleted-apps) for more information.

## How do I restore a deleted Web App or a deleted App Service Plan?

Once the Web App you want to restore has been identified, and it has not been deleted after 30 days, you can restore it using `Restore-AzDeletedWebApp`. Please check [Restore deleted app](https://docs.microsoft.com/azure/app-service/app-service-undelete#restore-deleted-app) and [Restore(Undelete) Deleted Web Apps - Microsoft Tech Community](https://techcommunity.microsoft.com/t5/apps-on-azure-blog/restore-undelete-deleted-web-apps/ba-p/2922088) for more information.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
