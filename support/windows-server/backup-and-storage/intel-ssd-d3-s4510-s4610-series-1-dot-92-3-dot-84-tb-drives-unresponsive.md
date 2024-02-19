---
title: Intel SSD D3-S4510 and Intel SSD D3-S4610 series 1.92 TB and 3.84 TB drives unresponsive after 1,700 cumulative idle power-on hours
description: Discusses that Intel SSD D3-S4510 and Intel SSD D3-S4610 series 1.92 TB and 3.84 TB drives become unresponsive after 1,700 cumulative idle power-on hours. Provides a resolution.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-jesits
ms.custom: sap:partition-and-volume-management, csstroubleshoot
---
# Intel SSD D3-S4510 and Intel SSD D3-S4610 series 1.92 TB and 3.84 TB drives unresponsive after 1,700 cumulative idle power-on hours

This article discusses that Intel SSD D3-S4510 and Intel SSD D3-S4610 series 1.92 TB and 3.84 TB drives become unresponsive after 1,700 cumulative idle power-on hours.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016  
_Original KB number:_ &nbsp; 4499612

## Symptoms

Intel SSD D3-S4510 and Intel SSD D3-S4610 series drives in the 1.92 TB and 3.84 TB capacities may experience an NAND "channel hang" condition in firmware release XCV10100 that could cause the drive to become unresponsive after approximately 1,700 hours of cumulative idle power-on time.

When this issue occurs on a Windows Server Storage Spaces Direct (S2D) cluster, the cluster may experience any of the following symptoms:

- Slow workload performance.
- Virtual disks in the cluster have an Operational Status value of Detached or No Redundancy.
- The physical disk reports a status of Lost Communication or IO Error.
- The physical disk reports a status of Transient Error if the cluster node is restarted while the disk is in the unresponsive state.

## Resolution

The NAND "channel hang" issue is currently addressed in the Maintenance Release 1 (MR1) of Intel firmware (version XCV10110) as of March 2019. We recommend that you update to the latest firmware before the drive reaches 1,700 cumulative idle power-on hours.

Run the Intel SSD Data Center Tool to inspect all affected disks as soon as possible, and take corrective actions as recommended. For more information, see [Intel SSD Data Center Tool](https://www.intel.com/content/www/us/en/support/articles/000006289/memory-and-storage.html).

The following MR1 firmware binary is available for use together with the Storage Spaces Direct automated firmware update method, as appropriate for your device.

- Dell [Serial-ATA_Firmware_8VGP8_WN64_DL63_A00.EXE](https://www.dell.com/support/home/us/en/ilbsdt1/drivers/driversdetails?driverid=8vgp8&oscode=wst14&productcode=poweredge-r740)
- Lenovo [Intel S4510 and S4610 SATA SSD issue - Lenovo Server, Lenovo ThinkSystem and IBM Server](https://support.lenovo.com/us/en/solutions/ht507987)

> [!Note]
> There is no counter or other attribute that reports drive idle power-on hours. Intel recommends that you use SMART 09h (drive power-on hours) as an approximation of the idle power-on hours. Therefore, Intel strongly recommends that you update the firmware as soon as possible to avoid the risk of unrecoverable data loss. The new MR1 firmware will not resolve any read-uncorrectable errors that existed before the firmware upgrade. Intel has released a Data Center Tool (DCT) to identify whether the issue is successfully corrected by installing the MR1 firmware. The tool also describes possible next steps.
>
> For more information about the DCT tool, see [Intel Solid State Drive Data Center Tool User Guide](https://www.intel.com/content/dam/support/us/en/documents/memory-and-storage/Intel_SSD_DCT_3_0_x_User_Guide.pdf).

## More information

This is a hardware issue that may affect the Microsoft products that are listed in the "Applies to" section. Intel has determined the root cause of the issue and confirmed that the issue is addressed in the firmware version that is based on "Maintenance Release 1."

### Known hardware that is affected

Hardware based on the Intel SSD D3-S4510 and Intel SSD D3-S4610 series drives in the 1.92 TB and 3.84 TB capacities.

### Known hardware that is not affected

- Hardware based on the Intel SSD D3-S4510 and Intel SSD D3-S4610 series drives in the 240 GB, 480 GB, and 960 GB capacities.
- Hardware based on the Intel SSD DC S4500 and Intel SSD DC S4600 family of SATA devices.
- Hardware based on the Intel SSD DC P4500 and Intel SSD DC P4600 family of NVMe devices.

## References

For more information about how to update storage device firmware in an automated manner by using Storage Spaces Direct (S2D), see the following Docs website:  
[Automated firmware updates with Storage Spaces Direct](/windows-server/storage/update-firmware#automated-firmware-updates-with-storage-spaces-direct)

For a step-by-step video about how to update storage device firmware in an automated manner by using Storage Spaces Direct (S2D), see the following Windows Server Channel website:  
[Update Drive Firmware Without Downtime in Storage Spaces Direct](https://channel9.msdn.com/Blogs/windowsserver/Update-Drive-Firmware-Without-Downtime-in-Storage-Spaces-Direct)

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../includes/third-party-contact-disclaimer.md)]
