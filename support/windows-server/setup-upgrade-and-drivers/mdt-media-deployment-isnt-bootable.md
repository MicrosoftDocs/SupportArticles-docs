---
title: MDT Media Deployment USB isn't bootable
description: Provides a solution to an error that occurs when you try to boot a Microsoft Deployment Toolkit 2012 Update 1 media deployment USB drive on a x86 UEFI-based system.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, mniehaus, aaroncz
ms.custom: sap:installing-or-upgrading-windows, csstroubleshoot
---
# MDT Media Deployment USB drive not bootable on x86 UEFI system

This article provides a solution to an error that occurs when you try to boot a Microsoft Deployment Toolkit 2012 Update 1 media deployment USB drive on a x86 UEFI-based system.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2845990

## Symptoms

When attempting to boot a Microsoft Deployment Toolkit 2012 Update 1 media deployment USB drive on a x86 UEFI-based system, the drive may not appear in the boot options of the system

## Cause

If you create media using MDT that selects both x86 and x64 platforms, MDT will generate a message that says "Not adding x86 boot entry to UEFI BCD because dual boot UEFI media isn't supported"

## Resolution

To boot an MDT media deployment on x86 UEFI-based system, you must uncheck x64 when building the MDT media.  To resolve this, do the following:

1. In the deployment share, navigate to **Advanced Configuration** > **Media**.
2. Right-click the **Media** and choose properties.
3. Under platforms, uncheck Generate x64 boot image.

> [!NOTE]
> Make sure the drive is also formatted FAT32.

The USB drive should appear as bootable in the boot order.

## More information

UEFI systems can only boot operating systems and Windows PE boot images that match the computer's CPU architecture.  For example, Intel Atom-based systems support only x86 while Intel Core-based systems support only x64 (without using legacy BIOS compatibility).

Due to limitations in the UEFI boot process, it isn't possible to create media that works with both x86 and x64 UEFI systems. So for MDT media that specifies both x86 and x64 architecture support, MDT can only support one architecture for UEFI booting. (Both x86 and x64 work fine for non-UEFI systems.) Rather than generating an error, MDT logs a message indicating that the resulting media will only support x64 UEFI systems.

To support UEFI x86 systems, you need to have separate media that selects only the x86 architecture.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
