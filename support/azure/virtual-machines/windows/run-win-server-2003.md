---
title: Running Windows Server 2003 on Microsoft Azure
description: Provides information about Windows Server 2003 support and answers some of the most common questions about running Windows Server 2003 on Microsoft Azure.
ms.date: 07/21/2020
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-support-statements
ms.collection: windows
---
# Running Windows Server 2003 on Microsoft Azure

This article provides information about Windows Server 2003 support and answers some of the most common questions about running Windows Server 2003 on Microsoft Azure.  

_Original product version:_ &nbsp; Microsoft Windows Server 2003 Datacenter Edition (32-bit x86), Microsoft Windows Server 2003 Enterprise Edition (32-bit x86), Microsoft Windows Server 2003 Standard Edition (32-bit x86), Microsoft Windows Server 2003 Datacenter x64 Edition, Microsoft Windows Server 2003 Enterprise x64 Edition, Microsoft Windows Server 2003 Standard x64 Edition, Microsoft Windows Server 2003 R2 Datacenter Edition (32-Bit x86), Microsoft Windows Server 2003 R2 Enterprise Edition (32-Bit x86), Microsoft Windows Server 2003 R2 Standard Edition (32-bit x86), Microsoft Windows Server 2003 R2 Datacenter x64 Edition with Service Pack 2, Microsoft Windows Server 2003 R2 Enterprise x64 Edition, Microsoft Windows Server 2003 R2 Standard x64 Edition  
_Original KB number:_ &nbsp; 4010166

## Microsoft Windows Server 2003 end-of-support

Microsoft ended extended support for Windows Server 2003 on July 14, 2015. If you are running Windows Server 2003, this may put your applications and business at risk, since there may be no security or software updates. You can still move a Windows Server 2003 VM to Azure, and receive assistance in troubleshooting issues that concern running Windows Server 2003 on Azure. However, this support is limited to issues that don't require OS-level troubleshooting or patch.

Machines running Windows 2003 will no longer receive Microsoft support and may not receive further security updates. Additionally, many compliance requirements include being on a currently supported operating system.

Migrating your applications to Azure instances running a newer version of Windows Server is the recommended approach to ensure that you are effectively leveraging the flexibility and reliability of the Azure cloud. Pre-configured images with different combinations of Windows and SQL Server are available in the Marketplace and enable you to run any compatible solution on our cost-effective, high-performance, reliable cloud computing platform. For more information, see [Windows Server 2003 migration strategy](https://www.microsoft.com/cloud-platform/windows-server-2003).

## Frequently asked questions

**When does extended support for Windows Server 2003 end?**

Windows Server 2003 extended support ended on July 14, 2015.

**Can I run existing Windows Server 2003 instances after the end of extended support?**
  
Yes.

**Can I create a new VM from the custom Windows Server 2003 image after the end of extended support?**  

Yes. You can create a Windows Server 2003 Azure VM from specialized VHD only, not from generalized (Syspreped) VHD.

**Can I create a new Windows Server 2003 VM from the Azure Marketplace?**

For versions that are earlier than Windows Server 2008 R2, there is no Azure Marketplace support. you must provide your own specialized operating system VHD for new Windows Server 2003 VMs.

**Will Microsoft Azure support Windows Server 2003 after July 14, 2015?**
  
The Azure support team continues to offer assistance in troubleshooting issues that concern running Windows Server 2003 on Azure. However, this support is limited to issues that don't require OS-level troubleshooting or patches.

**Can I build custom images that contain updates provided by Microsoft through a custom support agreement?**

Yes. You can create and upload [specialized VHD](/azure/virtual-machines/windows/create-vm-specialized-portal)  only for your own use, including situations in which those images contain updates resulting from a custom support agreement.

**Will I be able to import new Windows Server 2003 virtual machines after the end of extended support?**
  
Yes.

**How can I migrate specifically the apps from Windows Server 2003?**
  
See [Migrate an enterprise web app to Azure App Service](https://azure.microsoft.com/migration/web-applications/).

**If I run Microsoft applications such as SQL Server 2005 on Windows Server 2003, will it be supported after the end of extended support?**
  
Yes. The applications running on Windows Server are supported based on their [lifecycle](https://support.microsoft.com/lifecycle). However, if the application issue requires OS-level troubleshooting or patches, Azure support may not be able to fully resolve the issue.

**Does Microsoft support in-place OS upgrades for my Windows Server 2003 instances?**  
No.

**Do I need to bring my own Windows Server 2003 license to Azure?**
  
Yes, you will need your own Windows Server 2003 license, and it must be valid. For more information, see [Prioritize Your Windows Server 2003 Migration Plans](https://azure.microsoft.com//blog/be-prepared-for-tomorrows-business-prioritize-your-windows-server-2003-migration-plans/).

**Does the Azure VM agent and extensions work in Windows Server 2003?**
  
No. The Azure VM agent and extensions do not support Windows Server 2003.

**What is the maximum number of virtual processors that Windows Serve 2003 Azure VM can support?**  

The maximum supported VM size is two virtual processors. 64-bit OS has been reported to work with a larger number, but this configuration is not officially supported due to limited testing.

**Is 32-bit version of Windows Server 2003 supported on Azure?**  

A: Windows Server 2003 32-bit has the same level of support as 64-bit, but both operating systems are past their end of support date. Microsoft does not support operating systems that are past their [End of Support date](https://support.microsoft.com/lifecycle/search) without a Custom Support Agreement (CSA). However, the Azure infrastructure is supported. See [Microsoft server software support for Microsoft Azure virtual machines](https://support.microsoft.com/help/2721672/microsoft-server-software-support-for-microsoft-azure-virtual-machines) for more information.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
