---
title: SAS Key hasn't been configured error when publishing a schedule
description: Resolves an issue with misconfigured Azure resources in the Resource Scheduling Optimization add-in for Dynamics 365 Field Service.
ms.author: feiqiu
author: feifeiqiu
ms.reviewer: mhart
ms.date: 10/19/2023
---
# "SAS Key hasn't been configured" error in Resource Scheduling Optimization

This article helps administrators resolve an issue in the [Resource Scheduling Optimization add-in](/dynamics365/field-service/rso-overview) for Microsoft Dynamics 365 Field Service.

## Symptoms

The "SAS Key hasn't been configured" error message appears when users try to [publish a schedule](/dynamics365/field-service/rso-schedule-optimization#buttons-and-functions-for-optimization-schedules).

## Resolution

The message means the Resource Scheduling Optimization Azure resources aren't set up correctly.

Go to the [Resource Scheduling Optimization deployment app](/dynamics365/field-service/rso-deployment) to check the Resource Scheduling Optimization deployment status. Then, redeploy the add-in to fix the issue.
