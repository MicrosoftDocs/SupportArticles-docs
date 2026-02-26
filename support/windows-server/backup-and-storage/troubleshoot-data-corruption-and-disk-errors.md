---
title: Guidance for Troubleshooting Data Corruption and Disk Errors
description: Provides guidance to help troubleshoot data corruption and disk errors in Windows.
ms.date: 02/12/2026
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, simonw
ai.usage: ai-assisted
ms.custom:
- sap:backup,recovery,disk,and storage\data corruption and disk errors
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Data corruption and disk errors troubleshooting guidance

Disk, file system, and storage issues in Windows Server environments can cause inaccessible drives, file or folder corruption, unexpected drive state changes, and application or backup failures. If they're not resolved promptly, these issues can compromise data integrity, disrupt service availability, and cause downtime or data loss.

This article provides guidance to help you identify, diagnose, and repair data corruption and disk errors effectively.

## Prerequisites

- Before you perform any repairs or modify any disks, back up all critical data.
- Make sure that you have administrative permissions on the affected devices.
- Familiarize yourself with storage subsystem architecture and event log monitoring.
- Make sure that you use modern volume management tools. Avoid deprecated features, such as dynamic disks

> [!NOTE]
> This article discusses commands that you have to run at an administrative Windows command prompt or an administrative Windows PowerShell command prompt.

## Troubleshooting checklist

Use this checklist for systematic troubleshooting.

**Check drivers and firmware**

Make sure that the storage-related drivers and firmware are up to date. Consult your hardware vendor for the latest drivers and diagnostic tools, if it's necessary. This step includes drivers for components such as:

- iSCSI port
- RAID controller
- Host Bus Adapter (HBA)
- Device-specific module (DSM)
- Multipath I/O (MPIO)

**Scan the health of the storage system**

Run `chkdsk` in scan mode to look for potential storage system issues without making changes. Open a Windows Command Prompt window as an administrator, and then run the following command:

```
console chkdsk /scan
```

**Review the event log for relevant events**

The following event IDs indicate data corruption or a disk error:

- Event ID 55, `The file system structure on the disk is corrupt and unusable. Please run the chkdsk utility on the volume.`
- Event ID 98, `Volume C: (\Device\HarddiskVolume3) needs to be taken offline to perform a Full Chkdsk. Please run "CHKDSK /F" locally via the command line or run "REPAIR-VOLUME \<drive:>" locally or remotely via PowerShell.`
- Event ID 129, `Reset to device, \Device\RaidPort1, was issued.`
- Event ID 153, `The IO operation at logical block address 123456 for Disk 2 was retried.`
- Event ID 157, `Disk 2 has been surprise removed.`

**Scan and repair NTFS volumes**

> [!NOTE]  
> Resilient file system (ReFS) volumes can automatically fix corruption issues. You can still run `chkdsk` if you want to scan the volumes.

1. To get detailed information about a volume, run the following command at a Windows command prompt:

   ```console
   fsutil fsinfo ntfsinfo <RootPath>:
   ```

   > [!NOTE]
   > In this command, \<RootPath> represents the drive letter of the drive root.

1. To check whether the volume is dirty, run the following command at a Windows command prompt:

   ```console
   fsutil dirty query <VolumePath>:
   ```

   > [!NOTE]
   > In this command, \<VolumePath> represents the drive letter.

1. If the results of the previous step indicate that the volume is dirty, schedule a maintenance window for the volume. The disk isn't accessible during the repair process. During the maintenance window, run the following command at the Windows command prompt:

   ```console
   chkdsk /f /r
   ```

   > [!NOTE]  
   > If `chkdsk` doesn't fix the disk errors, consider reviewing the rest of the checklist to look for more issues. However, you have to restore the data from a backup.

**Advanced troubleshooting**

If errors persist, further test the system to isolate the issue. Follow these steps:

1. Uninstall any third-party disk management software, such as Diskeeper.
1. Remove or update filter drivers.
1. Switch to different types of drivers. For example, RAID controller drivers or monolithic drivers.
1. Check the multipath I/O configuration. For more information, see [Multipath I/O (MPIO) troubleshooting guidance](windows-server-mpio-troubleshooting.md).
1. To isolate an issue to specific hardware, remove individual disks from the cluster, and then test the system.

## Common issues and solutions

### Event ID 153: The IO operation at logical block address 123456 for Disk 2 was retried

Event ID 153 indicates that the storage subsystem is overloaded. This condition causes requests to time out. Event ID 153 is similar to Event ID 129. The events differ as follows:

- Event ID 153 is logged when the Storport miniport driver (sometimes known as an adapter or HBA driver) times out a request.
- Event ID 129 is logged when the Storport driver (*Storport.sys*) times out a request to the disk.

Because of the manner in which the Storport miniport driver and the Storport driver interact, Event ID 153 might not be accompanied by an error message.

To fix this issue, you have to relieve the overload. Follow these steps:

1. Determine how traffic is distributed in the system (for example, by examining Performance Monitor statistics).
1. Make sure that you have enough controllers to handle the system load. If you have multiple high-load drives that share a controller, consider splitting the drives among different controllers.
1. Check the controller configurations, especially any throttling configurations (such as for VMware Storage I/O Control).
1. If the system traffic doesn't flow as expected, check for the following issues:
   - iSCSI configuration issues, such as damaged cables, damaged network adapters, or network adapters that handle nonstorage traffic and storage traffic.
   - MPIO configuration issues, such as insufficient or incorrectly configured multipaths.
1. If the previous steps don't fix the timeout issue, contact your hardware vendor for information about your specific driver timeouts.

### Event ID 129: Reset to device, \Device\RaidPort1, was issued

Similar to Event ID 153, Event ID 129 indicates that the storage subsystem is overloaded. This condition causes requests to time out. Event ID 129 is logged when the Storport driver (*Storport.sys*) times out a request to the disk. The event information includes the name of the storage adapter (HBA) driver (also known as the miniport driver) that's associated with the affected Storport driver.

The following issues can cause this behavior:

- LUNs aren't responding.
- Hardware issues such as faulty SAN routers cause request drops.

To fix this issue, follow these steps:

1. Verify that the storage network is stable and the LUNs are responding.
1. If you need information about disk tuning, contact your storage vendor. Don't change the disk timeout values in the registry unless you have vendor guidance.

### Event ID 157: Disk 2 has been surprise removed

This event indicates that the *Classpnp.sys* driver received a surprise removal request from the plug and play (PNP) manager for a nonremovable disk.

This issue most often occurs when something disrupts communication between the system and a disk. For example, any of the following incidents can generate this event:

- A SAN fabric error
- A SCSI bus issue
- A disk failure
- A user unplugging a disk while the system is running

To fix this issue, follow these steps:

1. Verify that the disk subsystem is healthy.
1. Check the state of the disk hardware.
2. Check storage connections for disruptions.

### Event ID 55 and Event ID 98: Please run the chkdsk utility

NTFS events such as Event ID 55, 50, 140, and 98 indicate file system corruption and similar issues. The file system corruption occurs when one or more of the following issues occur:

- A disk has bad sectors.
- I/O requests that the file system sends to the disk subsystem aren't completed successfully.

> [!NOTE]  
> Because NTFS can't write data to the transaction log, this issue could affect the ability of NTFS to stop or roll back the operations in which the transaction data couldn't be written.

To fix these issues, follow these steps:

1. Open an administrative Windows Command Prompt window, and then run the following command:

   ```console
   chkdsk with /f /r
   ```

   This command repairs and recovers sectors.

1. Verify that the underlying hardware is working correctly.

1. Update the SCSI port or RAID controller drivers.

1. Remove or update filter drivers.

1. Update third-party storage drivers or firmware.

1. If the issue persists, try switching to different kinds of drivers. For example, RAID controller drivers or monolithic drivers, or try rearranging hardware into various combinations.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
