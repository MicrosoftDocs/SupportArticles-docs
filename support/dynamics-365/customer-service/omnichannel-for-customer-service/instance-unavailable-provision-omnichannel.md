---
title: Instance unavailable to select on the provisioning application
description: Provides a resolution for the issue where you don't see all the instances in the Organization selector when provisioning Omnichannel for Customer Service.
ms.reviewer: nenellim
ms.author: nahadda
ms.date: 05/23/2023
---
# Instance isn't available to select on the provisioning application

This article provides a resolution for the issue where not all the instances are shown in the **Organization** selector when you provision Omnichannel for Customer Service.

## Symptoms

You can't see all the instances from the **Organization** selector when provisioning Omnichannel for Customer Service.

## Cause

For security, reliability, and performance reasons, Omnichannel for Customer Service is separated by geographical locations known as "regions." The provisioning webpage only displays instances in the same region, so you might experience issues where you don't see all the instances from the **Organization** selector if you have instances in more than one region and provision Omnichannel for Customer Service without selecting the correct region.

## Resolution

Go to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/). Expand **Resources**, and select **Dynamics 365**. Select the region in the upper-right corner and select a new region from the dropdown list.

:::image type="content" source="media/instance-unavailable-provision-omnichannel/oc-region-menu.png" alt-text="Screenshot that shows how to change region in the Power Platform admin center.":::

The portal will reload when you change the region. After it has finished reloading, go to **Applications** > **Omnichannel for Customer Service**, and then follow the provisioning steps.

The provisioning application you're directed to is associated with the region you chose, and all instances located in that region are displayed as options for provisioning.

:::image type="content" source="media/instance-unavailable-provision-omnichannel/oc-region-provision.png" alt-text="Screenshot that shows the Manage Omnichannel environments page.":::
