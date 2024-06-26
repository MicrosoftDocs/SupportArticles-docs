---
title: SLA Timer keeps running or expires before the Timer failure time
description: Provides a resolution for an issue where the SLA Timer keeps running or expires prior to the failure time on the Timer.
ms.reviewer: sdas, ankugupta
ms.author: sdas
ms.date: 06/26/2024
ms.custom: sap:Service Level Agreements\SLA timer is running even if the case is resolved
---
# Updating failure and warning times for SLA KPI instances in workflows isn't supported 

This article provides a resolution for an issue where the [service-level agreement (SLA) Timer](/dynamics365/customer-service/administer/add-timer-control-case-form-track-time-against-sla) keeps running or expires prior to the failure time on the Timer.

## Symptoms

The SLA Timer keeps running or expires prior to the failure time on the Timer.

## Cause

Updating the failure and warning times for SLA KPI instances in workflows isn't supported.

A static flow (`SLAInstanceMonitoringWarningAndExpiryFlow`) is triggered only when an SLA KPI instance is created. When the failure and warning times are updated for existing SLA KPI instances, the static flow can't run as expected, which can cause unexpected behaviors.

## Resolution

To resolve this issue, you can use a custom workflow and plugin to cancel the existing KPI and trigger a new KPI instead of updating the failure and warning times.

> [!NOTE]
> If the failure and warning times are updated by custom logic after an SLA KPI instance is created, these new times won't be considered.

## More information

[Understand SLA details with Timer control](/dynamics365/customer-service/use/customer-service-hub-user-guide-case-sla#understand-sla-details-with-timer-control)
