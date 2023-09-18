---
title: OnHold Time isn't populated for a case for Unified Interface SLA
description: Provides a resolution for the issue where the OnHold Time attribute isn't populated for a case for the Unified Interface SLA in Dynamics 365 Customer Service.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 05/23/2023
---
# The OnHold Time attribute isn't populated for a case for the Unified Interface SLA

This article provides a resolution for the issue where the `OnHold Time` attribute isn't populated for a case for the Unified Interface SLA in Customer Service.

## Symptoms

The `onholdtime` attribute to track the `onHold` duration for a case at a case entity level doesn't get populated.

## Cause

In the legacy SLA, the `onholdtime` attribute tracks the on-hold duration for a case at the case entity level. In the Unified Interface SLA, `Elapsed time` tracks the on-hold duration at the KPI instance level since one case can have multiple KPIs with different pause conditions, and each SLA KPI instance might have a different calendar associated with it.

## Resolution

For the Unified Interface SLAs, use the `elapsedtime` attribute to track the `onHold` duration at the SLA KPI instance level.
