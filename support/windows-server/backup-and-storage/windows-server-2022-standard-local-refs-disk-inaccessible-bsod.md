---
title: "Windows Server 2022 Standard: Local disk volume becomes inaccessible after ReFS.sys errors"
description: Fix an inaccessible local disk volume on Windows Server 2022 that's caused by ReFS.sys errors and driver conflicts with third-party backup or security software.
ms.date: 03/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, simonw, v-appelgatet
ai.usage: ai-assisted
ms.custom:
- sap:backup, recovery, disk, and storage\data corruption and disk errors
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Local disk volume is inaccessible after ReFS.sys errors in Windows Server 2022 Standard

## Summary

This article describes how to troubleshoot a corrupted or unmountable local disk on a standalone Windows Server 2022 Standard system that uses the Resilient File System (ReFS). The server experiences a series of stop errors, and then the local disk volume becomes inaccessible. The issue is caused by driver conflicts between Windows Server storage drivers and third-party security or backup software.

## Symptoms

While you run a standalone Windows Server 2022 Standard system that uses ReFS, you experience one or more of the following symptoms:

- Stop errors occur during normal operation.
- After you restart the computer, the local drive (for example, drive D) doesn't mount.
- You can't manually access or mount the local drive.
- The Disk Management tool displays the local drive as RAW.
- Uninstalling antivirus software doesn't resolve the instability.
- The local drive appears to be corrupted or damaged.
- Backup operations fail because the backup engine can't access the local drive.

## Cause

This issue occurs because of conflicts between Windows Server drivers for third-party security or backup software such as Veeam, ESET, or CrowdStrike. Typically, the driver or [driver altitude](/windows-hardware/drivers/ifs/load-order-groups-and-altitudes-for-minifilter-drivers#minifilter-altitudes) settings of the software are incorrect.

These conflicts can cause corruption of the ReFS file system. At that point, the volume dismounts or enters a RAW state.

## Resolution

To restore access to the affected drive and recover data, follow these steps:

1. To put the affected volume in read-only mode, open a Command Prompt window, and run the following commands, in sequence:

   ```console
   diskpart
   list volume
   select volume <VolumeID>
   attributes volume set readonly
   exit
   ```

   > [!NOTE]  
   > In these commands, \<VolumeID> represents the number or drive letter that identifies the volume.

1. Review and correct the [driver altitude settings](/windows-hardware/drivers/ifs/load-order-groups-and-altitudes-for-minifilter-drivers#minifilter-altitudes) of any installed security or backup software to make sure that they don't conflict with storage drivers.
1. If you can't resolve the conflicts, uninstall any conflicting security or backup tools.
1. Use the [ReFS salvage tool](/windows-server/administration/windows-commands/refsutil-salvage) (`refs-util`) to recover data from the volume, and then try to restore the volume to a healthy state.
1. Remount the volume.
1. Run `chkdsk` or `refs-util` to verify the integrity of the data on the volume.
1. To prevent future failures, verify that backup operations run correctly.

## Data collection

If the issue persists after you finish the resolution steps, collect the following data, and then contact [Microsoft Support](https://support.microsoft.com/contactus):

- The exact Windows Server 2022 Standard build version. To find this information, run `winver` at a command prompt.
- Details of installed security or backup software and driver versions.
- A list of recent changes or updates that were applied to the system.
- Event data that covers the period during which the stop errors occurred. You can export this information from Event Viewer.
- Output from the DiskPart tool that shows the current state of the affected volume.
- Results from ReFS salvage tool (`refs-util`) operations.
