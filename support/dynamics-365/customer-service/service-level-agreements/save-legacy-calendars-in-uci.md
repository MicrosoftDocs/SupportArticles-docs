---
title: "Calendar dates are corrupted" error while migrating legacy calendar to Unified Interface
description: Provides a resolution for the "Calendar dates are corrupted" error message that occurs when you migrate a legacy calendar to Unified Interface.
ms.reviewer: sdas, ankugupta, mpanduranga
ms.author: v-psuraty
author: v-psuraty
ms.date: 01/23/2024
---
# "Calendar dates are corrupted" error while migrating legacy calendar to Unified Interface

This article provides a resolution for the "Calendar dates are corrupted" error message that occurs when you migrate a legacy calendar to Unified Interface.

## Symptoms

The following error message appears:

"Error Code:0x10000003 Calendar 649bf685-aa40-e911-a95c-000d3ab3f13b dates are corrputed. Try to create a new Calendar."

## Cause

This issue occurs because the legacy calendar isn't configured to Unified Interface after migration.

## Resolution

Create a new calendar and replace it with the existing one in the SLA Item. Or, open the legacy calendar in Unified interface and save it.

