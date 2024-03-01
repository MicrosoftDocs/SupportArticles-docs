---
title: Stop code SYSTEM SERVICE EXCEPTION when initializing PMem or NVDIMM
description: Provides a method to avoid the stop code SYSTEM SERVICE EXCEPTION when you try to initialize PMem or NVDIMM in Windows.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-anfiro, coma, shthomps, scolee
ms.custom: sap:blue-screen/bugcheck, csstroubleshoot
---
# Stop code SYSTEM SERVICE EXCEPTION when initializing PMem or NVDIMM in Windows

_Applies to:_ &nbsp; Supported versions of Windows Server and Windows Client

This article provides a method to avoid the stop code SYSTEM SERVICE EXCEPTION when you try to initialize a persistent memory (PMem) or non-volatile dual in-line memory module (NVDIMM) device in Windows.

## Stop code when initializing PMem or NVDIMM devices

You create a 64-bit version of Windows virtual machine. Then, you add a persistent memory (PMem) or non-volatile dual in-line memory module (NVDIMM) device with a size less than 16 megabytes (MB) as a PMem disk. When you try to initialize the disk by using the GUID Partition Table (GPT) partition style in **Disk Management**, the initialization fails with this stop code:

> SYSTEM SERVICE EXCEPTION

## Use devices with a larger size to avoid this issue

Windows supports PMem or NVDIMM devices (both physical and virtual) with a minimum size of 16 MB. If the size is less than 16 MB, the disk may not be initialized and used.

> [!NOTE]
> The PMem support in Windows was first introduced in Windows Server 2016 and Windows 10.

To avoid this issue, use a PMem or NVDIMM device with a size of 16 MB or larger.

For more information about creating a persistent memory disk in an unused persistent memory region, see the [New-PmemDisk](/powershell/module/persistentmemory/new-pmemdisk) cmdlet.
