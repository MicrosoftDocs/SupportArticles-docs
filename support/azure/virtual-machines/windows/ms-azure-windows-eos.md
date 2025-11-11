---
title: 'Windows Server EOS Timeline: Key Dates and Impact for Azure Virtual Machines'
description: Provides information about Windows Server 2003 and later versions End of Support (EOS).
ms.date: 08/26/2025
ms.reviewer: v-liuamson 
ms.service: azure-virtual-machines
ms.collection: windows
ms.custom: sap:VM Admin - Windows (Guest OS)
---
# Windows Server EOS timeline: Key dates and impact for Azure Virtual Machines

**Applies to:** :heavy_check_mark: Windows VMs

_Original KB number:_ &nbsp; 4010166

This article provides information about Windows Server support and answers some of the most common questions about around End of Support (EOS) for Azure Virtual Machines (VMs) running Windows Server operating systems.

> [!IMPORTANT]
> This article applies to Windows Server versions that have reached End of Support (EOS). Microsoft has officially ended support for the following operating systems:
>
> - Windows Server 2003
> - Windows Server 2008/R2
>
>Machines running the above listed operating systems will no longer receive Microsoft support and may not receive further security updates. Additionally, many compliance requirements include being on a currently supported operating system.


[!INCLUDE [Azure VM Windows Update Diagnostic Tools](~/includes/azure/virtual-machines-runcmd-wu-tools.md)]

Migrating your applications to Azure instances running a newer version of Windows Server is the recommended approach to ensure that you are effectively leveraging the flexibility and reliability of the Azure cloud. Pre-configured images with different combinations of Windows and SQL Server are available in the Marketplace and enable you to run any compatible solution on our cost-effective, high-performance, reliable cloud computing platform. For more information, see [Windows Server 2012 migration strategy](/windows-server/get-started/upgrade-migrate-roles-features).

## Microsoft Windows Server 2008/R2 End of Support (EOS)

Microsoft ended extended support for Windows Server 2008 and 2008 R2 on January 14, 2020, and Azure Extended Security Updates (ESU) support ended on January 9, 2024. Systems running these versions are no longer eligible for free security updates, non-security patches, or technical support. To maintain security and compliance, Microsoft recommends migrating workloads to newer Windows Server versions on Azure.

## Microsoft Windows Server 2003 End of Support (EOS)

Microsoft ended extended support for Windows Server 2003 on July 14, 2015. If you are running Windows Server 2003, this may put your applications and business at risk, since there may be no security or software updates. You can still move a Windows Server 2003 VM to Azure and receive assistance in troubleshooting issues that concern running Windows Server 2003 on Azure. However, this support is limited to issues that don't require OS-level troubleshooting or patch.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
