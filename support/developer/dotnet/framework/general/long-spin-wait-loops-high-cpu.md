---
title: High CPU or memory usage in applications on VMs
description: This article fixes a problem in which high CPU or memory usage occurs in the .NET Framework because of the Pause Latency change.
ms.date: 05/04/2023
ms.custom: sap:.NET Framework, Virtual Machine running Windows
ms.reviewer: joelpell
ms.technology: dotnet-general
---
# High CPU or memory usage and increased spin-wait loops in .NET Framework on VMs by using Intel Skylake processors

This article helps you resolve the problem where high CPU or memory usage occurs in Microsoft .NET Framework applications on Azure virtual machines (VMs) that are driven by Intel Skylake processors.

_Original product version:_ &nbsp; .NET Framework  
_Original KB number:_ &nbsp; 4527212

## Symptoms

You experience higher than expected CPU or memory usage on Azure VMs that were recently deployed on computers that are driven by Intel Skylake processors. According to Intel, this change affects VM performance and overall workload or application execution.

The issue is caused by an increase in the *pause* instruction delay for Intel Skylake processors. You may notice this issue particularly in .NET Framework applications. This is because the Pause Latency change affects long spin-wait loops that are common in .NET Framework.

## Cause

In the most recent Skylake microarchitecture, Intel increased the Pause Latency value to up to 140 cycles. In earlier-generation microarchitecture, the Pause Latency value is about 10 cycles. According to Intel, this change was made to improve resource sharing. For more information about the change and its effects, see section 2.6.4 (Pause Latency in Skylake Client Microarchitecture) of the following Intel PDF document: [Intel 64 and IA-32 Architectures Optimization Reference Manual](https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-optimization-manual.pdf).

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

### Fix for this issue

To fix this issue, install [.NET Framework October 2018 Security and Quality RollUp](https://devblogs.microsoft.com/dotnet/net-framework-october-2018-security-and-quality-rollup/).

> [!NOTE]
> In .NET Framework 4.8, the fix is enabled by default. In .NET Framework 4.6.x and 4.7.x, the fix is disabled by default and can be manually enabled.

To enable the fix for the pause delay on Skylake processors, start Registry Editor, and add the `Thread_NormalizeSpinWait` key as a DWORD value to the following subkey:

- Location: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework`
- Value Name: `Thread_NormalizeSpinWait`
- Value data: **1**  

> [!NOTE]
> Other customer applications may also be affected by the timer configuration, even though this setting is not enabled by default in any version of .NET Framework. If the workload performance is still affected after the Pause Latency change, consider whether timers are a significant source of lock contention. If you determine that this is true, go to the [Fix for the timers](#fix-for-the-timers) section.

### Fix for the timers

To manually enable the fix, add the `Switch.System.Threading.UseNetCoreTimer` key as a String value to the following subkey:

- Location: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\AppContext`
- Value Name: `Switch.System.Threading.UseNetCoreTimer`
- Value data: **true**

For more information about timers, see the **AppContext for library consumers** section in [AppContext Class](/dotnet/api/system.appcontext?view=netframework-4.7.2&preserve-view=true#appcontext-for-library-consumers).

## Frequently asked questions

- **Does this change cause any harm if we also have UseNetCoreTimer enabled on all kinds of hardware?**

    The timer fix is not currently enabled by default in any version of .NET Framework. We don't recommend that you change the default setting at the local level.

- **Are there any other known issues caused by the Pause Latency change in Skylake?**

    The new Pause Latency measurement also consumes additional CPU time during startup. Typically, the value is about 10 ms of CPU time. The increased duration is considered to be necessary to get more reliable measurements and improve the ability to fix the issue. However, .NET Framework applications may also be short-running tools. The frequent use of such tools may cause greater CPU usage than before the fix was applied. This was considered to be an acceptable tradeoff in order to fix a larger problem and enable the fix by default in .NET Framework 4.8.

- **Is the Skylake Pause Latency fix guaranteed to solve my issue?**

    No, the fix isn't guaranteed. There could be other, unrelated elements outside this issue that affect specific workload performance. The effectiveness of the fix is gated on measurement quality. There are bounds in use to make sure that we don't overscale spin counts in .NET Framework. However, bad measurements can occur when the VM is heavily loaded. This can prevent the fix from being effective. In the worst case (excluding the tradeoff that is mentioned in A2), this situation would be similar to the fix not being applied.

- **Do we have any guidance for support engineers about how we can detect that any perceived performance issue is caused by this change?**  

    You can determine this by profiling the application that's used. Comparing profiles that have similar loads between a pre-Skylake-based VM and a Skylake-based VM may show much more time relatively spent in `clr!AwareLock::Contention` on the Skylake VM. That would indicate that the pause delay fix would be useful if the VM runs on a Skylake processor.

For the timer fix, the call stack would show that `clr!AwareLock::Contention` is called by `mscorlib.ni!System.Threading.TimerQueueTimer.Fire()`. If the `Fire()` method or other methods on `TimerQueueTimer` are the primary source of contention, this would indicate that the timer fix would help.

It's also possible to monitor lock contention rates by using Performance Monitor. For more information, see the **Contention Rate / Sec** and **Total # of Contentions** entries for **.NET CLR LocksAndThreads** in the **Lock and thread performance counters** section in [Performance Counters in the .NET Framework](/dotnet/framework/debug-trace-profile/performance-counters#lock-and-thread-performance-counters).

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]
