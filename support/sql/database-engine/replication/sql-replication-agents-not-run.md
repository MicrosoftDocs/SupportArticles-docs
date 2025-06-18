---
title: SQL Server replication agents can't run
description: This article provides workarounds for the problem that occurs when you configure many SQL Server replication agents to run on a server, and some replication agents can't run.
ms.date: 06/18/2025
ms.custom: sap:Replication, Change Tracking, Change Data Capture, Synapse Link
ms.reviewer: akshaym, jopilov
---
# Some SQL Server replication agents can't run when you configure many replication agents to run on a server

This article helps you work around the problem where some replication agents can't run when you configure many SQL Server replication agents to run on a server.

_Original product version:_ &nbsp; SQL Server
_Original KB number:_ &nbsp; 949296

## Symptoms

Consider the following scenario:

- You configure many Microsoft SQL Server replication agents to run on a server. For example, you configure more than 200 replication agents to run on a server.

In this scenario, some replication agents can't run. Additionally, the following error message is logged in the system log:

> Application Error : The application failed to initialize properly (0xc0000142).  
> Click on OK to terminate the application.

## Cause

This problem occurs because the desktop heap is used up.

## Workaround

To work around this problem, use one of the following methods:

### Use separate accounts for the replication agents created for different databases
  
You can specify this while you are creating replication agents. You have to make sure all permissions touch points are taken care of. The procedure to change the security settings for already-created replication agents can be found at [View and modify replication security settings](/sql/relational-databases/replication/security/view-and-modify-replication-security-settings).

### Use registry settings to increase the desktop heap size
  
You can change the following registry entries:

- `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\SessionViewSize` (for example, increase the value from 48 to 64).

- `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\SubSystems\Windows` (for example, increase the third value of `SharedSection` by 256 kilobytes)

You have to apply the changes on both nodes. You have to save the registry keys before the change, and you have to restart the server after you apply the change.

### Change the replication agents from running continuously to running on a scheduled basis
  
This makes sure that the replication agents run only when it's necessary, and not to stay idle constantly (because this wastes resources).

Instructions about how to change the replication agent schedule are available at [Specify synchronization schedules](/sql/relational-databases/replication/specify-synchronization-schedules).

### Change the server location on which the replication agents are running
  
You can evaluate the publisher-subscriber pairs and see whether you can change some subscribers to pull that will make the distribution/merge agent run on the subscriber instead of on the publisher. This helps reduce the number of concurrent agents that have to run on the server.

## Status

This behavior is by design.

## Steps to use LiveKD to enumerate the desktop heap values

1. Download [Debugging Tools for Windows as part of the SDK](https://developer.microsoft.com/windows/downloads/sdk-archive/).
2. Run `Sdksetup.exe`, and then install Debugging Tools for Windows.
3. [Download LiveKD](/sysinternals/downloads/livekd).
4. Create a `C:\debugger` folder.
5. Copy all the files from the location where you installed the debugging tools to `C:\debugger`. The default path is `C:\Program Files (x86)\Windows Kits\8.0\Debuggers\x64`.
6. Extract LiveKD to `C:\debugger`.
7. Open a command prompt that has elevated permission.
8. Run the following command from the command prompt:

    ```console
    livekd -y srv*http://msdl.microsoft.com/download/symbols
    ```

9. You should receive output that resembles the following:

    ```console
    LiveKd v5.3 - Execute kd/windbg on a live system
    Sysinternals -[www.sysinternals.com](http://www.sysinternals.com/) 
    Copyright (C) 2000-2012 Mark Russinovich and Ken Johnson
    Launching C:\Debugger\kd.exe:
    Microsoft (R) Windows Debugger Version 6.2.9200.20512 AMD64
    Copyright (c) Microsoft Corporation. All rights reserved.
    Loading Dump File [C:\Windows\livekd.dmp]
    Kernel Complete Dump File: Full address space is available
    Comment: 'LiveKD live system view'
    Symbol search path is: srv*http://msdl.microsoft.com/download/symbols
    Executable search path is:
    Product: Server, suite:
    Built by:
    Machine Name:
    Kernel base =
    Debug session time:
    System Uptime:
    Loading Kernel Symbols
    ...............................................................
    Loading User Symbols
    ...................................................
    Loading unloaded module list
    ......Unable to enumerate user-mode unloaded modules, NTSTATUS 0xC0000147
    ```

10. Run `!dskheap` to receive the following output:

    ```console
    kd> !dskheap
    *** ERROR: Module load completed but symbols could not be loaded for LiveKdD.SYS
    Winstation\Desktop            Heap Size(KB)   Used Rate(%)
    ------------------------------------------------------------
    WinSta0\Default                  20480                 0%
    WinSta0\Disconnect                  96                 4%
    WinSta0\Winlogon                   192                 2%
    Service-0x0-3e7$\Default           768                 1%
    Service-0x0-3e4$\Default           768                 0%
    Service-0x0-3e5 $\Default           768                 0%
    Service-0x0-10a75$\Default         768                 0%
    ------------------------------------------------------
    Total Desktop: (23840 KB - 7 desktops)
    Session ID:  0
    ============================================================
    ```

11. Decode the encrypted logon by doing the following:

    1. `"3e5$Service-0x0- 3e5 $\Default" -> 0x3e5 == 997`.
    2. Open **wbemtest** from the **Run** command in Windows.
    3. Connect to the `root\cimv2` namespace.
    4. Select **Query**, and then type `select * from win32_logonsession`.
    5. Double-click the entry that contains 997.
    6. Select **UUID** in the object editor, and then click **Associators** to show the actual logon name. Refer to the following screenshot:

        :::image type="content" source="media/sql-replication-agents-not-run/select-uuid-click-associators.png" alt-text="Screenshot of the steps to locate the actual logon name." :::

## Considerations if you use Remote Desktop Protocol

If you connect to the server by using the Remote Desktop Protocol (RDP), make sure that you create the console session by using the `/console` switch. If you don't use the `/console` switch, you can't see the desktop. This is because the account that starts the SQL Server Agent service is associated with session 0.

The Win32k.sys driver allocates 48 MB of buffer address space for the desktop heap. Make sure that you don't have many desktops that use up the whole 48 MB of buffer address space.

If the server isn't configured as a terminal server, all desktop heaps share the 48 MB of buffer address space. This limits the number of service processes that can run on the server.

If the server is configured as a terminal server, the Win32k.sys driver allocates 20 MB of buffer address space for the desktop heap. The Win32k.sys driver also allocates 16 MB of session space for its own paged pool.

## Differences between a terminal server and terminal services with regard to the desktop heap

A terminal server and terminal services are different. You install the Terminal Server component in **Add or Remove Programs**. After you install the Terminal Server component, the server becomes a terminal server. Terminal services are a service that exists in the Services Microsoft Management Console (MMC) snap-in. If you remove the Terminal Server component from the server, client computers can still connect to the server by using RDP. Therefore, consider removing the Terminal Server component to obtain the 48 MB of buffer address space for the desktop heap.

## How jobs in SQL Server affect the desktop heap

In SQL Server, you may have different jobs that run under different proxy accounts. For each proxy account, the noninteractive desktop heap for that proxy account will be allocated. For example, the third value of the
 SharedSection parameter is 512. If you use a proxy account to start a job, the 512-KB desktop heap will be allocated, even if the job itself uses only 10 KB of the desktop heap.

> [!NOTE]
> Other jobs that use the same proxy account will still use this desktop heap.

This may result in many desktops when the SQL Server Agent service is started. Therefore, the 48 MB of buffer address space may be used up. If you use the Desktop Heap Monitor tool to examine the use of the desk heap, you'll notice that one desktop corresponds to one proxy account that is used by a running job. We recommend that you use fewer proxy accounts to avoid reaching the 48-MB limit.

## References

For more information about the values of the `SharedSection` parameter, see [User32.dll or Kernel32.dll fails to initialize](/previous-versions/troubleshoot/windows/win32/user-32-kernel-32-not-initialize).
