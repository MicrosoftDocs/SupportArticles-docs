---
title: Changes to SLAItem through an upgrade solution don't appear even after a successful upgrade
description: Provides a solution for when changes to an SLAItem through an upgrade solution don't appear even after a successful upgrade in Customer Service.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 04/11/2023
ms.subservice: d365-customer-service
---

# Changes to SLAItem through an upgrade solution don't appear even after a successful upgrade

This article provides a solution for an issue where changes to an SLAItem through an upgrade solution don't appear even after a successful upgrade.

## Symptom

Changes like Applicable when, Success, Pause conditions, or adding action flows through an upgrade solution don't appear in the SLA of the target organization. This is the expected behavior, and is applicable to both UCI and legacy SLAs.

## Cause

When an SLA is activated or an SLAItem is modified manually on the organization (for example, Applicable when conditions, Success, Warning, or Failure actions), the upgrade solution changes aren't reflected. This is because the active layer takes precedence over the upgrade solution.

## Resolution

We recommend that you make changes to a SLA or a SLAItem only through an upgrade solution. If the issue persists even after importing the patch solution, you can opt for the overwrite customization option while importing the full solution. Overwriting customization removes all the active layer customizations on the SLA, and therefore, all the changes in the upgrade solution are reflected. Overwrite customization might only be visible in Legacy Solution import.
