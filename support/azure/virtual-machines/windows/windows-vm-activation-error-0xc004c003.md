---
title: Error 0xC004C003 - The activation server determined the specified product key is blocked
description: Resolve error 0xC004C003 when you activate Windows VMs in Azure. Follow the step-by-step guidance to fix blocked product key issues.
ms.date: 04/14/2026
ms.service: azure-virtual-machines
ms.custom: sap:Cannot activate my Windows VM
ms.collection: windows
ms.reviewer: cwhitley, scotro, v-leedennis
---
# Error 0xC004C003 - "The activation server determined the specified product key is blocked"

**Applies to:** :heavy_check_mark: Windows VMs

## Summary

This article explains how to resolve error 0xC004C003 that occurs when you try to activate a Windows virtual machine (VM) in Microsoft Azure.

[!INCLUDE [virtual-machines-windows-activation-troubleshoot-tools](~/includes/azure/virtual-machines-windows-activation-troubleshoot-tools.md)]

## Prerequisites

- [PowerShell](/powershell/scripting/install/installing-powershell-on-windows)
- The [Software License Manager](/previous-versions/ff793433(v=technet.10)) (*slmgr.vbs*) script

## Symptoms

When you try to activate a Microsoft Azure Windows VM, you see the following error message in Windows Script Host:

`**Error: 0xC004C003** The activation server determined the specified product key is blocked.`

## Cause

The Multiple Activation Key (MAK) that you configured on the VM is blocked on the Microsoft activation server. This block can occur if:

- The product key is reported as stolen or misused.
- The product key is a trial or evaluation key that expires.
- The product key doesn't match the installed Windows edition.
- The VM is migrated from an on-premises environment by having a product key that isn't valid for Azure.

### Solution 1: Reconfigure the VM to use Azure KMS activation

By default, Azure VMs should use Azure Key Management Service (KMS) activation. If the VM uses a Multiple Activation Key (MAK) instead, reconfigure it to use Azure KMS.

1. Open an elevated Command Prompt window on the VM.

1. Set the appropriate [KMS client setup key](/windows-server/get-started/kms-client-activation-keys) for your Windows version. For example, for Windows Server 2022 Datacenter, run the following command:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ipk WX4NM-KYWYW-QJJR4-XV3QB-6VM33
   ```

1. Set the Azure KMS endpoint:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /skms azkms.core.windows.net:1688
   ```

1. Retry activation:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

### Solution 2: Obtain a new MAK (if MAK activation is required)

If your licensing model requires MAK activation:

1. Contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/Licensing/existing-customer/activation-centers) to obtain a new MAK.

1. After you receive the new MAK, install it on the VM by running the following command:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ipk <new-mak-key>
   ```

1. Retry activation:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

## References

- [Troubleshoot Azure Windows virtual machine activation problems](troubleshoot-activation-problems.md)
- [Troubleshooting tools for Windows activation issues on Azure VMs](windows-activation-troubleshoot-tools.md)
- [Troubleshoot Windows activation error codes](/troubleshoot/windows-server/licensing-and-activation/troubleshoot-activation-error-codes)
