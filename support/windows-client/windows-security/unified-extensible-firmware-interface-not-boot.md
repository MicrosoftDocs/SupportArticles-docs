---
title: UEFI Mode System Can't Boot After Maintenance or Servicing Activity
description: Helps resolve the issue in which a UEFI mode system can't boot after maintenance or servicing activity.
ms.date: 08/06/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-lianna
ms.custom:
- sap:system performance\startup configuration (general,secure boot,uefi)
- pcy:WinComm Performance
---
# A UEFI mode system can't boot after maintenance or servicing activity

## Symptoms

A Unified Extensible Firmware Interface (UEFI) mode system that has a boot partition that is larger than 2 terabytes (TB) can't boot after maintenance or servicing activity. (For example, the system can't boot after the installation of a hotfix, defragmentation, or restoration from a backup.)

## Cause

The UEFI specification doesn't provide guidance on whether to use the traditional option ROM drivers or UEFI drivers in Class 2 UEFI mode. This has caused some UEFI implementations to prioritize traditional option ROM drivers over UEFI drivers in this mode. In some cases, these traditional-option ROM drivers support only 32-bit Logical Block Addressing (LBA) for accessing storage. This behavior limits how much storage they can access to 2 TB.

With the wider availability of storage devices that are larger than 2 TB, you can create a Windows boot partition that is larger than 2 TB. This poses a risk in the scenario described here, because a maintenance or servicing activity (for example, the installation of a hotfix, defragmentation, or restoration from a backup) can cause a boot-critical file to be moved beyond the 2-TB limit that is imposed by 32-bit LBA. Because the preboot environment can't access this file, Windows won't boot.

## Resolution

To reduce the effect of this issue, use one of the following options:

- OEMs can provide a fix for this issue through a firmware update, together with either 64-bit LBA support in traditional Option ROM drivers or prioritizing UEFI drivers when traditional Option ROM is loaded. Contact your OEM to check whether such an updated firmware exists.
- Some UEFI implementations provide a setting to select the drivers to use in this mode. An administrator can select UEFI drivers instead of traditional Option ROM drivers to access storage larger than 2 TB.
- The administrator can also reduce the size of the boot and OS partitions so that the last logical block address for both the boot and OS partitions is located below 2 TB. This configuration prevents boot-critical files from being accidentally relocated to an address above 2 TB, where the boot environment can't read them.

## More information

By policy, Windows requires UEFI firmware to boot the operating system. UEFI provides basic services such as access to the boot device in the preboot environment. Windows Server and earlier versions of Windows client don't require UEFI mode and can boot either from traditional BIOS or from UEFI if this is supported by firmware. To enable booting these operating systems on a computer that uses UEFI, Compatibility Support Module (CSM) in UEFI provides compatibility support for traditional BIOS. Earlier versions of Windows require INT 10H support for boot graphics. This is provided by CSM in UEFI mode. The CSM can also be used to fully support traditional BIOS mode on a system that has UEFI firmware. These modes are known as Class 2 UEFI mode and Class 2 BIOS mode.
