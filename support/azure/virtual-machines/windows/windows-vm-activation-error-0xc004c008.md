---
title: Error 0xC004C008 The activation server determined that the specified product key can't be used
description: Learn how to resolve the 0xC004C008 error that occurs when you try to activate an Azure Windows virtual machine (VM).
ms.date: 04/14/2026
ms.service: azure-virtual-machines
ms.custom: sap:Cannot activate my Windows VM
ms.collection: windows
ms.reviewer: cwhitley, scotro, v-leedennis
---
# Error 0xC004C008 "The activation server determined that the specified product key could not be used"

**Applies to:** :heavy_check_mark: Windows VMs

This article discusses how to resolve the 0xC004C008 error that occurs when you try to activate a Windows virtual machine (VM) in Microsoft Azure.

[!INCLUDE [virtual-machines-windows-activation-troubleshoot-tools](~/includes/azure/virtual-machines-windows-activation-troubleshoot-tools.md)]

## Prerequisites

- [PowerShell](/powershell/scripting/install/installing-powershell-on-windows)
- The [Software License Manager](/previous-versions//ff793433(v=technet.10)) (*slmgr.vbs*) script

## Symptoms

When you try to activate an Azure Windows VM, you encounter the following error message in Windows Script Host:

> **Error: 0xC004C008** The activation server determined that the specified product key could not be used.

## Cause

This error occurs when the KMS key has exceeded its activation limit. A KMS host key can be used for up to 10 activations on a maximum of 6 computers. If the limit is exceeded, the key is flagged and further activation attempts fail.

On Azure VMs, this error typically occurs in the following scenarios:

- The VM was deployed using a custom image that contains a KMS host key that has already been activated on too many machines.
- A shared KMS key is being reused across multiple VMs in a test or development environment.
- The VM was migrated from an on-premises environment where the same KMS key was heavily reused.

## Solution 1: Reconfigure the VM to use the Azure KMS service

Azure VMs are entitled to activate against Azure's KMS infrastructure at no additional cost. This removes the dependency on a specific KMS host key.

1. Open an elevated Command Prompt window on the VM.

2. Install the correct [KMS client setup key](/windows-server/get-started/kms-client-activation-keys) for your Windows edition:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ipk <kms-client-setup-key>
   ```

3. Configure the Azure KMS endpoint:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /skms azkms.core.windows.net:1688
   ```

4. Retry activation:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

## Solution 2: Contact Microsoft Licensing Activation Centers

If you require a MAK or KMS host key (for example, for VMs in an isolated network), contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/licensing/existing-customer/activation-centers) to request a new key or to reset the activation count on your existing key.

## More information

- [Troubleshoot Azure Windows virtual machine activation problems](troubleshoot-activation-problems.md)
- [Troubleshooting tools for Windows activation issues on Azure VMs](windows-activation-troubleshoot-tools.md)
- [Troubleshoot Windows activation error codes](/troubleshoot/windows-server/licensing-and-activation/troubleshoot-activation-error-codes)
