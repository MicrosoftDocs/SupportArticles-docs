---
title: Windows Server 2022 on VMWare doesn't restart because of unrecoverable I/O operation error
description: Discusses how to fix an issue in which you restart a Windows Server 2022 virtual machine (VM) that's hosted on VMware, and the VM fails to restart and displays an unrecoverable input/output (I/O) operation error.
ms.date: 03/06/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, simonw, v-appelgatet
ms.custom:
- sap:virtualization and hyper-v\high availability virtual machines
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Windows Server 2022 on VMware doesn't restart because of unrecoverable I/O operation error

## Summary

When you restart a Windows Server 2022 virtual machine (VM) that's hosted on VMware, the VM might fail to restart and display an unrecoverable input/output (I/O) operation error. This error occurs when the operating system can't flush a registry hive to disk, which can affect system stability or data integrity.

This article helps you identify the component that's causing the failure and resolve the issue.

## Symptoms

You restart a Windows Server 2022 VM that runs in a VMware environment. During the restart process, you see an error message that indicates that an I/O operation failed during a registry hive flush. You might also see Event ID 6 in the System event log. The event details look similar to the following example:

```output
Source: Kernel-General
Event ID: 6
Description: The operating system failed to flush data to the transaction log.
```

The issue doesn't recur consistently.

## Cause

This issue occurs when Windows Server 2022 doesn't flush a registry hive to disk, which can affect system stability or data integrity. Several factors can cause this behavior, including the following circumstances:

- Resource constraints, such as memory exhaustion
- Interference from file system filter drivers
- Temporary system performance degradation during the restart process

Because the error is isolated to the registry flush process and doesn't recur consistently, hardware failure isn't likely to be a factor.

## Resolution

To resolve this issue, you have to first identify the component that's triggering the failure, identify the underlying issue in that component, and fix that issue.

### Step 1: Update your configuration

1. Verify that the VM has the latest Windows Server 2022 updates and the latest VMware drivers.
2. Verify that you're using the latest version of VMware Tools and any related drivers.
3. Verify that all third-party filter drivers, such as antivirus or backup software drivers, are up to date.
4. Apply any missing updates.
5. To see if the updates fixed the issue, restart the VM.

### Step 2: Collect data while you reproduce the issue

1. Set up a monitoring tool such as Performance Monitor ([PerfMon](../support-tools/troubleshoot-issues-performance-monitor.md)). Monitor the following counters on the VM:
   - CPU usage
   - Memory usage
   - Disk usage
1. Restart the VM.
1. After the error occurs, save the performance data.

### Step 3: Analyze the data and update or adjust your configuration

1. Review the performance data. In particular, look for spikes in resource usage.
1. In Event Viewer, review the System and Application logs.
   Look for warnings or errors that occur before the registry hive flush operation fails.
1. Use the performance and event data to identify which components might be causing issues. In particular, watch for log entries that occur at the same time as spikes in resource usage.
   This information can help pinpoint which component, such as a specific driver or process, is at the root of the I/O failure.
1. Resolve any underlying issues that you find during your analysis.
1. To see if the updates fixed the issue, restart the VM.

## Data collection

If you contact Microsoft Support, you can attach this data to your support request.

- Exact error message text and screenshots of the relevant events in Event Viewer
- Complete System and Application event data that covers the period when the issue occurred. You can export this information from Event Viewer.
- The performance data that you collected during Step 2.
- Windows Server 2022 version and build details

   **Note:** To see the exact version and build number, run `winver` at a command prompt on the affected computer.
- VMware configuration details, including virtual hardware settings and VMware Tools version

## References

- [Troubleshoot issues using Performance Monitor](../support-tools/troubleshoot-issues-performance-monitor.md)
- [VMware documentation](https://support.broadcom.com/)
