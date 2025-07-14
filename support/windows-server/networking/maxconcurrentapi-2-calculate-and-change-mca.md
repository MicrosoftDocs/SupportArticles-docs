---
title: Calculate and change MCA on your affected computers
description: Describes how to calculate and implement new values for the MaxConcurrentApi parameter.
ms.date: 01/15/2025
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-tappelgate
ms.custom:
- sap:network connectivity and file sharing\tcp/ip connectivity (tcp protocol,nla,winhttp)
- pcy:WinComm Networking
keywords: MaxConcurrentApi, MCA, authentication slowdown, authentication performance
---

# Remediating MCA issues, part 2: Calculate and change MCA on your affected computers

This article discusses how to calculate and implement new values for the `MaxConcurrentApi` parameter.

_Applies to:_ &nbsp; Windows Server 2012 and later versions, Windows 8 and later versions

## Summary

Now that you have a list of servers that might benefit from a change in `MaxConcurrentApi`, you have to determine what the new value should be. To do this, follow these general steps for each affected server:

1. Collect general performance statistics to establish baselines for the affected server.
1. Collect tuning-related performance statistics while the server is processing the maximum client requests. For example, in an email server scenario, the best time to collect the performance data is when users arrive at work and check their email messages.
1. Use the performance data to calculate a `MaxConcurrentApi` value that's tuned for that server.
1. If the calculated value isn't equal to the default value, and is less than the maximum value, set the calculated value in the registry.
1. Collect fresh performance statistics to check that the change made an improvement. Check performance against the baseline.

> [!IMPORTANT]  
>
> - Before you change `MaxConcurrentApi` on a production server, change it in a test environment. Make sure that the change does not cause other performance issues. Such a change can take up memory and disk resources on servers that use older hardware.
> - Be aware that load conditions might change based on each scenario and business environment. Therefore, if the service load changes, you might have to recalculate the `MaxConcurrentApi` value.

## Set the performance baseline

Before you make any changes, monitor the servers that you suspect have MCA issues long enough to establish performance baselines (especially during peak load periods). Continue monitoring after you make any `MaxConcurrentApi` changes. The performance baselines provide the data that you need to determine the effects of the new `MaxConcurrentApi` values. The same data can also help you identify the root cause of your environment's performance issues (see [Part 3](maxconcurrentapi-3-troubleshoot-causes-of-mca-issues.md) of this series).

At a minimum, you should monitor the following counters to establish a performance baseline and to verify the effectiveness of any `MaxConcurrentApi` changes.

| Performance counter set | Purpose |
| --- | --- |
| **Memory** | Track the overall system memory to to make sure that the system isn't being overtaxed. |
| **Physical Disk** or **Logical Disk** | Track the disk I/O to make sure that the disks aren't overtaxed. This is important if Netlogon logging is enabled (which it should be if you're tracking this problem). |
| **Process** (*lsass.exe*, at a minimum) | For this baseline, *lsass.exe* is the most interesting because this is where Netlogon operates. However, it never hurts to have a view of the processes in case a problem does arise after you change `MaxConcurrentApi`. |
| **Processor** | Monitor the processor load. |
| **Network Interface** | Optional, but recommended. |
| **Netlogon** | Track Netlogon performance counters to get a holistic view of Netlogon functions. You can use the counters to detect delays in authentication and also the time-outs themselves.<br/><br/>Monitoring these counters provides a quick way (outside of the Netlogon logs) to determine whether authentication time-outs are occurring.<br/><br/>You still have to use the Netlogon logs for proper trending and analysis (such as to determine how many users are affected, how often they were affected, the exact error codes, and the source of the "bad" authentication). |

## Collect the tuning-related statistics

This section describes how to use Performance Monitor (*Perfmon.msc*, also available on the **Tools** menu in Server Manager) to collect the data that you have to calculate `MaxConcurrentApi`.

Configure Performance Monitor as follows:

- **Duration.** Set the **Duration** value in the Performance Monitor properties. We recommend that you use a value in the range of 90 to 120 seconds.  

  :::image type="content" source="./media/maxconcurrentapi-2-calculate-and-change-mca/perfmon-duration-property.png" alt-text="Screenshot that shows the location of the Duration property in Performance Monitor.":::

- **Counters.** Add the following counters from the **Netlogon** object.

  | Counter | Instance |
  | --- | --- |
  | Semaphore Acquires | _Total |
  | Semaphore Timeouts | _Total |
  | Average Semaphore Hold Time | _Total |

  > [!NOTE]  
  > You can obtain most of the values that you need from the Performance Monitor Line view. However, for the **Average Semaphore Hold Time** value, use the Report view.  
  > :::image type="content" source="./media/maxconcurrentapi-2-calculate-and-change-mca/perfmon-view-property.png" alt-text="Screenshot that shows the location of the View property in Performance Monitor.":::

Collect the following values from Performance Monitor:

- \<*Duration*> = Constant that defines the data collection interval. 
- \<*Semaphore_Acquires*> = The change in value of the Netlogon **Semaphore Acquires** counter during the specified duration. The counter is cumulative. The **Minimum** value is the starting value, and the **Maximum** value is the ending value.  
- \<*Semaphore_Timeouts*> = The change in value of the Netlogon **Semaphore Timeouts** counter during the specified duration. The counter is cumulative. The **Minimum** value is the starting value, and the **Maximum** value is the ending value.  
- \<*Avg_Semaphore_Hold_Time*> = The value of the Netlogon **Average Semaphore Hold Time** counter. To see the value as calculated across the specified duration, set the Performance Monitor view to **Report** instead of **Line**.

> [!NOTE]  
> If the value of any of these counters is zero, the server doesn't need a new `MaxConcurrentApi` value.

## Calculate the new MaxConcurrentApi value

Use the following equation to determine the MCA value for a server:

> (\<*Semaphore_Acquires*> + \<*Semaphore_Timeouts*>) &times; \<*Avg_Semaphore_Hold_Time*> / \<*Duration*> = \<*MaxConcurrentApiI*>

Compare the calculated value to the default and maximum value for the server's role, as listed in the following table.

| Operating system type or role | Default threads (per secure channel) | Maximum threads |
| --- | --- | --- |
| Domain controllers<br/> Windows Server 2012 and later versions | 10 | 150 |
| Member servers<br/> Windows 2012 and later versions | 10 | 150 |
| Workstations<br/> Windows 8 and later versions | 1 | 150 <br/>**Note:** It's unlikely that you'll need a value that's greater than **1** on a workstation. |

> [!NOTE]  
>
> - Earlier versions of Windows that have reached their End of Support date have different default and maximum values for MaxConcurrentApi. If you have an MCA issue that involves an unsupported version of Windows, upgrade to a more recent Windows version instead of trying to change the MaxConcurrentApi value.
> - The values in this table reflect conditions in which no communication delays exist between the authenticating system (that sends the authentication request, such as an app server) and the domain controller in the target domain.

If the value that you calculate for `MaxConcurrentApi` is greater than the default value and less than 150, change the server's `MaxConcurrentApi` value, as described in the next section.

> [!IMPORTANT]  
> If the value that you calculate is equal to or greater than 150, changing `MaxConcurrentApi` won't solve the issue. Check your environment for underlying issues, and consider adding servers to support the authentication request load (see [Part 3](maxconcurrentapi-3-troubleshoot-causes-of-mca-issues.md) of this series).

## Change MaxConcurrentApi

You have to configure `MaxConcurrentApi` in the server's registry. No comparable Group Policy setting exists.

[!INCLUDE [Registry warning](../../includes/registry-important-alert.md)]  

To change the MaxConcurrentApi setting, follow these steps:

1. Select **Start**, enter *regedit*, and then select Registry Editor in the search results.
2. Select the following registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters`
3. Select **Edit** > **New** > **DWORD Value**, and then enter *MaxConcurrentApi*.
4. Select **Edit** > **Modify**, and then enter the decimal value of the new `MaxConcurrentApi` setting.
5. Open a Command Prompt window, and then run the following commands, in sequence:

   ```console
   net stop netlogon
   net start netlogon
   ```

## Verify the new MaxConcurrentApi setting

As described in [Set the performance baseline](#set-the-performance-baseline), continue monitoring server performance after you change the server's `MaxConcurrentApi` value. Concentrate on the following performance counters:

- **Memory**
- **Physical Disk** or **Logical Disk**
- **Process**
- **Processor**
- **Network Interface**
- **Netlogon**

Ideally, performance should improve after you change `MaxConcurrentApi`.

## Example: Calculating a tuned MaxConcurrentApi value

This section continues the example that started in [part 1](maxconcurrentapi-1-identify-computers-that-have-mca-issues.md) of this series. The example data revealed that the server had a significant MCA issue.

To collect the information that's required for the calculations, Performance Monitor is configured as follows:

- The **Duration** property is 90 seconds.
- The following three counters are visible:
  - **Semaphore Acquires** (_Total)
  - **Semaphore Timeouts** (_Total)
  - **Average Semaphore Hold Time** (_Total)

The first value to add to the equation is the known value, /<*Duration*>.

> (\<*Semaphore_Acquires*> + \<*Semaphore_Timeouts*>) &times; \<*Avg_Semaphore_Hold_Time*> / **90** = \<*MaxConcurrentApi*>

### Determine the Average Semaphore Hold Time value

The best way to find **Average Semaphore Hold Time** is to switch to the **Report** view in Performance Monitor. To do this, select **Change graph type** > **Report** on the Performance Monitor toolbar. The **Report** view resembles the following:

:::image type="content" source="./media/maxconcurrentapi-2-calculate-and-change-mca/perfmon-report-avg-semaphore-hold-time.png" alt-text="Screenshot that shows the Report view in Performance Monitor.":::  

Now add the **Average Semaphore Hold Time** to the equation.

> (\<*Semaphore_Acquires*> + \<*Semaphore_Timeouts*>) &times; **0.098** / **90** = \<*MaxConcurrentApi*>

This value is the only value that you have to obtain from the **Report** view. For the remaining values, you have to switch back to **Line** view (in the toolbar, select **Change graph type** > **Line**).

### Determine the Semaphore Timeouts value

The example in [Part 1](maxconcurrentapi-1-identify-computers-that-have-mca-issues.md) used **Semaphore Timeouts** to determine whether the server had an MCA issue. In this step, you have to recalculate this value by using the 90-second duration.  

:::image type="content" source="./media/maxconcurrentapi-2-calculate-and-change-mca/perfmon-min-max-semaphore-timeouts-90-sec-sample.png" alt-text="Screenshot that shows time-outs data over a 90-second duration in Performance Monitor.":::  

Subtracting the minimum value from the maximum value produces a value of 1,983.

> (\<*Semaphore_Acquires*> + **1,983**) &times; **0.098** / **90** = \<*MaxConcurrentApi*>

### Determine the Semaphore Acquires value

Similar to the **Semaphore Timeouts** value, the **Semaphore Acquires** data is cumulative over the duration period that appears in Performance Monitor.  

:::image type="content" source="./media/maxconcurrentapi-2-calculate-and-change-mca/perfmon-min-max-semaphore-acquires.png" alt-text="Screenshot that shows Semaphore Acquires data in Performance Monitor.":::  

Subtracting the minimum value from the maximum value produces a value of 1,833.

> (**1,833** + **1,983**) &times; **0.098** / **90** = \<*MaxConcurrentApi*>

### Calculate MaxConcurrentApi

The equation produces a value of **4.1552** for `MaxConcurrentApi`. The registry entry requires an integer value, but **4** might not be sufficient. In this case, **5** is a safe value to use.

## Next steps

- [Remediating MCA issues, part 3: Troubleshoot the underlying causes of an MCA issue](maxconcurrentapi-3-troubleshoot-causes-of-mca-issues.md)
