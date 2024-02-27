---
title: Windows Server shows PCR7 configuration as "Binding not possible"
description: Introduces the PCR7 configuration "Binding not possible" issue and its cause.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:installing-or-upgrading-windows, csstroubleshoot
---
# Windows Server shows PCR7 configuration as "Binding not possible"

This article introduces the **Binding not possible** issue in msinfo32 and the cause of the issue. This applies to both Windows clients and Windows Server.

## PCR7 Configuration in msinfo32

Consider the following scenario:

- Windows Server is installed on a secure boot-enabled platform.
- You enable Trusted Platform Module (TPM) 2.0 in Unified Extensible Firmware Interface (UEFI).
- You turn on BitLocker.
- You install chipset drivers and update the latest Microsoft Monthly Rollup.
- You also run *tpm.msc* to make sure that the TPM status is fine. The status displays **The TPM is ready for use**.

In this scenario, when you run *msinfo32* to check the PCR7 Configuration, it's displayed as **Binding not possible**.

## Cause of the unexpected message

BitLocker only accepts the Microsoft Windows PCA 2011 certificate to be used to sign early boot components that will be validated during boot. Any other signature present on boot code will cause BitLocker to use TPM profile 0, 2, 4, 11 instead of 7, 11. In some cases, the binaries are signed with UEFI CA 2011 certificate, which will prevent you from binding BitLocker to PCR7.

> [!Note]
> UEFI CA can be used to sign third-party applications, Option ROMs or even third-party boot loaders that can load malicious (UEFI CA signed) code. In this case, BitLocker switches to PCR 0, 2, 4, 11. In the cases of PCR 0,2,4,11, Windows measures exact binary hashes instead of the CA certificate.
>
> Windows is secure regardless of using TPM profile 0, 2, 4, 11 or profile 7, 11.

## More information  

To check whether your device meets the requirements:

1. Open an elevated command prompt, and run the `msinfo32` command.
2. In **System Summary**, verify that **BIOS Mode** is **UEFI**, and **PCR7 Configuration** is **Bound**.
3. Open an elevated PowerShell command prompt, and run the following command:

    ```powershell
    Confirm-SecureBootUEFI
    ```

    Verify that the value of **True** is returned.

4. Run the following PowerShell command:

    ```powershell
    manage-bde -protectors -get $env:systemdrive
    ```

    Verify that the drive is protected by PCR 7.

    ```powershell
    PS C:\Windows\system32> manage-bde -protectors -get $env:systemdrive  
    BitLocker Drive Encryption: Configuration Tool version 10.0.22526
    Copyright (C) 2013 Microsoft Corporation. All rights reserved.

    Volume C: [OSDisk]
    All Key Protectors

        TPM:
         ID: <GUID>
        PCR Validation Profile:
        7, 11
        (Uses Secure Boot for integrity validation)
    ```

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
