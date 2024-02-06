---
title: Slow performance when using power plan
description: Provides a solution to an issue where slow performance on Windows Server when using the Balanced power plan.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, papant, deepku
ms.custom: sap:slow-performance, csstroubleshoot
---
# Slow performance on Windows Server when using the Balanced power plan

This article provides a solution to an issue where slow performance on Windows Server when using the Balanced power plan.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2207548

## Symptoms

In some cases, you may experience degraded overall performance on a Windows Server 2008 R2 or later machine when running with the default (Balanced) power plan. The issue may occur irrespective of platform and may be exhibited on both native and virtual environments. The degraded performance may increase the average response time for some tasks and cause performance issues with CPU-intensive applications.

> [!NOTE]
> You may not notice performance issues while performing simple operations. However, applications or scripts that intensively use resources (primarily processor and memory) may exhibit the problem. See [More information](#more-information) section for details.

## Cause

This issue may occur if the **Power Options** settings are set to **Balanced**. By default, Windows Server 2008 R2 or later sets the **Balanced (recommended)** power plan, which enables energy conservation by scaling the processor performance based on current CPU utilization.

## Resolution

- Option 1:  Recommended

    This issue is tied to interaction between the processors and the operating system not adjusting P-States and turning off Core Parking as needed. To address this, it requires both hardware and operating system updates.

    1. Update System BIOS to a current revision. Reference the hardware manufacturer for model-specific recommendations.
    2. Apply the appropriate hotfix for your operating system:
        - For Windows Server 2008 R2 and Windows Server 2008 R2 Service Pack 1
        - For Windows Server 2008, reference Option 2.
    3. Apply the appropriate CPU updates - For AMD FX, AMD Opteron 4200/4300, AMD Opteron 6200/6300, and AMD Opteron Bulldozer

- Option 2

    To work around the performance degradation issue, you can switch to the **High Performance** power plan.  However, it will disable dynamic performance scaling on the platform. Depending on the environment, if the platform is always under a heavy load, then it's a viable solution.  In most cases, however, the workload varies throughout the day and thus it's recommended to leave the power plan set to Balanced and evaluate the proper settings within the Balanced power plan for processor power management.

    > [!IMPORTANT]
    > Today's modern processors enable scaling of performance and power based on the current activity on the system.  The different performance states are dynamically managed by Windows in conjunction with hardware and platform firmware to respond to varying workload requirements. The 3 default power plans exposed by Windows provide varying tradeoffs of performance vs. power consumption.  For example, if the High Performance power plan is selected, Windows places the system in the highest performance state and disables the dynamic scaling of performance in response to varying workload levels.  Therefore, special care should be taken before setting the power plan to High Performance as this can increase power consumption unnecessarily when the system is underutilized.

    If the choice is made to change the default power plan, Windows Server 2008 R2 or later provides three power plans to maximize performance and conserve energy: **Balanced (recommended), High Performance** and **Power Saver**.

    To change a power plan:

    1. Select **Start** and then **Control Panel**.
    2. From the list of displayed item under **Control Panel**, select **Power Options**, which takes you to **Select a power plan** page. If you don't see **Power Options**, type the word power in the **Search Control Panel** box and then select **Choose a power plan**.
    3. By default, the option to change power plans is disabled. To enable it, select **Change settings that are currently unavailable** link.
    4. Choose the **High Performance** option.
    5. Close the **Power Option** window.

## More information

Processors change between performance states ("P-states") quickly to match supply to demand, delivering performance where necessary and saving power when possible. If your server has specific high-performance or minimum-power-consumption requirements, you might consider configuring the Minimum or Maximum Processor Performance State parameter. The values for both the Minimum and Maximum Processor Performance State parameters are expressed as a percentage of maximum processor frequency, with a value in the range 0 - 100. If your server requires low latency, invariant frequency, or high performance, you might not want the processors switching to lower-performance states.
