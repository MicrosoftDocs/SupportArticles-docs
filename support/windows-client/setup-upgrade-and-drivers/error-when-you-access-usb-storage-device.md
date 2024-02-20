---
title: Error when you access a USB storage device
description: Provides a solution to an error that occurs when you access a USB storage device after resuming from suspend.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:driver-installation-or-driver-update, csstroubleshoot
---
# Error message when you access a USB storage device after resuming from suspend

This article provides a solution to an error that occurs when you access a USB storage device after resuming from suspend.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 323754

## Symptoms

If you try to use a Universal Serial Bus (USB) storage device immediately after you resume your computer from suspend, you may receive the following error message:

> **X** :\ drive is not accessible. The request could not be performed because of an I/O device error.

You continue to receive the error message when you try to use the USB storage device until you either remove and reattach the device, or you restart the computer. This problem may occur with any USB storage device such as floppy disk drives, hard disks, or CD-ROM drives.

## Cause

This problem occurs with some USB 1.x storage devices that are attached to a USB 2.0 controller in Windows 2000 with the USB 2.0 update installed.

## Resolution

To resolve this problem, obtain and install the updated Usbhub.sys file from the hotfix.

## Workaround

To work around this problem, wait approximately 10 seconds after you resume your computer before you try to use the USB 1.x storage device.

If you do not use any USB 2.0 devices on the computer, another workaround is to turn off the USB 2.0 controller in Device Manager. After you turn off the USB 2.0 controller, the problem that is described earlier in this article with USB 1.x devices does not occur.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed at the beginning of this article.

## More information

After you apply the hotfix that is mentioned earlier in this article, the following behaviors change:

- If you try to use a USB 1.x storage device immediately after you resume your computer, the problem may still occur. However, the problem does not occur if you then try to use the storage device again in a few seconds.

- Soon after you resume your computer, you may receive a **Unsafe Removal of Device** message that mentions the USB 1.x device. You can safely close this box. This message occurs because of a Windows timing issue that involves powering up both the USB companion controller driver stack and the Enhanced Host Controller interface (EHCI) stack after resuming from suspend.

    If the companion controller root hub driver powers up first, the USB 1.x devices that were attached to the root hub ports when the computer entered suspend are no longer attached. Therefore, the driver informs Plug and Play that the device has been removed. This occurs because the devices were routed to the EHCI controller when the Configure Flag was set, but they are not currently attached to the companion controller.

    When the EHCI controller (for USB 2.0) root hub driver then powers up later, the root hub ports are reset and USB 1.x devices are routed back to the companion controllers. The companion controller hub then enumerates the devices again. They are then detected and become functional.

    This does not affect USB 2.0 devices because they always remain attached to the EHCI controller.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
