---
title: This device cannot start error when deploying a hot plug NVMe SSD
description: Describes an error "This device cannot start" that occurs when you deploy a hot plug NVMe SSD.
ms.date: 45286
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-pekuo, shthomps, v-lianna
ms.custom: sap:driver-installation-or-driver-update, csstroubleshoot
---
# "This device cannot start" error when deploying a hot plug NVMe SSD

_Applies to:_ &nbsp; Windows Server, version 2004, all editions, Windows Server, version 1903, all editions, Windows Server 2019, all editions, Windows Server 2016, Windows Server 2016 Datacenter, Windows Server 2016 Standard  
_Original KB number:_ &nbsp; 4035110

When deploying a hot plug NVM Express (NVMe) solid-state drive (SSD) that supports a maximum payload size (MPS) which is less than the currently configured Peripheral Component Interconnect Express (PCIe) bus MPS, the SSD device cannot be detected or enumerated, and you receive the following error message:

> This device cannot start. Try upgrading the device drivers for this device. (Code 10)

All NVMe SSD devices which support hot plug/hot swap capability must support the same (or higher) MPS value as the existing NVMe PCIe bus MPS hierarchy in Windows Server. The PCIe driver cannot dynamically change the existing MPS value of the hierarchy. If a new device is hot plugged to an existing NVMe PCIe bus that doesn't support the MPS value initialized at the boot process, then the detection and enumeration of the device will fail.

Restart the server to initialize the NVMe PCIe bus MPS value to that of the SSD device which has the lowest MPS. Otherwise, contact the system or device manufacturer for further assistance.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
