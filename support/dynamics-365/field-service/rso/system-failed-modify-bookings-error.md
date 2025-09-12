---
title: Optimization request fails to modify some bookings
description: Resolves issues with optimization requests in the Resource Scheduling Optimization add-in for Dynamics 365 Field Service.
ms.author: AnilMur
author: anilmur
ms.reviewer: mhart
ms.date: 12/19/2024
ms.custom: sap:Resource Scheduling Optimization
---
# An optimization request fails to modify some bookings

This article helps administrators troubleshoot optimization requests in the [Resource Scheduling Optimization add-in](/dynamics365/field-service/rso-overview) for Microsoft Dynamics 365 Field Service.

## Symptoms

An [optimization request](/dynamics365/field-service/rso-schedule-optimization#monitoring-optimization-requests) fails with the "System failed to modify some bookings" error message.

## Cause

The optimization request can fail in the following scenarios:

- A user manually updates a booking during a Resource Scheduling Optimization run. Resource Scheduling Optimization won't overwrite the changes.
- A workflow or plug-in updates the same bookings during a Resource Scheduling Optimization run. Resource Scheduling Optimization won't overwrite the changes made by other system logic.
- Multiple Resource Scheduling Optimization schedules share the same resources and run at the same time. If schedules include overlapping resources, requirements, and bookings, a later schedule is cancelled with a status of blocked.

## Resolution

For analysis and troubleshooting, check the following options:

- Review the optimization request booking grid and inspect the **Operation Details** column for each requirement and booking.
- Check if multiple schedules that share the same resources, requirements, and bookings run at the same time. If that's the case, [update the schedules to run sequentially](/dynamics365/field-service/rso-requirement-dependency) or reconfigure them to avoid overlaps. For more information, see [Resolve booking conflicts in Resource Scheduling Optimization](/dynamics365/field-service/rso-handling-resolving-booking-conflicts).
- Check if any other user or workflow tries to update a booking during the optimization request run.
