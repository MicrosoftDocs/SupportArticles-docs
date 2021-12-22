---
title: 'Windows Server shows PCR7 configuration as "Binding not possible"'
description: 'Introduces the PCR7 configuration "Binding not possible" issue and its cause.'
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:setup, csstroubleshoot
ms.technology: windows-server-deployment
---
# Windows Server shows PCR7 configuration as "Binding not possible"

This article introduces the **Binding not possible** issue in msinfo32 and the cause of the issue.

## PCR7 Configuration in msinfo32

Consider the following scenario:

- Windows Server is installed on a secure boot-enabled platform.
- You enable Trusted Platform Module (TPM) 2.0 in Unified Extensible Firmware Interface (UEFI).
- You turn on BitLocker.
- You install chipset drivers and update the latest Microsoft Monthly Rollup.
- You also run *tpm.msc* to make sure that the TPM status is normal. The status displays **The TPM is ready for use**.

In this scenario, when you run *msinfo32* to check the PCR7 Configuration, it is displayed as **Binding not possible**.

## Cause of the unexpected message

Microsoft only accepts the Microsoft Windows PCA 2011 certificate to be used to sign BitLocker binding download components in PCR7. Any other signature present on boot code will cause BitLocker to use TPM profile 0, 2, 4, 11 instead of 7, 11. In some cases, the binaries are signed with UEFI CA 2011 certificate, which will prevent you from binding to PCR7.

> [!Note]
> UEFI CA can be used to sign third party applications, Option ROMs or even third party boot loaders which can load malicious (UEFI CA signed) code. In this case, BitLocker switched to PCR 0, 2, 4, 11. The exact binary hashes are measured rather than CA certificate, which means less exposure to attacks.

## More Information  

To check whether your device meets the requirements:

1. Open an elevated command prompt, and run the `msinfo32` command.
2. In **System Summary**, verify that **BIOS Mode** is **UEFI**, and **PCR7 Configuration** is **Bound**.
3. Open an elevated PowerShell command prompt, and run the following command:

    ```powershell
    Confirm-SecureBootUEFI
    ```
    Verify that it returns the value of **True**.

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
