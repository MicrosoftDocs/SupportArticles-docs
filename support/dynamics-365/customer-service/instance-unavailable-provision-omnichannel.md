---
title: Instance unavailable to select on the provisioning application
description: Provides a solution for an issue where an instance is unavailable to select when provisioning Omnichannel for Customer Service..
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
---

# Instance unavailable to select on the provisioning application <a name="provision"></a>

### Symptom

Cannot see all the instances from the Organization selector.

### Cause

For security, reliability, and performance reasons, Omnichannel for Customer Service is separated by geographical locations known as "regions". The provisioning webpage only displays instances in the same region, so you might experience issues where you don’t see all the instances from the Organization selector if you have instances in more than one region and you provision Omnichannel for Customer Service without selecting the correct region.

### Resolution

Go to the Power Platform admin center (https://admin.powerplatform.microsoft.com/). Expand Resources, and select Dynamics 365. Select the region in the upper-right corner and select a new region from the dropdown list.

   > [!div class=mx-imgBorder]
   > ![Power Platform admin center change region.](media/oc-region-menu.png "Power Platform admin center change region")

The portal will reload when you change the region. After it has finished reloading, go to **Applications** > **Omnichannel for Customer Service**, and then do the provisioning steps.

The provisioning application you're directed to is associated with the region you chose, and all instances located in that region are displayed as options for provisioning.

   > [!div class=mx-imgBorder]
   > ![Manage Omnichannel environments.](media/oc-region-provision.png "Manage Omnichannel environments")
