---
title: Interrupt and DPC time streaming Isoch data
description: This article provides workarounds for the problem where a significant increase in Processor utilization (Interrupt & DPC time) while streaming Isochronous data to or from an IEEE 1394 device with Windows 7 IEEE 1394 bus driver, as compared with previous versions of the Windows IEEE 1394 bus driver.
ms.date: 09/01/2020
ms.custom: sap:Windows 7 Ultimate
ms.subservice: bus-driver
---
# Increased Interrupt & DPC time streaming Isoch data to or from an IEEE 1394 device

This article helps you work around the problem where a significant increase in Processor utilization (Interrupt & DPC time) while streaming Isochronous data to or from an IEEE 1394 device.

_Original product version:_ &nbsp; Windows 7, Windows Server 2008  
_Original KB number:_ &nbsp; 2450963

## Symptoms

You may observe a significant increase in Processor utilization (Interrupt and DPC time) while streaming Isochronous data to or from an IEEE 1394 device with Windows 7 IEEE 1394 bus driver, as compared with previous versions of the Windows IEEE 1394 bus driver.

## Cause

Under certain conditions, the Windows 7 IEEE 1394 bus driver (*1394ohci.sys*) programs the IEEE 1394 host controller to generate an interrupt and resulting DPC (Deferred Procedure Call) for every Isochronous packet sent or received. Under similar conditions, the legacy Windows IEEE 1394 bus driver (*ohci1394.sys* and *1394bus.sys*) programs the IEEE 1394 host controller to only generate an interrupt and DPC to occur at the end of each Isochronous transfer (frame) as designated by the IEEE 1394 device driver that initiates the Isochronous transfers.

An Isochronous data transfer typically requires multiple Isochronous data packets to transfer a meaningful unit of data, such as a video frame or audio sample. An IEEE 1394 device driver can be notified when such a meaningful unit of data has been transferred by specifying a callback routine in the Isoch Descriptor structure used to describe the buffer used for this transfer. This Isoch Descriptor structure is submitted to the Microsoft Windows IEEE 1394 bus driver via a `REQUEST_ISOCH_ATTACH_BUFFERS` I/O request, and is used to program the IEEE 1394 host controller to perform the requested Isochronous transfer.

The problem described in this article occurs when an IEEE 1394 device driver submits Isoch Descriptors that each describe a single packet's worth of data, instead of Isoch Descriptors that each describe multiple packets of data, such as a complete video frame or audio sample. In this scenario, multiple Isoch Descriptors are attached by the IEEE 1394 device driver, one per packet, and a callback routine is only specified in the last Isoch Descriptor.

As a result, the Windows 7 IEEE 1394 bus driver only invokes the specified callback routine when the last packet of data has been transferred, but the programs the IEEE 1394 host controller to generate an interrupt once the data described by each Isoch Descriptor has been transferred. Each interrupt causes the interrupt handler and DPC routines in the Microsoft Windows 7 IEEE 1394 bus driver to be invoked, resulting in an increase in Interrupt and DPC time, which can be observed in performance-monitoring tools and may have an impact on overall system performance.

## Workaround

It may be possible to work around this problem by changing the behavior of the affected IEEE 1394 device driver to submit a single Isoch Descriptor for each meaningful unit of data, such as a video frame or audio sample, instead of submitting an Isoch Descriptor for each packet of data. This would also reduce the total number of Isoch Descriptors required to transfer the same amount of Isochronous data, and would generally be expected to reduce the processing overhead associated with each `REQUEST_ISOCH_ATTACH_BUFFERS` I/O request.

## More information

For more information about how IEEE 1394 client drivers submit Isochronous transfers to the Microsoft IEEE 1394 bus driver, see the following articles:

- [Setting Up Isochronous Transfer for IEEE 1394 Devices](/windows-hardware/drivers/ieee/setting-up-isochronous-transfer-for-ieee-1394-devices)

- [ISOCH_DESCRIPTOR Structure](/windows-hardware/drivers/ddi/1394/ns-1394-_isoch_descriptor)

## Applies to

- Windows 7 Ultimate
- Windows 7 Enterprise
- Windows 7 Professional
- Windows 7 Home Premium
- Windows 7 Home Basic
- Windows 7 Starter
- Windows Server 2008 R2 Standard
- Windows Server 2008 R2 Enterprise
- Windows Server 2008 R2 Datacenter
