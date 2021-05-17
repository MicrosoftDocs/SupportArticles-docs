---
title: Can't access an EFI system partition
description: Provides a solution to an issue that you can't gain access to the EFI system partition by using the mountvol /s command when you  use the Mountvol utility (Mountvol.exe) in a WinPE Environment.
ms.date: 10/19/2020
author: Deland-Han 
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika, chadbee, davidwin
ms.prod-support-area-path: Setup
ms.technology: windows-client-deployment
---
# You can't access an EFI system partition with the Mountvol utility in a WinPE Environment

This article provides a solution to an issue that you can't gain access to the Extensible Firmware Interface (EFI) system partition by using the `mountvol /s` command when you  use the Mountvol utility (Mountvol.exe) in a WinPE Environment.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 315943

## Symptoms

If you use the Mountvol utility (Mountvol.exe) in a Windows Preinstall Environment (WinPE) on either a Windows XP-based or Windows Server 2003-based computer, you can't gain access to the Extensible Firmware Interface (EFI) system partition by using the `mountvol /s` command. For example, if you try to use the `mountvol x: /s` command, you may receive the following error message:

> The system cannot find the file specified.

## Cause

This behavior occurs because the Mountvol utility isn't supported in WinPE environments.

## Resolution

To work around this behavior, use the Diskpart utility (Dispart.exe) instead of the Mountvol tool. To use the Diskpart utility:

1. Select **Start**, select **Run**, type diskpart in the **Open** box, and then select **OK**.
2. When the Diskpart utility starts, type select disk **n** at the prompt (where **n** is number for the mapped ESP disk), and then press **ENTER**.
3. Type select partition  
    **n** at the prompt (where **n** is number for the mapped ESP partition), and then press **ENTER**.
4. Type assign letter= **x** at the prompt (where **x** is the drive letter that you want to assign), and then press **ENTER**.

After you follow these steps, you can access an EFI system partition by using the drive letter that you assign to the partition with the Diskpart utility.

## Status

This behavior is by design.
