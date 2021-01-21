---
title: BitLocker could not be enabled when USB drive is not found
description: Provides a resolution to an issue where BitLocker could not be enabled when USB drive is not found
ms.date: 09/21/2020
author: Deland-Han
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: manojse, kaushika, dereka
ms.prod-support-area-path: Bitlocker 
ms.technology: windows-client-security
---
# BitLocker could not be enabled when USB drive is not found

This article provides a resolution to an issue where BitLocker could not be enabled when USB drive isn't found.

_Original product version:_ &nbsp; Windows Server 2012 R2, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2732377

## Symptoms

When attempting to turn on BitLocker using a Startup Key as a protector and the system check option is accepted, BitLocker restarts the machine to complete the hardware test. If the USB drive holding the Startup Key is removed, or if USB ports are not enumerated correctly by the BIOS, then BitLocker isn't enabled on the volume and you may see following error message:

:::image type="content" source="./media/bitlocker-not-enabled-usb-drive-not-found/bitlocker-error.png" alt-text="Screenshot of error message.":::

## Cause

Boot Manager (Bootmgr) verifies that, the key material needed to unlock the disk is available before booting and starting encryption. If it is not available during the pre-boot hardware test before encryption, BitLocker will refuse to encrypt rather than leave the disk in a state that may not be usable in the expected manner. In the Startup Key case, this can occur when Bootmgr fails to find the Startup Key, either because then USB flash drive containing the Startup Key wasn't plugged in, or because the BIOS did not correctly enumerate the USB port with the USB drive inserted.

## Resolution

The resolution will depend on the underlying cause. If you have already verified that the USB flash drive containing the Startup Key is inserted correctly and securely in the USB port, try the following steps:

1. Some USB ports are not enumerated during boot. Try a different USB port.
2. Some USB drives cannot be read during boot. Try a different USB dongle.
3. Boot into the BIOS and ensure USB is supported at boot time.
4. Check to see if there is a firmware update for your machine.
