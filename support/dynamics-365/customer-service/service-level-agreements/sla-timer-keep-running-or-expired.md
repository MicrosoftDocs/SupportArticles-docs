---
title: SLA Timer keeps running or expires before the Timer failure time
description: Provides a resolution for an issue where the SLA Timer keeps running or expires prior to the failure time on Timer.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 07/18/2023
ms.custom: sap:Service Level Agreements\SLA timer is running even if the case is resolved
---
# Updating failure and warning times for SLA KPI instances in workflows isn't supported 

This article provides a resolution for an issue where the service-level agreements (SLA) Timer keeps running or expires prior to the failure time on Timer.

## Symptoms

The SLA Timer keeps running or expires prior to the failure time on Timer.

## Cause

Updating the failure and warning times for SLA KPI instances in workflows isn't supported.

A static flow (`SLAInstanceMonitoringWarningAndExpiryFlow`) is triggered only when an SLA KPI instance is created. When the failure and warning times are updated for existing SLA KPI instances, the static flow can't run as expected, which can cause unexpected behaviors.

## Resolution

To resolve this issue, you can use a custom workflow and plugin to cancel the existing KPI and trigger a new KPI instead of updating the failure and warning times.

> [!NOTE]
> After creation of SLA KPI Instance failure time is extended/updated by a workflow then it will be consider as expired as the process is set to wait only the earlier date.