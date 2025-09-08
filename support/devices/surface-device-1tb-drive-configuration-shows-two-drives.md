---
title: Surface Device that has a 1-TB drive configuration shows two drives
description: Helps resolve the issue in which a Surface device that has a 1-TB drive configuration shows two drives.
ms.date: 05/31/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-lianna
ms.custom: csstroubleshoot
ms.subservice: windows
---
# Surface Device that has a 1-TB drive configuration shows two drives

This article helps resolve the issue in which a Surface device that has a 1-TB drive configuration shows two drives.

_Applies to:_ &nbsp; Surface Pro (5th Gen), Surface Laptop (1st Gen), Surface Pro 6, Surface Laptop 2  
_Original KB number:_ &nbsp; 4046105

## Symptoms

You experience the following symptoms on some Surface devices that have the 1-TB drive configuration:

- Diskpart shows two 512 GB drives instead of a single 1 TB drive.
- Windows Explorer shows two 512 GB drives instead of single 1 TB drive.
- A bare metal recovery (BMR) image states "There was a problem recovering your PC" or reports other errors when you try to restore the BMR image.

Surface devices that are impacted by this issue:

- Surface Pro (5th gen) 1-TB drive configuration
- Surface Laptop (1st Gen) 1-TB drive configuration
- Surface Pro 6 1-TB drive configuration
- Surface Laptop 2 1-TB drive configuration

The following Surface Devices with 1-TB drive configuration use a single SSD and aren't impacted by this issue：

- Surface Pro 4
- Surface Book
- Surface Book 2
- Surface Studio 2
- Surface Pro 7
- Surface Laptop 3

## Cause

This issue occurs because some Surface Devices with 1-TB drive configuration use Storage Spaces technology to combine two 512-GB drives into a single drive. If you use older deployment or disk configuration tools that don't support the storage spaces, it can break a single storage-space drive into two separate drives.

## Resolution

To resolve this issue, follow these steps:

1. Download version 3.2.43 or a later version of the [Surface Data Eraser](https://www.microsoft.com/download/details.aspx?id=46703) tool.
2. Create a Surface Data Eraser drive, and then start the device from that drive.

The Surface Data Eraser tool rejoins the two drives into a single storage-spaces drive. The BMR image can be downloaded and installed, or a custom image can be deployed.

> [!NOTE]
> The image and deployment tools that are used must be based on the Windows 10, version 1703 (Spring Creators) update or a later Windows 10 update.  