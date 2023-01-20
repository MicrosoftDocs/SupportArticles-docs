---
title: Troubleshoot sync issues with social data in Omnichannel for Customer Service
description: Provides a resolution for the social profile entity being blocked and data not syncing in Omnichannel for Customer Service.
author: lalexms
ms.author: laalexan
ms.topic: troubleshooting
ms.date: 01/19/2023
---

# Troubleshoot sync issues with social data in Omnichannel for Customer Service

This article helps you troubleshoot and resolve an issue with social data not syncing and prevents record identification for return users in the Omnichannel for Customer Service environment.

### Symptom

The data flush for the **Social Profile** entity is blocked. Customer information, including social profiles and contact details, aren't syncing properly in the environment. Data for returning customers isn't available.

### Cause

The setting for preventing social data in Dynamics 365 is turned on.

### Resolution
Ensure that the toggle for preventing social data in Dynamics is turned off. More information: [Manage feature settings](/power-platform/admin/settings-features)

1. Open Power Platform admin center, and then navigate to **Environments** > [select an environment] > **Settings** > **Product** > **Features**.

1. Ensure that in the Power BI **Embedded chat** settings, the toggle for the **Prevent social data in Dynamics** setting is set to **Off**.

    > [!div class="mx-imgBorder"]
    > ![Prevent social data in Dynamics setting in Power Platform admin center.](media/social-data-setting.png "Prevent social data in Dynamics")
 
