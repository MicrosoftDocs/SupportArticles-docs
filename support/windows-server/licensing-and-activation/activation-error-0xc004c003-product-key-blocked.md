---
title: Error 0xC004C003 "the specified product key is blocked" when activating Windows
description: Discusses how to troubleshoot and resolve error 0xC004C003 ("the specified product key is blocked"). The steps apply to physical computers, on-premises virtual machines (VMs), and Azure VMs.
ms.date: 05/27/2026
ms.collection: windows
ms.reviewer: cwhitley, scotro, v-leedennis, kaushika, v-appelgatet
ms.custom: 
  - sap:Windows Activation\Windows activation issues
appliesto:
  - ✅ <a href=https://learn.microsoft.com/lifecycle/products/azure-virtual-machine target=_blank>Supported versions of Azure Virtual Machine</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Error 0xC004C003 "product key is blocked" when you use MAK to activate Windows

## Summary

This article explains how to resolve error `0xC004C003 (The activation server determined the specified product key is blocked)`. This error might appear when you use a Multiple Activation Key (MAK) to activate Windows. The article reviews the common causes of this issue, and provides steps to resolve them. The troubleshooting steps in this article apply to physical computers, on-premises virtual machines (VMs), and Azure VMs.

## Symptoms

When you try to activate a Windows system, you see the following error message in Windows Script Host:

```output
**Error: 0xC004C003** The activation server determined the specified product key is blocked.
```

## Cause

The MAK that you configured on the client is blocked on the activation server. Situations that cause the activation server to block a key include the following scenarios:

- The product key is reported as stolen or misused.
- The product key is a trial or evaluation key that expires.
- The product key doesn't match the installed Windows edition.
- The client was originally an on-premises physical computer or virtual machine (VM), and was migrated to the Azure environment. The original product key isn't valid for Azure.

## Resolution

Use the following steps to troubleshoot and fix the issue. To get the best results from these procedures, you should be familiar with the [`slmgr` script](/windows-server/get-started/activation-slmgr-vbs-options).

[!INCLUDE [virtual-machines-windows-activation-troubleshoot-tools](~/includes/azure/virtual-machines-windows-activation-troubleshoot-tools.md)]

### Step 1: Obtain a new MAK

If your licensing model requires MAK activation, follow these steps:

1. Contact the [Microsoft Licensing Activation Centers](https://www.microsoft.com/Licensing/existing-customer/activation-centers) to obtain a new MAK.

1. To install the new MAK, open an administrative Command Prompt window on the client, and then run the following command:

```cmd
   slmgr -/ipk <xxxxx-xxxxx-xxxxx-xxxxx-xxxxx>
```

> [!NOTE]  
> In this command, \<xxxxx-xxxxx-xxxxx-xxxxx-xxxxx> represents your MAK product key.

1. To try again to activate, run the following command:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

1. If the activation fails, take one of the following actions:

   - If the affected computer is an Azure VM, go to step 2.
   - Contact Microsoft Support for assistance.

### Step 2 (Azure VMs): Activate by using Azure KMS

By default, Azure VMs should use Azure Key Management Service (KMS) activation. If the VM uses a Multiple Activation Key (MAK) instead, reconfigure it to use Azure KMS.

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

If activation fails and generates the same error, Contact Microsoft Support for assistance.

## References

- [Troubleshoot Windows activation error codes](/troubleshoot/windows-server/licensing-and-activation/troubleshoot-activation-error-codes)
- [DNS troubleshooting guidance](../networking/troubleshoot-dns-guidance.md)
- [Guidelines for troubleshooting DNS-related activation issues](/windows-server/get-started/common-troubleshooting-procedures-kms-dns)
- [Troubleshoot Azure Windows virtual machine activation problems](../../azure/virtual-machines/windows/troubleshoot-activation-problems.md)
- [Troubleshooting tools for Windows activation issues on Azure VMs](../../azure/virtual-machines/windows/windows-activation-troubleshoot-tools.md)
- [Configure DNS name resolution for Azure virtual networks](/azure/virtual-network/virtual-networks-name-resolution-for-vms-and-role-instances)
- [Azure IP address 168.63.129.16 overview](/azure/virtual-network/what-is-ip-address-168-63-129-16)
