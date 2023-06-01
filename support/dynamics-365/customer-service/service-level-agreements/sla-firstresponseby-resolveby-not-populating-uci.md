---
title: SLA 'First Response By' and 'Resolve By' fields are not populating values in UCI.
description: Provides a resolution for the issue where SLA First response by, Resolve by fields are not populating in UCI SLA.
ms.reviewer: sdas
ms.author: ravimanne
ms.date: 06/01/2023
---
# 'First Response By' and 'Resolve By' fields are not populating values in UCI

This article provides a resolution for the issue where SLA First response by, Resolve by fields are not populating in UCI SLA.

## Symptoms

In Legacy,  SLA First response by, Resolve by Fields are populated when SLA for specific KPI is triggered, but these field's values are not populating in UCI by default.

## Cause

As part of Standard Legacy SLA, SLA First response by and Resolve by fields were filled by default and these Standard Legacy SLAs are already deprecated. As part of UCI-SLA, we are not filling these fields by default as they can have multiple SLA KPIs per KPI field and enhanced Legacy SLA also does not have these field filled by default.

## Resolution

This is by design behavior for UCI-SLA. So, please implement custom logic through workflow or plugin to fill these fields as per user requirement.