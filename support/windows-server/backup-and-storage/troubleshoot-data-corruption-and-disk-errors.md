---
title: Guidance for troubleshooting data corruption and disk errors
description: Provides guidance to help troubleshoot data corruption and disk errors in Windows.
ms.date: 01/15/2025
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:backup,recovery,disk,and storage\data corruption and disk errors
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Data corruption and disk errors troubleshooting guidance

Disk, file system, and storage issues in Windows Server environments can cause inaccessible drives, file or folder corruption, unexpected drive state changes, and application or backup failures. If not resolved promptly, these issues can compromise data integrity, disrupt service availability, and lead to downtime or data loss.

This article provides guidance to help you identify, diagnose, and repair data corruption and disk errors effectively.

## Prerequisites

- Before you perform any repairs or modify any disks, back up all critical data.
- Make sure that you have administrative permissions on the affected devices.
- Familiarize yourself with storage subsystem architecture and event log monitoring.
- Make sure that you use modern volume management tools. Avoid deprecated features such as dynamic disks

> [!NOTE]
> This article describes commands you have to run at an administrative Windows command prompt or an administrative Windows PowerShell command prompt.

## Troubleshooting checklist

Use this checklist for systematic troubleshooting.

**Check drivers and firmware**

Make sure that the storage-related drivers and firmware are up to date. Consult your hardware vendor for the latest drivers and diagnostic tools, if necessary. This step includes drivers foe components such as:

- SCSI port
- RAID controller
- Host Bus Adapter (HBA)
- Device-specific module (DSM)
- Multipath I/O (MPIO)

**Scan the health of the storage system**

Use `chkdsk` in scan mode to look for potential storage system issues without making changes. Open a Windows Command Prompt window as an administrator, and then run the following command:

```
console chkdsk /scan
```

**Review the event log for relevant events**

The following Event IDs indicate that there's data corruption or a disk error:

- Event ID 55, `The file system structure on the disk is corrupt and unusable. Please run the chkdsk utility on the volume.`
- Event ID 98, `Volume C: (\Device\HarddiskVolume3) needs to be taken offline to perform a Full Chkdsk. Please run "CHKDSK /F" locally via the command line or run "REPAIR-VOLUME \<drive:>" locally or remotely via PowerShell.`
- Event ID 129, `Reset to device, \Device\RaidPort1, was issued.`
- Event ID 153, `The IO operation at logical block address 123456 for Disk 2 was retried.`
- Event ID 157, `Disk 2 has been surprise removed.`

**Scan and repair NTFS volumes**

> [!NOTE]  
> Resilient file system (ReFS) volumes can automatically fix corruption issues. You can still run `chkdsk` to scan them.

1. To get detailed information about a volume, run the following command at a Windows command prompt:

   ```console
   fsutil fsinfo ntfsinfo <RootPath>:
   ```

   > [!NOTE]
   > In this command, \<RootPath> represents the drive letter of the drive root.

1. To verify if the volume is dirty, run the following command at a Windows command prompt:

   ```console
   fsutil dirty query <VolumePath>:
   ```

   > [!NOTE]
   > In this command, \<VolumePath> represents the drive letter.

1. If the result of the previous step indicates that the volume is dirty, schedule a maintenance window for the volume. The disk isn't accessible during the repair process. During the maintenance window, run the following command at the Windows command prompt:

   ```console
   chkdsk /f /r
   ```

   > [!NOTE]  
   > If `chkdsk` doesn't fix the disk errors, consider reviewing the rest of the checklist to look for more issues. However, you have to restore the data from a backup.

**Advanced troubleshooting**

If errors persist, follow these steps to further test the system and isolate the issue:

1. Uninstall any third-party disk management software, such as Diskeeper.
1. Remove or update filter drivers.
1. Switch to different types of drivers. For example, RAID controller drivers or monolithic drivers.
1. Check the multipath I/O configuration. For more information, see [Multipath I/O (MPIO) troubleshooting guidance](windows-server-mpio-troubleshooting.md).
1. To isolate an issue to specific hardware, remove individual disks from the cluster and then test the system.

## Common issues and solutions

### Event ID 153: The IO operation at logical block address 123456 for Disk 2 was retried

Event ID 153 indicates that the storage subsystem is overloaded, which is causing requests to time out. Event ID 153 is similar to Event ID 129, but the difference is that Event ID 153 is logged when the Storport miniport driver (sometimes known as an adapter or HBA driver) times out a request, while Event ID 129 is logged when the Storport driver times out a request to the disk. Because of the way the Storport miniport driver an the Storport driver interact, Event ID 153 might not be accompanied by an error.

To fix this issue, you have to relieve the overload. Follow these steps:

1. Determine how traffic is distributed in the system (for example, by examining Performance Monitor statistics).
1. Make sure that you have enough controllers to handle the system load. If you have multiple high-load drives that share a controller, consider splitting the drives among different controllers.
1. Check the controller configurations, especially any throttling configurations (such as for VMware Storage I/O Control).
1. If the system traffic doesn't flow as expected, check for the following issues:
   - iSCSI configuration issues, such as damaged cables, damaged network adapters, or network adapters that handle non-storage traffic as well as storage traffic.
   - MPIO configuration issues, such as insufficient or incorrectly configured multipaths.
1. If the previous steps can't fix the timeout issue, contact your hardware vendor for information about you specific driver timeouts.


## Troubleshooting Event ID 129

Event ID 129 is logged with the storage adapter (HBA) driver's name as the source. The Storport driver (*Storport.sys*) logs this event when it detects that a request is timed out. The HBA driver's name is used in the event because it's the miniport driver that is associated with the Storport driver.

Here's an example of Event ID 129:

```output
Event Type:       Warning
Event Source:     <HBA_Name>
Event Category:   None
Event ID:         129
Computer:         <Computer_Name>
Description: Reset to device, \Device\RaidPort1, was issued.
```

### Information about Windows I/O stack architecture

Windows I/O operation uses a layered architecture where device drivers are on a device stack. In a basic model, the top of the stack is the file system. The next is the volume manager, followed by the disk driver. The port and miniport drivers are at the bottom of the device stack. When an I/O request reaches the file system, it takes the block number of the file and translates it to an offset in the volume. Then, the volume manager translates the volume offset to a block number on the disk and passes the request to the disk driver. When the request reaches the disk driver, it will create a command descriptor block (CDB) and send it to the SCSI device. The disk driver embeds the CDB into the SCSI_REQUEST_BLOCK (SRB) structure. This SRB is sent to the port driver as part of the I/O request packet (IRP).

The port driver does most of the request processing. There are different port drivers depending on the architecture. For example, the ATA port driver (*Ataport.sys*) and the SCSI port driver (*Storport.sys*). Here are some responsibilities of a port driver:

- Providing timing services for requests

- Enforcing queue depth to make sure that a device doesn't have more requests than it can handle

- Building "scatter" and "gather" arrays for data buffers

The port driver interfaces with the miniport driver, and the miniport driver is designed by the hardware vendor to work with a specific adapter. It's responsible for taking requests from the port driver and sending them to the target logical unit number (LUN). The port driver calls the `HwStorStartIo()` function to send requests to the miniport driver, and the miniport driver will send the requests to the HBA driver so that they can be sent over the physical medium (Fibre or Ethernet) to the LUN. When the request is completed, the miniport driver will call the `StorPortNotification()` function with the `NotificationType` parameter with a value set to `RequestComplete`, along with a pointer to the completed SRB.

When a request is sent to the miniport driver, the Storport driver will put the request in a pending queue, and it's timed. When the request is completed, it's removed from this queue.

The timing mechanism is simple. There's one timer per logical unit, and it's initialized to `-1`. When the first request is sent to the miniport driver, the timer is set to the timeout value in the SRB. The disk timeout value is a tunable parameter that's located under the following registry key:

`HKLM\System\CurrentControlSet\Services\Disk\TimeOutValue`

Some hardware vendors will tune this value to best match their hardware. Don't change this value without guidance from your storage vendor.

The timer is decremented once per second. When a request is completed, the timer is refreshed with the timeout value of the head request in the pending queue. Therefore, the timer will never go to zero as long as requests complete. If the timer goes to zero, it means that the device has stopped responding. For example, when the Storport driver logs Event ID 129, the Storport driver has to take corrective action by trying to reset the unit. When the unit is reset, all incomplete requests are completed with an error, and they're retried. When the pending queue is cleared, the timer is set to `-1`, which is the initial value.

Each SRB has a timer value set. When requests are completed, the queue timer is refreshed with the timeout value of the SRB at the head of the list.

The most common causes of Event ID 129 are unresponsive LUNs or a dropped request. Dropped requests can be caused by faulty routers or other hardware problems on the storage area network (SAN).

## Troubleshooting Event ID 157

This event indicates that the *Classpnp.sys* driver has received a surprise removal request from the plug and play manager (PNP) for a non-removable disk.

This issue most often occurs when something disrupts the system's communication with a disk, such as a SAN fabric error or a SCSI bus problem. The errors can also be caused by a disk that fails or when a user unplugs a disk while the system is running. In this case, an administrator needs to verify the heath of the disk subsystem.

## Troubleshooting Event ID 55 and 98

If NTFS events such as Event ID 55, 50, 140, and 98 are logged, you need to run the "chkdsk" utility.

Because NTFS couldn't write data to the transaction log, this could affect the ability of NTFS to stop or roll back the operations in which the transaction data couldn't be written.

Here's an example of Event ID 55:

```output
Event Type: Error
Event Source: NTFS
Event ID: 55
Description: The file system structure on the disk is corrupt and unusable. Please run the chkdsk utility on the volume.
```

Usually, Event ID 55 is logged when file system corruption occurs. The file system corruption occurs when one or more of the following issues occur:

- A disk has bad sectors.

- I/O requests that are delivered by the file system to the disk subsystem aren't completed successfully.

Most issues are hardware-related, and hardware may be corrupted unexpectedly. You can try the following methods to fix the issues:

- Update the SCSI port or the RAID controller drivers.

- Remove or update filter drivers.

- Update third-party storage drivers or firmware.

- Switching to different types of drivers. For example, RAID controller drivers or monolithic drivers.

- Rearrange hardware into various combinations.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
