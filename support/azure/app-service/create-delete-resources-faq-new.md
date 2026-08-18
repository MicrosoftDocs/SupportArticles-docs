---
title: FAQ - Creating or deleting web apps in Azure App Service
description: Learn how to create, delete, and restore Azure App Service web apps, and resolve naming, quota, permission, and billing issues. Get answers now.
services: active-directory
author: kaushika-msft
ms.reviewer: amehrot, rimarr, kaushika
manager: dcscontentpm
ms.topic: troubleshooting
ms.date: 08/17/2026
ms.author: kaushika
ms.service: azure-app-service
ms.custom: sap:Configuration and Management
---

# Frequently asked questions (FAQ) - Creating or deleting resources in Azure App Service

## Summary

This article answers common questions about creating, deleting, and restoring [Azure App Service web apps](https://azure.microsoft.com/services/app-service/web). Learn how to resolve naming conflicts, quota issues, permission errors, and billing questions.

## Create a web app in Azure App Service

### What if I create a web app with a duplicate name as another one?

You can't create a web app with a name that already exists in Azure. The web app name is part of the web app's URL, so it must be unique among all Azure App Service web apps.
          
### How can I create an Azure App Service web app in a region that's unavailable in the subscription?

Certain Azure regions require customers to go through a request process to gain access. For more information, see the [Azure region access request process](../general/region-access-request-process.md) and [Azure App Service available by region](https://azure.microsoft.com/global-infrastructure/services/?products=app-service&regions=all).

### What if the requested SKU of the App Service plan isn't available in the resource group?

Your App Service deployments might not have specific SKUs available due to constraints (for example, the SKU isn't available in the region). 
          
If the requested SKU isn't available in the resource group, you must create a new App Service Plan in a new resource group in the same region or in the same resource group using a different region.
          
If you want to reuse the same resource group and region, you must delete all the App Services, App Service plans, and `Microsoft.Web/Certificates` resources and then create the desired SKU in this resource group. Be aware that migrating App Services originating in this resource group to another resource group doesn't unblock the creation.
      
### I'm getting the following error - "This region has quota of 0 instances for your subscription. Try selecting a different region or SKU." You might also consistently experience resource creation issues in a particular region.

This error means your subscription has no available quota for the selected region. You have two options:

1. Create your web app in a different region. If possible, choose a geographically paired region for better resiliency and compliance. Examples include:

- *West US 2* ↔ *West Central US*
- *East Asia (Hong Kong SAR)* ↔ *Southeast Asia (Singapore)*

Each Azure region has unique characteristics that affect performance, availability, and regulatory requirements. Selecting the right region is critical for your workload. For more information, see:

- [Azure region pairs and nonpaired regions](/azure/reliability/regions-paired#azure-cross-region-replication-pairings-for-all-geographies)
- [Azure regions decision guide - Select Azure regions](/azure/cloud-adoption-framework/ready/azure-setup-guide/regions)

1. Request additional quota for your App Service plan.

Use the [App Service quota self-service experience](https://portal.azure.com/?feature.customportal=false#view/Microsoft_Azure_Capacity/QuotaMenuBlade/~/overview) in the [Azure portal](https://portal.azure.com). This portal provides a dedicated quota blade where you can:

- View current usage and limits across SKUs.
- Set custom quotas tailored to your plan.

## Delete or restore web apps in Azure App Service

### If I delete all my web apps, am I still charged?

Yes, charges still apply unless you delete the App Service plan that the web app runs on and all its web apps.   
          
To stop all billing associated with your App Service, delete the App Service plan or scale the App Service plan to the free tier. For more information, see [How much does my App Service Plan cost?](/azure/app-service/overview-hosting-plans#how-much-does-my-app-service-plan-cost) and [Plan and manage costs for Azure App Service](/azure/app-service/overview-manage-costs).
          
### I can't create or delete an Azure App Service web app due to a permission error. What permissions do I need to create or delete a web app?

You need at least Contributor access on the resource group to deploy App Services. If you have Contributor access only on the App Service plan and web app, you can't create the app service in the resource group.
          
For more information, see [Azure built-in roles](/azure/role-based-access-control/built-in-roles).
          
### I'm trying to delete my App Service plan, but I'm getting the following error - "Storage usage quota exceeded. Can't update or delete a server farm. Please ensure your file system storage is below the limit of the target pricing tier". How and where do I check the file system storage limit?

During the deletion process, Azure calculates the usage of the remaining App Service plans. If they're above the remaining limit, this error appears. 
          
The storage limit is the total content size across all apps in the same App Service plan. The total content size of all apps across all App Service plans in a single resource group and region can't exceed 500 GB. The file system quota for App Service hosted apps is determined by the aggregate of App Service plans created in a region and resource group.

For more information, see: 
          
- [App Service limits - Storage](/azure/azure-resource-manager/management/azure-subscription-service-limits#app-service-limits) 
- [App Service pricing](https://azure.microsoft.com/pricing/details/app-service/windows)

### Is there a way to list the deleted web apps for my App Service subscription?

You can run `Get-AzDeletedWebApp` to get the list of the web apps that you deleted within the last 30 days in your subscription. Azure permanently deletes apps 30 days after the initial deletion. After an app is permanently deleted, it can't be recovered. For more information, see [List deleted apps](/azure/app-service/app-service-undelete#list-deleted-apps).

### How do I restore a deleted web app or a deleted App Service plan?
If you deleted the web app within the last 30 days, you can restore it by using `Restore-AzDeletedWebApp`. For more information, see: 
          
- [Restore deleted app](/azure/app-service/app-service-undelete#restore-deleted-app) 
- [Restore deleted web apps](https://techcommunity.microsoft.com/t5/apps-on-azure-blog/restore-undelete-deleted-web-apps/ba-p/2922088)
