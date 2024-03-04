---
title: Trusted Platform Module (TPM) isn't recognized
description: TPM isn't recognized on some Windows 7 devices. Provides a resolution.
ms.date: 12/26/2023
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, manojse, raverma, suhasm
ms.custom: sap:secure-boot-and-uefi, csstroubleshoot
---
# A Trusted Platform Module (TPM) isn't recognized on some Windows 7 devices

This article solves the issue that a TPM isn't recognized as a compatible device on some Windows 7 devices.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2895212

## Symptoms

On some Windows 7 devices, a TPM isn't recognized as a compatible device. And it can't be used for certain applications, such as BitLocker Drive Encryption and Virtual Smart Card. Additionally, if you check the status of the TPM by using Windows TPM Management Console, you receive a **Compatible TPM cannot be found** message.

Also, you may experience the same behavior on some Windows-based devices when you do an in-place upgrade from Windows XP or Windows Vista to Windows 7.

## Cause

This issue occurs because the TPM is using the OEM driver and not the Windows built-in Trusted Platform Module driver.

> [!NOTE]
> When you open Device Manager on some devices, the TPM is listed under **System Devices** and not under **Security Devices**.

## Resolution

To resolve this issue, open Device Manager on the device on which you're experiencing the issue, and then uninstall the Trusted Platform Module driver.

If you do a hardware scan, the TPM will be detected as a security device and will use the Microsoft driver. Additionally, the TPM will now be listed under **Security Devices** as Trusted Platform Module 1.2.

## More information

For more information, see:

- [Trusted Platform Module Technology Overview](/previous-versions/windows/it-pro/windows-8.1-and-8/jj131725(v=ws.11))
- [Initialize and Configure Ownership of the TPM](/previous-versions/windows/it-pro/windows-8.1-and-8/dn466538(v=ws.11))
