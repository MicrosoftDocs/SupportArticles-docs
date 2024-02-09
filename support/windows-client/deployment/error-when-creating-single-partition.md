---
title: Error when creating a single partition
description: Provides a solution to an error that occurs when you install Windows to a drive greater than 2.2 TB.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:setup, csstroubleshoot
---
# Error 0x80042468 when creating a single partition on a drive greater than 2.2 TB during install of Windows

This article provides a solution to an error that occurs when you install Windows to a drive greater than 2.2 TB.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2604034

## Symptoms

When installing Windows to a drive greater than 2.2TB, you receive Error 0x80042468.
This will occur if you install Windows 7 and manually try to create one partition using "Advanced Drive Options" during setup.

:::image type="content" source="media/error-when-creating-single-partition/error-when-installing-windows.png" alt-text="Screenshot of error 0x80042468: Failed to create a new partition on the selected unused space." border="false":::

## Cause

It's by design with Windows 7 x86 and with Windows 7 x64 on a non-UEFI system.

> [!NOTE]
> The check for UEFI (Unified Extensible Firmware Interface) and GUID Partition Table (GPT) isn't done during Setup in Advanced Format like it's done in Disk Management.

## Resolution

Install will complete but you won't be able to access the drive beyond 2.2 TB.

If you install Windows 7 x64 on a system that supports UEFI, you can partition the drive to use GUID Partition Table (GPT) and access all of the drive if the system is in UEFI mode.

> [!IMPORTANT]
> The disk that you select can't contain any data. Back up the data, or move your data to another volume before doing operations in diskpart.

To Boot a UEFI enabled system, the disk type should be changed to GPT using convert gpt command. Follow steps as below.

1. Press Shift+F10, which brings a command window. At command prompt, run the Diskpart.exe (It starts the diskpart console. After the console is initialized, DISKPART> is displayed. The diskpart console is now ready for input commands.)

2. Under diskpart> prompt type "list disk". (Locate the disk, in this case disk 0)
3. Type **Select disk 0** (It selects the disk that you want to convert to GPT.)
4. Type **Convert GPT** (This command will convert drive to GPT.)

    :::image type="content" source="media/error-when-creating-single-partition/type-convert-gpt-command.png" alt-text="Screenshot of the output of convert gpt command." border="false":::

5. Just to make sure everything went fine type **list disk**. The converted disk should now have an asterix in the GPT column. (See example image below)

    :::image type="content" source="media/error-when-creating-single-partition/type-list-disk.png" alt-text="Screenshot of the output of list disk command." border="false":::

6. Type exit and exit again. It should close the command window.

Select the disk you have converted and that should display as **Unallocated Space**.

The installation process should start and continue as usual. After reboot, the Windows 7 x64 should be installed on the GPT partitioned disk.

## More information

Windows doesn't support booting of GPT initialized volumes with UEFI systems on 32-bit versions of Windows, and that legacy BIOS (Basic Input/Output System) systems don't support booting of GPT partitioned volumes. Consult with your system vendor to determine if the system supports UEFI and booting of devices greater than 2 TB.

For details on Windows support for large drives, see the following articles:

- [Windows support for hard disks that are larger than 2 TB](../../windows-server/backup-and-storage/support-for-hard-disks-exceeding-2-tb.md)
- [How to establish and boot to GPT mirrors on 64-bit Windows](https://support.microsoft.com/help/814070)
- [Configure UEFI/GPT-Based Hard Drive Partitions](/previous-versions/windows/it-pro/windows-8.1-and-8/hh824839(v=win.10))

- [Using GPT Drives](/previous-versions/windows/hardware/design/dn653580(v=vs.85))

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
