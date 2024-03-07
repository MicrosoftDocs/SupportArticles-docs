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

This happens when there are multiple layers for a single SLA, It can be the SLA upgrades are happening with 2-3 solution or the SLAs are upgraded using unmanaged and managed solutions.

## Resolution

It is recommended to have a single managed solution for SLAs when they upgrade their environments. A single SLA should not be upgraded using both unmanaged and managed solution.
