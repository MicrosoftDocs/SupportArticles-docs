---
title: Troubleshoot booking locks from Resource Scheduling Optimization
description: Resolves issues with bookings in the Resource Scheduling Optimization add-in for Microsoft Dynamics 365 Field Service.
ms.author: AnilMur
author: anilmur
ms.reviewer: mhart
ms.date: 12/19/2024
ms.custom: sap:Resource Scheduling Optimization
---
# Troubleshoot issues with booking locks in Resource Scheduling Optimization

This article helps troubleshoot issues with booking locks in the [Resource Scheduling Optimization add-in](/dynamics365/field-service/rso-overview) for Microsoft Dynamics 365 Field Service.

## Symptoms

A locked booking can't respect all defined constraints. The optimization request continues, but skips over the identified resources that have violations and displays the following error:

**System failed to optimize some records. Inner error(s): Locked booking is infeasible, reason: `Violation`. Tracing data points: `RequirementId`, `RequirementName`, `BookingId`, `BookingName`, `ScheduledTimeWindow`, `FullTimeWindow`, `ArrivalTime`, `Lock Type`**

## Resolution

The tracing data points help you identify what went wrong. Try updating the booking settings to address the violation reason before running Resource Scheduling Optimization again.

### Violation types

- The locked booking cannot fulfill the time window filter.

  - **LockBookingTimeWindowFilter**. Potential scenarios:
    - Locked booking is outside of resource working hours
    - Invalid promised time window
    - Invalid travel time

  - **ResourceBreakTimeWindowFilter**. A locked booking conflicts with a [scheduled break time](set-work-hours-resource.md).

- The eligibility check failed with constraint.

  - **MeetsRequiredSkills**. A locked booking has an invalid match of the [resource skill characteristics](set-up-characteristics.md).

  - **MeetsRequiredRoles**. A locked booking has an invalid [resource role match](/training/modules/configure-bookable-resources-urs-dynamics-field-service/).

  - **MeetsResourcePreferences**. A locked booking has an invalid [“must choose from” or “restricted” resource](resource-preferences.md).
