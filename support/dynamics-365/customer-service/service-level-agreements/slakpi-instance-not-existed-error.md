---
title: Failed to apply active SLA to case due to SLA item's `ChangedAttributeList` is null
description: Provides a resolution for the issue where it's failed to apply active SLA to case if SLA item's `ChangedAttributeList` is null.
ms.reviewer: sdas
ms.author: ravimanne
ms.date: 06/07/2023
---
# Failed to apply active SLA to case if SLA item's `ChangedAttributeList` is null

This article provides a resolution for the issue where it's failed to apply active SLA to case if SLA item's `ChangedAttributeList` is null.

## Symptoms

You can't see active SLA applied to case even it has SLA item applicable condtion.

## Cause

This issue occurs when an active SLA exists but the SLA item's `ChangedAttributeList` isn't defined or null.

## Resolution

To solve this issue, 

1. Find the active SLA which meets applicable condtion.
2. Open the respective SLA and check the SLA items. 
3. If the SLA has SLA items, administrators can reactivate the SLA by resetting any SLA item's applicable when\success condition, which should calculate the `ChangedAttributeList` again.
4. If the SLA doesn't have any SLA item, administrators can define SLA items and reactivate the SLA again.
