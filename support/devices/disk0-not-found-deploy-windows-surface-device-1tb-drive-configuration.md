---
title: Disk0 not found when deploying Windows on a Surface device that has 1-TB drive configuration
description: Helps resolve the errors or other issues that concern locating the Disk0 When deploying Windows on a Surface device that has 1-TB drive configuration.
ms.date: 05/12/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: surface
localization_priority: medium
ms.reviewer: delhan, v-lianna
ms.custom: csstroubleshoot
ms.subservice: windows
---
# Disk0 not found when you deploy Windows on a Surface device that has 1-TB drive configuration

This article helps resolve the errors or other issues that concern locating the Disk0 When deploying Windows on a Surface device that has 1-TB drive configuration.

_Applies to:_ &nbsp; Surface Laptop (1st Gen), Surface Pro (5th Gen)  
_Original KB number:_ &nbsp; 4046108

## Symptom

When you deploy Windows on a Surface device that has 1-TB drive configuration, you may encounter errors or other issues that concern locating the Disk0. For example, if you're using Microsoft Deployment Toolkit (MDT), the following error is logged in the *bdd.log* file:

```output
<[LOG[################################################]LOG]><time="12:54:12.000+000" date="06-09-2017" component="ZTIDiskpart" context="" type="3" thread="" file="ZTIDiskpart">
<[LOG[## Disk(0) was not found. Unable to continue.]LOG]><time="12:54:12.000+000" date="06-09-2017" component="ZTIDiskpart" context="" type="3" thread="" file="ZTIDiskpart">
<[LOG[## Possible Cause: Missing Storage Driver.]LOG]><time="12:54:12.000+000" date="06-09-2017" component="ZTIDiskpart" context="" type="3" thread="" file="ZTIDiskpart">
<[LOG[################################################]LOG]><time="12:54:12.000+000" date="06-09-2017" component="ZTIDiskpart" context="" type="3" thread="" file="ZTIDiskpart">
<[LOG[FAILURE ( 7711 ): Disk OSDDiskIndex(0) can not be found!]LOG]><time="12:54:12.000+000" date="06-09-2017" component="ZTIDiskpart" context="" type="3" thread="" file="ZTIDiskpart">
```

Surface devices that are impacted by this issue:

- Surface Pro (5th gen) 1-TB drive configuration
- Surface Laptop (1st Gen) 1-TB drive configuration
- Surface Pro 6 1-TB drive configuration
- Surface Laptop 2 1-TB drive configuration

The following Surface devices that have 1-TB drive configuration and use a single solid-state drive (SSD) aren't impacted by this issue.

- Surface Pro 4
- Surface Book
- Surface Book 2
- Surface Studio 2
- Surface Pro 7
- Surface Laptop 3

## Cause

This issue occurs because some Surface devices that have 1-TB drive configuration use Storage Spaces technology to combine two 512-GB drives into a single drive. Storage spaces drives are virtual, so they're listed after physical drives. Due to this configuration, you have to target Disk2 or Disk3 instead of Disk0, depending on the device and whether an SD card is present.

## Resolution

To work around this issue, change the deployment tool to target Disk2. For example, if you're using Microsoft Deployment Toolkit, you can change your task sequence "Format and Partition Disk (UEFI)" step to change disk number to 2, or change the disk number to 3 if an SD Card is present.

> [!NOTE]
> This means that Microsoft Deployment Task Sequence is specific to these kinds of devices and cannot be used with other devices.
