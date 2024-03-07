---
title: The uninstall operation will delete the base layer for the component (xxxx) with id (xxxx-xxxx-xxxxxx-xxxxxxxxx) error
description: Provides a resolution for the issue that occurs when you try to delete the SLAItem for an SLA with multiple solutions.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 03/07/2024
---
# "The uninstall operation will delete the base layer for the component (xxxx) with id (xxxx-xxxx-xxxxxx-xxxxxxxxx)" error

This article provides a resolution for the "The uninstall operation will delete the base layer for the component (xxxx) with id (xxxx-xxxx-xxxxxx-xxxxxxxxx)" error, that occurs when you try to delete the SLAItem for an SLA with multiple solutions.

## Symptoms

When you try to delete an SLA Item for an SLA that has both unmanaged and managed solutions, the operation isn't successful as there are other managed layers over the base layer.

## Cause

The issue occurs when there are multiple solutions for a single SLA. For example, if SLA1 was created with solution 1 but was upgraded using solution 2 or 3, you'll see an error. The issue also occurs when you have both multiple managed and unmanaged solutions for an SLA.

## Resolution

It is recommended to have a single managed solution for SLAs when you upgrade them. Additionally, you shouldn't upgrade an SLA using both unmanaged and managed solutions.
