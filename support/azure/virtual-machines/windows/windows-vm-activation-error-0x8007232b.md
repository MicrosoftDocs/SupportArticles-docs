---
title: Error 0x8007232B - DNS name does not exist when activating Windows
description: Resolve error 0x8007232B when you activate your Azure Windows VM. Troubleshoot DNS name issues by using step-by-step solutions.
ms.date: 04/14/2026
ms.service: azure-virtual-machines
ms.custom: sap:Cannot activate my Windows VM
ms.collection: windows
ms.reviewer: cwhitley, scotro, v-leedennis
---
# Error 0x8007232B - "DNS name does not exist"

**Applies to:** :heavy_check_mark: Windows VMs

## Summary

This article explains how to resolve the 0x8007232B error that occurs when you try to activate a Windows virtual machine (VM) in Microsoft Azure.

[!INCLUDE [virtual-machines-windows-activation-troubleshoot-tools](~/includes/azure/virtual-machines-windows-activation-troubleshoot-tools.md)]

## Prerequisites

- [PowerShell](/powershell/scripting/install/installing-powershell-on-windows)
- The [Software License Manager](/previous-versions/ff793433(v=technet.10)) (*slmgr.vbs*) script
- The [PsPing](/sysinternals/downloads/psping) tool

## Symptoms

When you try to activate a Microsoft Azure Windows VM, you see the following error message in Windows Script Host:

`**Error: 0x8007232B** DNS name does not exist.`

## Cause

This error occurs if the Key Management Services (KMS) client can't find the KMS Service Location (SRV) records in DNS. The Windows activation client tries to locate a KMS server by querying DNS for `_vlmcs._tcp` SRV records. If no KMS SRV records are published in DNS, activation fails.

On Azure VMs, this error typically occurs in the following scenarios:

- The VM is configured to use a custom DNS server that doesn't have KMS SRV records published.
- The VM was migrated from an on-premises environment in which DNS autodiscovery was used to locate a KMS host, and the Azure DNS environment doesn't have those records.
- Network Security Group (NSG) rules or a firewall are blocking DNS resolution.
- The VM is pointed at the wrong KMS host through `slmgr.vbs /skms`, and the DNS name is invalid.

### Solution 1: Reconfigure the VM to use the Azure KMS service

Azure provides a KMS endpoint that doesn't rely on DNS SRV record discovery. Point the VM directly to it.

1. Open an elevated Command Prompt window on the VM.

1. Clear any existing KMS server setting, and configure the Azure KMS endpoint by running the following command:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ckms
   cscript c:\windows\system32\slmgr.vbs /skms azkms.core.windows.net:1688
   ```

1. Verify the VM has the correct [KMS client setup key](/windows-server/get-started/kms-client-activation-keys):

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /dlv
   ```

1. If the product key is incorrect, install the correct KMS client setup key:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ipk <kms-client-setup-key>
   ```

1. Verify network connectivity to the Azure KMS endpoint:

   ```cmd
   psping azkms.core.windows.net:1688
   ```

1. Retry activation:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

### Solution 2: Configure DNS SRV records (self-hosted KMS)

If you use a self-hosted KMS server, make sure that you publish KMS SRV records in DNS.

1. On the KMS host server, open an elevated Command Prompt window, and verify that the KMS service is running. Run the following command:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /dlv
   ```

1. Enable DNS publishing on the KMS host:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /sdns
   ```

1. Alternatively, manually point the client VM to the KMS host by name or IP:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /skms <kms-host-fqdn>:1688
   ```

1. On the client VM, retry activation:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

## References

- [Troubleshoot Azure Windows virtual machine activation problems](troubleshoot-activation-problems.md)
- [Troubleshooting tools for Windows activation issues on Azure VMs](windows-activation-troubleshoot-tools.md)
- [Troubleshoot Windows activation error codes](/troubleshoot/windows-server/licensing-and-activation/troubleshoot-activation-error-codes)
