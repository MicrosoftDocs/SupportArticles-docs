---
title: SLA First Response By and Resolve By fields aren't filled in Unified Interface
description: Provides a resolution for the issue where the First Response By and Resolve By fields aren't populating values in the Unified Interface SLA.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 06/09/2023
---
# The SLA "First Response By" and "Resolve By" fields aren't populating values in Unified Interface

This article provides a resolution for the issue where the **First Response By** and **Resolve By** fields in a service-level agreement (SLA) aren't getting populated in Unified Interface.

## Symptoms

In the legacy SLA, the **First Response By** and **Resolve By** fields are populated when the SLA for a specific KPI is triggered, but these fields' values aren't populated in Unified Interface by default.

## Cause

As part of the legacy standard SLA, the SLA **First Response By** and **Resolve By** fields are filled by default, and these legacy standard SLAs are already deprecated. As part of the Unified Interface SLA, these fields aren't filled by default as they can have multiple SLA KPIs per a KPI field, and the legacy enhanced SLA also doesn't have these fields filled by default.

## Resolution

This is a by-design behavior in Unified Interface. So, implement a custom logic through a workflow or a plugin to fill these fields per user requirements.