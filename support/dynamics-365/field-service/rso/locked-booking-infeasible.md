---
title: Locked booking is infeasible in Resource Scheduling Optimization
description: Resolves issues with booking locks in the Resource Scheduling Optimization add-in for Microsoft Dynamics 365 Field Service.
ms.author: AnilMur
author: anilmur
ms.reviewer: mhart
ms.date: 02/04/2025
ms.custom: sap:Resource Scheduling Optimization
---
# Locked booking is infeasible in Resource Scheduling Optimization

This article helps troubleshoot issues with booking locks in the [Resource Scheduling Optimization add-in](/dynamics365/field-service/rso-overview) for Microsoft Dynamics 365 Field Service.

## Symptoms

If a locked booking can't respect all defined constraints, the optimization request continues, but skips over the identified resources that have violations. The following error occurs:

**System failed to optimize some records. Inner error(s): Locked booking is infeasible, reason: `Violation`. Tracing data points: `RequirementId`, `RequirementName`, `BookingId`, `BookingName`, `ScheduledTimeWindow`, `FullTimeWindow`, `ArrivalTime`, `Lock Type`**

## Cause

The tracing data points in the message help you identify what went wrong. The violation types include:

- The locked booking can't fulfill the time window filter.

  - **LockBookingTimeWindowFilter**. Potential scenarios:
    - Locked booking is outside of resource working hours
    - Invalid promised time window
    - Invalid travel time

  - **ResourceBreakTimeWindowFilter**. A locked booking conflicts with a [scheduled break time](/dynamics365/field-service/set-up-bookable-resources#add-work-hours).

- The eligibility check failed with constraint.

  - **MeetsRequiredSkills**. A locked booking has an invalid match of the [resource skill characteristics](/dynamics365/field-service/set-up-characteristics).

  - **MeetsRequiredRoles**. A locked booking has an invalid [resource role match](/training/modules/configure-bookable-resources-urs-dynamics-field-service/).

  - **MeetsResourcePreferences**. A locked booking has an invalid ['must choose from' or 'restricted' resource](/dynamics365/field-service/resource-preferences).

## Resolution

Update the booking settings to address the violation reason and then run Resource Scheduling Optimization again.