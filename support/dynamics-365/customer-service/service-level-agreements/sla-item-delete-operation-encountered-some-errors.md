---
title: SLAItem delete operation encountered some errors. The uninstall operation will delete the base layer for the component
description: Provides a resolution for the issue where the SLAItem delete operation encountered some errors. The uninstall operation will delete the base layer for the component.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 02/26/2024
---
# SLAItem delete operation encountered some errors. The uninstall operation will delete the base layer for the component

This article provides a resolution for the issue where the SLAItem delete operation encountered some errors. The uninstall operation will delete the base layer for the component.

## Symptoms

Solution upgrade is failing with below error
SLAItem delete operation encountered some errors. The uninstall operation will delete the base layer for the component ‘xxxx’ with id 'xxxx-xxxx-xxxxxx-xxxxxxxxx'. The operation cannot continue because there are other managed layers over the base layer.

## Cause

This happens when there are multiple layers for a single SLA. It can be the SLA upgrades are happening with 2-3 solution. Or the SLAs are upgraded using unmanaged and managed solutions.

## Resolution

It is recommended to have a single managed solution for SLAs when there moved from lower environment to higher environments. A single should not be upgraded using unmanaged and managed solution. A single solution layer is recommended for SLA upgrades.