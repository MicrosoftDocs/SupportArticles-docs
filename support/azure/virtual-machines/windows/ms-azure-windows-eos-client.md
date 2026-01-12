---
title: Windows Client EOS Timeline - Key Dates and Impact for Azure Virtual Machines
description: Provides information about Windows Client End of Support (EOS).
author: JarrettRenshaw
ms.author: scotro
manager: dcscontentpm
ms.date: 08/26/2025
ms.reviewer: v-liuamson, v-ryanberg, v-gsitser 
ms.service: azure-virtual-machines
ms.collection: windows
ms.custom: sap:VM Admin - Windows (Guest OS)
---
# Windows Client EOS timeline for Azure VMs

**Applies to:** :heavy_check_mark: Windows VMs

_Original KB number:_ &nbsp; 4010166

This article provides information about Windows Client 10 support, and answers some of the most common questions about End of Support (EOS) for Azure virtual machines (VMs) that run on Windows Client operating systems.

> [!IMPORTANT]
> This article applies to Windows Client versions that reached End of Support (EOS). Microsoft officially ended support for the following operating systems:
>
> - Windows 10
>
> Computers that run the listed operating systems no longer receive Microsoft support and might not receive further security updates. Additionally, many compliance requirements include being on a currently supported operating system.


[!INCLUDE [Azure VM Windows Update / Windows OS Upgrade Diagnostic Tools](~/includes/azure/virtual-machines-runcmd-wu-tools.md)]

## Microsoft 10 (EOS)

Windows 10 is no longer supported except under the Extended Security Updates (ESU) program. ESU includes only critical and important security updates. It doesn't cover new features or non-security fixes. Support covers only enabling and ensuring that ESU is functional. For workloads that run on Azure VMs, ESU is automatically included at no additional cost. No MAK keys or manual activation is required.

- [Extended Security Updates (ESU) program for Windows 10](/windows/whats-new/extended-security-updates)
- [Enable Extended Security Updates (ESU)](/windows/whats-new/enable-extended-security-updates)
- [Frequently asked questions](/windows/whats-new/extended-security-updates?source=recommendations#frequently-asked-questions)
- [Lifecycle FAQ - Extended Security Updates](/lifecycle/faq/extended-security-updates)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
