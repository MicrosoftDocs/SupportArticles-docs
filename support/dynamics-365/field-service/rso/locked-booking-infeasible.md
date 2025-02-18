---
title: Locked Booking Is Infeasible in Resource Scheduling Optimization
description: Resolves issues with booking locks in the Resource Scheduling Optimization add-in for Microsoft Dynamics 365 Field Service.
ms.author: AnilMur
author: anilmur
ms.reviewer: mhart
ms.date: 02/18/2025
ms.custom: sap:Resource Scheduling Optimization
---
# Locked booking is infeasible in Resource Scheduling Optimization

This article helps you resolve the "Locked booking is infeasible" error that occurs in the [Resource Scheduling Optimization add-in](/dynamics365/field-service/rso-overview) for Microsoft Dynamics 365 Field Service.

## Symptoms

When a [locked booking](/dynamics365/field-service/booking-lock-options) can't respect all defined constraints, the Resource Scheduling Optimization request continues but skips the identified resources that have violations. You might encounter the following error message:

> System failed to optimize some records. Inner error(s): Locked booking is infeasible, reason: Violation. Tracing data points: RequirementId, RequirementName, BookingId, BookingName, ScheduledTimeWindow, FullTimeWindow, ArrivalTime, Lock Type

## Cause

The tracing data points in the error message can help you identify what went wrong. The violation types include:

- Time window violations:

  - The locked booking is outside of the resource's working hours.
  - The promised time window is invalid.
  - The travel time is invalid.
  - The locked booking conflicts with a [scheduled break time](/dynamics365/field-service/set-up-bookable-resources#add-work-hours).

- Eligibility check failures:

  - **Meets Required Skills**. A locked booking has an invalid match to the [resource skill characteristics](/dynamics365/field-service/set-up-characteristics).
  - **Meets Required Roles**. A locked booking has an invalid match to the [resource role](/training/modules/configure-bookable-resources-urs-dynamics-field-service/).
  - **Meets Resource Preferences**. A locked booking has an invalid ["must choose from" or "restricted" resource](/dynamics365/field-service/resource-preferences).

  For more information, see [Resource Scheduling Optimization constraints](/dynamics365/field-service/rso-optimization-goal#understand-constraints).

## Resolution

To solve the issue, update the booking settings, and then rerun Resource Scheduling Optimization:

1. Adjust the settings to resolve the identified violation. For example, update the [booking lock options](/dynamics365/field-service/booking-lock-options#booking-lock-options) or adjust the [Resource Scheduling Optimization constraints](/dynamics365/field-service/rso-optimization-goal#understand-constraints).
1. Save the changes and [run the Resource Scheduling Optimization process](/dynamics365/field-service/rso-run-optimization) again.
