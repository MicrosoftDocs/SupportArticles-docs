---
title: Conflicting-or-Unsupported-Encryption Warning when Sending an Encrypted Message
description: Provides a resolution for an issue in which users encounter a "Conflicting or unsupported encryption" warning when sending SMIME messages.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom:
  - sap:Send or receive mail
  - Outlook for Windows
  - CSSTroubleshoot
  - CI 2736
ms.reviewer: thomno, gbratton, meerak, v-shorestris
appliesto:
  - Outlook for Microsoft 365
  - Outlook 2024
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
  - Classic Outlook for Windows
search.appverid: MET150
ms.date: 01/17/2025
---

# "Conflicting or unsupported encryption" warning when sending an encrypted message

_Original KB number:_ 9067236

## Symptoms

When a user tries to send an encrypted email message in Microsoft Outlook, an **Encryption Problems** dialog appears. The dialog displays the following warning message:

> Microsoft Outlook had problems encrypting this message because the following recipients had missing or invalid certificates, or conflicting or unsupported capabilities.

The dialog provides options to send the email message either unencrypted or encrypted, or cancel sending, as shown in the following screenshot.

:::image type="content" source="media/outlook-warning-dialog-when-sending-smime-messages-to-recipients-with-ecc-certificates/encryption-problems-dialog.png" border="true" alt-text="Screenshot of an Encryption Problems dialog in Microsoft Outlook." lightbox="media/outlook-warning-dialog-when-sending-smime-messages-to-recipients-with-ecc-certificates/encryption-problems-dialog-lrg.png":::

## Cause

If all the following conditions are true, the warning is a false positive, and you can safely ignore it:

- Message encryption is Secure/Multipurpose Internet Mail Extensions (S/MIME).

- The sender's S/MIME certificate uses the RSA public key cryptography algorithm.

- The recipient's S/MIME certificate uses the ECC public key cryptography algorithm.

> [!TIP]
> To determine whether an S/MIME certificate uses RSA or ECC, examine the **Public key** attribute of the certificate. The attribute value is either `RSA` or `ECC`. You can view certificate attributes in the Microsoft [Certificate Manager](/dotnet/framework/tools/certmgr-exe-certificate-manager-tool) tool (certmrg.msc).

## Workaround

To work around the "false positive" warning, select **Continue** in the **Encryption Problems** dialog to send the S/MIME encrypted message. 

> [!NOTE]
> We recommend that you don't select **Send unencrypted** if encryption is required.

## Resolution

In Outlook for Microsoft 365, version 16.0.18227.20000 and later versions, admins can permanently suppress the "false positive" warning for this issue. To do this, select one of the following methods.

**Note**: This resolution won't prevent the **Encryption Problems** dialog from appearing for other issues, such as a missing or invalid recipient certificate.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For protection, back up the registry before you modify it so that you can restore it if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

### Method A: Suppress the warning for domain-joined users

Run Registry Editor (Regedit) on a domain controller to update Group Policy.

1. Navigate to `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\16.0\Outlook\Security`.

2. Add a DWORD entry that's named `SkipProblemsDialogForDhCertMismatch`. Set the DWORD value to `1`.

### Method B: Suppress the warning for an individual user

Run Regedit on the user's computer.

1. Navigate to `HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook\Security`.

2. Add a DWORD entry that's named `SkipProblemsDialogForDhCertMismatch`. Set the DWORD value to `1`.

3. Restart Outlook.
