---
title: Changes to an SLA Item record through an upgrade solution aren't shown
description: Provides a resolution for the issue where the changes to an SLA Item record through an upgrade solution don't appear even after a successful upgrade in Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 05/23/2023
---
# The changes to an SLA Item record through an upgrade solution don't appear even after a successful upgrade

This article provides a resolution for the issue where the changes to a service-level agreement (SLA) or an SLA Item record through an upgrade solution aren't shown even if the upgrade is successful in Dynamics 365 Customer Service.

## Symptoms

Changes like **Applicable when**, **Success**, **Pause** conditions, or adding action flows through an upgrade solution don't appear in the SLA of the target organization. This is the expected behavior and is applicable to both Unified Interface and legacy SLAs.

## Cause

When an SLA is activated, or an SLA Item record is modified manually on the organization (for example, the **Applicable when** conditions, the **Success**, **Warning**, or **Failure** actions), the upgrade solution changes aren't reflected. This is because the active layer takes precedence over the upgrade solution.

## Resolution

We recommend that you make changes to an SLA or an SLA Item record only through an upgrade solution. If the issue persists even after importing the patch solution, you can select the overwrite customization option while importing the full solution. Overwriting customization removes all the active layer customizations on the SLA. Therefore, all the changes in the upgrade solution are reflected. Overwrite customization might only be visible in a "Legacy Solution" import.
