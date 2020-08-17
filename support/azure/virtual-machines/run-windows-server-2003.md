---
title: Run Windows Server 2003 on Microsoft Azure
description: Provides information about Microsoft support for running Windows Server 2003 VMs on Microsoft Azure.
ms.date: 07/21/2020
ms.prod-support-area-path: 
ms.reviewer: craigw
---
# Run Windows Server 2003 on Microsoft Azure

This article provides information about Windows Server 2003 support and answers some of the [most common questions](#frequently-asked-questions) about running Windows Server 2003 on Microsoft Azure.

_Original product version:_ &nbsp; Microsoft Windows Server 2003 R2 Datacenter Edition (32-Bit x86), Microsoft Windows Server 2003 R2 Datacenter x64 Edition, Microsoft Windows Server 2003 R2 Enterprise Edition (32-Bit x86), Microsoft Windows Server 2003 R2 Enterprise x64 Edition,
Microsoft Windows Server 2003 R2 Standard Edition (32-bit x86), Microsoft Windows Server 2003 R2 Standard x64 Edition, Microsoft Windows Server 2003 Datacenter Edition (32-bit x86), Microsoft Windows Server 2003 Datacenter x64 Edition, Microsoft Windows Server 2003 Enterprise Edition (32-bit x86), Microsoft Windows Server 2003 Enterprise x64 Edition, Microsoft Windows Server 2003 Standard Edition (32-bit x86), Microsoft Windows Server 2003 Standard x64 Edition  
_Original KB number:_ &nbsp; 3206074

## Microsoft Windows Server 2003 end-of-support

Microsoft ended extended support for Windows Server 2003 on July 14, 2015. If you are running Windows Server 2003, this may put your applications and business at risk, since there may be no security or software updates. You can still move a Windows Server 2003 VM to Azure, and receive assistance in troubleshooting issues that concern running Windows Server 2003 on Azure. However, this support is limited to issues that don't require OS-level troubleshooting or patches.

Machines running Windows 2003 will no longer receive Microsoft support and may not receive further security updates. Additionally, many compliance requirements include being on a currently supported operating system.

Migrating your applications to Azure instances running a newer version of Windows Server is the recommended approach to ensure that you are effectively leveraging the flexibility and reliability of the Azure cloud. Preconfigured images with different combinations of Windows and SQL Server are available in the Marketplace and enable you to run any compatible solution on our cost-effective, high-performance, reliable cloud computing platform. For more information, see [Windows Server 2003 migration strategy](https://www.microsoft.com/cloud-platform/windows-server-2003).

Additional information and assistance to help with migration

To find a partner to provide guidance about how to plan, prioritize, and implement your migration, see the [Windows Server 2003 Migration Planning Assistant](http://migrationplanningassistant.azurewebsites.net/).

## Frequently asked questions

### When does extended support for Windows Server 2003 end? 

Windows Server 2003 extended support ended on July 14, 2015.

### Can I run existing Windows Server 2003 instances after the end of extended support? 

Yes.

### Can I create a new VM from the custom Windows Server 2003 image after the end of extended support? 

Yes. You can create a Windows Server 2003 Azure VM from specialized VHD only, not from generalized (Syspreped) VHD.

### Can I create a new Windows Server 2003 VM from the Azure Marketplace? 

For versions that are earlier than Windows Server 2008 R2, there is no Azure Marketplace support. you must provide your own specialized operating system VHD for new Windows Server 2003 VMs.

### Will Microsoft Azure support Windows Server 2003 after July 14, 2015? 

Azure support team continues to offer assistance in troubleshooting issues that are related to Windows Server 2003 on Azure. There is no support for OS-level troubleshooting or patches, and functionality in older operating systems may fail to function properly in the future as the hypervisor technology used in Azure is updated.

### Can I build custom images that contain updates provided by Microsoft through a custom support agreement? 

Yes. You can create and upload [specialized VHD](https://docs.microsoft.com/azure/virtual-machines/virtual-machines-windows-create-vm-specialized.json)  only for your own use, including situations in which those images contain updates resulting from a custom support agreement. 

### Will I be able to import new Windows Server 2003 virtual machines after the end of extended support? 

Yes.

### How can I migrate specifically the apps from Windows Server 2003? 

See [Migrate an enterprise web app to Azure App Service](https://azure.microsoft.com/documentation/articles/web-sites-migration-from-iis-server/).

### If I run Microsoft applications such as SQL Server 2005 on Windows Server 2003, will it be supported after the end of extended support? 

Yes. The applications running on Windows Server are supported based on their [lifecycle](/lifecycle). However, if the application issue requires OS-level troubleshooting or patches, Azure support may not be able to fully resolve the issue.

### Does Microsoft support in-place OS upgrades for my Windows Server 2003 instances? 

No.

### Does the Azure VM agent and extensions work in Windows Server 2003? 

No. The Azure VM agent and extensions do not function correctly on Windows Server 2003.
