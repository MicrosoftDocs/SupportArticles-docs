---
title: SAS Key hasn't been configured error when publishing a schedule
description: Resolves an issue with misconfigured Azure resources in the Resource Scheduling Optimization add-in for Dynamics 365 Field Service.
ms.reviewer: anclear, v-wendysmith
ms.date: 05/04/2026
ms.custom: sap:Resource Scheduling Optimization
---
# "SAS Key hasn't been configured" error in Resource Scheduling Optimization

## Summary

This article helps administrators resolve an issue in the [Resource Scheduling Optimization add-in](/dynamics365/field-service/rso-overview) for Microsoft Dynamics 365 Field Service.

## Symptoms

The "SAS Key hasn't been configured" error message appears when users try to [publish a schedule](/dynamics365/field-service/rso-schedule-optimization#buttons-and-functions-for-optimization-schedules).

## Solution

The message means the Resource Scheduling Optimization Azure resources aren't set up correctly.

Go to the [Resource Scheduling Optimization deployment app](/dynamics365/field-service/rso-deployment) to check the Resource Scheduling Optimization deployment status. Then, redeploy the add-in to fix the issue.
