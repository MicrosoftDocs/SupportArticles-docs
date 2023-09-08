---
title: Manually rebuild performance counters
description: Describes how to manually rebuild performance counters.
ms.date: 01/04/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:performance-monitoring-tools, csstroubleshoot
ms.technology: windows-server-performance
---
# Manually rebuild performance counters for Windows Server 2008 64 bit or Windows Server 2008 R2 systems

This article helps solve an issue where some performance counter libraries become corrupted and need to be rebuilt.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2554336

## Symptoms

When you use the Performance Monitor tool, some counters may be missing or don't contain counter data. The performance counter libraries may become corrupted and need to be rebuilt.

You may see the following errors in the application log:

```output
Log Name: Application  
Source: Microsoft-Windows-IIS-W3SVC-PerfCounters  
Event ID: 2002  
Level: Error  
Keywords: Classic  
Description:  
Setting up Web Service counters failed, please make sure your Web Service counters are registered correctly.
```

```output
Log Name: Application  
Source: IISInfoCtrs  
Event ID: 1001  
Level: Error  
Keywords: Classic  
Description:  
Unable to read the first counter index value from the registry. The error code returned by the registry is data DWORD 0.
```

## Cause

This behavior may occur if certain extensible counters corrupt the registry, or if Windows Management Instrumentation (WMI)-based programs modify the registry.

## Resolution

To resolve this issue, use the following methods.

### Ensure that the counters aren't disabled in the registry

The counters may be disabled via registry settings. Check the following registry locations to ensure that the counters haven't been disabled:

`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\%servicename%\Performance`

> [!NOTE]
> `%servicename%` represents any service with a performance counter. For example: PerfDisk, PerfOS, etc.

There may be registry keys for **DisablePerformanceCounters** in any of these locations. As per the article [Disable Performance Counters](/previous-versions/windows/it-pro/windows-server-2003/cc784382(v=ws.10)), this value should be set to 0. If the value is anything other than 0 the counter may be disabled.

- A value of 1 means the counter is disabled.
- A value of 2 means the 32-bit counter is disabled.
- A value of 4 means the 64-bit counter is disabled.

### Rebuild all performance counters including extensible and third-party counters

To rebuild all performance counters including extensible and third-party counters, type the following commands at an Administrative command prompt. Press **ENTER** after each command.

1. Rebuild the counters:

    ```console
    cd c:\windows\system32
    lodctr /R
    cd c:\windows\sysWOW64
    lodctr /R
    ```

2. Resync the counters with Windows Management Instrumentation (WMI):

    ```console
    WINMGMT.EXE /RESYNCPERF
    ```

3. Stop and restart the Performance Logs and Alerts service.

    ```powershell
    Get-Service -Name "pla" | Restart-Service -Verbose
    ```

4. Stop and restart the Windows Management Instrumentation service.

    ```powershell
    Get-Service -Name "winmgmt" | Restart-Service -Force -Verbose
    ```

5. Create a new Data Collector Set (don't use an existing Data Collector Set).

Sometimes, running `lodctr /R` may not recover all counters. If you notice this happening, verify the file `c:\windows\system32\PerfStringBackup.INI` contains the proper information. You can copy this file from an identical machine to restore the counters. There may be slight differences in this file from machine to machine. But if you notice a drastic difference in size, it may be missing information. Always create a backup copy before replacing. There's no guarantee that copying this file from another machine will restore all counters. If possible, compare the file to backups of the machine to see if the file size has reduced at some point in time.

For many counters, the location of the ini files to install perf counters is under `windows\winsxs`, such as the ini files for IIS.

If you see the following errors:

```output
Log Name: Application  
Source: Microsoft-Windows-IIS-W3SVC-PerfCounters  
Event ID: 2002  
Level: Error  
Keywords: Classic  
Description:  
Setting up Web Service counters failed, please make sure your Web Service counters are registered correctly.
```

```output
Log Name: Application  
Source: IISInfoCtrs  
Event ID: 1001  
Level: Error  
Keywords: Classic  
Description:  
Unable to read the first counter index value from the registry. The error code returned by the registry is data DWORD 0.
```

You'll need to use the counter install ini files in the directory `c:\Windows\winsxs`.

Multiple folders may exist for counters that you need to repair. In those cases, you might need to use trial and error to find the correct ini files.

For example,

`Dir C:\Windows\winsxs\amd64_microsoft-windows-iis-metabase*`

In this example, try installing the infoctrs.ini from each folder using:

`Lodtr infoctrs.ini`

When it's successful, you'll see the following entry in the application log:

```output
Log Name: Application  
Source: Microsoft-Windows-LoadPerf  
Event ID: 1000  
Level: Information  
Description:  
Performance counters for the inetinfo (inetinfo) service were loaded successfully. The Record Data in the data section contains the new index values assigned to this service.
```

You need do the same for the following counters:

amd64_microsoft-windows-iis-w3svc*

`lodctr w3ctrs.ini`

After which you'll see:

```output
Log Name: Application  
Source: Microsoft-Windows-LoadPerf  
Event ID: 1000  
Level: Information  
Description:  
Performance counters for the W3SVC (World Wide Web Publishing Service) service were loaded successfully. The Record Data in the data section contains the new index values assigned to this service.
```

Following these steps, rerun `WINMGMT /RESYNCPERF`.

## More information

There's a hotfix for known issues with PerfDisk.dll on Windows Server 2008 and Vista systems. This hotfix has been rolled into Service Pack 2 for these operating systems. If you're at Service Pack 1 or below, apply the hotfix 961382.

## References

- [The report generation process may stop responding when you run Perfmon.exe with the Active Directory Diagnostics template to generate a report on a Windows Server 2008-based domain controller](https://support.microsoft.com/help/971714)
- [Error message when you try to access the Performance Monitor (Perfmon.exe) on a remote computer: "Access Is Denied"](https://support.microsoft.com/help/969639)
