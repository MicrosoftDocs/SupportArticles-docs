---
title: CPU usage over 100% if Intel Turbo Boost is active
description: Describes an issue where CPU usage exceeds 100% in Task Manager and Performance Monitor if Intel Turbo Boost is active.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:performance-monitoring-tools, csstroubleshoot
---
# CPU usage exceeds 100% in Task Manager and Performance Monitor if Intel Turbo Boost is active

This article describes an issue where CPU usage exceeds 100% in Task Manager and Performance Monitor if Intel Turbo Boost is active.

_Applies to:_ &nbsp; Windows 8  
_Original KB number:_ &nbsp; 3200459

## Symptoms  

Starting with Windows 8, a change was made to the way that Task Manager and Performance Monitor report CPU utilization. With this change, CPU utilization may appear to exceed 100% when the system is under a heavy load, especially when capacity is boosted by Intel Turbo Boost.

## Cause

This change affects the way that CPU utilization is computed. The values in Task Manager now correspond to the **Processor Information\% Processor Utility** and **Processor Information\% Privileged Utility** performance counters, *not* to the **Processor Information\% Processor Time** and **Processor Information\% Privileged Time** counters as in Windows 7.

## More information

The difference between the two counter types concerns how they measure the actual work that the processor performs. The time-based performance counters measure the percentage of time that the processor is busy, whereas the utility performance counters measure how much work the processor actually performs. The utility performance counters take into account the processor performance state and Turbo Boost-based enhancements to measure and normalize the work that's being done by the CPU.

This change was intended to provide a more accurate representation of how much work the system is handling. A processor that's running 100% of the time and clocked down to 50% frequency performs only half the work of a processor that's running 100% of the time at 100% frequency. Before this change, under the time-based performance counters (used in Windows 7 Task Manager), both processors appear to be doing the same amount of work: 100% of their capacity. With the redesigned Task Manager, the first processor is shown to be running at 50% capacity, whereas the second processor is shown to be running at 100% capacity. And Turbo Boost drives the processor above 100% of its nominal speed, and allows the processor to exceed 100% capacity.  

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
