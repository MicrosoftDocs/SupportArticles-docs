---
title: Sync issue with social data
description: Provides a resolution for the issue where the Social Profile entity is blocked, and the social data isn't syncing in Omnichannel for Customer Service.
ms.reviewer: nenellim
ms.author: yangao
ms.date: 05/23/2023
---
# Sync issue with social data in Omnichannel for Customer Service

This article provides a resolution for the issue where social data isn't syncing and prevents record identification for return users in the Omnichannel for Customer Service environment.

## Symptoms

The data flush for the **Social Profile** entity is blocked. Customer information, including social profiles and contact details, isn't syncing properly in the environment. Data for returning customers isn't available.

## Cause

The setting for preventing social data in Dynamics 365 is turned on.

## Resolution

To solve this issue, ensure the toggle for preventing social data in Dynamics 365 is turned off. For more information, see [Manage feature settings](/power-platform/admin/settings-features).

1. Open the Power Platform admin center, navigate to **Environments**, select an environment, and then select **Settings** > **Product** > **Features**.
1. Ensure the toggle for the **Prevent social data in Dynamics** setting is set to **Off** in the Power BI **Embedded chat** settings.

   :::image type="content" source="media/social-data-sync/social-data-setting.png" alt-text="Screenshot shows how to prevent social data in the Dynamics setting in the Power Platform admin center.":::
