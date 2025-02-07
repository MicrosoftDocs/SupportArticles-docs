---
title: Locked Booking is Infeasible in Resource Scheduling Optimization
description: Resolves issues with booking locks in the Resource Scheduling Optimization add-in for Microsoft Dynamics 365 Field Service.
ms.author: AnilMur
author: anilmur
ms.reviewer: mhart
ms.date: 02/07/2025
ms.custom: sap:Resource Scheduling Optimization
---
# Locked booking is infeasible in Resource Scheduling Optimization

This article presents possible causes and a resolution for the "Locked booking is infeasible" error that occurs in the [Resource Scheduling Optimization add-in](/dynamics365/field-service/rso-overview) for Microsoft Dynamics 365 Field Service.

## Symptoms

If a locked booking can't respect all defined constraints, the optimization request continues, but skips over the identified resources that have violations. The following error message occurs:

> System failed to optimize some records. Inner error(s): Locked booking is infeasible, reason: Violation. Tracing data points: RequirementId, RequirementName, BookingId, BookingName, ScheduledTimeWindow, FullTimeWindow, ArrivalTime, Lock Type

## Cause

The tracing data points in the error message help you identify what went wrong. The violation types include:

- A locked booking can't fulfill the _Lock Booking Time Window_ or _Resource Break Time Window_ filter. The scenarios inlcude:

  - The locked booking is outside of resource working hours.
  - Invalid promised time window.
  - Invalid travel time.
  - Conflicts with a [scheduled break time](/dynamics365/field-service/set-up-bookable-resources#add-work-hours).

- The eligibility check fails with a [constraint](/dynamics365/field-service/rso-optimization-goal#understand-constraints):

  - **Meets Required Skills**. A locked booking has an invalid match of the [resource skill characteristics](/dynamics365/field-service/set-up-characteristics).
  - **Meets Required Roles**. A locked booking has an invalid [resource role match](/training/modules/configure-bookable-resources-urs-dynamics-field-service/).
  - **Meets Resource Preferences**. A locked booking has an invalid ['must choose from' or 'restricted' resource](/dynamics365/field-service/resource-preferences).

## Resolution

To solve the issue, update the booking settings and then rerun the Resource Scheduling Optimization:

1. Navigate to **Resource Scheduling** > **Settings** > **Administration** > **Scheduling Parameter** > **Resource Scheduling Optimization**.
1. Adjust the settings to resolve the identified violation. For example, update the time window, adjust resource skills, and so on.
1. Save the changes and [run the optimization process](/dynamics365/field-service/rso-run-optimization) again.
