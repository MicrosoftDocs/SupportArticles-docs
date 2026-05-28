---
title: Error 0xC004F038 The count reported by your Key Management Service (KMS) is insufficient when activating Windows
description: Discusses how to troubleshoot and resolve error 0xC004F038 ("The count reported by your Key Management Service (KMS) is insufficient"). The steps apply to physical computers, on-premises virtual machines (VMs), and Azure VMs.
ms.date: 05/29/2026
ms.collection: windows
ms.reviewer: cwhitley, scotro, v-leedennis, kaushika, v-appelgatet
ms.custom: 
  - sap:Windows Activation\Windows activation issues
appliesto:
  - ✅ <a href=https://learn.microsoft.com/lifecycle/products/azure-virtual-machine target=_blank>Supported versions of Azure Virtual Machine</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Error 0xC004F038 "The count reported by your Key Management Service (KMS) is insufficient" when you activate Windows

This article explains how to resolve error `0xC00F038 (The count reported by your Key Management Service (KMS) is insufficient)`. This error might appear when you use a self-hosted KMS host to activate Windows. The article reviews the common causes of this issue, and provides steps to resolve them. The troubleshooting steps in this article apply to physical computers, on-premises virtual machines (VMs), and Azure VMs.

## Symptoms

When you try to activate a Windows system, you see the following error message in Windows Script Host:

```output
The Software Protection Service reported that the computer couldn't be activated. The count reported by your Key Management Service (KMS) is insufficient. Please contact your system administrator.
```

Typically, this message indicates that the KMS host doesn't have enough computers in its KMS pool.

## Cause

When you use a self-hosted KMS host (either on-premises or in Azure), you have to have a sufficient number of computers in the KMS pool before you can use the KMS host for activation. The following conditions apply:

- For Windows Server-based computers (including virtual machines (VMs)), the KMS count must be greater than or equal to five. 
- For Windows Client-based computers (including VMs), the KMS count must be greater than or equal to 25.

> [!NOTE]  
> Azure VMs that use the default Azure KMS endpoints (`azkms.core.windows.net`) typically don't encounter this error because the Azure KMS service handles activation counts automatically.

## Resolution

To troubleshoot and fix the issue, follow these steps. To get the best results from these procedures, you should be familiar with the [`slmgr` script](/windows-server/get-started/activation-slmgr-vbs-options).

[!INCLUDE [virtual-machines-windows-activation-troubleshoot-tools](~/includes/azure/virtual-machines-windows-activation-troubleshoot-tools.md)]

### Step 1: Add computers to the KMS pool

1. To obtain the current count on the KMS host, run `Slmgr.vbs /dli` in an administrative Command Prompt window on the KMS host computer. 

1. Add unique KMS client computers until the count reaches the appropriate threshold.

1. To try again to activate, run the following command in an administrative Command Prompt window on the KMS client:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

1. If the activation fails, take one of the following actions:

   - If the affected computer is an Azure VM, go to step 2.
   - Contact Microsoft Support for assistance.

### Step 2 (Azure VMs): Activate by using Azure KMS

By default, Azure VMs should use Azure Key Management Service (KMS) activation. If you don't have to use a self-hosted KMS host, reconfigure Azure VMs to use Azure KMS.

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
- [Troubleshoot Azure Windows virtual machine activation problems](../../azure/virtual-machines/windows/troubleshoot-activation-problems.md)
- [Troubleshooting tools for Windows activation issues on Azure VMs](../../azure/virtual-machines/windows/windows-activation-troubleshoot-tools.md)
