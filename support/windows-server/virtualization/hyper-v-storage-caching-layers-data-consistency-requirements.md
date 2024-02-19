---
title: Hyper-V storage caching layers and implications for data consistency
description: Describes the various levels of caching in the storage stack, virtualized or otherwise, that have implications for data consistency.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:configuration-of-virtual-machine-settings, csstroubleshoot
---
# Hyper-V storage: Caching layers and implications for data consistency

This article provides an overview of caching in the virtual storage stack and gives guidance to software developers and administrators to make sure that desired data consistency requirements are met.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2801713

## More information

At the very least, the various layers of caching in the system generally involve the following:

- Filesystem cache. By default, Windows caches file data that is read from disks and written to disks. This implies that read operations read file data from an area in system memory that is known as the system file cache instead of from the physical disk. Correspondingly, write operations write file data to the system file cache instead of to the disk, and this kind of cache is known as a writeback cache.
Applications can use filesystem unbuffered semantics to make sure that writes aren't cached in the system cache.
- Disk drives cache. Disk drives implement caching at the firmware layer to improve the disk drives' performance. Although caching at the firmware layer can improve performance, the data on the disk can be lost before it's written to the disk in the event of a power failure. Options to control this caching behavior are part of standardized drive interfaces such as SCSI, SATA, and ATA. These options are as follows:
    1. Use the per I/O control mechanism that is known as Force Unit Access (FUA). This flag specifies that the drive should write the data to stable media storage before signaling is finished. Applications that have to do this make sure that data is stable on the disk issue FUA to make sure that data isn't lost if a power failure occurs.

        Server-class disk drives (SCSI and Fibre Channel) generally support the FUA flag. On commodity drives (ATA, SATA, and USB), FUA might not be honored. This can potentially leave data in an inconsistent state unless the drive's write cache is disabled. Make sure that the disk subsystem handles FUA correctly if you depend on this mechanism.
    2. Force disk cache flushing. An application or system that sends a flush down to the disk will force the disk subsystem to write all the data in its cache to the disk. Issuing flushes too frequently will have performance consequences because all the information in the disk cache will have to be written to the disk media before the flush returns.
    3. Disable disk caching. You can disable a disk's write caching by issuing the IOCTL_DISK_SET_CACHE_INFORMATION control code to the disk. The state of the write cache (on or off) will be preserved across system restarts. Issuing this control code will have very significant performance consequences for all I/O mechanisms that are issued to that disk. These consequences will most likely include a noticeable decrease in performance. You should carefully consider using this control code before you deploy it.

        > [!NOTE]
        > If you cannot disable disk caching, you should consider options 1 and 2.

Therefore, if the application or workload is running inside the virtual machine (VM), the various caching layers have data consistency implications.

- Guest filesystem cache. This layer can be bypassed by using the filesystem unbufferred semantics, as was mentioned earlier.
- Guest virtual disk cache. The virtualized IDE (emulated or synthetic) or SCSI device will report the write cache state that is returned by the lower stack. Virtual disks will report that their write cache is enabled, and they refuse to let the guest turn off the write cache. Disabling the cache will fail and will always respond that the cache is enabled. This behavior is necessary for the following reasons:
  - Hyper-V can't make an assumption that all the VMs that are running on the same disk will have to have the disk cache settings be the same.
  - The underlying storage might have an always-on write cache that can't be turned off. This is emphasized by the fact that the virtual disk might be migrated to a different disk on the same host (live storage migration) or to a different host (live migration).

    Because applications won't be able to turn off disk cache, any application in the guest that has to make sure of data integrity across a power failure will have to use either option 1 or option 2 to make sure that writes bypass the disk cache.

- Host filesystem cache. The Hyper-V storage stack also uses unbufferred writes to make sure that the writes from the guest bypass the underlying host filesystem stack.
- Host disk cache. FUA, if set by the guest, is propagated to the host and to the host storage stack. The host physical disk system must satisfy at least one of the following criteria to make sure of virtualized workload data integrity through power faults:
  - The system uses server-class disks (SCSI, Fibre Channel).
  - The system makes sure that the disks are connected to a battery-backed caching host bus adapter (HBA).
  - The system uses a storage controller (for example, a RAID system) as the storage device.
  - The system makes sure that power to the disk is protected by an uninterruptible power supply (UPS).
  - The system makes sure that the disk's write-caching feature is disabled.
