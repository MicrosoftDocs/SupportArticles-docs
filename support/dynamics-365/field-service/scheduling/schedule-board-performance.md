---
title: Schedule board is slow to load or experiences extreme latency
description: Resolves performance issues with the Dynamics 365 Field Service schedule board including slow loading and extreme latency.
author: mkelleher-msft
ms.author: mkelleher
ms.reviewer: puneetsingh
ms.date: 03/12/2026
ms.custom: sap:Schedule Board
---

# Schedule board is slow to load or experiences extreme latency

This article helps dispatchers and administrators troubleshoot performance issues with the schedule board in Microsoft Dynamics 365 Field Service, including slow loading and extreme latency when moving bookings.

## Symptoms

When you use the schedule board, you experience one or more of the following issues:

- The schedule board takes more than 30 seconds to load.
- Moving or creating bookings by using drag-and-drop takes several minutes per operation.
- The board becomes unresponsive when switching between days or weeks.
- UI glitches appear alongside network request timeouts.

## Cause

### Cause 1: Too many resources displayed

The schedule board tab is configured to display too many resources at once. Loading hundreds of resources with their bookings significantly increases rendering time and API call volume.

### Cause 2: Excessive date range

The schedule board view is set to show too many days (for example, a full month view with many resources), which multiplies the data loaded.

### Cause 3: Custom plug-ins or workflows on booking entity

Synchronous plug-ins or real-time workflows registered on the `BookableResourceBooking` entity run during every booking operation, adding latency to each interaction.

### Cause 4: Network latency or browser resource limits

High-latency network connections or insufficient browser memory can slow schedule board rendering.

## Resolution

### Resolution for Cause 1: Reduce visible resources

1. In the Dynamics 365 Field Service app, go to **Service** area > **Scheduling** > **Schedule Board**.
2. On the active board tab, select **⋮** (vertical ellipsis) > **Board Settings** (gear icon) to open the tab settings.
3. Reduce the number of resources by applying filters, such as filtering by territory, role, or organizational unit.
4. Set the resource count slider to display no more than 25–50 resources at a time.
5. Consider creating separate board tabs for different teams or territories.

### Resolution for Cause 2: Reduce date range

1. In the Dynamics 365 Field Service app, open the schedule board and switch the view from **Weekly** or **Monthly** to **Daily** view by using the view selector at the top of the board.
2. Select **⋮** (vertical ellipsis) > **Board Settings** (gear icon) on the active board tab to open tab settings, and then set the **Number of days** to a smaller value (1–5 days).
3. Use date navigation to move between periods instead of loading large ranges.

### Resolution for Cause 3: Review custom plug-ins

1. Go to [make.powerapps.com](https://make.powerapps.com) and select your environment.
2. Go to **Tables** > **Bookable Resource Booking** > **Business rules** or **Plug-in steps**.
3. Find synchronous plug-ins or real-time workflows registered on **Create**, **Update**, or **Retrieve** operations.
4. Convert synchronous plug-ins to asynchronous where possible, or optimize their logic.
5. Use the **Plug-in Profiler** to measure execution time of each step.

> [!NOTE]
> To check if custom logic is the problem, temporarily disable custom plug-ins in a test environment and compare schedule board performance.

### Resolution for Cause 4: Network and browser optimization

- Test from a different network to rule out local network issues.
- Close unused browser tabs to free memory.
- Disable unnecessary browser extensions.
- Ensure minimum 10-Mbps connection speed for optimal schedule board performance.

## More information

- [Use the schedule board in Field Service](/dynamics365/field-service/work-with-schedule-board)
- [Schedule board tab settings](/dynamics365/field-service/schedule-board-tab-settings)
