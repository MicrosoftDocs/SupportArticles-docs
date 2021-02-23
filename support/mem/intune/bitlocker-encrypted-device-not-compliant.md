---
title: BitLocker-encrypted device displays as Not compliant
description: Describes an issue in which a BitLocker-encrypted Windows 10 device shows as Not compliant in Intune because BitLocker encryption takes a long time.
ms.date: 05/11/2020
ms.prod-support-area-path: Device protection
---
# BitLocker-encrypted Windows 10 device shows as Not compliant in Intune

This article describes an issue in which a BitLocker-encrypted Windows 10 device shows as **Not compliant** in Intune.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4055337

## Symptom

Consider the following scenario:

- You have a Windows 10 device that has **BitLocker Drive Encryption** enabled.
- The device is enrolled in Microsoft Intune.
- You set device compliance policies to require device encryption and BitLocker.

In this scenario, the Windows 10 device displays a status of **Not compliant**.

## Cause

The issue occurs when BitLocker encryption isn't finished. Based on factors such as the disk size, number of files, and BitLocker settings, BitLocker encryption may take a long time. After encryption is complete, the device will be shown as **Compliant**.

## More information

- [Overview of BitLocker Device Encryption in Windows 10](/windows/security/information-protection/bitlocker/bitlocker-device-encryption-overview-windows-10)
- [Why BitLocker takes longer to complete the encryption in Windows 10 as compared to Windows 7](/archive/blogs/askcore/why-bitlocker-takes-longer-to-complete-the-encryption-in-windows-10-as-compared-to-windows-7)
