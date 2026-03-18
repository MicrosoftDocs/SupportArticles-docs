---
title: Troubleshoot Schedule Board Latency in Dynamics 365
description: Resolve slow loading and high latency issues on the Dynamics 365 Field Service schedule board with these troubleshooting steps for improved performance.
ms.date: 03/16/2026
ms.reviewer: mkelleher, puneetsingh, v-shaywood
ms.custom: sap:Schedule Board\Issues with usability
---

# Schedule board is slow to load or experiences extreme latency

## Summary

This article helps dispatchers and administrators troubleshoot [schedule board](/dynamics365/field-service/work-with-schedule-board) performance problems in [Microsoft Dynamics 365 Field Service](/dynamics365/field-service/overview), such as slow loading, high latency when moving bookings, and unresponsive behavior. Common causes include:

- Displaying too many resources on a single board tab
- Using an excessive date range
- Synchronous plug-ins or real-time workflows that are registered on the `BookableResourceBooking` entity
- Network latency or browser resource limits

The troubleshooting steps in this article cover how to:

- Reduce the resource count through [tab settings](/dynamics365/field-service/schedule-board-tab-settings) and territory filters
- Narrow the date range
- Use profiling and optimizing custom plug-ins in [Power Apps](https://make.powerapps.com)
- Address network and browser constraints

## Symptoms

When you use the schedule board, you experience one or more of the following problems:

- The schedule board takes more than 30 seconds to load.
- It takes several minutes per operation to move or create bookings by using drag-and-drop actions.
- The board becomes unresponsive when you switch between days and weeks.
- Visual glitches appear alongside network request timeouts.

## Cause: Too many resources displayed

The schedule board tab is configured to display too many resources at one time. Rendering time and API call volume are significantly increased if you load hundreds of resources together with their bookings.

### Solution

1. In the Dynamics 365 Field Service app, select **Service** > **Scheduling** > **Schedule Board**.
1. On the active board tab, select the overflow menu (**⋮**) > **Board Settings** (gear icon) to open the [tab settings](/dynamics365/field-service/schedule-board-tab-settings).
1. Reduce the number of resources by applying filters, such as filtering by [territory](/dynamics365/field-service/set-up-territories), role, or organizational unit.
1. Set the resource count slider to display no more than 25–50 resources at one time.

> [!TIP]
> Create separate board tabs for different teams or territories to further reduce the resource count per tab.

## Cause: Excessive date range

The schedule board view shows too many days (for example, a full month view that has many resources). This behavior multiplies the data that's loaded.

### Solution

1. Open the schedule board, and use the view selector at the top of the board to switch the view from **Weekly** or **Monthly** to **Daily**.
1. On the active board tab, select the overflow menu (**⋮**) > **Board Settings** (gear icon), and then set **Number of days** to a smaller value (1–5 days).
1. Use date navigation to move between periods instead of loading large ranges.

## Cause: Custom plug-ins or workflows on the booking entity

Synchronous plug-ins or real-time workflows that are registered on the `BookableResourceBooking` entity run during every booking operation. This behavior adds latency to each interaction.

### Solution

1. Go to [Power Apps](https://make.powerapps.com), and select your environment.
1. Select **Tables** > **Bookable Resource Booking** > **Business rules** or **Plug-in steps**.
1. Find synchronous plug-ins or real-time workflows that are registered on **Create**, **Update**, or **Retrieve** operations.
1. Convert synchronous plug-ins to asynchronous wherever possible, or optimize their logic.
1. To measure the execution time of each step, use the [Plug-in Profiler](/power-apps/developer/data-platform/debug-plug-in#use-plug-in-profiler).

> [!NOTE]
> To check whether custom logic is causing the problem, temporarily disable custom plug-ins in a test environment, and then compare schedule board performance.

## Cause: Network latency or browser resource limits

High-latency network connections or insufficient browser memory can slow schedule board rendering.

### Solution

- To rule out local network problems, test from a different network.
- To free up memory, close unused browser tabs.
- Disable unnecessary browser extensions.
- For optimal schedule board performance, make sure that you have at least a 10-Mbps connection speed.

## Related content

- [Schedule board shows a blank page or fails to load](schedule-board-not-loading.md)
- [Debug plug-ins](/power-apps/developer/data-platform/debug-plug-in)
