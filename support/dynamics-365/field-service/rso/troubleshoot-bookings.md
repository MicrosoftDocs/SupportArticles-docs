---
title: Troubleshoot bookings from the Resource Scheduling Optimization add-in for Dynamics 365 Field Service
description: Resolve issues with bookings in the Resource Scheduling Optimization add-in for Dynamics 365 Field Service.
ms.author: feiqiu
author: feifeiqiu
ms.reviewer: mhart
ms.date: 06/15/2023
---

# Troubleshoot issues with bookings in the Resource Scheduling Optimization add-in for Dynamics 365 Field Service

This article helps troubleshoot issues bookings created by the Resource Scheduling Optimization add-in for Dynamics 365 Field Service.

## Symptoms

- Completed, canceled, or other bookings get optimized or removed although they shouldn’t be moved.
- Past or future bookings that are outside of the optimization start and end range get removed.
- Bookings show in a simulation status.

## Resolution

### Avoid deletion of bookings

After optimization runs, Resource Scheduling Optimization can make decisions to create, update, or delete bookings as needed based on objective and constraints settings. Hence, it's expected to find booking deleted to optimize results throughout the schedule. If you don't want Resource Scheduling Optimization to delete existing bookings, try the following options:

- [Configure the scheduling method for the booking status](/dynamics365/field-service/rso-configuration#make-data-changes-to-prepare-for-optimizations).
- [Exclude bookings from the optimization scope](/dynamics365/field-service/rso-optimization-scope).
- [Configure a booking lock](/dynamics365/field-service/booking-lock-options).

### Scheduling method mapping to booking status

Booking status has a **Scheduling Method** field that dictates how Resource Scheduling Optimization should consider booking records of that status:

- If Booking Status is set to **Optimize**, Resource Scheduling Optimization moves those bookings around.
- If Booking Status is set to **Don't Move**, Resource Scheduling Optimization doesn't move or optimize those bookings. Use this option for booking statuses that indicate work is in progress or completed.
- If Booking Status is set to **Ignore**, Resource Scheduling Optimization doesn't consider that booking record. Use this option booking statuses that indicate work got canceled.

### Block Resource Scheduling Optimization from moving past bookings

- Set the booking status to **Don't Move**.
- Remove the booking from the booking view.
- Lock the booking to a time or time range in the past.
- Set a promised date from/to while enabling the time window constraint.

### Bookings in simulation status

If an exception or error happens when an optimization schedule is still running, you might see some overlap on the schedule board. Some bookings are created or updated from the latest run while other bookings from the previous run failed to be deleted due to an issue. To avoid this issue, the optimization process uses transactional bookings in the *Simulation* status.

During the optimization process, the create, update, and deleted operations are visible. All new, updated, and to-be-deleted bookings are simulated. If the optimization run completes successfully, these simulated bookings become real bookings. During the optimization run, simulation status bookings are transparent and move around the schedule board. When the run completes, simulation bookings change into real bookings with solid color.

If an exception occurs and the optimization request fails, these simulation bookings remain in simulation status for troubleshooting purposes unless you manually delete them. Otherwise, a system job deletes them automatically every two weeks.

You can hide simulation bookings by changing the schedule board settings. Select the gear icon on the top right and select the **Hide Canceled** option.
