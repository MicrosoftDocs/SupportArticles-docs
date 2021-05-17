---
title: High CPU usage by the WMI Provider Host (WmiPrvSE.exe) process at regular intervals
description: Provides a workaround for the issue of high CPU usage by the WMI Provider Host (WmiPrvSE.exe) process at regular intervals.
ms.date: 11/16/2020
author: Deland-Han
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-sanair 
ms.prod-support-area-path: WMI 
ms.technology: windows-server-system-management-components
---
# High CPU usage by the WMI Provider Host (WmiPrvSE.exe) process at regular intervals in Windows

This article provides a workaround for the issue of high CPU usage by WmiPrvSE.exe process at regular intervals.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Window 10 - all editions  
_Original KB number:_ &nbsp; 4483874

## Symptoms

When you use a Windows-based computer, you notice that the Windows Management Instrumentation (WMI) Provider Host (WmiPrvSE.exe) process is using high CPU capacity (close to 100 percent) for several minutes every 15 to 20 minutes.

When the issue occurs, use Task Manager to identify the process identifier (PID) of the WmiPrvSE.exe process that's consuming high CPU. Then, open an elevated command prompt and run the following command:  

```console
tasklist /m wmiperfclass.dll
```

The list of WmiPrvSE.exe processes that have this module loaded will be displayed. ‎Usually only one process is listed. However, if you have both 32-bit and 64-bits clients, you may see two processes.‎ This is example output:  

> Image Name &emsp;&emsp; PID &emsp;&emsp;&emsp;Modules  
==========    ========    ==========================  
WmiPrvSE.exe &emsp;&emsp;2140 &emsp;&emsp;WmiPerfClass.dll  

If the PID of the listed process matches the one that you found in Task Manager, it is likely that you are encountering the issue that's described in this article.  

## Cause

This issue can be caused by either of the following factors.

### One or more processes are using a high number of handles  

All the handles are stored in the kernel structure \BaseNamedObjects. The [WMIPerfClass provider](https://docs.microsoft.com/windows/win32/wmisdk/wmiperfclass-provider) must scan this structure when creating the performance class that is related to the Job objects.

If this structure is bloated because of the high number of handles, the operation will have high CPU usage and will take longer than normal.

‎You may expect an impact for this condition when a process is using more than about 30,000 handles, or the total number of handles on the system exceeds 50,000.

An update that is released in March 2020 for supported operating system versions includes some performance optimization and addresses some variants of this issue. Refer to the Windows Updates history for more information on the update that applies to your Windows version.

### One or more processes running on the system are using lots of memory

This affects the creation of the Process performance classes because the memory area of each running process will have to be queried. The memory that's used by the process may be fragmented, and this makes the operation more resource-intensive. This happens because WMIPerfClass is also querying “Costly” performance counters.

‎You can check whether Costly performance counters are enabled by running the following PowerShell command:

```powershell
‎ (gwmi -query 'select * from meta_class').Name | ? { $_ -match "costly"}  
```

If the command returns results, this indicates the Costly performance counters that are enabled. For example:

> Win32_PerfFormattedData_PerfProc_FullImage_Costly  
Win32_PerfRawData_PerfProc_FullImage_Costly  
Win32_PerfFormattedData_PerfProc_Image_Costly  
Win32_PerfRawData_PerfProc_Image_Costly  
Win32_PerfFormattedData_PerfProc_ProcessAddressSpace_Costly  
Win32_PerfRawData_PerfProc_ProcessAddressSpace_Costly  
Win32_PerfFormattedData_PerfProc_ThreadDetails_Costly  
Win32_PerfRawData_PerfProc_ThreadDetails_Costly  

## Workaround

To fix the issue, identify the process that's using a large number of handles or a large amount of memory.‎ The process may have a memory leak or a handle leak issue. As a workaround, restart the process.

By default if you're using Windows Server 2016 or a later version of Windows, the Costly performance counters are disabled starting from the following Cumulative Updates:

- Windows Server 2016 / Windows 10 version 1607 (RS1)  
[October 18, 2018—KB4462928 (OS Build 14393.2580)](https://support.microsoft.com/help/4462928)
- Windows 10 version 1703 (RS2)  
[July 24, 2018—KB4338827 (OS Build 15063.1235)](https://support.microsoft.com/help/4338827)
- Windows 10 version 1709 (RS3)  
[July 24, 2018—KB4338817 (OS Build 16299.579)](https://support.microsoft.com/help/4338817)
- Windows 10 version 1803 (RS4)  
[July 16, 2018—KB4345421 (OS Build 17134.167)](https://support.microsoft.com/help/4345421)  

> [!NOTE]
> After the cumulative update is installed, if you need the classes that are related to the Costly performance counters, set the value **Enable Costly Providers** to **1** (***DWORD***) under the following registry subkey to make them available again:
>
> `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Wbem`
>
> The cumulative update will not affect the behavior when a process is using a large number of handles.

This issue happens when a client is querying the performance classes. This is usually a monitoring application.

As a workaround, you can also disable the monitoring application to prevent the creation of the performance classes.  

## More information

WMI provides several performance classes. For more information, see [Performance Counter Classes](https://docs.microsoft.com/windows/win32/cimwin32prov/performance-counter-classes).

These classes are created dynamically based on the Performance Counters that are available on the system. All the classes are created at the same time, not only the classes that are being queried.

WMIPerfClass is the module that handles creating these classes when the WMI client queries any of them or enumerates the available classes.

These performance classes are stored in a cache that's invalidated after 15 to 20 minutes. ‎As soon as the cache is invalidated, the performance classes must be created again if a client requests them.

Creating the performance classes means that the WMIPerfClass.dll module will have to be loaded inside a WmiPrvSE.exe process and the related code executed.  
