---
title: SLAItem delete operation encountered some errors during solution upgrade
description: Resolves an error that occurs when a solution upgrade fails in Microsoft Dynamics Customer Service. 
ms.reviewer: sdas, ankugupta, v-psuraty
ms.author: mpanduranga
ms.date: 03/07/2024
---
# "SLAItem delete operation encountered some errors" occurs during solution upgrade 

This article provides a resolution for the "SLAItem delete operation encountered some errors, The uninstall operation will delete the base layer for the component" error that occurs when you upgrade a solution in Microsoft Dynamics Customer Service.

## Symptoms

A [solution upgrade](/dynamics365/customer-service/administer/manage-solution#upgrade) fails with the following error:

> SLAItem delete operation encountered some errors, The uninstall operation will delete the base layer for the component '\<component>' with id '\<componentID>', The operation cannot continue because there are other managed layers over the base layer.

## Cause

- This issue occurs when a single service-level agreement (SLA) has multiple layers.

  For example, SLA 1 is introduced using solution 1 and later it's upgraded using solution 2 or solution 3.
- Multiple managed and unmanaged solutions for a single SLA also can cause this issue.

## Resolution

It's recommended to have a single managed solution for SLAs when upgrading their environments. A single SLA shouldn't be upgraded using both unmanaged and managed solutions.
