---
title: Troubleshoot Schedule Board Latency in Dynamics 365
description: Resolve slow loading and high latency issues on the Dynamics 365 Field Service schedule board with these troubleshooting steps for improved performance.
ms.date: 03/16/2026
ms.reviewer: mkelleher, puneetsingh, v-shaywood
ms.custom: sap:Schedule Board
---

# Schedule board is slow to load or experiences extreme latency

## Summary

This article helps dispatchers and administrators troubleshoot [schedule board](/dynamics365/field-service/work-with-schedule-board) performance problems in Microsoft [Dynamics 365 Field Service](/dynamics365/field-service/overview), such as slow loading, high latency when moving bookings, and unresponsive behavior. Common causes include displaying too many resources on a single board tab, using an excessive date range, synchronous plug-ins or real-time workflows registered on the `BookableResourceBooking` entity, and network latency or browser resource limits. The troubleshooting steps in this article cover reducing the resource count through [tab settings](/dynamics365/field-service/schedule-board-tab-settings) and territory filters, narrowing the date range, profiling and optimizing custom plug-ins in [Power Apps](https://make.powerapps.com), and addressing network and browser constraints.

## Symptoms

When you use the schedule board, you experience one or more of the following problems:

- The schedule board takes more than 30 seconds to load.
- Moving or creating bookings by using drag-and-drop takes several minutes per operation.
- The board becomes unresponsive when switching between days or weeks.
- Visual glitches appear alongside network request timeouts.

## Cause: Too many resources displayed

The schedule board tab is configured to display too many resources at once. Loading hundreds of resources with their bookings significantly increases rendering time and API call volume.

### Solution

1. In the Dynamics 365 Field Service app, select **Service** > **Scheduling** > **Schedule Board**.
1. On the active board tab, select the overflow menu (**⋮**) > **Board Settings** (gear icon) to open the [tab settings](/dynamics365/field-service/schedule-board-tab-settings).
1. Reduce the number of resources by applying filters, such as filtering by [territory](/dynamics365/field-service/set-up-territories), role, or organizational unit.
1. Set the resource count slider to display no more than 25–50 resources at a time.

> [!TIP]
> Create separate board tabs for different teams or territories to further reduce the resource count per tab.

## Cause: Excessive date range

The schedule board view shows too many days (for example, a full month view with many resources), which multiplies the data that's loaded.

### Solution

1. Open the schedule board and switch the view from **Weekly** or **Monthly** to **Daily** by using the view selector at the top of the board.
1. On the active board tab, select the overflow menu (**⋮**) > **Board Settings** (gear icon), and then set **Number of days** to a smaller value (1–5 days).
1. Use date navigation to move between periods instead of loading large ranges.

## Cause: Custom plug-ins or workflows on the booking entity

Synchronous plug-ins or real-time workflows registered on the `BookableResourceBooking` entity run during every booking operation, which adds latency to each interaction.

### Solution

1. Go to [Power Apps](https://make.powerapps.com) and select your environment.
1. Select **Tables** > **Bookable Resource Booking** > **Business rules** or **Plug-in steps**.
1. Find synchronous plug-ins or real-time workflows registered on **Create**, **Update**, or **Retrieve** operations.
1. Convert synchronous plug-ins to asynchronous where possible, or optimize their logic.
1. Use the [Plug-in Profiler](/power-apps/developer/data-platform/debug-plug-in#use-plug-in-profiler) to measure the execution time of each step.

> [!NOTE]
> To check whether custom logic is the problem, temporarily disable custom plug-ins in a test environment and compare schedule board performance.

## Cause: Network latency or browser resource limits

High-latency network connections or insufficient browser memory can slow schedule board rendering.

### Solution

- Test from a different network to rule out local network problems.
- Close unused browser tabs to free memory.
- Disable unnecessary browser extensions.
- Make sure you have at least a 10-Mbps connection speed for optimal schedule board performance.

## Related content

- [Schedule board shows a blank page or fails to load](schedule-board-not-loading.md)
- [Debug plug-ins](/power-apps/developer/data-platform/debug-plug-in)
