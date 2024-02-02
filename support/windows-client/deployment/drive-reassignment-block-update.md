---
title: Windows Update blocked because of drive reassignment
description: Works around a problem in which Windows Update is blocked for Windows 10 customers because of a drive reassignment that is caused by an attached device.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:servicing, csstroubleshoot
ms.subservice: deployment
---
# Error on a computer that has a USB device or SD card attached: This PC can't be upgraded to Windows 10

This article helps fix an error that occurs on a computer that has a USB device or SD card attached when you try to upgrade to the May 2019 Feature Update for Windows 10 (Windows 10, version 1903).

_Applies to:_ &nbsp; Windows 10, version 1903  
_Original KB number:_ &nbsp; 4500988

## Symptoms

If you are trying to upgrade to the May 2019 Feature Update for Windows 10 (Windows 10, version 1903), you may experience an upgrade hold and receive the following message:

> This PC can't be upgraded to Windows 10.

:::image type="content" source="media/drive-reassignment-block-update/this-pc-cannot-be-upgraded-to-windows-10-error.png" alt-text="The details of the PC can't be upgraded to Windows 10 error." border="false":::

## Cause

If you have an external USB device, SD memory card or UFS card attached when installing Windows 10, version 1903, you may get an error message stating "This PC can't be upgraded to Windows 10." This is caused by inappropriate drive reassignment during installation.

An external USB device, SD memory card, or UFS card that is attached to the computer can cause an inappropriate drive reassignment on Windows 10-based computers during the installation of the Windows 10, version 1903 update. For this reason, there is an update hold on computers to prevent them from receiving Windows 10, version 1903 if this situation is detected. This generates the error message that is mentioned in the [Symptoms](#symptoms) section if the upgrade is tried again on an affected computer.

### Sample scenario

An update to Windows 10, version 1903 is tried on a computer that has a thumb drive inserted into a USB port. Before the update, the thumb drive is mounted in the system as drive G based on the existing drive configuration. However, after the feature update is installed, the device is assigned a different drive letter (for example, drive H).

> [!NOTE]
> The drive reassignment is not limited to removable drives. Internal hard drives may also be affected.

To safeguard your update experience, we have applied a hold on devices with an external USB device or SD memory card attached from being offered Windows 10, version 1903 until this issue is resolved.

## Workaround

To work around this problem, remove all external media, such as USB devices, SD cards, and UFS cards, from your computer. Then, restart installation of the Windows 10, version 1903 feature update. The update should now proceed normally.

If you are using installation media (USB flash drive, DVD, or ISO file) to install Windows 10, copy the files on the installation media to your local drive, and then start the installation from the local drive.

## Status

Microsoft has confirmed that this is a problem in Windows 10, version 1903.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
