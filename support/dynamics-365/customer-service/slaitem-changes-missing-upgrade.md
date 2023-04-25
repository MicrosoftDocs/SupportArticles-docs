---
title: Changes to an SLA Item record through an upgrade solution don't show
description: Provides a resolution for the issue where the changes to an SLA Item record through an upgrade solution don't appear even after a successful upgrade in Customer Service.
ms.reviewer: laalexan
ms.date: 04/11/2023
---
# Changes to an SLA Item record through an upgrade solution don't appear even after a successful upgrade

This article provides a resolution for the issue where the changes to a service-level agreement (SLA) or an SLA Item record through an upgrade solution aren't shown even if the upgrade is successful in Customer Service.

## Symptoms

Changes like **Applicable when**, **Success**, **Pause** conditions, or adding action flows through an upgrade solution don't appear in the SLA of the target organization. This is the expected behavior, and is applicable to both Unified Interface and legacy SLAs.

## Cause

When an SLA is activated or an SLA Item record is modified manually on the organization (for example, **Applicable when** conditions, **Success**, **Warning**, or **Failure** actions), the upgrade solution changes aren't reflected. This is because the active layer takes precedence over the upgrade solution.

## Resolution

We recommend that you make changes to an SLA or an SLA Item record only through an upgrade solution. If the issue persists even after importing the patch solution, you can opt for the overwrite customization option while importing the full solution. Overwriting customization removes all the active layer customizations on the SLA, and therefore, all the changes in the upgrade solution are reflected. Overwrite customization might only be visible in a "Legacy Solution" import.
