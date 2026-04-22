---
title: Troubleshoot bookings from Resource Scheduling Optimization
description: Resolves issues with bookings in the Resource Scheduling Optimization add-in for Microsoft Dynamics 365 Field Service.
ms.reviewer: anclear, v-wendysmith, v-shaywood
ms.date: 04/14/2026
ms.custom: sap:Resource Scheduling Optimization
---
# Troubleshoot issues with bookings in Resource Scheduling Optimization

## Summary

This article helps you troubleshoot issues with bookings created by the [Resource Scheduling Optimization add-in](/dynamics365/field-service/rso-overview) for Microsoft Dynamics 365 Field Service.

## Symptoms

- The system optimizes or removes completed, canceled, or other bookings, although it shouldn't move them.
- The system removes past or future bookings that are outside the optimization start and end range.
- Bookings show in a simulation status.

## Solutions

### Avoid deletion of bookings

After an optimization runs, Resource Scheduling Optimization can create, update, or delete bookings based on [objective and constraint settings](/dynamics365/field-service/rso-optimization-goal). The system might delete bookings to optimize the overall schedule. If you don't want Resource Scheduling Optimization to delete existing bookings, try the following options:

- [Configure the scheduling method for the booking status](/dynamics365/field-service/rso-configuration#prepare-resources-and-requirements-for-optimizations).
- [Exclude bookings from the optimization scope](/dynamics365/field-service/rso-optimization-scope).
- [Configure a booking lock](/dynamics365/field-service/booking-lock-options).

### Scheduling method mapping to booking status

Booking status has a **Scheduling Method** field that determines how Resource Scheduling Optimization handles bookings with that status:

- If you set the booking status to **Optimize**, Resource Scheduling Optimization moves those bookings.
- If you set the booking status to **Don't Move**, Resource Scheduling Optimization doesn't move or optimize those bookings. Use this option for booking statuses that indicate work is in progress or completed.
- If you set the booking status to **Ignore**, Resource Scheduling Optimization doesn't consider that booking record. Use this option for booking statuses that indicate work was canceled.

### Block Resource Scheduling Optimization from moving past bookings

The [optimization range](/dynamics365/field-service/rso-optimization-scope#create-an-optimization-scope) is the time range during which you can create, update, or delete bookings. It defines the "output" side, but not the "input" side. The optimization range doesn't determine which bookings are included.

To block changes to past bookings, consider the following options:

- Set the booking status to **Don't Move**.
- Remove the booking from the booking view. To limit optimization to future bookings, in the **Booking View** of the optimization scope, select a value in the **On or After** field.
- Lock the booking to a time or time range in the past.
- [Set a promised date from/to](/dynamics365/field-service/schedule-time-constraints#schedule-a-requirement-in-a-time-frame) while enabling the time window constraint.

### Bookings in simulation status

If an error occurs during an optimization run, you might see overlapping bookings on the [Schedule Board](/dynamics365/field-service/schedule-board-tab-settings#board-view-settings). Some bookings are created or updated from the latest run, while bookings from a previous run weren't deleted because of the error. To prevent this issue, the optimization process uses transactional bookings in the *Simulation* status.

During optimization, you can see the create, update, and delete operations. If a booking needs to be updated, the system tries to update it. If the update fails because the booking changed after the optimization run started, Resource Scheduling Optimization creates a simulated booking instead.

If an error occurs and the optimization request fails, simulation bookings remain in simulation status for troubleshooting unless you delete them manually. If you don't, a system job automatically deletes them every two weeks.

You can hide simulation bookings by changing the [schedule board settings](/dynamics365/field-service/schedule-board-tab-settings#board-view-settings). Select the gear icon on the top right to open the **Scheduler settings**, and then disable the **Show canceled** option.

## Related content

- [Create optimization schedules in Resource Scheduling Optimization](/dynamics365/field-service/rso-optimization-schedule)
- [Requirements not scheduled in Resource Scheduling Optimization](/troubleshoot/dynamics-365/field-service/rso/requirement-not-scheduled-in-rso)
