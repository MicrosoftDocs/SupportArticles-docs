---
title: Error 0xC004F042 - The specified Key Management Service (KMS) cannot be used
description: Fix error 0xC004F042 when you activate an Azure Windows VM by correcting KMS settings and making sure that the KMS host supports the Windows edition.
ms.date: 04/14/2026
ms.service: azure-virtual-machines
ms.custom: sap:Cannot activate my Windows VM
ms.collection: windows
ms.reviewer: cwhitley, scotro, v-leedennis
---
# Error 0xC004F042 - "The specified Key Management Service (KMS) cannot be used"

**Applies to:** :heavy_check_mark: Windows VMs

This article explains how to resolve error 0xC004F042 that which occurs when you try to activate a Windows virtual machine (VM) in Microsoft Azure.

[!INCLUDE [virtual-machines-windows-activation-troubleshoot-tools](~/includes/azure/virtual-machines-windows-activation-troubleshoot-tools.md)]

## Prerequisites

- [PowerShell](/powershell/scripting/install/installing-powershell-on-windows)
- The [Software License Manager](/previous-versions/ff793433(v=technet.10)) (*slmgr.vbs*) script
    
## Symptoms

When you try to activate a Microsoft Azure Windows VM, you see the following error message in Windows Script Host:

> **Error: 0xC004F042** The Software Licensing Service determined that the specified Key Management Service (KMS) cannot be used.

## Cause

This error occurs if the KMS client contacts a KMS host that can't activate the client software. This scenario is common in mixed environments that have application-specific and operating system-specific KMS hosts.

On Azure VMs, this error typically occurs in the following scenarios:

- You configure the VM to contact a self-hosted KMS server that doesn't support the Windows edition installed on the VM.
- The KMS host key doesn't match the product that you're activating (for example, trying to use a Windows Server 2016 KMS key to activate a Windows Server 2022 client).
- You migrated the VM from an on-premises environment where a different KMS infrastructure is used.

### Solution 1: Reconfigure the VM to use the Azure KMS service

Azure KMS supports all Windows editions that are eligible for Azure activation. Reset the VM to use Azure KMS:

1. Open an elevated Command Prompt window on the VM.

1. Clear any existing KMS server setting, and configure the Azure KMS endpoint by running the following command:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ckms
   cscript c:\windows\system32\slmgr.vbs /skms azkms.core.windows.net:1688
   ```

1. Verify that the VM has the correct [KMS client setup key](/windows-server/get-started/kms-client-activation-keys) for your Windows edition. Check the current configuration:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /dlv
   ```

1. If the product key doesn't match the installed edition, install the correct KMS client setup key:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ipk <kms-client-setup-key>
   ```

1. Retry activation:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

### Solution 2: Make sure that the correct KMS host is targeted (self-hosted KMS)

If you intentionally use a self-hosted KMS server:

1. Verify that the KMS host has a KMS key that supports the Windows edition on the client VM.

1. If you use separate KMS hosts for different applications or OS versions, make sure that the client is pointed at the correct host by running the following command:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /skms <correct-kms-host>:1688
   ```

1. Retry activation:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

## References

- [Troubleshoot Azure Windows virtual machine activation problems](troubleshoot-activation-problems.md)
- [Troubleshooting tools for Windows activation issues on Azure VMs](windows-activation-troubleshoot-tools.md)
- [Troubleshoot Windows activation error codes](/troubleshoot/windows-server/licensing-and-activation/troubleshoot-activation-error-codes)
