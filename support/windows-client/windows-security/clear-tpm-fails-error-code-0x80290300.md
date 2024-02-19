---
title: Clear TPM fails with error code 0x80290300
description: Fixes the error code 0x80290300 that occurs when you clear TPM information.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:secure-boot-and-uefi, csstroubleshoot
---
# Clear TPM fails with error code: 0x80290300

This article helps fix the error code 0x80290300 that occurs when you try to clear the TPM information.

_Applies to:_ &nbsp; Window 10 – all editions  
_Original KB number:_ &nbsp; 2561178

## Symptoms

On certain laptops or notebooks, when you attempt to clear TPM information you may receive the following error:

> 0x80290300: A general error was detected when attempting to acquire the BIOS's response to a Physical Presence command.

:::image type="content" source="media/clear-tpm-fails-error-code-0x80290300/clear-tpm.png" alt-text="Screenshot of the Cannot clear the TPM error." border="false":::

## Cause

This issue is likely to happen when you have options like "RESET of TPM from OS" or "OS Management of TPM" disabled in the BIOS.

## Resolution

Enable "RESET of TPM from OS" and "OS Management of TPM" option under System BIOS -> Security -> TPM Embedded Security page. Once done, this should help clear the TPM from operating system.

## More information

To help protect against malware taking control of your computer's Trusted Platform Module (TPM) security hardware, computer manufacturers require users to establish "physical presence" before performing administrative tasks on the TPM, such as:

* Clearing an existing Owner from the TPM. (TPM_ForceClear Command)
* Temporarily deactivating a TPM. (TPM_SetTempDeactivated Command)
* Temporarily disabling a TPM. (TPM_PhysicalDisable Command)

Physical presence implies a level of control and authorization to perform basic administrative tasks and to bootstrap management and access control mechanisms.

Clearing the TPM cancels the TPM ownership and resets it to factory defaults. This should be done when a TPM-equipped client computer is recycled, or when the TPM owner has lost the TPM owner password.

You can clear the TPM or perform a limited number of TPM management tasks without entering the TPM owner password by just being present at the computer (Runs TPM_ForceClear Command). A physical presence isn't required to clear the TPM, if you have the TPM owner password (Runs TPM_OwnerClear command).

CAUTION: Clearing the TPM resets it to factory defaults. You'll lose all created keys and any data protected only by those keys.

For more information about TPM and how to manage TPM in Windows, see the TechNet Article [Windows Trusted Platform Module Management Step-by-Step Guide](https://technet.microsoft.com/library/cc749022%28WS.10%29.aspx).

For information about how to modify the BIOS, contact the BIOS manufacturer.
