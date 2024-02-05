---
title: Use or reference Usbser.sys driver from USB modem .inf files
description: Describes how to use or reference the system-supplied Usbser.sys driver file from a third-party modem .inf file. We recommend different configurations, depending on how the driver is distributed.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:driver-installation-or-driver-update, csstroubleshoot
---
# How to use or reference the Usbser.sys driver from universal serial bus (USB) modem .inf files

This article describes how to use or reference the system-supplied Usbser.sys driver file from a third-party modem .inf file.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 837637

## Summary

Universal serial bus (USB) modem .inf files can both use the Usbser.sys driver and directly reference the Usbser.sys driver from the .inf file. However, we don't recommend this.

Instead, we recommend the following:

- Drivers that are distributed with the operating system use the Usbser.sys driver.
- Drivers that are not distributed with the operating system use the Include directive or the Needs directive. The Include directive is described in the [More Information](#more-information) section.

## More information

To reference the Usbser.sys driver, we recommend that USB modem .inf files reference the Mdmcpq.inf file.

For example, the DDInstall section of an .inf file uses the Include directive and may be similar to the following:

```inf
[DDInstall.NT]
include=mdmcpq.inf
CopyFiles=FakeModemCopyFileSection

[DDInstall.NT.Services]
include=mdmcpq.inf
AddService=usbser, 0x00000000, LowerFilter_Service_Inst

[DDInstall.NT.HW]
include=mdmcpq.inf
AddReg=LowerFilterAddReg
```

The following sections appear in the Mdmcpq.inf file:

- FakeModemCopyFileSection
- LowerFilter_Service_Inst
- LowerFilterAddReg

## References

For more information, see the "Device Installation" topic in the Microsoft Windows Driver Development Kit documentation.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
