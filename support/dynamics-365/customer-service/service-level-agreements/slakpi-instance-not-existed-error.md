---
title: Case update fails due to no SLA KPI instance existing if it's associated with an active SLA
description: Provides a resolution for the issue where updating a case fails due to no SLA KPI instance existing.
ms.reviewer: sdas
ms.author: ravimanne
ms.date: 06/09/2023
---
# "SLA KPI instance does not exist" error when updating a case

This article provides a resolution for the issue where updating a case fails due to no service-level agreement (SLA) KPI instance existing.

## Symptoms

You can't update a case and receive the "SLA KPI instance does not exist" error.

## Cause

This issue occurs when an active SLA exists but the SLA item's `ChangeAttributeList` isn't defined or null.

## Resolution

To solve this issue, 

1. Find the SLA that's associated with a case.
2. Open the associated SLA and check the SLA items. 
3. If the SLA has SLA items, administrators can reactivate the SLA, which should calculate the `ChangeAttributeList` again.
4. If the SLA doesn't have any SLA item, administrators can define SLA items and reactivate the SLA again.
