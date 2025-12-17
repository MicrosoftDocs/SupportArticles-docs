---
title: Error 403 - This web app is stopped message
description: This article provides guidance on addressing the "Error 403 - This web app is stopped" message. 
author: JarrettRenshaw
manager: dcscontentpm
ms.topic: troubleshooting-general
ms.date: 12/17/2025
ms.author: jarrettr
ms.reviewer: v-ryanberg
ms.service: azure-app-service
ms.custom: sap:Availability, Performance, and Application Issues
---
# "Error 403 - This web app is stopped" message 

This article provides guidance on addressing the "Error 403 - This web app is stopped" message in Azure App Service.

## Symptom

When browsing to an Azure web site, you encounter the following message: "Error 403 - This web app is stopped."

## Cause

There are three possible conditions:

- The site has reached a [billing limit](#billing-limit) and is disabled.
- The website has been [stopped in the portal](#website-stopped-in-the-portal).
- The website has reached a [resource quota limit](#website-has-reached-a-resource-quota-limit).

## Resolution

### Billing limit

This can occur when your Azure subscription has a spending limit. When the limit is reached, your site is suspended. 

To verify this, browse to the [Azure Account Portal](https://account.windowsazure.com/Home/Index) and select **Account Center**. 

If this is the issue, see [What do I do if my Azure subscription becomes disabled?](https://azure.microsoft.com/documentation/articles/billing-subscription-become-disable/) for information on how to resolve subscription limits.

### Website stopped in the portal

In [Azure portal](https://portal.azure.com/), check the status of your site. If it reads **Stopped**, select **Start**.

### Website has reached a resource quota limit

In Azure portal, navigate to the **Quotas** blade and determine your quota status. 

There are two recovery options if you reach a usage quota:

- Wait until the quota is reset. Under each quota, you see **Resets in X hours X minutes**. This is the quota measurement period. If you choose to wait, the site isn't be functional until this time expires. For example, the **Data Out** quota is applied once per day. If the quota is reached in the first hour of the measurement period (one day), your site will be offline for 23 hours until the quota is reset.

- Scale up the web hosting plan. Quotas only apply to the Free and Shared web hosting plans. Upgrading your plan can solve the limit issue. For more information, see [Azure plan](https://azure.microsoft.com/pricing/offers/ms-azr-0017g/) and [Pricing calculator](https://azure.microsoft.com/pricing/calculator/).

[!INCLUDE [azure-help-support](~/includes/azure-help-support.md)]

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]


