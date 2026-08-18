---
title: Error 403 - This web app is stopped message
description: Learn how to troubleshoot and resolve the Error 403 - This web app is stopped message caused by billing limits, stopped status, or resource quotas.
author: kaushika-msft
manager: dcscontentpm
ms.topic: troubleshooting
ms.date: 08/17/2026
ms.author: kaushika
ms.reviewer: kaushika
ms.service: azure-app-service
ms.custom: sap:Availability, Performance, and Application Issues
---
# Error 403 - This web app is stopped message 

## Summary

This article explains how to identify and resolve the **Error 403 - This web app is stopped** message in Azure App Service by checking billing limits, app status, and resource quotas.

## Symptom

When browsing to an Azure web site, you encounter the following message:

> Error 403 - This web app is stopped.

## Cause

This error message can occur for three reasons:

- The site reached a [billing limit](#billing-limit) and is disabled.
- The website is [stopped in the portal](#website-stopped-in-the-portal).
- The website reached a [resource quota limit](#website-reached-a-resource-quota-limit).

## Resolution

### Billing limit

This error occurs when your Azure subscription has a spending limit. When the limit is reached, Azure suspends your site. 

To verify this condition, go to the [Azure Account Portal](https://account.windowsazure.com/Home/Index) and select **Account Center**. 

If this condition is the issue, see [Reactivate a disabled Azure subscription](/azure/cost-management-billing/manage/subscription-disabled) for information on how to resolve subscription limits.

### Website stopped in the portal

In [Azure portal](https://portal.azure.com/), check the status of your site. If it reads **Stopped**, select **Start**.

### Website reached a resource quota limit

In Azure portal, go to the **Quotas** blade to check your quota status. 

If you reach a usage quota, you have two recovery options:

- Wait until the quota resets. Under each quota, you see **Resets in X hours X minutes**. This value shows the quota measurement period. If you choose to wait, the site isn't functional until this time expires. For example, the **Data Out** quota resets once per day. If the quota is reached in the first hour of the measurement period (one day), your site is offline for 23 hours until the quota resets.

- Scale up the web hosting plan. Quotas only apply to the Free and Shared web hosting plans. Upgrading your plan can solve the limit issue. For more information, see [Azure plan](https://azure.microsoft.com/pricing/offers/ms-azr-0017g/) and [Pricing calculator](https://azure.microsoft.com/pricing/calculator/).


