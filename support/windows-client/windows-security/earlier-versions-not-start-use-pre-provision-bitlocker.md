---
title: Earlier Windows versions don't start after you use Pre-Provision BitLocker with Windows 10, version 1511
description: Explains why earlier Windows versions don't start after you run the Setup Windows and Configuration Manager step if Pre-Provision BitLocker is used with Windows 10, version 1511.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Windows Security Technologies\BitLocker, csstroubleshoot
---
# Earlier Windows versions don't start after "Setup Windows and Configuration Manager" step if Pre-Provision BitLocker is used with Windows 10, version 1511

This article explains why earlier Windows versions don't start after you run the "Setup Windows and Configuration Manager" step if Pre-Provision BitLocker is used with Windows 10, version 1511.

_Applies to:_ &nbsp; Windows 10 – all editions, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 4494799

## Symptoms

Consider following scenario:

- You install the Windows 10, version 1511 ADK to your boot images.
- You apply KB3143760 to your boot images.
- You want to install a Windows version that's earlier than Windows 10, version 1511 by using your new 1511 boot images. To do this, you add the built-in "Pre-Provision BitLocker" step to your task sequence. This enables the "Used space only encryption" feature to speed up BitLocker drive encryption.

All the steps in the task sequence work as expected until the "Setup Windows and Configuration Manager" step. After this step runs, your device starts up into a "Recovery" screen that displays a "There are no more BitLocker recovery options on your PC" message and resembles the following screenshot:

:::image type="content" source="media/earlier-versions-not-start-use-pre-provision-bitlocker/no-more-bitlocker-recovery-option.png" alt-text="Screenshot of the Recovery screen after this step." border="false":::

## Cause

This problem occurs because the default encryption in Windows 10, version 1511 was changed from AES 128 to XTS-AES 128 to improve security. The new encryption method is not recognized by systems versions that were released before Windows 10, version 1511.

To verify this situation, enable command-line support, and run the following command during the Windows PE phase:

```console
manage-bde.exe -status
```

:::image type="content" source="media/earlier-versions-not-start-use-pre-provision-bitlocker/manage-bde-exe-status.png" alt-text="Screenshot of the output of the command, which shows the Encryption Method is XTS-AES 128.":::

## Resolution

To resolve this issue, use a **Run** **Command Line** step. To do this, add the following command before the "Pre-Provision BitLocker" task sequence step:

```console
reg.exe add HKLM\SOFTWARE\Policies\Microsoft\FVE /v EncryptionMethod  /t REG_DWORD /d 3 /f
```

:::image type="content" source="media/earlier-versions-not-start-use-pre-provision-bitlocker/run-command-line.png" alt-text="Screenshot of the properties of the added task sequence step: Set BitLocker Key Strength AES 128." border="false":::

If an x64 boot image is used, select the option to disable 64-Bit file system redirection.

If you prefer other encryption methods, such as AES 256, use the guidance in the following table.

|Value|Encryption method| Meaning and command line syntax |
|---|---|---|
|1| AES_128_WITH_DIFFUSER|The volume has been fully or partially encrypted by the Advanced Encryption Standard (AES) algorithm and enhanced by using a diffuser layer that has an AES key size of 128 bits.<br/><br/> `reg.exe add HKLM\SOFTWARE\Policies\Microsoft\FVE /v EncryptionMethod  /t REG_DWORD /d 1 /f` |
|2| AES_256_WITH_DIFFUSER|The volume has been fully or partially encrypted by the Advanced Encryption Standard (AES) algorithm and enhanced by using a diffuser layer that has an AES key size of 256 bits.<br/><br/> `reg.exe add HKLM\SOFTWARE\Policies\Microsoft\FVE /v EncryptionMethod  /t REG_DWORD /d 2 /f` |
|3| AES_128|The volume has been fully or partially encrypted by the Advanced Encryption Standard (AES) algorithm that has an AES key size of 128 bits.<br/><br/> `reg.exe add HKLM\SOFTWARE\Policies\Microsoft\FVE /v EncryptionMethod  /t REG_DWORD /d 3 /f` |
|4| AES_256|The volume has been fully or partially encrypted by the Advanced Encryption Standard (AES) algorithm that has an AES key size of 256 bits.<br/><br/> `reg.exe add HKLM\SOFTWARE\Policies\Microsoft\FVE /v EncryptionMethod  /t REG_DWORD /d 4 /f` |
|6| XTS_AES128 *|The volume has been fully or partially encrypted by the Advanced Encryption Standard (AES) algorithm that has an XTS-AES key size of 128 bits. This is the default for Windows PE 10.0.586.0 (version 1511).<br/><br/> `reg.exe add HKLM\SOFTWARE\Policies\Microsoft\FVE /v EncryptionMethod  /t REG_DWORD /d 6 /f` |
|7| XTS_AES256 *|The volume has been fully or partially encrypted by the Advanced Encryption Standard (AES) algorithm that has an XTS-AES key size of 256 bits. `reg.exe add HKLM\SOFTWARE\Policies\Microsoft\FVE /v EncryptionMethod  /t REG_DWORD /d 7 /f` |
  
  \* Supported for deployments of Windows 10 images, version 1511, or later versions only

Your system deployment will now work. The encryption method is again set to AES 128, as it was in older Windows PE releases.

:::image type="content" source="media/earlier-versions-not-start-use-pre-provision-bitlocker/aes-128.png" alt-text="Screenshot of the bde status command output after using the task sequence step, which shows the encryption method is again set to AES 128." border="false":::

## References

[What's new in Windows 10, versions 1507 and 1511](/windows/whats-new/whats-new-windows-10-version-1507-and-1511)
