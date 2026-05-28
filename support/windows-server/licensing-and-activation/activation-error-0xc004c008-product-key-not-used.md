---
title: Error 0xC004C008 "The specified product key could not be used" when you activate Windows
description: Discusses how to resolve error 0xC004C008 ("The activation server determined that the specified product key could not be used"). This error occurs if your Key Management Services (KMS) host key exceeds its activation limit.
ms.date: 05/28/2026
ms.collection: windows
ai.usage: ai-assisted
ms.reviewer: cwhitley, scotro, v-leedennis, kaushika, v-appelgatet
manager: dcscontentpm
audience: itpro
ms.custom: 
  - sap:Windows Activation\Windows activation issues
  - pcy:WinComm Devices Deploy
appliesto:
  - ✅ <a href=https://learn.microsoft.com/lifecycle/products/azure-virtual-machine target=_blank>Supported versions of Azure Virtual Machine</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Error 0xC004C008 "The specified product key could not be used" when you activate Windows

## Summary

When you try to activate Windows, you might receive error 0xC004C008 if your Key Management Services (KMS) host key exceeds its activation limit. The troubleshooting steps in this article help you to reset the key, obtain a new key, or, for Azure virtual machines (VMs), use the Azure KMS service to activate. The steps apply to physical computers, on-premises VMs, and Azure VMs.

## Symptoms

When you try to activate a Windows system, you see the following error message in Windows Script Host:

```output
**Error: 0xC004C008** The activation server determined that the specified product key could not be used.
```

## Cause

This error occurs if the Key Management Services (KMS) host key exceeds its activation limit. You can use a KMS host key for up to 10 activations on a maximum of six computers. If you exceed the limit, the key is flagged, and further activation attempts fail.

This error typically occurs in the following scenarios:

- You deploy Windows by using a custom image that contains a KMS host key that was used to activate too many computers.
- You reuse a shared KMS key across multiple Windows systems in a test or development environment.
- You migrate a virtual machine (VM) from an on-premises environment to the Azure environment. The on-premises environment reused the same KMS key many times.

## Resolution

Use the following steps to troubleshoot and fix the issue. To get the best results from these procedures, you should be familiar with the [`slmgr` script](/windows-server/get-started/activation-slmgr-vbs-options).

[!INCLUDE [virtual-machines-windows-activation-troubleshoot-tools](~/includes/azure/virtual-machines-windows-activation-troubleshoot-tools.md)]

### Step 1: Get a new key or reset the existing key

If you need an MAK or KMS host key (for example, for VMs that are in an isolated network), contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/licensing/existing-customer/activation-centers). There, you can request a new key or to have the activation count on your existing key be reset.

If you're trying to activate an Azure VM, and your infrastructure doesn't require a KMS key for a self-hosted KMS host, you can try Step 2.

### Step 2 (Azure VMs): Activate by using Azure KMS

By default, Azure VMs should use Azure Key Management Service (KMS) activation. If the VM uses a Multiple Activation Key (MAK) or a KMS key for a self-hosted KMS server instead, reconfigure the VM to use Azure KMS:

1. Open an administrative Command Prompt window on the Azure VM.

1. Set the appropriate [KMS client setup key](/windows-server/get-started/kms-client-activation-keys) for your Windows version. For example, for Windows Server 2022 Datacenter, run the following command:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ipk WX4NM-KYWYW-QJJR4-XV3QB-6VM33
   ```

1. To configure the Azure VM to use Azure KMS, run the following command:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /skms azkms.core.windows.net:1688
   ```

1. To try again to activate, run the following command:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

If activation fails and generates the same error, contact Microsoft Support for assistance.

## References

- [Troubleshoot Windows activation error codes](/troubleshoot/windows-server/licensing-and-activation/troubleshoot-activation-error-codes)
- [Slmgr.vbs options for obtaining volume activation information](/windows-server/get-started/activation-slmgr-vbs-options)
- [Troubleshoot Azure Windows virtual machine activation problems](../../azure/virtual-machines/windows/troubleshoot-activation-problems.md)
- [Troubleshooting tools for Windows activation issues on Azure VMs](../../azure/virtual-machines/windows/windows-activation-troubleshoot-tools.md)
