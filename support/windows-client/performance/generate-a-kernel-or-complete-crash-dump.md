---
title: Generate a kernel or complete crash dump
description: Learn how to generate a kernel or complete crash dump, and then use the output to troubleshoot several issues.
ms.date: 08/23/2022
ms.service: windows-client
ms.topic: troubleshooting
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
ms.collection: highpri
ms.subservice: performance
ms.custom: sap:blue-screen/bugcheck, csstroubleshoot
ms.reviewer: willchen
audience: itpro
localization_priority: medium
---
# Generate a kernel or complete crash dump

A system crash (also known as a "bug check" or a "Stop error") occurs when Windows can't run correctly. The dump file that is produced from this event is called a system crash dump.

A manual kernel or complete memory dump file is useful when you troubleshoot several issues because the process captures a record of system memory at the time of a crash.

_Applies to:_ &nbsp; Windows 10

## Set up page files

See [Support for system crash dumps](how-to-determine-the-appropriate-page-file-size-for-64-bit-versions-of-windows.md#support-for-system-crash-dumps) for the page file size requirement for system crash dump.

## Enable memory dump setting

You must be logged on as an administrator or a member of the Administrators group to complete this procedure. If your computer is connected to a network, network policy settings may prevent you from completing this procedure.

To enable memory dump setting, follow these steps:

1. In **Control Panel**, select **System and Security** > **System**.
2. Select **Advanced system settings**, and then select the **Advanced** tab.
3. In the **Startup and Recovery** area, select **Settings**.
4. Make sure that **Kernel memory dump** or **Complete memory dump** is selected under **Writing Debugging Information**.
5. Restart the computer.

> [!NOTE]
> You can change the dump file path by edit the **Dump file** field. In other words, you can change the path from *%SystemRoot%\\Memory.dmp* to point to a local drive that has enough disk space, such as *E:\\Memory.dmp*.

### Tips to generate memory dumps

When the computer crashes and restarts, the contents of physical RAM are written to the paging file that is located on the partition on which the operating system is installed.

Depending on the speed of the hard disk on which Windows is installed, dumping more than 2 gigabytes (GB) of memory may take a long time. Even in a best-case scenario, if the dump file is configured to reside on another local hard drive, a significant amount of data will be read and written to the hard disks. This read-and-write process can cause a prolonged server outage.

> [!NOTE]
> Use this method to generate complete memory dump files with caution. Ideally, you should do this only when you are explicitly requested to by the Microsoft Support engineer. Any kernel or complete memory dump file debugging should be the last resort after all standard troubleshooting methods have been completely exhausted.

## Manually generate a memory dump file

### Use the NotMyFault tool

If you can sign in while the problem is occurring, you can use the Microsoft Sysinternals NotMyFault tool by following these steps:

1. Download the [NotMyFault](https://download.sysinternals.com/files/NotMyFault.zip) tool.
2. Select **Start**, and then select **Command Prompt**.
3. At the command line, run the following command:

   ```console
   notMyfault.exe /crash
   ```

> [!NOTE]
> This operation generates a memory dump file and a D1 Stop error.

### Use NMI

On some computers, you can't use keyboard to generate a crash dump file. For example, Hewlett-Packard (HP) BladeSystem servers from the Hewlett-Packard Development Company are managed through a browser-based graphical user interface (GUI). A keyboard isn't attached to the HP BladeSystem server.

In these cases, you must generate a complete crash dump file or a kernel crash dump file by using the Non-Maskable Interrupt (NMI) switch that causes an NMI on the system processor.

To implement this process, follow these steps:

> [!IMPORTANT]  
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

> [!NOTE]
> This registry key isn't required for clients running Windows 8 and later, or servers running Windows Server 2012 and later. Setting this registry key on later versions of Windows has no effect.

1. In Registry Editor, locate the following registry subkey:

   `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl`
2. Right-click **CrashControl**, point to **New**, and then select **DWORD Value**.
3. Type *NMICrashDump*, and then press Enter.
4. Right-click **NMICrashDump**, and then select **Modify**.
5. In the **Value data** box, type *1*, and then select **OK**.
6. Restart the computer.
7. Hardware vendors, such as HP, IBM, and Dell, may provide an Automatic System Recovery (ASR) feature. You should disable this feature during troubleshooting. For example, if the HP and Compaq ASR feature is enabled in the BIOS, disable this feature while you troubleshoot to generate a complete Memory.dmp file. For the exact steps, contact your hardware vendor.
8. Enable the NMI switch in the BIOS or by using the Integrated Lights Out (iLO) Web interface.

   > [!NOTE]
   > For the exact steps, see the BIOS reference manual or contact your hardware vendor.

9. Test this method on the server by using the NMI switch to generate a dump file. You'll see a STOP 0x00000080 hardware malfunction.

If you want to run NMI in Microsoft Azure using Serial Console, see [Use Serial Console for SysRq and NMI calls](/azure/virtual-machines/linux/serial-console-nmi-sysrq).

### Use the keyboard

[Forcing a System Crash from the Keyboard](/windows-hardware/drivers/debugger/forcing-a-system-crash-from-the-keyboard)

### Use Debugger

[Forcing a System Crash from the Debugger](/windows-hardware/drivers/debugger/forcing-a-system-crash-from-the-debugger)
