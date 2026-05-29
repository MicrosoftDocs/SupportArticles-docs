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

- The KMS host key has already been used to set up other KMS hosts. For example, you reuse a shared KMS key across multiple KMS hosts in a test or development environment.
- The KMS host key was used incorrectly to activate non-KMS host.
- The KMS host role was moved to new server.

## Resolution

Use the following steps to troubleshoot and fix the issue. To get the best results from these procedures, you should be familiar with the [`slmgr` script](/windows-server/get-started/activation-slmgr-vbs-options).

[!INCLUDE [virtual-machines-windows-activation-troubleshoot-tools](~/includes/azure/virtual-machines-windows-activation-troubleshoot-tools.md)]

### Step 1: Get a new key or reset the existing key

> [!IMPORTANT]  
> To request more KMS activations to activate more than six KMS hosts, you must have the VL Administrator or Product keys reader role.

If you need a KMS host key (for example, for VMs that are in an isolated network), contact [Microsoft Volume License Key assisted support](https://www.microsoft.com/licensing/existing-customer/activation-centers). There, you can find the appropriate contact information to request a new key or to have the activation count on your existing key be reset.

You can also request additional activations through the [Microsoft Engage Center request form](https://support.serviceshub.microsoft.com/supportforbusiness/create?sapId=2afa6f15-b710-db46-909a-8346017c802f). Provide the following information on the web form:

- Agreement number, enrollment number, or license ID
- Product name (including version and edition)
- The number of host activations that you need
- Business justification or reason for deployment

If you're trying to activate an Azure VM, and your infrastructure doesn't require a KMS key for a self-hosted KMS host, you can try Step 2.

### Step 2 (Azure VMs): Activate by using Azure KMS

By default, Azure VMs should use Azure Key Management Service (KMS) activation. If the VM uses a KMS key for a self-hosted KMS server instead, reconfigure the VM to use Azure KMS:

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

- [KMS client activation and product keys](/windows-server/get-started/kms-client-activation-keys)
- [Troubleshoot Windows activation error codes](troubleshoot-activation-error-codes.md)
- [Slmgr.vbs options for obtaining volume activation information](/windows-server/get-started/activation-slmgr-vbs-options)
- [Troubleshoot Azure Windows virtual machine activation problems](../../azure/virtual-machines/windows/troubleshoot-activation-problems.md)
- [Troubleshooting tools for Windows activation issues on Azure VMs](../../azure/virtual-machines/windows/windows-activation-troubleshoot-tools.md)
