---
title: Microsoft server software support for Microsoft Azure Virtual Machines
description: Discusses the support policy for Microsoft server software in a Microsoft Azure Virtual Machine environment.
ms.date: 04/03/2023
ms.reviewer: drewm, coreysa
ms.service: virtual-machines
ms.subservice: vm-support-statements
ms.collection: windows
---
# Microsoft server software support for Azure virtual machines

This article discusses the support policy for running Microsoft server software in the Microsoft Azure Virtual Machine environment (infrastructure-as-a-service).

_Original product version:_ &nbsp; Virtual Machine running Windows, Cloud Services (Web roles/Worker roles)  
_Original KB number:_ &nbsp; 2721672

## Summary

Microsoft supports server software that runs in the Microsoft Azure Virtual Machine environments, as described in the "Supported software" section. This support is subject to the Microsoft Support Lifecycle policy. For more information, go to the following Microsoft website: [Microsoft Support Lifecycle](/lifecycle).

All Microsoft, software that's installed in the Azure virtual machine environment must be licensed correctly. By default, Azure virtual machines include a license for using Windows Server in the Microsoft Azure environment. Certain Azure virtual machine offerings may also include additional Microsoft software on a per-hour or evaluation basis. Licenses for other software must be obtained separately. For information about the Microsoft License Mobility program, see [Volume licensing](https://www.microsoft.com/licensing/software-assurance/license-mobility.aspx).

In some cases, specific versions of Microsoft server software are required for support. These versions are noted in this article, and the supported versions may be updated as required.

Microsoft does not support an in-place upgrade of certain versions of the operating system in a Microsoft Azure Virtual Machine. (For more information, see KB [4014997](https://support.microsoft.com/help/4014997).) Instead, you should create a new Azure virtual machine that is running the supported version of the operating system that is required and then migrate the workload. Instructions for how to migrate Windows Server roles and features are available in the following TechNet topic: [Install, use, and remove Windows Server migration tools](https://technet.microsoft.com/library/jj134202).

## Supported software

Microsoft supports the following Microsoft server software that's running in the Azure virtual machine environment:

<a name='azure-ad-connect'></a>

### Microsoft Entra Connect

Microsoft Entra Connect is supported. For more information, see [Prerequisites for Microsoft Entra Connect](/azure/active-directory/hybrid/how-to-connect-install-prerequisites).

### Microsoft BizTalk Server

Microsoft BizTalk Server 2013 and later versions are supported. For more information, see [BizTalk offerings: Server, IaaS, and PaaS feature list](https://social.technet.microsoft.com/wiki/contents/articles/19743.biztalk-offerings-server-iaas-and-paas-feature-list.aspx).

### Microsoft Dynamics AX

Microsoft Dynamics AX 2012 R3 and later updates are supported. For more information, see the following TechNet topic: [Deploy Microsoft Dynamics AX 2012 R3 on Azure](https://technet.microsoft.com/library/dn741581.aspx).

### Microsoft Dynamics GP

Microsoft Dynamics GP 2013 and later versions are supported.

### Microsoft Dynamics NAV

Microsoft Dynamics NAV 2013 and later versions are supported.

### Microsoft Dynamics CRM

Microsoft Dynamics CRM 2015 and Microsoft Dynamics CRM 2016 are supported.

### Microsoft Dynamics 365

Microsoft Dynamics 365 Server version 9.1 and later versions are supported.

### Microsoft Exchange

Exchange Server 2013 and later versions are supported. For more information, see the "Requirements for hardware virtualization" section of the following TechNet topic: [Exchange 2013 virtualization](https://technet.microsoft.com/library/jj619301%28v=exchg.150%29.aspx?f=255&mspperror=-2147217396#bkmk_prereq).

> [!NOTE]
> The only supported way to send email to external domains from Azure compute resources is through an SMTP relay (otherwise known as an SMTP smart host). The Azure compute resource sends the email message to the SMTP relay, and then the SMTP relay provider delivers the message to the external domain. Microsoft Exchange Online Protection is one provider of a SMTP relay, but a number of third-party providers also offer this service.

### Microsoft Forefront Identity Manager

Forefront Identity Manager 2010 R2 SP1 and later versions are supported.

### Microsoft HPC Pack

Microsoft HPC Pack 2012 and later versions are supported. For more information, see the "Microsoft Azure integration" section of the following TechNet topic: [What's new in Microsoft HPC Pack 2012](https://technet.microsoft.com/library/jj899598.aspx#bkmk_windows_azure)

### Microsoft Project Server

Project Server 2013 and later versions are supported.

### Microsoft SharePoint Server

SharePoint Server 2010 and later versions are supported on Azure virtual machines.

### Microsoft SQL Server

64-bit versions of SQL Server 2008 and later versions are supported. For more information, see the following Microsoft Knowledge Base article: [956893](https://support.microsoft.com/help/956893) Support policy for Microsoft SQL Server products that are running in a hardware virtualization environment

Now Azure supports Failover Cluster Instances (FCI). For more information, see [Create an FCI with Storage Spaces Direct (SQL Server on Azure VMs)](/azure/azure-sql/virtual-machines/windows/failover-cluster-instance-storage-spaces-direct-manually-configure).

### Microsoft System Center

System Center 2012 Service Pack 1 (SP1) and later versions are supported for the following applications:

- App Controller
  - Configuration Manager
  - Data Protection Manager
  - Endpoint Protection
  - Operations Manager
  - Orchestrator
  - Server Application Virtualization
  - Service Manager
  
  For more information about Configuration Manager and Endpoint Protection support, see the following Microsoft Knowledge Base article: [2889321](https://support.microsoft.com/help/2889321) System Center 2012 Configuration Manager and System Center 2012 Endpoint Protection support for Microsoft Azure Virtual Machines

### Microsoft Team Foundation Server

Team Foundation Server 2012 and later versions are supported.

## Windows Server

Standard editions of Windows Server 2016 and Windows Server 2019 aren't available in Azure Marketplace. To use them, [upload an image](/azure/virtual-machines/windows/prepare-for-upload-vhd-image).

Windows Server 2003 and later versions are supported for deployment in Microsoft Azure. Click [here](https://support.microsoft.com/help/3206074) to see more information about running Windows Server 2003 on Azure.

For versions that are earlier than Windows Server 2008 R2, there is no Azure Marketplace support, and customers must provide their own images. The ability to deploy an operating system on Microsoft Azure is independent of the support status of the operating system. Microsoft does not support operating systems that are past their [End of Support date](https://support.microsoft.com/lifecycle/search) without a Custom Support Agreement (CSA). For example, Windows Server 2003/2003 R2 is no longer supported without a CSA.

Windows Server 2008 R2 and later versions are supported for the following roles unless explicitly noted otherwise (this list will be updated as new roles are confirmed):

- Active Directory Certificate Services

    > [!NOTE]
    > Whether you're extending an existing public key infrastructure (PKI) or planning to deploy a new PKI in the Azure environment, there are best practices, policies, and recommendations to mitigate many of the common insecurities and shortcomings. Not all the recommendations are applicable to every customer scenario. Consider the level of protection that is required for your business through a risk assessment. Before you deploy, make sure that you can implement those controls.

- Active Directory Domain Services
- Active Directory Federation Services
- Active Directory Lightweight Directory Services
- Application Server
- DNS Server
- Failover Clustering
- File Services
- Hyper-V role is supported in Azure Ev3, and Dv3 series VMs
- Network Policy and Access Services
- Print and Document Services
- Remote Desktop Services
- Web Server (IIS)
- Windows Server Update Service

### Requirements for Windows Server Failover Cluster

- Must Run Windows Server 2008 R2 or later version
  - For Windows Server 2012 and Windows Server 2008 R2, must have [hotfix 2854082](https://support.microsoft.com/help/2854082) installed on all nodes
  - Must use a single-cluster IP address resource
  - Must use Azure-hosted storage by using one of the following options:

    - Application-level replication for nonshared storage
    - Volume-level replication for nonshared storage
    - ExpressRoute for remote iSCSI Target shared block storage
    - Azure Files for shared file storage

    > [!NOTE]
    > For example: SQL Server Always On availability groups. For more information, see the following MSDN article: [High availability and disaster recovery for SQL Server in Azure virtual machines](/previous-versions/azure/jj870962(v=azure.100)?redirectedfrom=MSDN).

- Can be a third-party clustered role

    > [!NOTE]
    > Third-party clustered roles are supported by the vendor

    For more information about licensing restrictions that are related to Remote Desktop Services in Microsoft Azure, see [Virtual machines Licensing FAQ](https://azure.microsoft.com/pricing/licensing-faq/). For technical information about how to configure Remote Desktop Services in Microsoft Azure for session hosting by using Windows Server 2012 or Windows Server 2012 R2, see [Azure Desktop Hosting - Reference Architecture and Deployment Guides](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/mt404690(v=ws.11)).

The following roles are not supported on Microsoft Azure Virtual Machines:

- Dynamic Host Configuration Protocol Server (not supported for use on a NIC directly connected to an Azure VNet, but it is supported on internal networks used in nested virtualization scenarios)
- Hyper-V (Hyper-V role is supported in Azure Ev3, and Dv3 series VMs only)
- Rights Management Services
- Windows Deployment Services

## Windows Server features

The following significant features are not supported:

- BitLocker Drive Encryption (on the operating system hard disk, may be used on data disks)
- Internet Storage Name Server
- Multipath I/O
- Network Load Balancing
- Peer Name Resolution Protocol
- RRAS
- Direct Access
- SNMP Services
- Storage Manager for SANs
- Windows Internet Name Service
- Wireless LAN Service

## Additional resources

- [Minimum version support for Linux and Windows virtual machine agents in Azure](https://support.microsoft.com/help/4049215/extensions-and-virtual-machine-agent-minimum-version-support).
- Download the [Azure Virtual Machine Readiness Assessment](https://go.microsoft.com/fwlink/?linkid=335841). This assessment helps you make your move to Azure virtual machines. It automatically inspects your on-premises environment, whether that environment is physical or already virtualized. If you are running Active Directory Domain Services (AD DS), SharePoint Server, or SQL Server, this tool makes it easy for you to get started.
- The optimization assessment provides prioritized recommendations across six focus areas to optimize your experience while running in Azure. After a short questionnaire, automated data collection and analysis, a custom report is generated. The report includes an executive summary, key, and detail recommendations which provide a high-level view across the focus areas to help you manage, prioritize, and implement the recommendations.
- In Virtual Machines Image Gallery, you can find prebuilt Linux images that are provided by commercial distributors. For a complete list, go to the following Microsoft website: [Linux on Microsoft Azure-endorsed distributions](/azure/virtual-machines/linux/endorsed-distros).
- Our partners offer tools and finished services that you can integrate with your applications that run on Azure virtual machines. For a complete list of add-ons for Microsoft Azure Store, go to [Azure Marketplace](https://azure.microsoft.com/marketplace/).
- VM Depot is a community-driven catalog of preconfigured operating systems, applications, and development stacks that can be deployed on Microsoft Azure. These images are provided and licensed to you by community members. Microsoft Open Technologies, Inc. does not screen these images for security, compatibility, or performance, and does not provide any license rights or support for them. By using unsupported images, you might forfeit Microsoft Azure availability SLA. For more information, see [Using and contributing to VM Depot](https://www.microsoft.com/research/wp-content/uploads/2016/04/using-and-contributing-vms-to-vm-depot.pdf).
- Supplemental guidance is available to help you use the following technologies on Azure virtual machines:

  - Active Directory Domain Services: [Guidelines for deploying Windows Server Active Directory in Azure virtual machines](/windows-server/identity/ad-ds/introduction-to-active-directory-domain-services-ad-ds-virtualization-level-100?redirectedfrom=MSDN).
  - For information about Office activation on Azure virtual machines, see [Microsoft Office prompts for activation in Azure](https://support.microsoft.com/help/956893).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
