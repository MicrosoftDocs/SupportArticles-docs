---
title: Troubleshoot bookings from Resource Scheduling Optimization
description: Resolves issues with bookings in the Resource Scheduling Optimization add-in for Microsoft Dynamics 365 Field Service.
ms.author: AnilMur
author: anilmur
ms.reviewer: mhart
ms.date: 04/22/2025
ms.custom: sap:Resource Scheduling Optimization
---
# Troubleshoot issues with bookings in Resource Scheduling Optimization

This article helps troubleshoot issues with bookings created by the [Resource Scheduling Optimization add-in](/dynamics365/field-service/rso-overview) for Microsoft Dynamics 365 Field Service.

## Symptoms

- Completed, canceled, or other bookings are optimized or removed, although they shouldn't be moved.
- Past or future bookings that are outside the optimization start and end range are removed.
- Bookings show in a simulation status.

## Resolution

### Avoid deletion of bookings

After an optimization runs, Resource Scheduling Optimization can make decisions to create, update, or delete bookings as needed based on objective and constraint settings. Hence, it's expected to find bookings deleted to optimize results throughout the schedule. If you don't want Resource Scheduling Optimization to delete existing bookings, try the following options:

- [Configure the scheduling method for the booking status](/dynamics365/field-service/rso-configuration#make-data-changes-to-prepare-for-optimizations).
- [Exclude bookings from the optimization scope](/dynamics365/field-service/rso-optimization-scope).
- [Configure a booking lock](/dynamics365/field-service/booking-lock-options).

### Scheduling method mapping to booking status

Booking status has a **Scheduling Method** field that dictates how Resource Scheduling Optimization should consider booking records of that status:

- If the booking status is set to **Optimize**, Resource Scheduling Optimization moves those bookings around.
- If the booking status is set to **Don't Move**, Resource Scheduling Optimization doesn't move or optimize those bookings. Use this option for booking statuses that indicate work is in progress or completed.
- If the booking status is set to **Ignore**, Resource Scheduling Optimization doesn't consider that booking record. Use this option for booking statuses that indicate work got canceled.

### Block Resource Scheduling Optimization from moving past bookings

The [optimization range](/dynamics365/field-service/rso-optimization-scope#create-an-optimization-scop) is the time range during which bookings can be created, updated, or deleted. It defines the "output" side, but not the "input" side. The optimization range doesn't determine what bookings are included.

To block changes to past bookings, consider the following options:

- Set the booking status to **Don't Move**.
- Remove the booking from the booking view. To ensure that optimization runs, consider only future bookings that occur after a specific point. In the **Booking View** of optimization scope, you can select a value in the **On or After** field.
- Lock the booking to a time or time range in the past.
- [Set a promised date from/to](/dynamics365/field-service/schedule-time-constraints#schedule-a-requirement-in-a-time-frame) while enabling the time window constraint.

### Bookings in simulation status

If an exception or error occurs during an optimization schedule run, you might see some overlap on the [Schedule Board](/dynamics365/field-service/schedule-board-tab-settings#board-view-settings). Some bookings are created or updated from the latest run, while other bookings from the previous run failed to be deleted due to an issue. To avoid this issue, the optimization process uses transactional bookings in the *Simulation* status.

During the optimization process, the create, update, and delete operations are visible. If a booking needs to be updated, the system tries to make that change. If the update fails because the booking has changed after the optimization run starts, Resource Scheduling Optimization creates a simulated booking instead.

If an exception occurs and the optimization request fails, simulation bookings remain in simulation status for troubleshooting purposes unless you manually delete them. Otherwise, a system job deletes them automatically every two weeks.

You can hide simulation bookings by changing the [schedule board settings](/dynamics365/field-service/schedule-board-tab-settings#board-view-settings). Select the gear icon on the top right to open the **Scheduler settings**, and then disable the **Show canceled** option.
