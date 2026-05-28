---
title: Error 0xC004F042 "The specified Key Management Service (KMS) can't be used" when activating Windows
description: Describes how to troubleshoot and resolve error 0xC004F042 ("The specified Key Management Service (KMS) can't be used"). The steps apply to physical computers, on-premises virtual machines (VMs), and Azure VMs.
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
# Error 0xC004F042 "The specified Key Management Service (KMS) can't be used" when you activate Windows

## Summary

This article explains how to resolve error `0xC004F042 (The Software Licensing Service determined that the specified Key Management Service (KMS) cannot be used.)`. This error might occur if you have multiple KMS hosts that activate different sets of KMS clients. The troubleshooting steps in this article apply to physical computers, on-premises virtual machines (VMs), and Azure VMs.

## Symptoms

When you try to activate a Windows system, you see the following error message in Windows Script Host:

```output
**Error: 0xC004F042** The Software Licensing Service determined that the specified Key Management Service (KMS) cannot be used.
```

## Cause

This error occurs if the KMS client contacts a KMS host that can't activate the client software. This scenario is common in mixed environments that have application-specific and operating system-specific KMS hosts.

This error typically occurs in the following scenarios:

- You configure the KMS client to contact a self-hosted KMS server that doesn't support the Windows edition that's installed on the client.
- The KMS host key doesn't match the product that you're activating (for example, trying to use a Windows Server 2016 KMS key to activate a Windows Server 2022 client).
- You migrate the client from an on-premises environment that uses a different KMS infrastructure.

## Resolution

To resolve this issue, make sure your KMS clients connect to the correct hosts. This factor is particularly important if you're using specific KMS hosts to activate specific applications or operating systems.

To get the best results from these procedures, you should be familiar with the [`slmgr` script](/windows-server/get-started/activation-slmgr-vbs-options).

[!INCLUDE [virtual-machines-windows-activation-troubleshoot-tools](~/includes/azure/virtual-machines-windows-activation-troubleshoot-tools.md)]

1. Open an administrative Command Prompt window on the client.

1. To clear any existing KMS host setting, run the following command:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ckms
   ```

1. To specify a KMS host for activation, run the following command:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /skms <KMSHost_fqdn>:<KMSHost_Port>
   ```

   > [!NOTE]  
   >
   > - In this command, \<KMSHost_fqdn> represents the fully qualified domain name (FQDN) of the KMS host, and \<KMSHost_Port> represents the port that the KMS host uses.
   > - To activate an Azure VM by using the Azure KMS service, use `azkms.core.windows.net` for \<KMSHost_fqdn>, and use `1688` for \<KMSHost_Port.

1. To try again to activate, run the following command:

   ```cmd
   cscript c:\windows\system32\slmgr.vbs /ato
   ```

## References

- [Troubleshoot Windows activation error codes](troubleshoot-activation-error-codes.md)
- [Troubleshoot Azure Windows virtual machine activation problems](../../azure/virtual-machines/windows/troubleshoot-activation-problems.md)
- [Troubleshooting tools for Windows activation issues on Azure VMs](../../azure/virtual-machines/windows/windows-activation-troubleshoot-tools.md)
