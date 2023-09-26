---
title: Can't apply active SLA to case because SLA item's ChangedAttributeList is null
description: Provides a resolution for an issue where you can't apply an active SLA to a case if the SLA item's ChangedAttributeList is null.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 06/25/2023
---
# Fails to apply an active SLA to a case if the SLA item's ChangedAttributeList is null

This article provides a resolution for an issue where you can't apply an active SLA to a case if the SLA item's `ChangedAttributeList` is null.

## Symptoms

You can't see an active SLA applied to a case even if it has an SLA item applicable condition.

## Cause

This issue occurs when an active SLA exists but the SLA item's `ChangedAttributeList` isn't defined or null.

## Resolution

To solve this issue, 

1. Find the active SLA that meets the applicable condition.
2. Open the respective SLA and check the SLA items. 
3. If the SLA has SLA items, administrators can reactivate the SLA by resetting any SLA item's **Applicable when** or **Success** conditions, which should recalculate the `ChangedAttributeList`.
4. If the SLA doesn't have any SLA item, administrators can define SLA items and reactivate the SLA again.
