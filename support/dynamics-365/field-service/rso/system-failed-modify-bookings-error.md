---
title: Optimization request fails to modify some bookings
description: Resolves issues with optimization requests in the Resource Scheduling Optimization add-in for Dynamics 365 Field Service.
ms.author: feiqiu
author: feifeiqiu
ms.reviewer: mhart
ms.date: 10/19/2023
ms.custom: sap:Resource Scheduling Optimization
---
# An optimization request fails to modify some bookings

This article helps administrators troubleshoot optimization requests in the [Resource Scheduling Optimization add-in](/dynamics365/field-service/rso-overview) for Microsoft Dynamics 365 Field Service.

## Symptoms

An [optimization request](/dynamics365/field-service/rso-schedule-optimization#monitoring-optimization-requests) fails with the "System failed to modify some bookings" error message.

## Resolution

The optimization request can fail in the following scenarios:

- A user manually updates a booking during a Resource Scheduling Optimization run. Resource Scheduling Optimization won't overwrite the changes.
- A workflow or plug-in updates the same bookings during a Resource Scheduling Optimization run. Resource Scheduling Optimization won't overwrite the changes your other system logic did.
- Multiple Resource Scheduling Optimization schedules share the same resources and run at the same time. For analysis and troubleshooting, check the following options:

  - Review the optimization request booking grid and inspect the operation details column for each requirement and booking.
  - Check if multiple schedules that share the same resources, requirements, and bookings run at the same time. If that's the case, update the schedules to run sequentially or reconfigure them to avoid overlaps.
  - Check if any other user or workflow tries to update a booking during the optimization request run.
