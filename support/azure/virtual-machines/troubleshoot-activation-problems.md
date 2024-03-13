---
title: Troubleshoot Windows virtual machine activation problems in Azure
description: Provides the troubleshoot steps for fixing Windows virtual machine activation problems in Azure
services: virtual-machines, azure-resource-manager
author: genlin
tags: top-support-issue, azure-resource-manager
ms.service: virtual-machines
ms.subservice: vm-windows-activation
ms.collection: windows
ms.workload: na
ms.tgt_pltfrm: vm-windows
ms.topic: troubleshooting-problem-resolution
ms.date: 03/13/2024
ms.author: genli
ms.reviewer: cwhitley, jusilver, v-naqviadil, v-leedennis, v-weizhu
---
# Troubleshoot Azure Windows virtual machine activation problems

[!INCLUDE [Feedback](../../includes/feedback.md)]

This article helps you troubleshoot an activation issue that occurs when you create a Microsoft Azure Windows Virtual Machine (VM).

## Understanding Azure KMS endpoints for Windows product activation of Azure Virtual Machines

Azure uses different endpoints for Key Management Services (KMS) activation depending on the cloud region in which the VM resides. When using this troubleshooting guide, use the appropriate KMS endpoint that applies to your region.

| Region | KMS endpoint |
|--|--|
| Azure public cloud regions | `azkms.core.windows.net:1688` |
| Azure China 21Vianet national cloud regions | `kms.core.chinacloudapi.cn:1688` or `azkms.core.chinacloudapi.cn:1688` |
| Azure Germany national cloud regions | `kms.core.cloudapi.de:1688` |
| Azure US Gov national cloud regions | `kms.core.usgovcloudapi.net:1688` |

> [!NOTE]
> `kms.core.windows.net` for Azure public cloud regions was updated to `azkms.core.windows.net` in July of 2022. For more information, see [KMS endpoints - new endpoints](windows-activation-stopped-working.md).

## Troubleshoot Windows activation issues

To troubleshoot a Windows activation issue, follow these steps:

1. Get the error message and the error code:

    1. Open a command prompt as an administrator
    2. Type `slmgr.vbs /ato` and press Enter.
        
        This command will try to activate Windows using the current product key and display the result.

    3. If the activation fails, you will receive an error message and an error code. For example,

       > Error: 0xC004F074 The Software Licensing Service reported that the computer could not be activated. No Key Management Service (KMS) could be contacted.
    
       The error code and message will help identify the possible cause and solution of the activation issue.

2. Search the error message and error code online for possible solutions or check known errors and issues below:

    |Known error codes|error message or issue|
    |---|---|
    |Error 0xC004F074|["No Key Management Service (KMS) could be contacted"](windows-vm-activation-error-0xc004f074.md)|
    |Error 0xC004FD01|["Windows isn't running on a supported Microsoft Hyper-V virtualization platform"](windows-vm-activation-error-0xc004fd01-0xc004fd02.md)|
    |Error 0xC004FD02|["Windows isn't activated on the host machine. Please contact your system administrator"](windows-vm-activation-error-0xc004fd01-0xc004fd02.md)|
    |Error 0xC004F06C|["The Key Management Service (KMS) determined that the request timestamp is invalid"](../../windows-server/licensing-and-activation/error-0xc004f06c-activate-windows.md)|
    |Error 0xC004E015|["On a computer running Microsoft Windows non-core edition, run 'slui.exe 0x2a 0xC004E015' to display the error text"](../../windows-server/installing-updates-features-roles/error-0xc004e015-sl-e-eul-consumption-failed-activate-windows.md)|
    |Error 0x800705B4|["A problem occurred when Windows tried to activate. Error Code 0x800705B4"](windows-vm-activation-error-0x800705b4.md)|
    |Error 0x80070005|["Access denied: the requested action requires elevated privileges"](../../windows-server/installing-updates-features-roles/error-0x80070005-access-denied.md)|
    |N/A|[Windows activation fails in forced tunneling scenario](custom-routes-enable-kms-activation.md)|
    |N/A|[Windows activation - duplicate Client Machine ID](windows-activation-duplicate-client-machine-id.md)|

## More information

- [Azure Windows virtual machine activation FAQ](./windows-virtual-machine-activation-faq.yml)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
