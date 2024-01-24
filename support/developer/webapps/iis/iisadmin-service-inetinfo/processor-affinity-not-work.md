---
title: Processor affinity doesn't work on NUMA
description: Discusses that the IIS 10.0 processor affinity does not work on NUMA hardware. Provides a resolution.
ms.date: 04/07/2020
ms.custom: sap:IISAdmin service and Inetinfo process operation
ms.reviewer: yashi
ms.technology: iisadmin-service-inetinfo
---
# IIS 10.0 processor affinity feature doesn't work on NUMA hardware

This article provides information about resolving the problem where Internet Information Services (IIS) 10.0 processor affinity does not work on non-uniform memory access (NUMA) hardware if IIS thread pool ideal CPU optimization is enabled.

_Original product version:_ &nbsp; Internet Information Services 10.0  
_Original KB number:_ &nbsp; 4041818

## Symptoms

The processor affinity feature does not work on out-of-box NUMA hardware in IIS 10.0.  

You can specify whether a particular worker process that's assigned to an application pool should be assigned to a particular CPU. To do this, you can use the `smpAffinitized` application pool setting together with the `smpProcessorAffinityMask` and `smpProcessorAffinityMask2` specified affinity masks.

However, on IIS 10.0 that is running on a NUMA server, a worker process is still assigned to all available processors even if you enable processor affinity and set the affinity mask to indicate only a subset of CPUs.  

> [!NOTE]
>
> - The issue does not apply to non-NUMA hardware.
> - You can check the processor affinity of each worker process from the Task Manager. To do this, follow these steps:
>    1. Select **Details**.
>    2. Select **w3wp.exe**.
>    3. Set **affinity**.

## Cause

The issue occurs because a new feature, IIS Thread Pool Ideal CPU Optimization for NUMA hardware, is enabled in IIS 10.0.

By default, this feature is enabled. The feature optimizes IIS performance by evenly distributing loads across all CPUs of all NUMA nodes. However, this setting conflict with the specified processor affinity.

## Workaround

To work around this issue, disable **IIS Thread Pool Ideal CPU Optimization** on a NUMA server if you want to specify processor affinity. To do this, update the value of the following registry from **1** to **0**:

`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\InetInfo\Parameters\ThreadPoolUseIdealCpu`

## Resolution

To fix this issue, upgrade your IIS to a later version, such as IIS 10.0 RS3, when it is available.

## Reference

- [CPU Settings for an Application Pool \<cpu>](/iis/configuration/system.applicationhost/applicationpools/add/cpu)
- [IIS Thread Pool Ideal CPU Optimization for NUMA hardware](/iis/get-started/whats-new-in-iis-10/thread-pool-ideal-cpu-numa-optimization)
