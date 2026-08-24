---
title: FAQ - Scaling web apps in Azure App Service
description: Get answers to common questions about scaling web apps in Azure App Service, including scale up, autoscale, instance limits, and Premium tier upgrades.
author: kaushika-msft
ms.author: kaushika
ms.reviewer: kaushika
manager: dcscontentpm
ms.topic: troubleshooting
ms.service: azure-app-service
ms.date: 08/18/2026
ms.custom: sap:Configuration and Management
---

# Frequently asked questions (FAQ) - Scaling web apps in Azure App Service

## Summary

This article answers common questions about [scaling web apps in Azure App Service](https://azure.microsoft.com/services/app-service/web). Learn how to scale up, configure autoscale, understand instance limits, and troubleshoot common scaling issues.

## Scaling a web app

### How do I scale up a web app?

You can scale up a web app by using the [Azure portal](https://portal.azure.com). On your web app page, select **Scale Up (App Service Plan)** from the left menu. For more information, see [Scale up an app in Azure App Service](/azure/app-service/manage-scale-up).

### Is there any further action I need to perform before scaling up a Free App Service plan?

Before you switch an App Service plan from the Free tier, remove the [spending limits](https://azure.microsoft.com/pricing/spending-limits/) for your Azure subscription. To view or change options for your App Service subscription, see [Microsoft Azure Subscriptions - Remove spending limits](/azure/cost-management-billing/manage/account-admin-tasks#remove-spending-limit).

### Is there any instance limitation when scaling a web app?

Yes. The limitation depends on the tier of the App Service plan. For more information, see [App Service limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#app-service-limits).

### Can I scale a Standard App Service plan for more than 10 instances?

The Standard App Service plan tier doesn't support more than 10 instances. You can move to a Premium App Service plan and get the benefit of having 30 instances (in selected regions) per App Service plan. To check the instance limit per pricing tier, see [App Service limits](/azure/azure-resource-manager/management/azure-subscription-service-limits#app-service-limits).

### Can I configure App Services on the same App Service plan with a different number of instances?

You can configure it by enabling Per-App Scaling, and changing App Service's `numberOfWorkers` property to the desired instance count. For more information, see [Per-App Scaling](/azure/app-service/manage-scale-per-app#recommended-configuration-for-high-density-hosting).

### Why does scaling up for my web app also trigger scaling up for another web app?

Scaling happens on the entire App Service plan. If you host multiple App Services in the same App Service plan, all App Services in this App Service plan scale up.

### Why isn't autoscale working as expected?

You might be running into a scenario where the system intentionally chooses not to scale to avoid an infinite loop due to *flapping*. This behavior usually happens when there isn't an adequate margin between the scale-out and scale-in thresholds. For more information about how to avoid flapping and other autoscale best practices, see [Autoscale best practices](/azure/azure-monitor/autoscale/autoscale-best-practices).

### How do I determine when an autoscale rule triggers scaling?

You can retrieve scale history from the activity log. Whenever your resource scales up or down, an event is logged in the activity log. View the scale history of your resource for the past 24 hours by switching to the **Run history** tab. To view the complete scale history (for up to 90 days), select **Click here to see more details**. For more information, see [View the scale history of your resource](/azure/azure-monitor/autoscale/autoscale-get-started#view-the-scale-history-of-your-resource). 

### Why does autoscale sometimes scale only partially?

Autoscale triggers when metrics exceed preconfigured boundaries. Sometimes, you might notice that the capacity is only partially filled compared to what you expected. This behavior can occur when the number of instances you want isn't available. In that scenario, autoscale partially fills in with the available number of instances. Autoscale then runs the rebalance logic to get more capacity. It allocates the remaining instances, and this allocation might take a few minutes. If you don't see the expected number of instances after a few minutes, it might be because the partial refill was enough to bring the metrics within the boundaries. Autoscale can also scale down because it reached the lower metrics boundary.

### When I scale up an App Service plan to a Premium V3 tier, the "Premium V3 isn't supported for this scale unit. Please consider redeploying or cloning your app." error occurs. What do I do?

The Premium V3 feature requires the site to run on the newest hardware infrastructure. To scale up an App Service plan to Premium V3, the web app must be running in an App Service deployment that supports PremiumV3. For more information, see [Scale up from an unsupported resource group and region combination](/azure/app-service/app-service-configure-premium-tier#scale-up-from-an-unsupported-resource-group-and-region-combination).

### I'm unable to scale up or scale down the App Service plan due to the "You have exceeded the maximum amount of scale changes within the past hour (XX changes and limit is XX)" error. What do I do?

To avoid this issue, don't perform scaling operations that release more than *XX* instances in an hour. Every time you release an instance during a scale-down operation, the instance restarts to ensure the next App Service plan gets a clean instance. When you perform too many scaling operations in quick succession, instance restarts can cause performance problems for other App Services. There's a throttling mechanism for scaling that prevents you from performing scaling operations more than the acceptable limit in quick succession.

### My web app is using the Diagnostic setting `AppServiceFileAuditLogs` and I'm unable to scale the App Service plan from Premium V2 to the Basic tier. What do I do?

The file change audit logs `AppServiceFileAuditLogs` are only available for App Services in Premium, PremiumV2, and Isolated App Service plans. If you need `AppServiceFileAuditLogs`, you can't scale down to the Basic tier. To make these file change audit logs available, configure your App Service plan for a Premium or higher tier.

### I'm getting the "App Service Plans with fewer than 3 workers aren't allowed for zone redundancy. Requested number of workers: number" error. What do I do?

[Availability zone support](/azure/reliability/reliability-app-service#availability-zone-support) requires at least three instances. Verify if the App Service plan has zone redundancy enabled and if you have autoscale active on the App Service plan. If so, correct the autoscale rule to not set the number of instances to a value less than three.
