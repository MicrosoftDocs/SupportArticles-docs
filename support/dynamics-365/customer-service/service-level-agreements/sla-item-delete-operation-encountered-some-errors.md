---
title: SLAItem delete operation encountered some errors, The uninstall operation will delete the base layer for the component.
description: Provides a resolution for the issue where the SLAItem delete operation encountered some errors, The uninstall operation will delete the base layer for the component.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 03/07/2024
---
# SLAItem delete operation encountered some errors, The uninstall operation will delete the base layer for the component.

This article provides a resolution for the issue where the SLAItem delete operation encountered some errors, The uninstall operation will delete the base layer for the component.

## Symptoms

Solution upgrade is failing with the following error
SLAItem delete operation encountered some errors, The uninstall operation will delete the base layer for the component ‘xxxx’ with id 'xxxx-xxxx-xxxxxx-xxxxxxxxx', The operation cannot continue because there are other managed layers over the base layer.

## Cause

This happens when there are multiple layers for a single SLA. For example, if SLA1 is introduced using solution1 and later it is upgraded using solution2 or solution3 and so on might lead to this error. Also having multiple managed and unmanaged solutions for single SLA will also cause this issue.

## Resolution

It is recommended to have a single managed solution for SLAs when they upgrade their environments. A single SLA should not be upgraded using both unmanaged and managed solution.
