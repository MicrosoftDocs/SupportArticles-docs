---
title: Windows Server EOS Timeline: Key Dates and Impact for Azure Virtual Machines
description: Provides information about Windows Server 2003 and later versions that are in End of Support (EOS).
ms.date: 08/26/2025
ms.reviewer: v-liuamson 
ms.service: azure-virtual-machines
ms.collection: windows
ms.custom: sap:VM Admin - Windows (Guest OS)
---
# Windows Server EOS timeline for Azure VMs

**Applies to:** :heavy_check_mark: Windows VMs

_Original KB number:_ &nbsp; 4010166

This article provides information about Windows Server support. It also answers some of the most common questions about around End of Support (EOS) for Azure Virtual Machines (VMs) that run on Windows Server operating systems.

> [!IMPORTANT]
> This article applies to Windows Server versions that have reached End of Support (EOS). Microsoft has officially ended support for the following operating systems:
>
> - Windows Server 2003
> - Windows Server 2008/R2
>
> Computers that run the listed operating systems no longer receive Microsoft support and might not receive further security updates. Additionally, many compliance requirements include being on a currently supported operating system.

[!INCLUDE [Azure VM Windows Update / Windows OS Upgrade Diagnostic Tools](~/includes/azure/virtual-machines-runcmd-wu-tools.md)]

We recommend that you migrate your applications to Azure instances that run on a newer version of Windows Server. This move makes sure that you're effectively using the flexibility and reliability of the Azure cloud. Pre-configured images that have different combinations of Windows and Microsoft SQL Server are available in the Marketplace. They enable you to run any compatible solution on our cost-effective, high-performance cloud computing platform. For more information, see [Windows Server 2012 migration strategy](/windows-server/get-started/upgrade-migrate-roles-features).

## Microsoft Windows Server 2008/R2 End of Support (EOS)

Microsoft ended extended support for Windows Server 2008 and 2008 R2 on January 14, 2020, and Azure Extended Security Updates (ESU) support ended on January 9, 2024. Systems that run these versions are no longer eligible for free security updates, nonsecurity updates, or technical support. To maintain security and compliance, Microsoft recommends that you migrate workloads to newer Windows Server versions on Azure.

## Microsoft Windows Server 2003 End of Support (EOS)

Microsoft ended extended support for Windows Server 2003 on July 14, 2015. Running Windows Server 2003 might put your applications and business at risk because there might be no security or software updates for the OS. You can still move a Windows Server 2003 VM to Azure and receive assistance in troubleshooting issues that concern running Windows Server 2003 on Azure. However, this support is limited to issues that don't require OS-level troubleshooting or updates.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
