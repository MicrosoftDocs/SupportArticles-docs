---
title: Support for booting from SAN
description: Describes the supportability of having a Windows server boot from a Storage Area Network (SAN).
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:no-boot-not-bugchecks, csstroubleshoot
---
# Support for booting from a Storage Area Network (SAN)

This article describes the supportability of having a Windows server boot from a Storage Area Network (SAN).

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows Server 2008 R2 Service Pack 1,  Windows 10 - all editions  
_Original KB number:_ &nbsp; 305547

## More information

Microsoft supports booting from a Storage Area Network (SAN) if the SAN vendor supports their particular hardware platform booting a Windows server. The SAN and host bus adapter (HBA) must be configured according to the SAN vendor's guidelines and the SAN vendor *must* act as the main point of contact for boot-related issues. This requirement exists because booting from a SAN is complex, and the vendor needs to support the particular configuration because the SAN vendor provides the SAN boot supportability statement. It is important to note that the information that is included in this article is not intended to be an all-inclusive list of the items that are required to boot from a SAN. The SAN vendor must provide specific steps, drivers, firmware revisions, and resources about how to make their hardware (storage systems, switches, Host Bus Adapters, and so on) work properly together.

### Configuration

The following issues must be addressed so multiple computers can successfully boot from a SAN:

- To boot multiple computers from a SAN, the SAN must either be configured in a switched environment, or it must be directly attached from each host to one of the storage subsystem's Fibre Channel ports. The use of Fiber Channel - Arbitrated Loop (FC-AL) is not supported when booting multiple servers from the SAN because it does not allow the hosts that are attached to the SAN to be properly segregated from each other. A switched environment allows the hosts to be separate from each other. Booting to a SAN with a Fiber Channel-Arbitrated Loop topology is only supported when booting a single server from the SAN.

- The host must have exclusive access to the disk that it is booting from. No other host on the SAN should be able to detect or have access to the same logical disk. This can be accomplished by using a type of Logical Unit Number (LUN) management such as LUN masking, zoning, or some combination of these methods. LUN management is normally configured at the switch, storage subsystem and/or Host Bus Adapter (HBA) level and not within Windows. Windows provide no capabilities for mapping LUNs.

- Multi-path software and multiple HBAs improve your chances of recovery from a path failure. The purpose of having multiple HBAs in a single host is to have redundancy and (possibly) increased throughput. However, if a failure occurs and a path to the SAN is lost, there may be a period of time where the drives on the SAN are not accessible. This path failure may cause problems with the Windows server. Behavior of multi-path software varies greatly between vendors. Check the Windows Catalog (formerly Hardware Compatibility List or HCL) for Storage/RAID systems to make sure that the multi-path driver is in the Windows Catalog with the storage system. If you cannot find the multi-path software, contact your SAN vendor.

- If the hosts that are attached are part of a Windows 2000 cluster solution, you must use one HBA for the boot process and a separate HBA for shared storage.
- If the hosts that are attached are part of a Windows 2000 cluster solution and are using the Microsoft multipath I/O (MPIO) feature, you need four HBAs.

### Troubleshooting

This section describes several issues that may prevent a Windows server from successfully booting from a SAN:  

- A common problem when you configure a SAN is that it is possible that multiple hosts may have access to the same logical disk. This usually occurs because proper LUN management was not employed. The default behavior of Windows is to attach and mount every logical unit that it detects when the HBA driver loads. If multiple hosts mount the same disk, file system damage can occur. It is up to the configuration of the SAN to insure that only one host can access a particular logical disk at a time. Symptoms of multiple hosts accessing the same logical disk are:  
Disk Management displays the same logical disk on multiple hosts. Plug and Play notification that new hardware is found may occur on multiple hosts when you add or configure a new logical disk. When you try to access a logical disk by using My Computer or Windows Explorer, you may receive an "Access Denied", "Device not Ready", or similar error message that may indicate that other hosts have access to the same logical disk.

- Your computer stops responding (hangs) or has slow response times. This can indicate that there is a high latency to the pagefile, and this may be accompanied by events in the System Log such as:  

    > Event ID: 51  
    Event Type: Warning  
    Event Source: Disk  
    Description: An error was detected on device \Device\Harddisk0\DR0 during a paging operation.
    >
    > Event ID: 11  
    Source: %HBA_DRIVER_NAME%  
    Description: The driver detected a controller error on Device\ScsiPort0.  
    >
    > Event ID: 9  
    Source: %HBA_DRIVER_NAME%  
    Description: The device, \Device\ScsiPort0, did not respond within the timeout period.  

    If the preceding error messages are in the System Log, it indicates that Windows was trying to access a disk and there was a problem. If the disk that is referenced is on the SAN, it could indicate a latency issue. If an Event ID 51 is shown, this indicates that Memory Manager was attempting to copy data to or from memory and had a problem. Another indicator of pagefile latency issues is if the Windows server has a system failure, and either of the following error messages are displayed on a blue screen:  
    > 0x00000050 PAGE_FAULT_IN_NONPAGED_AREA
    >
    > or
    >
    > 0x0000000A IRQL_NOT_LESS_OR_EQUAL  

    A possible resolution is to place the pagefile on the host's local hard disk. Windows needs reliable access to the pagefile as data is paged in or out of memory. Having the pagefile local to the host guarantees that access is not influenced by other devices and hosts on the SAN.

    > [!NOTE]
    > If the pagefile is not on the same partition as the boot partition (typically c:\Windows or c:\WINNT), the creation of a Memory.dmp file will not occur. A Memory.dmp file is used for troubleshooting a Windows computer that has a STOP error. For information about how to configure your computer for a crashdump, see Windows Help.  

There are several ways to resolve the preceding problems. The first method is to try and correlate the time with any events that are occurring on the SAN. For example, it HostA was doing a large copy operation and HostB reports the Error 9s, it may imply that proper LUN management is not in place. Another example is if HostB produces errors whenever HostA is rebooted. This may indicate that FC-AL is being used and HostB is being affected by a Loop Initialization Primitive (LIP) sequences from HostA. These can often be corrected by reconfiguring the SAN, and this requires the assistance of the hardware vendor. Any type of latency issues might be resolved by placing pagefile on the Windows server's local hard disk, but again, this disables the creation of a memory dump. A key point to understand is that the hardware vendor of the SAN will have the most information about the proper configuration, and must be the first point of contact for all configuration questions and concerns.
