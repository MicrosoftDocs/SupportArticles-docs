---
title: Error 0xC004F038 - The count reported by your Key Management Service (KMS) is insufficient
description: Fix error 0xC004F038 when activating an Azure Windows VM by correcting KMS settings and activation count thresholds. Follow these steps now.
ms.date: 04/14/2026
ms.service: azure-virtual-machines
ms.custom: sap:Cannot activate my Windows VM
ms.collection: windows
ms.reviewer: cwhitley, scotro, v-leedennis
---
# Error 0xC004F038 - "The count reported by your Key Management Service (KMS) is insufficient"

**Applies to:** :heavy_check_mark: Windows VMs

## Summary

This article explains how to resolve error 0xC004F038, which occurs when you try to activate a Windows virtual machine (VM) in Microsoft Azure.

[!INCLUDE [virtual-machines-windows-activation-troubleshoot-tools](~/includes/azure/virtual-machines-windows-activation-troubleshoot-tools.md)]

## Prerequisites

- [PowerShell](/powershell/scripting/install/installing-powershell-on-windows).
- The [Software License Manager](/previous-versions/ff793433(v=technet.10)) (*slmgr.vbs*) script.

## Symptoms

When you try to activate an Azure Windows VM, you see  the following error message in Windows Script Host:

`**Error: 0xC004F038** The Software Licensing Service reported that the computer could not be activated. The count reported by your Key Management Service (KMS) is insufficient. Please contact your system administrator.`

## Cause

This error occurs when the KMS host count isn't high enough to activate the client. The KMS activation threshold requires a minimum number of unique computers requesting activation.

- For Windows Server, the KMS count must be greater than or equal to five (5).
- For Windows client operating systems, the KMS count must be greater than or equal to 25.

You most commonly see this error in environments that use a self-hosted KMS server rather than the Azure KMS service. Azure VMs that use the default Azure KMS endpoints (`azkms.core.windows.net`) typically don't encounter this error because the Azure KMS service handles activation counts automatically.

## Scenarios where this error occurs on Azure VMs

- You migrated the VM from an on-premises environment and it's still configured to use a self-hosted KMS server.
- You deployed a custom KMS host in Azure, and the KMS pool doesn't have enough unique client computers.
- You manually changed the VM's KMS configuration to point to a KMS server that doesn't meet the activation threshold.

## Solution 1: Reconfigure the VM to use the Azure KMS service

If the VM should use Azure KMS (the default for Azure VMs), reset the KMS configuration:

1. Open an elevated Command Prompt window on the VM.

1. Clear the existing KMS server setting and set the Azure KMS endpoint by running the following commands:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ckms
   cscript c:\windows\system32\slmgr.vbs /skms azkms.core.windows.net:1688
   ```

1. Set the appropriate [KMS client setup key](/windows-server/get-started/kms-client-activation-keys) for your Windows version:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ipk <kms-client-setup-key>
   ```

1. Retry activation:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

## Solution 2: Add computers to the KMS pool (self-hosted KMS)

If you use a self-hosted KMS server, add more computers to the KMS pool to reach the activation threshold:

1. Run the following command on the KMS host to check the current count:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /dli
   ```

1. Add more computers to the KMS pool until the count reaches the required threshold (five (5) for server, 25 for client).

1. After the count is sufficient, retry activation on the affected VM:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

## Resources

- [Troubleshoot Azure Windows virtual machine activation problems](troubleshoot-activation-problems.md)
- [Troubleshooting tools for Windows activation issues on Azure VMs](windows-activation-troubleshoot-tools.md)
- [Troubleshoot Windows activation error codes](/troubleshoot/windows-server/licensing-and-activation/troubleshoot-activation-error-codes)
