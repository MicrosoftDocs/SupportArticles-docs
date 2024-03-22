---
title: Server software and supported virtualization environments
description: Discusses the support policy for running Microsoft server software in the supported virtualization environments.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:virtual-machine-creation, csstroubleshoot
---
# Microsoft server software and supported virtualization environments

This article discusses the support policy for running Microsoft server software in the following supported virtualization environments.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008  
_Original KB number:_ &nbsp; 957006

## Introduction

This article discusses the support policy for running Microsoft server software in the following supported virtualization environments:

- Windows Server 2008 and later versions with Hyper-V
- Microsoft Hyper-V Server 2008 and later versions
- Server Virtualization Validation Program (SVVP)

For more information, see [Windows Server Catalog](https://www.windowsservercatalog.com/).

Microsoft supports Microsoft server software that is running in the supported virtualization environments that are listed in the [More Information](#more-information) section. This support is subject to the Microsoft Support Lifecycle policy. For more information, see [Microsoft Support Lifecycle](https://support.microsoft.com/?pr=lifecycle).

In some cases, specific versions of Microsoft server software are required for support. These versions are noted in this article, and the supported versions may be updated as appropriate.

SVVP doesn't apply to vendors that are hosting Windows Server or other Microsoft products through the [Microsoft Service Provider License Agreement Program (SPLA)](https://www.microsoft.com/licensing/existing-customer/existing-customers?rtc=1). Support for SPLA customers is provided under the SPLA agreement by the SPLA hoster. SPLA customers should contact their SPLA hoster for support.

> [!NOTE]
> Not all software applications are good candidates for running in a virtualized environment. For example, if an application has specific hardware requirements, such as access to a physical PCI card, the applications can't be supported in a virtual machine. This is true because virtual machines generally don't have access to underlying physical hardware.

## More information

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

Third parties are responsible for testing their software together with Microsoft software. Microsoft software may not work as intended in third-party virtualized hardware environments.

### Microsoft Application Virtualization (App-V)

Microsoft Application Virtualization 4.5 and later versions such as Management Server, Publishing Server, Sequencer, Terminal Services Client, and Desktop Client are supported.

### Microsoft BizTalk Server

Microsoft BizTalk Server 2009, BizTalk Server 2006 R2, BizTalk Server 2006, and BizTalk Server 2004 are fully supported when they're installed on a supported operating system that is running on Windows Server 2008 Hyper-V.

For more information, see [Microsoft BizTalk Server supportability on a virtual machine](../../developer/biztalk/setup-config/biztalk-server-supportability-on-vm.md).

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

Microsoft Exchange Server 2007 Service Pack 1 and later versions are supported. For more information about the support for Exchange Server, see [Microsoft Support Policies and Recommendations for Exchange Servers in Hardware Virtualization Environments](/previous-versions/office/exchange-server-2007-technical-articles/cc794548(v=exchg.80)).

For information about how to deploy Microsoft Exchange Server 2010 in a virtualized environment, see [Understanding Exchange 2010 Virtualization](/previous-versions/office/exchange-server-2010/jj126252(v=exchg.141)).

For information about how to deploy Microsoft Exchange Server 2013 in a virtualized environment, see [Exchange 2013 virtualization](/exchange/exchange-2013-virtualization-exchange-2013-help).

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

Microsoft ISA Server is supported. For more information about support for ISA Server, see [Security Considerations with Forefront Edge Virtual Deployments](/previous-versions//cc891502(v=technet.10)).

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

Microsoft Operations Manager 2005 Service Pack 1 (agents only) is supported. For more information, see [Microsoft Operations Manager 2005 Service Pack 1 (SP1) Supported Configurations](/previous-versions/system-center/operations-manager-2005/cc180251(v=technet.10)).

> [!NOTE]
> System Center Operations Manager 2007 or a later version is required to manage Windows Server 2008 and later versions.

### Microsoft Search Server

Microsoft Search Server 2008 and later versions are supported.

### Windows Essential Business Server 2008

Windows Essential Business Server 2008 and later versions are supported.

### Windows Small Business Server 2008

Windows Small Business Server 2008 and later versions are supported.

### Microsoft SQL Server 

For support of Microsoft SQL Server, see [Support policy for Microsoft SQL Server products that are running in a hardware virtualization environment](https://support.microsoft.com/help/956893).

### Microsoft System Center Configuration Manager

Configuration Manager, current branch, is supported.
System Center Configuration Manager 2007 Service Pack 1 (both server and agents) and later versions are supported.

### Microsoft System Center Data Protection Manager

Microsoft Systems Center Data Protection Manager 2007 is supported when it runs inside a virtual machine, but only if the DPM storage pool disks are made available directly to the DPM virtual machine as one of the following:

- Pass-through disks
- iSCSI target disks
- FC SAN target disks

You can also perform backups for the virtual machines either by using a DPM agent that is installed on the host computer or by installing the DPM agent into the virtual machine directly.

### Microsoft System Center Essentials

Microsoft System Center Essentials 2007 Service Pack 1 and later versions are supported.

### Microsoft System Center Operations Manager

Microsoft System Center Operations Manager 2007 (both server and agents) and later versions are supported. For more information about the support for Operations Manager 2007, see [Operations Manager 2007 R2 Supported Configurations](/previous-versions/system-center/operations-manager-2007-r2/bb309428(v=technet.10)).

### Microsoft System Center Virtual Machine Manager

Microsoft System Center Virtual Machine Manager 2008 (both server and agents) and later versions are supported.

### Microsoft System Center Service Manager

Microsoft System Center Service Manager 2010 and later versions are supported. For more information about support for Service Manager 2010, see [System Center Service Manager 2010 SP1 Planning Guide](/previous-versions/system-center/service-manager-2010-sp1/ff460890(v=technet.10)).

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

Identity Lifecycle Manager (ILM) 2007 Feature Pack 1 (FP1) (with the latest updates) and later versions are supported.

### Microsoft Office Online

Office Online is supported. For more information, see [Office Online](https://office.com/webapps).

### Opalis Integration Server

Opalis Integration Server 6.2.2 and later versions are supported.

> [!NOTE]
> Opalis Integration Server 6.3 or a later version is required for installation on Windows Server 2008 and later versions. However, only Integration Packs that were released with version 6.3 are supported on Windows Server 2008 and later versions. The use of existing Integration Packs requires installation on Windows Server 2003.

### Microsoft Lync Server

Microsoft Lync Server 2010 and later versions are supported. For more information, see [Server Virtualization in Microsoft Lync Server 2010](https://www.microsoft.com/download/details.aspx?id=22746).

### System Center Service Manager

Microsoft System Center Service Manager 2010 and later versions are supported. For more information about support for Service Manager 2010, see [System Center Service Manager 2010 SP1 Planning Guide](/previous-versions/system-center/service-manager-2010-sp1/ff460890(v=technet.10)).
