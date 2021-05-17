---
title: This device cannot start error when deploying a hot plug NVMe SSD
description: Describes an error "This device cannot start" that occurs when you deploy a hot plug NVMe SSD.
ms.date: 05/14/2021
author: v-lianna
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-pekuo, shthomps
ms.prod-support-area-path: Devices and Drivers
ms.technology: windows-server-deployment
---
# "This device cannot start" error when deploying a hot plug NVMe SSD

_Original product version:_ &nbsp;Windows Servers  
_Original KB number:_ &nbsp;4035110

When deploying a hot plug NVM Express (NVMe) solid-state drive (SSD) that supports a maximum payload size (MPS) which is less than the currently configured Peripheral Component Interconnect Express (PCIe) bus MPS, the SSD device cannot be detected or enumerated, and you receive the following error message:

> This device cannot start. Try upgrading the device drivers for this device. (Code 10)

All NVMe SSD devices which support hot plug/hot swap capability must support the same (or higher) MPS value as the existing NVMe PCIe bus MPS hierarchy in Windows Server. The PCIe driver cannot dynamically change the existing MPS value of the hierarchy. If a new device is hot plugged to an existing NVMe PCIe bus that doesn’t support the MPS value initialized at the boot process, then the detection and enumeration of the device will fail.

Restart the server to initialize the NVMe PCIe bus MPS value to that of the SSD device which has the lowest MPS. Otherwise, contact the system or device manufacturer for further assistance.
