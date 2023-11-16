---
title: Syskey.exe utility is no longer supported
description: Syskey.exe utility is no longer supported in Windows 10, Windows Server 2016, and later versions.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-backup-restore-or-disaster-recovery, csstroubleshoot
ms.technology: windows-server-active-directory
---
# Syskey.exe utility is no longer supported in Windows 10, Windows Server 2016, and later versions

Windows 10, version 1709, Windows Server, version 2004 and later versions of Windows no longer support the syskey.exe utility.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2019, Windows Server 2016  
_Original KB number:_ &nbsp; 4025993

## Changes detail

The following changes are made:

- The syskey.exe utility is no longer included in Windows.
- Windows will never prompt for a syskey password during startup.
- Windows will no longer support installing an Active Directory domain controller by using Install-From-Media (IFM) that was externally encrypted by the syskey.exe utility.

If an operating system (OS) was externally encrypted by the syskey.exe utility, you can't upgrade it to Windows 10 version 1709, Windows Server version 2004, or a later version of Windows.

## Workaround

If you want to use boot-time OS security, we recommend that you use BitLocker or similar technologies instead of the syskey.exe utility.

If you use Active Directory IFM media to install replica Active Directory domain controllers, we recommend that you use BitLocker or other file encryption utilities to protect all IFM media.

To upgrade an OS that's externally encrypted by the syskey.exe utility to Windows 10 RS3 or Windows Server 2016 RS3, the OS should be configured not to use an external syskey password. For more information, see step 5 in [How to use the SysKey utility to secure the Windows Security Accounts Manager database](https://support.microsoft.com/help/310105).

## More information

Syskey is a Windows internal root encryption key that's used to encrypt other sensitive OS state data, such as user account password hashes. The SysKey utility can be used to add an extra layer of protection, by encrypting the syskey to use an external password. In this state, the OS blocks the boot process and prompt users for the password (either interactively or by reading from a floppy disk).

Unfortunately, the syskey encryption key and the use of syskey.exe are no longer considered secure. Syskey is based on weak cryptography that can easily be broken in modern times. The data that's protected by syskey is limited and doesn't cover all files or data on the OS volume. The syskey.exe utility has also been known to be used by hackers as part of ransomware scams.

Active Directory previously supported the use of an externally encrypted syskey for IFM media. When a domain controller is installed by using IFM media, the external syskey password had to be provided as well. Unfortunately, this protection suffers from the same security flaws.

## Reference

The syskey.exe utility and its underlying support in the Windows OS was first introduced in Windows 2000 and backported to Windows NT 4.0. For more information, see [How to use the SysKey utility to help secure the Windows Security Accounts Manager database](https://support.microsoft.com/help/310105).
