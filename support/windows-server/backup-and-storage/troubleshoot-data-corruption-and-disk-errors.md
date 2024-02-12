---
title: Guidance for troubleshooting data corruption and disk errors
description: Provides guidance to help troubleshoot data corruption and disk errors in Windows.
ms.date: 05/10/2022
author: kaushika-msft
ms.author: kaushika
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:data-corruption-and-disk-errors, csstroubleshoot
---
# Data corruption and disk errors troubleshooting guidance

Data corruption and disk errors cover different areas such as issues about accessing a drive, drive corruption, and slow performance.

The following Event IDs indicate that there's data corruption or a disk error:

- Event ID 153

   > The IO operation at logical block address 123456 for Disk 2 was retried.

- Event ID 129

   > Reset to device, \Device\RaidPort1, was issued.

- Event ID 157

   > Disk 2 has been surprise removed.

- Event ID 55

   > The file system structure on the disk is corrupt and unusable. Please run the chkdsk utility on the volume.

- Event ID 98

   > Volume C: (\Device\HarddiskVolume3) needs to be taken offline to perform a Full Chkdsk. Please run "CHKDSK /F" locally via the command line or run "REPAIR-VOLUME \<drive:>" locally or remotely via PowerShell.

## Troubleshooting checklist

> [!NOTE]
> This article describes commands that need to be run at an elevated command prompt.

- In the System event log, search for New Technology File System (NTFS) and disk-related warnings and errors. For example, Event ID 55, 153, or 98.

- Run the `chkdsk /scan` command and check the result.

   > [!NOTE]
   > The `chkdsk /scan` command is read-only.

- Query a drive for NTFS-specific volume information by running the following command:

   `fsutil fsinfo ntfsinfo <rootpath>:`

   > [!NOTE]
   > The placeholder \<rootpath> represents the drive letter of the root drive.

- Run the `fsutil dirty query <volumepath>:` command to check if the volume is dirty.

   > [!NOTE]
   > The placeholder \<volumepath> represents the drive letter.

  - For a volume whose file system is NTFS, run the `chkdsk /f /r` command if the volume is dirty. The `chkdsk /F /R` command needs downtime because the disk won't be accessible.

  - For a volume whose file system is Resilient File System (ReFS), the disk corruption will be repaired automatically.

- If the "chkdsk" utility doesn't fix the disk errors, perform a restore from a backup.

- Run a storage validation to check if there are any storage-related errors.

- Remove the disks from the cluster and check the operating system level.

- Run the `chkdsk /f` command on all volumes that the event is logged for.

- Update third-party storage drivers or firmware.

If the issue persists, try the following methods:

- Uninstall any third-party disk managing software (for example, Diskeeper).

- Remove or update filter drivers.

- Contact the hardware vendor and run hardware diagnostics to avoid the possibility of any hardware issues.

- Get in touch with the storage vendor to check the multipathing configuration.

- Update the SCSI port or the RAID controller drivers.

- Switching to different types of drivers. For example, RAID controller drivers or monolithic drivers.

- Update the Host Bud Adapter (HBA) drivers.

- Update the multipathing drivers of device-specific modules (DSM).

- Update the HBA firmware.

## Troubleshooting Event ID 153

Event ID 153 indicates that there's an error with the storage subsystem. Event ID 153 is similar to Event ID 129, but the difference is that Event ID 129 is logged when the Storport driver times out a request to the disk, and Event ID 153 is logged when the Storport miniport driver times out a request. The miniport driver may also be referred to as an adapter driver or HBA driver, which is typically written by the hardware vendor.

If Event ID 153 or Event ID 129 is logged, disk I/O timeout is the common cause because the storage controller can't handle the load. In this case, the I/O operation times out, and the miniport driver (from a vendor) sends back the messages to the Storport driver (the last Microsoft storage driver in the stack). Then, the Storport driver translates the information and logs the event in the Event Viewer.

Because the miniport driver has sufficient knowledge of the request execution environment, some miniport drivers time the request themselves instead of letting the Storport driver handle request timing. The miniport driver can abort an individual request and return an error, whereas the Storport driver resets the drive after a timeout. Resetting the drive is disruptive to the I/O subsystem and may not be necessary if only one request has timed out. The miniport driver returns the error to the class driver that logs Event ID 153 and retries the request.

Here's an example of Event ID 153:

```output
Log Name: System
Source: disk
Event ID: 153
Level: Warning
Description: The IO operation at logical block address 123456 for Disk 2 was retried.
```

This event indicates that a request failed and was retried by the class driver. No error message was logged in this situation because the Storport driver didn't time out the request. The lack of messages resulted in confusion when troubleshooting disk errors because there was no evidence of the error.

On the **Details** tab of the event log, the detailed information shows the error that caused the retry and whether the request was a Read or Write request. For example:

```output
0000: 0004010F 002C0003 00000000 80040099
0010: 00000000 00000000 00000000 00000000
0020: 00000000 00000000 28090000

in bytes

0000: 0F 01 04 00 03 00 2C 00 ......,.
0008: 00 00 00 00 99 00 04 80 ......
0010: 00 00 00 00 00 00 00 00 ........
0018: 00 00 00 00 00 00 00 00 ........
0020: 00 00 00 00 00 00 00 00 ........
0028: 00 00 09 28             ...*
```

In this example, the byte offset `29` shows the SCSI status, the byte offset `30` shows the SCSI request block (SRB) status that caused the retry, and the byte offset `31` shows the SCSI command that is being retried. In this case, the SCSI status is `00` (`SCSISTAT_GOOD`), the SRB status is `09` (`SRB_STATUS_TIMEOUT`), and the SCSI command is `28` (`SCSIOP_READ`).

Here are the most common SCSI commands:

```output
SCSIOP_READ - 0x28
SCSIOP_WRITE - 0x2A
```

See [scsi.h](/windows-hardware/drivers/ddi/scsi/) for a list of SCSI operations and statuses.

Here are the most common SRB statuses:

```output
SRB_STATUS_TIMEOUT - 0x09
SRB_STATUS_BUS_RESET - 0x0E
SRB_STATUS_COMMAND_TIMEOUT - 0x0B
```

See [srb.h](/windows-hardware/drivers/ddi/srb/ns-srb-_scsi_request_block) for a list of SRB statuses.

> [!NOTE]
>
> - The timeout errors (`SRB_STATUS_TIMEOUT` or `SRB_STATUS_COMMAND_TIMEOUT`) indicate that a request is timed out in the adapter. A request was sent to the drive, and there was no response within the timeout period.
>
> - The bus reset error (`SRB_STATUS_BUS_RESET`) indicates that the device was reset and the request is being retried because of the reset since all incomplete requests are aborted when a drive receives a reset.

An administrator needs to verify the health of the disk subsystem. Although an occasional timeout may be part of the normal operation of a system, the frequent retry requests indicate a performance issue with storage that should be fixed.

### More information

Because the issue is normally outside the operating system, check the following common causes:

- Some type of throttling is configured, such as I/O limitations. Sometimes, Storage I/O Control in VMware causes this issue.

- Too many drives with a high load are on the same storage controller. Therefore the drives need to be split among different controllers.

- If Multipath I/O (MPIO) is configured, a single cable or a damaged NIC can cause issues with iSCSI.

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
