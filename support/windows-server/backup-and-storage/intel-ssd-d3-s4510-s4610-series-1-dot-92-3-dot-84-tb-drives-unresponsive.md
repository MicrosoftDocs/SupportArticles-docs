---
title: Intel SSD D3-S4510 and Intel SSD D3-S4610 series 1.92 TB and 3.84 TB drives unresponsive after 1,700 cumulative idle power-on hours
description: Discusses that Intel SSD D3-S4510 and Intel SSD D3-S4610 series 1.92 TB and 3.84 TB drives become unresponsive after 1,700 cumulative idle power-on hours. Provides a resolution.
ms.date: 12/07/2020
ms.prod-support-area-path:  Windows Servers/Windows Server 2016/Windows Server Datacenter 2016/Backup, Recovery, Disk, and Storage/Storage Spaces Direct (S2D)
ms.technology: [Replace with your value]
ms.reviewer: 
---
# Intel SSD D3-S4510 and Intel SSD D3-S4610 series 1.92 TB and 3.84 TB drives unresponsive after 1,700 cumulative idle power-on hours

_Original product version:_ &nbsp; Windows Server 2019 Datacenter, Windows Server 2019 Standard, Windows Server 2016 Datacenter, Windows Server 2016 Standard  
_Original KB number:_ &nbsp; 4499612

## Symptoms

Intel SSD D3-S4510 and Intel SSD D3-S4610 series drives in the 1.92 TB and 3.84 TB capacities may experience an NAND "channel hang" condition in firmware release XCV10100 that could cause the drive to become unresponsive after approximately 1,700 hours of cumulative idle power-on time.
When this issue occurs on a Windows Server Storage Spaces Direct (S2D) cluster, the cluster may experience any of the following symptoms:
- Slow workload performance.
- Virtual disks in the cluster have an **Operational Status**  value of **Detached** or **No Redundancy**.
- The physical disk reports a status of **Lost Communication** or **IO Error**.
- The physical disk reports a status of **Transient Error**  if the cluster node is restarted while the disk is in the unresponsive state.

## Resolution

The NAND "channel hang" issue is currently addressed in the Maintenance Release 1 (MR1) of Intel firmware (version XCV10110) as of March 2019. We recommend that you update to the latest firmware before the drive reaches 1,700 cumulative idle power-on hours.

Run the Intel SSD Data Center Tool to inspect all affected disks as soon as possible, and take corrective actions as recommended. The Intel SSD Data Center Tool is available at the following Intel website:
 [Intel SSD Data Center Tool (Intel SSD DCT)](https://downloadcenter.intel.com/download/28639?v=t) 
The following MR1 firmware binary is available for use together with the Storage Spaces Direct automated firmware update method, as appropriate for your device.

|Intel| [https://downloadcenter.intel.com/download/28673/SSD-S4510-S4610-2-5-non-searchable-firmware-links/](https://downloadcenter.intel.com/download/28673/SSD-S4510-S4610-2-5-non-searchable-firmware-links/) |
|---|---|
|Dell| [https://www.dell.com/support/home/us/en/ilbsdt1/drivers/driversdetails?driverid=8vgp8&oscode=wst14&productcode=poweredge-r740](https://www.dell.com/support/home/us/en/ilbsdt1/drivers/driversdetails?driverid=8vgp8&oscode=wst14&productcode=poweredge-r740) |
|Lenovo| [https://support.lenovo.com/us/en/solutions/ht507987](https://support.lenovo.com/us/en/solutions/ht507987) |
|||

**Note**  There is no counter or other attribute that reports drive idle power-on hours. Intel recommends that you use SMART 09h (drive power-on hours) as an approximation of the idle power-on hours. Therefore, Intel strongly recommends that you update the firmware as soon as possible to avoid the risk of unrecoverable data loss. The new MR1 firmware will not resolve any read-uncorrectable errors that existed before the firmware upgrade. Intel has released a Data Center Tool (DCT) to identify whether the issue is successfully corrected by installing the MR1 firmware. The tool also describes possible next steps.
The DCT tool script is available at [this Intel website](https://downloadcenter.intel.com/download/28729/SSD-S4510-S4610-2-5-Non-Searchable-Firmware-Links).

## More information

This is a hardware issue that may affect the Microsoft products that are listed in the "Applies to" section. Intel has determined the root cause of the issue and confirmed that the issue is addressed in the firmware version that is based on "Maintenance Release 1."
 **Known hardware that is affected:** 
- Hardware based on the Intel SSD D3-S4510 and Intel SSD D3-S4610 series drives in the 1.92 TB and 3.84 TB capacities.
 
 **Known hardware that is not affected:** 
- Hardware based on the Intel SSD D3-S4510 and Intel SSD D3-S4610 series drives in the 240 GB, 480 GB, and 960 GB capacities.
- Hardware based on the Intel SSD DC S4500 and Intel SSD DC S4600 family of SATA devices.
- Hardware based on the Intel SSD DC P4500 and Intel SSD DC P4600 family of NVMe devices.

## References

For more information about how to update storage device firmware in an automated manner by using Storage Spaces Direct (S2D), see the following Docs website:
 [Automated firmware updates with Storage Spaces Direct](https://docs.microsoft.com/windows-server/storage/update-firmware#automated-firmware-updates-with-storage-spaces-direct) 
For a step-by-step video about how to update storage device firmware in an automated manner by using Storage Spaces Direct (S2D), see the following Windows Server Channel website:
 [Update Drive Firmware Without Downtime in Storage Spaces Direct](https://channel9.msdn.com/Blogs/windowsserver/Update-Drive-Firmware-Without-Downtime-in-Storage-Spaces-Direct) 

| Third-party information disclaimer |
|---|
|The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.<br/>|
||

| Third-party contact disclaimer |
|---|
|Microsoft provides third-party contact information to help you find additional information about this topic. This contact information may change without notice. Microsoft does not guarantee the accuracy of third-party contact information.<br/>|
||
