---
title: Changes to an SLA item record through an upgrade solution aren't shown in Dynamics 365 Customer Service
description: Provides a resolution for the issue where the changes to an SLA item record through an upgrade solution don't appear even after a successful upgrade in Microsoft Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 08/18/2023
---
# The changes to an SLA item record through an upgrade solution don't appear even after a successful upgrade

This article provides a resolution for the issue where the changes to a service-level agreement (SLA) or an SLA item record through an upgrade solution aren't shown even if the upgrade is successful in Dynamics 365 Customer Service.

## Symptoms

Changes to **Applicable When**, **Success Conditions**, or **Pause Conditions**, or adding action flows through an upgrade solution don't appear in the SLA of the target organization. This is the expected behavior and is applicable to both Unified Interface and legacy SLAs.

## Cause

When an SLA is activated, or an SLA item record is modified manually on the organization (for example, the **Applicable When** conditions, the **Success**, **Warning**, or **Failure** actions), the upgrade solution changes aren't reflected. This is because the active layer takes precedence over the upgrade solution.

## Resolution

We recommend that you make changes to an SLA or an SLA item record only through an [upgrade solution](/dynamics365/customer-service/export-import-solution?tabs=customerserviceadmincenter#recommended-procedure-for-upgrading-a-solution). If the issue persists even after importing the patch solution, you can select the **Overwrite customizations (not recommended)** option while importing the full solution. Overwriting customization removes all the active layer customizations on the SLA. Therefore, all the changes in the upgrade solution are reflected. Overwrite customization might only be visible in a "Legacy Solution" import.

1. [Create updates using clone solution and clone to patch](/power-platform/alm/update-solutions-alm#creating-updates-using-clone-solution-and-clone-to-patch). Use the "Clone to solution" steps to create a separate solution and export it as a managed solution.

2. When you import the solution, select the **Upgrade (recommended)** and **Overwrite customizations (not recommended)** options in the pop-up window, as shown in the following screenshot.

   :::image type="content" source="media/slaitem-changes-missing-upgrade/sla-item-solution-import.png" alt-text="Import options in SLA solution import.":::
