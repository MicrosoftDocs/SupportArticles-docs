---
title: Display issue when you use USB-attached monitor
description: Describes an issue where the display configuration is retained after reboot when you use USB-attached monitor.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dpi-and-display-issues, csstroubleshoot
---
# When using USB-attached monitor, display configuration may not be retained after reboot

This article explains an issue where the display configuration is retained after reboot when you use USB-attached monitor.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2465368

## Symptoms

On a computer running Windows 10, you attach a secondary monitor via a USB connection. For example, you may attach a USB Port Replicator device, containing a DVI or VGA port, to the USB port of a laptop computer.

After attaching the secondary monitor, the display configuration may default to "Extend" or "Duplicate." You may then change to a "Computer Only" configuration, in order to turn off the secondary monitor and use only the primary monitor. (You can select a different display configuration by pressing Windows + P  keys on the keyboard.)

If you select a "Computer Only" configuration, and then reboot your computer, you may find that after rebooting, the configuration is changed back to "Extend," "Duplicate," or "Projector Only."

## Cause

This behavior occurs because the driver for the USB video adapter enumerates the attached monitor after Windows has already initialized the video subsystem. Therefore, Windows believes the external monitor was plugged in after the computer had already finished booting. When a new monitor is plugged into a running system, Windows 7 attempts to switch to a configuration in which the new monitor is enabled.

## Resolution

This is a known issue when using USB-attached displays in Windows.

## More information

Windows 7 does not provide native support for video displays that are connected via USB. However, there are some proprietary systems available that enable this type of connection.
