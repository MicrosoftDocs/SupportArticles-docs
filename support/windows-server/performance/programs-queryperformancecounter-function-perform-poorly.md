---
title: Programs that use the QueryPerformanceCounter function may perform poorly
description: Describes a problem that occurs on 32-bit computers and x64-based computers that have the AMD Cool'n'Quiet technology enabled in the BIOS. Provides a resolution.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika,joscon
ms.custom: sap:performance-monitoring-tools, csstroubleshoot
---
# Programs that use the QueryPerformanceCounter function may perform poorly

This article provides a resolution to an issue that occurs on 32-bit computers and x64-based computers that have the AMD Cool'n'Quiet technology enabled in the BIOS.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions  
_Original KB number:_ &nbsp; 895980

## Symptoms

In the following operating systems:

- Windows Server 2000
- Windows XP
- Windows Server 2003
- Windows Server 2000 guest O.S.
- Windows XP guest O.S.
- Windows Server 2003 guest O.S.

A program that uses the `QueryPerformanceCounter` function to query system time may perform poorly.

For example:

When you use the ping command to send Internet Control Message Protocol (ICMP) packets to a remote computer, the reply may show negative response times. For example, the following ping command may generate the following replies:

```console
C:\>ping x.x.x.x
```

Output:

> Pinging x.x.x.x with 32 bytes of data:
>
> Reply from x.x.x.x: bytes=32 time=-59ms TTL=128  
Reply from x.x.x.x: bytes=32 time=-59ms TTL=128  
Reply from x.x.x.x: bytes=32 time=-59ms TTL=128  
Reply from x.x.x.x: bytes=32 time=-59ms TTL=128

Also, if you use performance counters for Logical Disk or Physical Disk might incorrectly show a high latency value.

> [!NOTE]
> This issue occurs on a computer that is running an x86-based version of Windows or an x64-based version of Windows.

## Cause

This problem occurs when the computer has the AMD Cool'n'Quiet technology (AMD dual cores) enabled in the BIOS or some Intel multi-core processors. Multi-core or multiprocessor systems may encounter Time Stamp Counter (TSC) drift when the time between different cores is not synchronized. The operating systems that use TSC as a timekeeping resource may experience the issue.

## Resolution

To resolve this problem, check with the hardware vendor to see if a new driver/firmware update is available to fix the issue.

> [!NOTE]
> The driver installation may add the /usepmtimer switch in the Boot.ini file. This switch is discussed in the "Workaround" section.

## Workaround

To work around this problem, update the BIOS on the computer. Or, modify the Boot.ini file to use the /usepmtimer switch. To do this, follow these steps:

1. Log on to the computer by using an account that has administrative credentials.
2. Click **Start**, click **Run**, type `notepad c:\boot.ini`, and then click **OK**.
3. In the Boot.ini file, a line that starts with "default" is located in the "[boot loader]" section. This line specifies the location of the default operating system. The line may appear as follows:

    ```ini  
    default=multi(0)disk(0)rdisk(0)partition(2)\WINDOWS
    ```

    In the "[operating systems]" section, locate the line for the operating system that corresponds to the "default" line. For example, if the computer is running Microsoft Windows Server 2003, Enterprise x64 Edition, the line should resemble the following:

    ```ini  
    multi(0)disk(0)rdisk(0)partition(2)\WINDOWS="Windows Server 2003 Enterprise x64 Edition" /fastdetect /NoExecute=OptIn
    ```

4. At the end of the line, add a space, and then type /usepmtimer. The line should now resemble the following.

    ```ini  
    multi(0)disk(0)rdisk(0)partition(2)\WINDOWS="Windows Server 2003 Enterprise x64 Edition" /fastdetect /NoExecute=OptIn /usepmtimer
    ```

5. Save the file, and then exit Notepad.
6. Restart the computer.
  
The following is a sample Boot.ini file for a system that contains the /usepmtimer switch.

```ini  
[boot loader]  
timeout=0  
default=multi(0)disk(0)rdisk(0)partition(2)\\WINDOWS  
[operating systems]  
multi(0)disk(0)rdisk(0)partition(2)\WINDOWS="Windows Server 2003 Enterprise x64 Edition" /fastdetect /NoExecute=OptIn /usepmtimer
```

> [!NOTE]
> The Boot.ini file is located in the root folder of the system drive.  
Using the /UsePmTimer setting may introduce a decrease in performance.

## Technical support for x64-based versions of Microsoft Windows

If your hardware came with a Windows x64 edition already installed, your hardware manufacturer provides technical support and assistance for the Windows x64 edition. In this case, your hardware manufacturer provides support because a Windows x64 edition was included with your hardware. Your hardware manufacturer might have customized the Windows x64 edition installation by using unique components. Unique components might include specific device drivers or might include optional settings to maximize the performance of the hardware. Microsoft will provide reasonable-effort assistance if you need technical help with a Windows x64 edition. However, you might have to contact your manufacturer directly. Your manufacturer is best qualified to support the software that your manufacturer installed on the hardware. If you purchased a Windows x64 edition such as a Microsoft Windows Server 2003 x64 edition separately, contact Microsoft for technical support.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
