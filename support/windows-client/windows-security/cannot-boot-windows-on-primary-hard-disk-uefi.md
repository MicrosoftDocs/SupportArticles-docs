---
title: Unable to boot if more than one EFI system partition is present
description: Works around an issue where you can't boot Windows that was on the primary hard disk and may only have the option to boot to the new installation of Windows on the second hard disk.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:secure-boot-and-uefi, csstroubleshoot
---
# Unable to boot if more than one EFI system partition is present

This article helps work around an issue where you can't boot Windows that was on the primary hard disk and may only have the option to boot to the new installation of Windows on the second hard disk.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 – all editions  
_Original KB number:_ &nbsp; 2879602

## Symptoms

Consider the following scenario:

- You have a PC that is running Windows and is booting in uEFI mode.
- You add a second hard disk to the PC and start a second installation of Windows using uEFI bootable media. A new EFI System Partition (ESP) is created on the second disk in addition to the existing ESP on the primary hard disk.

In this scenario, after completing setup, you may no longer be able to boot to Windows that was on the primary hard disk and may only have the option to boot to the new installation of Windows on the second hard disk.

## Cause

With the uEFI boot process, there's a reliance on the uEFI firmware boot entries presented during boot. The Windows installation process will append the latest installation to the list of available operating system and then set the most recent installation as the default boot option. This menu isn't typically exposed when booting the PC.

Because of variances in different versions of uEFI firmware, Windows doesn't make provisions for previously installed operating systems and as a result, doesn't currently support booting to multiple ESPs in the way described in the Symptoms section.

## Workaround

The only Microsoft supported workaround for booting multiple installations of Windows in a uEFI environment is to use a [dual boot](https://answers.microsoft.com/en-US/windows/forum/windows_8-windows_install/dual-boot-windows-8-pro-and-windows-7/0c2887f8-fbe8-489a-ba20-b8ba2dfb0eab) configuration. This will make use of a single ESP and one MSR while still allowing the user to choose to boot to an installation on disk 1 or disk 2.

Note: The EFI firmware will use the last Windows installation (using setup.exe) as the primary boot OS.

## More information

You may also encounter this issue if a second hard drive is added that has a pre-existing EFI partition and bootable OS on it as well. Because of differences in hardware and firmware boot options, it's unknown which Windows OS will be set as the primary boot disk.
