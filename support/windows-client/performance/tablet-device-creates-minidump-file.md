---
title: Tablet device creates a minidump file
description: Provides a solution to an issue that prevents a complete memory dump from being written during a Stop error on a tablet device.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, steved, grahamm
ms.custom: sap:System Performance\System Reliability (crash, errors, bug check or Blue Screen, unexpected reboot), csstroubleshoot
---
# Tablet device that's running Windows 10 creates only a minidump file

This article provides a solution to an issue that prevents a complete memory dump from being written during a Stop error on a tablet device.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 3135462

## Symptoms

On a tablet device that's running Windows 10 and that uses SD eMMC memory, Windows produces only a minidump file, even if **Kernel memory dump** or **Complete memory dump** is configured under **Advanced System Settings** > **Startup and Recovery**. The minidump file is saved to the %systemroot%\minidump directory instead of to the standard C:\windows\minidump location.

## Cause

Because of aggressive power management on SD eMMC devices, Windows always creates a minidump and ignores the memory dump settings that are configured by the administrator. To override this default Windows behavior, special registry settings must be configured.

## Resolution

To override the Windows eMMC power-saving feature during a BugCheck (also known as a Stop error or a blue-screen error) to produce a kernel memory dump or a complete memory dump, follow these steps:

1. Under **Advanced System Settings** > **Startup and Recovery**, the **Write debugging information** option must be set to **Kernel memory dump** or **Complete memory dump**.
2. Use Registry Editor to create and configure the following registry key to 0x1 (REG_DWORD) (this permits the dump file to be written):

    `HKLM\SYSTEM\CurrentControlSet\services\sdbus\Parameters\ ForceF0State`
3. Use Registry Editor to create and configure the following registry key. (This makes sure that the dump file isn't deleted upon reboot, even if you're running low on free disk space.)

    - Path: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl`
    - Value name: AlwaysKeepMemoryDump
    - Value type: REG_DWORD
    - Value data: 1
4. Make sure that the maximum page file size is larger than the amount of RAM that's being used on the computer. Check this under **Advanced System Settings** > **Performance Option Settings** > **Advanced**. The virtual memory **paging file size** setting on the system drive must be larger than the amount of RAM that's being used.
5. Restart the computer.
