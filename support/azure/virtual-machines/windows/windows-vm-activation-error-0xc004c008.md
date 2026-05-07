---
title: Error 0xC004C008 - The activation server determined that the specified product key can't be used
description: Resolve error 0xC004C008 when you activate Windows VMs in Azure. Follow the step-by-step solutions to fix KMS key activation limits.
ms.date: 04/14/2026
ms.service: azure-virtual-machines
ms.custom: sap:Cannot activate my Windows VM
ms.collection: windows
ms.reviewer: cwhitley, scotro, v-leedennis
---
# Error 0xC004C008 - "The activation server determined that the specified product key could not be used"

**Applies to:** :heavy_check_mark: Windows VMs

## Summary

This article explains how to resolve error 0xC004C008 that occurs when you try to activate a Windows virtual machine (VM) in Microsoft Azure.

[!INCLUDE [virtual-machines-windows-activation-troubleshoot-tools](~/includes/azure/virtual-machines-windows-activation-troubleshoot-tools.md)]

## Prerequisites

- [PowerShell](/powershell/scripting/install/installing-powershell-on-windows)
- The [Software License Manager](/previous-versions/ff793433(v=technet.10)) (*slmgr.vbs*) script

## Symptoms

When you try to activate a Microsoft Azure Windows VM, you see the following error message in Windows Script Host:

`**Error: 0xC004C008** The activation server determined that the specified product key could not be used.`

## Cause

This error occurs if the KMS key exceeds its activation limit. You can use a Key Management Services (KMS) host key for up to 10 activations on a maximum of six computers. If you exceed the limit, the key is flagged, and further activation attempts fail.

On Azure VMs, this error usually occurs in the following scenarios:

- You deploy the VM by using a custom image that contains a KMS host key that's already activated on too many computers.
- You reuse a shared KMS key across multiple VMs in a test or development environment.
- You migrate the VM from an on-premises environment where you heavily reused the same KMS key.

### Solution 1: Reconfigure the VM to use the Azure KMS service

Azure VMs activate against Azure's KMS infrastructure at no extra cost. This activation removes the dependency on a specific KMS host key.

1. Open an elevated Command Prompt window on the VM.

1. Install the correct [KMS client setup key](/windows-server/get-started/kms-client-activation-keys) for your Windows edition by running the following command:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ipk <kms-client-setup-key>
   ```

1. Configure the Azure KMS endpoint:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /skms azkms.core.windows.net:1688
   ```

1. Retry activation:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

### Solution 2: Contact Microsoft Licensing Activation Centers

If you need an MAK or KMS host key (for example, for VMs that are in an isolated network), contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/licensing/existing-customer/activation-centers) to request a new key or to reset the activation count on your existing key.

## References

- [Troubleshoot Azure Windows virtual machine activation problems](troubleshoot-activation-problems.md)
- [Troubleshooting tools for Windows activation issues on Azure VMs](windows-activation-troubleshoot-tools.md)
- [Troubleshoot Windows activation error codes](/troubleshoot/windows-server/licensing-and-activation/troubleshoot-activation-error-codes)
