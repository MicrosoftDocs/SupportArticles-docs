---
title: Locked Booking is Infeasible in Resource Scheduling Optimization
description: Resolves issues with booking locks in the Resource Scheduling Optimization add-in for Microsoft Dynamics 365 Field Service.
ms.author: AnilMur
author: anilmur
ms.reviewer: mhart
ms.date: 02/11/2025
ms.custom: sap:Resource Scheduling Optimization
---
# Locked booking is infeasible in Resource Scheduling Optimization

This article helps you resolve the "Locked booking is infeasible" error that occurs in the [Resource Scheduling Optimization add-in](/dynamics365/field-service/rso-overview) for Microsoft Dynamics 365 Field Service.

## Symptoms

When a [locked booking](/dynamics365/field-service/booking-lock-options) can't respect all defined constraints, the Resource Scheduling Optimization request continues, but skips over the identified resources that have violations. You may encounter the following error message:

> System failed to optimize some records. Inner error(s): Locked booking is infeasible, reason: Violation. Tracing data points: RequirementId, RequirementName, BookingId, BookingName, ScheduledTimeWindow, FullTimeWindow, ArrivalTime, Lock Type

## Cause

The tracing data points in the error message help you identify what went wrong. The violation types include:

- Time window violations:

  - The locked booking is outside of resource working hours.
  - Promised time window is invalid.
  - Travel time is invalid.
  - The locked booking conflicts with a [scheduled break time](/dynamics365/field-service/set-up-bookable-resources#add-work-hours).

- Eligibility check failures:

  - **Meets Required Skills**. A locked booking has an invalid match of the [resource skill characteristics](/dynamics365/field-service/set-up-characteristics).
  - **Meets Required Roles**. A locked booking has an invalid [resource role match](/training/modules/configure-bookable-resources-urs-dynamics-field-service/).
  - **Meets Resource Preferences**. A locked booking has an invalid ['must choose from' or 'restricted' resource](/dynamics365/field-service/resource-preferences).

  For more information, see [Resource Scheduling Optimization constraints](/dynamics365/field-service/rso-optimization-goal#understand-constraints).

## Resolution

To solve the issue, update the booking settings and then rerun the Resource Scheduling Optimization:

1. Adjust the settings to resolve the identified violation. For example, update the [booking lock options](/dynamics365/field-service/booking-lock-options#booking-lock-options), or adjust the [Resource Scheduling Optimization constraints]((/dynamics365/field-service/rso-optimization-goal#understand-constraints)).
1. Save the changes and [run the Resource Scheduling Optimization process](/dynamics365/field-service/rso-run-optimization) again.
