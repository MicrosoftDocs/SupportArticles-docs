---
title: 'Windows Client EOS Timeline: Key Dates and Impact for Azure Virtual Machines'
description: Provides information about Windows Client End of Support (EOS).
ms.date: 08/26/2025
ms.reviewer: v-liuamson 
ms.service: azure-virtual-machines
ms.collection: windows
ms.custom: sap:VM Admin - Windows (Guest OS)
---
# Windows Client EOS timeline: Key dates and impact for Azure Virtual Machines

**Applies to:** :heavy_check_mark: Windows VMs

_Original KB number:_ &nbsp; 4010166

This article provides information about Windows Client 10 support and answers some of the most common questions about around End of Support (EOS) for Azure Virtual Machines (VMs) running Windows Client operating systems.

> [!IMPORTANT]
> This article applies to Windows Client versions that have reached End of Support (EOS). Microsoft has officially ended support for the following operating systems:
>
> - Windows 10
>
>Machines running the above listed operating systems will no longer receive Microsoft support and may not receive further security updates. Additionally, many compliance requirements include being on a currently supported operating system.


[!INCLUDE [Azure VM Windows Update Diagnostic Tools](~/includes/azure/runcmd-wu-tools.md)]

## Microsoft 10 (EOS)

Windows 10 is no longer supported except under the Extended Security Updates (ESU) program.  ESU only includes critical and important security updates and does not cover new features or non-security fixes. Support only covers enabling and ensuring ESU is functional. For workloads running on Azure Virtual Machines, ESU is automatically included at no additional cost—no MAK keys or manual activation required.

- [Extended Security Updates (ESU) program for Windows 10](/windows/whats-new/extended-security-updates)
- [Enable Extended Security Updates (ESU)](/windows/whats-new/enable-extended-security-updates)
- [Frequently asked questions](/windows/whats-new/extended-security-updates?source=recommendations#frequently-asked-questions)
- [Lifecycle FAQ - Extended Security Updates](/lifecycle/faq/extended-security-updates)

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
