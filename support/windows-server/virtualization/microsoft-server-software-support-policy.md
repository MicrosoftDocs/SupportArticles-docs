---
title: Microsoft server software and supported virtualization environments
description: Discusses the support policy for running Microsoft server software in the supported virtualization environments.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Virtual machine creation
ms.technology: HyperV
---
# Microsoft server software and supported virtualization environments

_Original product version:_ &nbsp;Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp;957006

## Introduction

This article discusses the support policy for running Microsoft server software in the following supported virtualization environments:

- Windows Server 2008 and later versions with Hyper-V
- Microsoft Hyper-V Server 2008 and later versions
- Server Virtualization Validation Program (SVVP)

For more information, see the following Microsoft website: [https://www.windowsservercatalog.com/](https://www.windowsservercatalog.com/) 
Microsoft supports Microsoft server software that is running in the supported virtualization environments that are listed in the "More Information" section. This support is subject to the Microsoft Support Lifecycle policy. For more information, see the following Microsoft website: [https://support.microsoft.com/?pr=lifecycle](/?pr=lifecycle) 

In some cases, specific versions of Microsoft server software are required for support. These versions are noted in this article, and the supported versions may be updated as appropriate.
SVVP doesn't apply to vendors that are hosting Windows Server or other Microsoft products through the [Microsoft Service Provider License Agreement Program (SPLA)](https://www.microsoft.com/Licensing/existing-customer/existing-customers.aspx). Support for SPLA customers is provided under the SPLA agreement by the SPLA hoster. SPLA customers should contact their SPLA hoster for support.
 **Note** Not all software applications are good candidates for running in a virtualized environment. For example, if an application has specific hardware requirements, such as access to a physical PCI card, the applications can't be supported in a virtual machine. This is true because virtual machines generally don't have access to underlying physical hardware.

## More information

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products. 

Third parties are responsible for testing their software together with Microsoft software. Microsoft software may not work as intended in third-party virtualized hardware environments.

### Microsoft Application Virtualization (App-V)

Microsoft Application Virtualization 4.5 and later versions such as Management Server, Publishing Server, Sequencer, Terminal Services Client, and Desktop Client are supported.

### Microsoft BizTalk Server

Microsoft BizTalk Server 2009, BizTalk Server 2006 R2, BizTalk Server 2006, and BizTalk Server 2004 are fully supported when they're installed on a supported operating system that is running on Windows Server 2008 Hyper-V.

For more information, click the following article number to view the article in the Microsoft Knowledge Base: 
 [842301](https://support.microsoft.com/help/842301) Microsoft BizTalk Server supportability on a virtual machine 

### Microsoft Commerce Server

Microsoft Commerce Server 2007 Service Pack 2 and later versions are supported.

### Microsoft Dynamics AX

Microsoft Dynamics AX 2009 (both server and client) and later versions are supported.

### Microsoft Dynamics CRM

Microsoft Dynamics CRM 4.0 and later versions are supported.

### Microsoft Dynamics GP

Microsoft Dynamics GP 10.0 and later versions are supported.

### Microsoft Dynamics NAV

Microsoft Dynamics NAV 2009 and later versions are supported.

### Microsoft Exchange Server

Microsoft Exchange Server 2007 Service Pack 1 and later versions are supported. For more information about the support for Exchange Server, visit the following TechNet website: [https://technet.microsoft.com/library/cc794548(v=EXCHG.80).aspx](https://technet.microsoft.com/library/cc794548%28v=exchg.80%29.aspx) 

For information about how to deploy Microsoft Exchange Server 2010 in a virtualized environment, visit the following TechNet website:
 [https://technet.microsoft.com/library/jj126252(v=exchg.141).aspx](https://technet.microsoft.com/library/jj126252%28v=exchg.141%29.aspx) 

For information about how to deploy Microsoft Exchange Server 2013 in a virtualized environment, visit the following TechNet website:
 [https://technet.microsoft.com/library/jj619301(v=exchg.150).aspx](https://technet.microsoft.com/library/jj619301%28v=exchg.150%29.aspx) 

### Microsoft Forefront Client Security

Microsoft Forefront Client Security is supported.

### Microsoft Forefront Endpoint Protection 2010

Microsoft Forefront Endpoint Protection 2010 and later versions are supported.

### Microsoft Forefront Identity Manager 2010

Microsoft Forefront Identity Manager 2010 and later versions are supported.

### Microsoft Intelligent Application Gateway (IAG)

Microsoft Intelligent Application Gateway 2007 Service Pack 2 and later versions are supported.

### Microsoft Forefront Security for Exchange (FSE)

Microsoft Forefront Security for Exchange Server Service Pack 1 (SP1) or higher is supported.

### Microsoft Forefront Security for SharePoint (FSP)

Microsoft Forefront Security for SharePoint Service Pack 2 (SP2) or higher is supported.

### Microsoft Host Integration Server

Microsoft Host Integration Server 2006 and later versions are supported.

### Microsoft Internet Security and Acceleration (ISA) Server

Microsoft ISA Server is supported. For more information about support for ISA Server, visit the following Microsoft website: [https://technet.microsoft.com/library/cc891502.aspx](https://technet.microsoft.com/library/cc891502.aspx) 

### Microsoft Office Groove Server

Microsoft Office Groove Server 2007 Service Pack 1 and later versions are supported. 

> [!NOTE]
> The virtual machine for Microsoft Office Groove Server Relay should be configured to use a physical hard disk, not a virtual hard disk.

### Microsoft Office PerformancePoint Server

Microsoft Office PerformancePoint Server 2007 Service Pack 2 and later versions are supported.

### Microsoft Office Project Server

Microsoft Office Project Server 2007 Service Pack 1 and later versions are supported.

### Microsoft Office SharePoint Server and Windows SharePoint Services

Microsoft Office SharePoint Server 2007 Service Pack 1 and later versions are supported. Windows SharePoint Services 3.0 Service Pack 1 and later versions are supported.

### Microsoft Operations Manager (MOM) 2005

Microsoft Operations Manager 2005 Service Pack 1 (agents only) is supported. For more information, visit the following Microsoft website: [https://technet.microsoft.com/library/cc180251.aspx](https://technet.microsoft.com/library/cc180251.aspx) 
> [!NOTE]
> System Center Operations Manager 2007 or a later version is required to manage Windows Server 2008 and later versions.

### Microsoft Search Server

Microsoft Search Server 2008 and later versions are supported.

### Windows Essential Business Server 2008

Windows Essential Business Server 2008 and later versions are supported.

### Windows Small Business Server 2008

Windows Small Business Server 2008 and later versions are supported.

### Microsoft SQL Server 

For support of Microsoft SQL Server, see the following Microsoft Knowledge Base article: [https://support.microsoft.com/kb/956893](https://support.microsoft.com/help/956893) 

### Microsoft System Center Configuration Manager

Configuration Manager, current branch, is supported. 
System Center Configuration Manager 2007 Service Pack 1 (both server and agents) and later versions are supported. For more information about support for Configuration Manager 2007, visit the following Microsoft website: [https://technet.microsoft.com/library/bb680717.aspx](https://technet.microsoft.com/library/bb680717.aspx) 

### Microsoft System Center Data Protection Manager

Microsoft Systems Center Data Protection Manager 2007 is supported when it runs inside a virtual machine, but only if the DPM storage pool disks are made available directly to the DPM virtual machine as one of the following:
- Pass-through disks
- iSCSI target disks
- FC SAN target disksYou can also perform backups for the virtual machines either by using a DPM agent that is installed on the host computer or by installing the DPM agent into the virtual machine directly.

### Microsoft System Center Essentials

Microsoft System Center Essentials 2007 Service Pack 1 and later versions are supported.

### Microsoft System Center Operations Manager

Microsoft System Center Operations Manager 2007 (both server and agents) and later versions are supported. For more information about the support for Operations Manager 2007, visit the following Microsoft website: [https://technet.microsoft.com/library/bb309428.aspx](https://technet.microsoft.com/library/bb309428.aspx) 

### Microsoft System Center Virtual Machine Manager

Microsoft System Center Virtual Machine Manager 2008 (both server and agents) and later versions are supported.

### Microsoft System Center Service Manager

Microsoft System Center Service Manager 2010 and later versions are supported. For more information about support for Service Manager 2010, visit the following Microsoft website: [https://go.microsoft.com/fwlink/?LinkId=182907](https://go.microsoft.com/fwlink/?linkid=182907) 

### Microsoft Visual Studio Team System

Microsoft Visual Studio Team System 2008 and later versions are supported.

### Microsoft Windows HPC Server 2008

Microsoft Windows HPC Server 2008 and later versions are supported.

### Windows Server 2003 Web Edition

Windows Server 2003 Web Edition with Service Pack 2 is supported.

### Microsoft Windows Server Update Services (WSUS)

Microsoft Windows Server Update Services 3.0 Service Pack 1 and later versions are supported. 

### Windows Web Server 2008

Windows Web Server 2008 is supported.

### Identity Lifecycle Manager 2007

Identity Lifecycle Manager (ILM) 2007 Feature Pack 1 (FP1) (with the latest updates) and later versions are supported. For more information, visit the following Microsoft website: [https://www.microsoft.com/windowsserver/ilm2007/faq.mspx](https://www.microsoft.com/windowsserver/ilm2007/faq.mspx)  

### Microsoft Office Online 

Office Online is supported. For more information, visit the following Microsoft Office website: [https://office.com/webapps](https://office.com/webapps)  

### Opalis Integration Server 

Opalis Integration Server 6.2.2 and later versions are supported.

**Note** Opalis Integration Server 6.3 or a later version is required for installation on Windows Server 2008 and later versions. However, only Integration Packs that were released with version 6.3 are supported on Windows Server 2008 and later versions. The use of existing Integration Packs requires installation on Windows Server 2003.

### Microsoft Lync Server 

Microsoft Lync Server 2010 and later versions are supported. For more information, visit the following Microsoft website: [https://www.microsoft.com/download/en/details.aspx?FamilyID=2905FD33-E29C-4709-A012-E55EA8DB63E4&displaylang=en](https://www.microsoft.com/download/en/details.aspx?familyid=2905fd33-e29c-4709-a012-e55ea8db63e4&displaylang=en).

### Microsoft System Center Service Manager

Microsoft System Center Service Manager 2010 and later versions are supported. For more information about support for Service Manager 2010, visit the following website: [https://technet.microsoft.com/library/ff460890.aspx](https://technet.microsoft.com/library/ff460890.aspx)
