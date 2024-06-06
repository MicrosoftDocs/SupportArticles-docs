---
title: Troubleshoot issues where system shutdown stops responding
description: Explains how to troubleshoot issues where a system shutdown doesn't complete and stops responding.
ms.date: 06/05/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, warrenw, v-lianna
ms.custom: sap:System Performance\Shutdown Performance (slow, unresponsive), csstroubleshoot
---
# Scenario guide: Troubleshoot issues where system shutdown stops responding

This scenario guide explains how to troubleshoot issues where a system shutdown doesn't complete and stops responding. It also helps collect the data and start the analysis of the issue. For more information, see [General information about the system shutdown](/windows/win32/shutdown/system-shutdown).

## The memory dump file

To troubleshoot this scenario, you need a [Complete Memory Dump](/windows-hardware/drivers/debugger/complete-memory-dump). If the machine has a lot of memory, you should configure an [Active Memory Dump](/windows-hardware/drivers/debugger/active-memory-dump) to reduce the size of the dump file. To get a memory dump, initiate a shutdown and wait 10 minutes for the dump analysis. Use the same method as for [troubleshooting a computer that's in a frozen state](../../windows-client/performance/windows-based-computer-freeze-troubleshooting#use-memory-dump-to-collect-data-for-the-physical-computer-thats-running-in-a-frozen-state) to configure and create the *memory.dmp* file. The file is for analysis from a [physical computer](../../windows-client/performance/windows-based-computer-freeze-troubleshooting#use-memory-dump-to-collect-data-for-the-physical-computer-thats-running-in-a-frozen-state) or a [virtual machine](../../windows-client/performance/windows-based-computer-freeze-troubleshooting#use-memory-dump-to-collect-data-for-the-virtual-machine-thats-running-in-a-frozen-state).

## Debugging tools

To analyze the memory dump file, install the [Windows debugger](/windows-hardware/drivers/debugger/).

The [MEX Debugging Extension for WinDbg](https://www.microsoft.com/download/details.aspx?id=53304) helps debug and analyze shutdown problems. It can also simplify common debugger tasks and provides powerful text filtering capabilities to the debugger.

## Analysis preparation

Configure the Windows debugger with the [symbol path](/windows-hardware/drivers/debugger/symbol-path) so that the Windows debugger can load [symbols](/windows-hardware/drivers/debugger/symbols) to analyze the scenario.

Use a local folder (for example, *c:\\Symbols*) to cache with the [Microsoft symbol server](https://msdl.microsoft.com/download/symbols). Set the **Symbol path** as follows:

    :::image type="content" source="media/system-shutdown-stops-responding-issues/symbol-server-path.png" alt-text="Screenshot that shows the symbol path in the debugging settings.":::

Unzip the *mex.dll* file and copy it to the *winext* folder under the path of the installed debugger tools (for example, *C:\\Prgram Files (x86)\\Windows Kits\\10\\Debuggers\\x64\\winext\\mex.dll*).

Start the debugger, load the *memory.dmp* file, and load the mex extension. For example:

```dbgcmd
0: kd> .load C:\Prgram Files (x86)\Windows Kits\10\Debuggers\x64\winext\mex.dll
Mex External 3.0.0.7172 Loaded!
```

## Analyze with debuggers

You can [analyze crash dump files](/windows-hardware/drivers/debugger/crash-dump-files) with debuggers.

The possible causes that block the shutdown for hours are:

- Blocked kernel situations
- [Services that don't end](../../azure/virtual-machines/windows/boot-error-troubleshoot-windows)
- The policy to [clear the paging file at shutdown](/previous-versions/windows/it-pro/windows-10/security/threat-protection/security-policy-settings/shutdown-clear-virtual-memory-pagefile) is activated

### Blocked kernel situations

Check for blocked threads by using the command `!mex.tl -t`. For example:

    :::image type="content" source="media/system-shutdown-stops-responding-issues/blocked-kernel-situations.png" alt-text="Screenshot that shows the blocked threads in the output of the command.":::

### Services that don't end

To isolate a problem with third-party services, start the machine in [safe mode](/windows/start-your-pc-in-safe-mode-in-windows-92c27cff-db89-8644-1ce4-b3e5e56fe234) with the third-party services disabled, and then shut it down with the third-party services disabled. If the problem is related to a third-party service, continue to use the [System Configuration utility](../../windows-client/performance/system-configuration-utility-troubleshoot-configuration-errors) and [selective startup](../../windows-client/performance/system-configuration-utility-troubleshoot-configuration-errors#selective-startup) to isolate the service blocking the shutdown.

### Check the "ClearPageFileAtShutdown" value

Check the value data of the `ClearPageFileAtShutdown` value (`Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management`). If the value is `0`, the policy to clear the paging file at shutdown is disabled. If the value is `1`, the policy is enabled.

## References

- [Shutdown Processes Duration](/windows-hardware/test/assessments/shutdown-processes-duration)
- [System Shutdown](/windows/win32/shutdown/system-shutdown)
- [Complete Memory Dump](/windows-hardware/drivers/debugger/complete-memory-dump)
- [Symbol path for Windows debuggers](/windows-hardware/drivers/debugger/symbol-path)
- [Windows-based computer freeze troubleshooting](../../windows-client/performance/windows-based-computer-freeze-troubleshooting#use-memory-dump-to-collect-data-for-the-physical-computer-thats-running-in-a-frozen-state)
