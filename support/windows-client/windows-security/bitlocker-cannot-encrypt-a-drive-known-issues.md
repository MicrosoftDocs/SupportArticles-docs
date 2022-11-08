---
title: 'BitLocker cannot encrypt a drive: known issues'
description: Provides guidance for troubleshooting known issues that may prevent BitLocker Drive Encryption from encrypting a drive.
ms.date: 08/24/2022
ms.technology: windows-client-security
ms.prod: windows-client
author: Teresa-Motiv
ms.author: v-tappelgate
manager: dcscontentpm
ms.collection: Windows Security Technologies\BitLocker
ms.topic: troubleshooting
ms.custom: sap:bitlocker, csstroubleshoot
ms.reviewer: kaushika
audience: itpro
localization_priority: medium
---
# BitLocker cannot encrypt a drive: known issues

This article describes common issues that prevent BitLocker from encrypting a drive. This article also provides guidance to address these issues.

> [!NOTE]
> If you have determined that your BitLocker issue involves the trusted platform module (TPM), see [BitLocker cannot encrypt a drive: known TPM issues](bitlocker-cannot-encrypt-a-drive-known-tpm-issues.md).

## Error 0x80310059: BitLocker drive encryption is already performing an operation on this drive

When you turn on BitLocker Drive Encryption on a computer that is running Windows 10 Professional or Windows 11, you receive the following message:

> **ERROR:** An error occurred (code 0x80310059):BitLocker Drive Encryption is already performing an operation on this drive. Please complete all operations before continuing.NOTE: If the -on switch has failed to add key protectors or start encryption,you may need to call manage-bde -off before attempting -on again.

### Cause

This issue may be caused by settings that are controlled by group policy objects (GPOs).

### Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To resolve this issue, follow these steps:

1. Start Registry Editor, and navigate to the following subkey:

   `HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\FVE`

2. Delete the following entries:

   - `OSPlatformValidation_BIOS`
   - `OSPlatformValidation_UEFI`
   - `PlatformValidation`

3. Exit registry editor, and turn on BitLocker drive encryption again.

## "Access is denied" message when you try to encrypt removable drives

You have a computer that is running Windows 10, version 1709 or version 1607, or Windows 11. You try to encrypt a USB drive by following these steps:

1. In Windows Explorer, right-click the USB drive and select **Turn on BitLocker**.
2. On the **Choose how you want to unlock this drive** page, select **Use a password to unlock the drive**.
3. Follow the instructions on the page to enter your password.
4. On the **Are you ready to encrypt this drive?** page, select **Start encrypting**.
5. The **Starting encryption** page displays the message "Access is denied."

You receive this message on any computer that runs Windows 10 version 1709 or version 1607, or Windows 11, when you use any USB drive.

### Cause

The security descriptor of the BitLocker drive encryption service (BDESvc) has an incorrect entry. Instead of NT AUTHORITY\\Authenticated Users, the security descriptor uses NT AUTHORITY\\INTERACTIVE.

To verify that this issue has occurred, follow these steps:

1. On an affected computer, open an elevated Command Prompt window and an elevated PowerShell window.
2. At the command prompt, enter the following command:

   ```console
   C:\>sc sdshow bdesvc
   ```

   The output of this command resembles as follows:

   ```output
   D:(A;;CCDCLCSWRPWPDTLORCWDWO;;;SY)(A;;CCDCLCSWRPWPDTLORCWDWO;;;BA)(A;;CCLCSWRPLORC;;;BU)(A;;CCLCSWRPLORC;;;AU)S:(AU;FA;CCDCLCSWRPWPDTLOSDRCWDWO;;;WD)
   ```

3. Copy this output, and use it as part of the [ConvertFrom-SddlString](/powershell/module/microsoft.powershell.utility/convertfrom-sddlstring) command in the PowerShell window, as follows.

    :::image type="content" source="media/bitlocker-cannot-encrypt-a-drive-known-issues/ts-bitlocker-usb-sddl.png" alt-text="Screenshot of the output of the ConvertFrom-SddlString command, showing NT AUTHORITY\\INTERACTIVE." border="false":::

   If you see NT AUTHORITY\INTERACTIVE (as highlighted) in the output of this command, this is the cause of the issue. Under typical conditions, the output should resemble as follows:

    :::image type="content" source="media/bitlocker-cannot-encrypt-a-drive-known-issues/ts-bitlocker-usb-default-sddl.png" alt-text="Screenshot of the output of the ConvertFrom-SddlString command, showing NT AUTHORITY\\Authenticated Users." border="false":::

> [!NOTE]
> GPOs that change the security descriptors of services have been known to cause this issue.

### Resolution

1. To repair the security descriptor of BDESvc, open an elevated PowerShell window and enter the following command:

   ```powershell
   sc sdset bdesvc D:(A;;CCDCLCSWRPWPDTLORCWDWO;;;SY)(A;;CCDCLCSWRPWPDTLORCWDWO;;;BA)(A;;CCLCSWRPLORC;;;BU)(A;;CCLCSWRPLORC;;;AU)S:(AU;FA;CCDCLCSWRPWPDTLOSDRCWDWO;;;WD)
   ```

2. Restart the computer.

The issue should now be resolved.
