---
title: Support policy for hardware virtualization product
description: This article describes the support policy for SQL Server products that are running in a hardware virtualization environment.
ms.date: 11/09/2020
ms.prod-support-area-path: General
ms.reviewer: bobward
ms.prod: sql
---
# Support policy for Microsoft SQL Server products that are running in a hardware virtualization environment

This article describes the support policy for SQL Server products that are running in a hardware virtualization environment.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 956893

## INTRODUCTION

This article describes the support policy for Microsoft SQL Server products that are running in a hardware virtualization environment.

## More information

Microsoft provides technical support for SQL Server 2008 and later versions for the following supported hardware virtualization environments:

- Windows Server 2008 and later versions with Hyper-V
- Microsoft Hyper-V Server 2008 and later versions
- Configurations that are validated through the Server Virtualization Validation Program (SVVP).

  For more information about certified vendors and about configurations for SVVP, see [http://windowsservercatalog.com/svvp.aspx?svvppage=svvp.htm](http://windowsservercatalog.com/svvp.aspx?svvppage=svvp.htm).

  > [!NOTE]
  > The SVVP solution must be running on hardware that is certified for Windows Server 2008 R2 or a later version to be considered a valid SVVP configuration.

Microsoft provides technical support for SQL Server 2008 and later versions for the following supported hardware virtualization environments:

- Azure Infrastructure Services that includes Azure Virtual Machines and Azure Virtual Network (See the Frequently Asked Questions section for more details)

Microsoft may provide limited or no technical support for the following environments:

- Any version of SQL Server earlier than SQL Server 2008 (such as SQL Server 2005) that's running on any virtualization vendor or configuration.
- Any non-Microsoft virtualization software that is not a configuration that is validated through the SVVP program

This policy of limited support is based on the following Microsoft Knowledge Base article:

[Support policy for Microsoft software that runs on non-Microsoft hardware virtualization software](/troubleshoot/windows-server/virtualization/software-runs-on-non-microsoft-virtualization-software)

## Restrictions and Limitations

The following restrictions and limitations may affect the support policy of the above supported configurations:

- Guest Failover Clustering is supported for SQL Server 2008 and later versions in a virtual machine for the supported hardware virtualization environments listed in this article provided all the following requirements are met:

  - The Operating System running in the virtual machine (the "Guest Operating System") is Windows Server 2008 or a later version.
  - The virtualization environment meets the requirements of Windows 2008 or Windows 2012 Failover Clustering, as documented in the following articles in the Microsoft Knowledge Base:
  
    - [The Microsoft Support Policy for Windows Server 2008 or Windows Server 2008 R2 Failover Clusters](https://support.microsoft.com/help/943984)

    - [Microsoft support policy for Windows server failover clusters](/troubleshoot/windows-server/high-availability/microsoft-support-policy-failover-clusters)

- The SQL Server product must be a supported version under its current Microsoft Support Lifecycle policy. For more information about Microsoft Support Lifecycle policies, see [Search Product and Services Lifecycle Information](/lifecycle/products/).

- SQL Server supports virtualization-aware backup solutions that use VSS (volume snapshots). For example, SQL Server supports Hyper-V backup.

  Virtual machine snapshots that do not use VSS volume snapshots are not supported by SQL Server. Any snapshot technology that does a behind-the-scenes save of a VMs point-in-time memory, disk, and device state without interacting with applications on the guest using VSS may leave SQL Server in an inconsistent state.

- SQL Server on Hyper-V Replica is supported provided the [EnableWriteOrderPreservationAcrossDisks](https://technet.microsoft.com/library/hh848543.aspx) flag is set.

  > [!NOTE]
  > To set the EnableWriteOrderPreservationAcrossDisks flag, run the following cmdlet:
  >
  > `Set-VMReplication -VMName \<vm-name> -EnableWriteOrderPreservationAcrossDisks 1`

  Exceptions

  If multiple SQL VMs are tightly coupled with one another, individual VMs can fail over to the disaster recovery (DR) site but SQL high availability (HA) features inside the VM need to be removed and reconfigured after VM failover. For this reason, the following SQL Server features are not supported on Hyper-VM Replica:

  - Availability Groups
  - Database mirroring
  - Failover Cluster instances
  - Log shipping
  - Replication

  For SQL Servers running on Linux environment, review the guidance in the Supported virtualization technologies section of [Technical support policy for Microsoft SQL Server](https://support.microsoft.com/help/4047326).

  It is recommended to use SQL Server in [Run Hyper-V in a Virtual Machine with Nested Virtualization](/virtualization/hyper-v-on-windows/user-guide/nested-virtualization) for testing and development purposes only.  

## Frequently asked questions

- **Q1: What level of technical support will I receive if my non-Microsoft vendor configuration is certified through SVVP?**

  A1: Microsoft Customer Service and Support (CSS) will work together with the customer and the SVVP certified vendor to investigate the problem with SQL Server that is running in the virtual machine. Microsoft CSS or the SVVP vendor will follow the process that is documented on the following SVVP website to use the TSANet program together with the customers' permission in an attempt to resolve the problem:

  [Server Virtualization Validation Program](https://www.windowsservercatalog.com/?svvppage=svvpsupport.htm)

- **Q2: What if the non-Microsoft vendor virtualization configuration is not certified through SVVP?**

  A2: Microsoft CSS will follow the support policies that are documented in Knowledge Base article 897615. For more information, click the following article number to view the article in the Microsoft Knowledge Base:

  [Support policy for Microsoft software that runs on non-Microsoft hardware virtualization software](/troubleshoot/windows-server/virtualization/software-runs-on-non-microsoft-virtualization-software)

  If Microsoft CSS determines that the problem may be related to the vendor virtualization software, Microsoft CSS may require the customer to reproduce the problem outside the virtualization environment.

  Not all vendor configurations are considered certified by SVVP even though the vendor participates in the program. The list of validated configurations may be updated as vendors submit changes through this program.

- **Q3: The SVVP program specifically lists the valid configurations for Windows Server 2008. Are other versions of Windows supported to be used as guest operating system?**

  A3: Yes. As documented at the following SVVP website, products that have passed the SVVP requirements for the latest released version of Windows Server are considered supported on all earlier versions of Windows Server that are still supported per Lifecycle Matrix.

  [Server Virtualization](https://www.windowsservercatalog.com/results.aspx?&bCatID=1521&cpID=0&avc=0&ava=0&avq=0&OR=1&PGS=25)

  When running SQL Server on a guest operating system, the version of SQL Server must be supported on the version of the guest operating system, according to the requirements that are listed in the respective SQL Server product documentation.

  For more information about the hardware and software requirements for SQL Server, visit the following pages on docs:

  - [SQL Server 2019: Hardware and software requirements](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server-ver15?view=sql-server-ver15&preserve-view=true)

  - [SQL Server 2016 and 2017: Hardware and software requirements](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server?view=sql-server-ver15&preserve-view=true)

  - [SQL Server 2014: Hardware and Software Requirements](/previous-versions/sql/2014/sql-server/install/hardware-and-software-requirements-for-installing-sql-server)

  - [Hardware and Software Requirements for Installing SQL Server 2012](/previous-versions/sql/sql-server-2012/ms143506(v=sql.110))

  - [Hardware and Software Requirements for Installing SQL Server 2008 R2](/previous-versions/sql/sql-server-2008-r2/ms143506%28v%3dsql.105%29)

  - [Hardware and Software Requirements for Installing SQL Server 2008](/previous-versions/sql/sql-server-2008/ms143506%28v%3dsql.100%29)

- **Q4: Are SQL Server features such as database mirroring supported to run in a virtualization environment?**

  A4: The only restrictions to install and use SQL Server in a virtualization environment are documented in this article or in the SQL Server product documentation. Any feature or usage that is not stated in this article or in the SQL Server product documentation is assumed to be supported in a virtualization environment by using the same restrictions and support as a bare metal hardware environment. For more information about the features that are supported by different editions of SQL Server, visit following TechNet website:

  [Features Supported by the Editions of SQL Server 2008 R2](/previous-versions/sql/sql-server-2008-r2/cc645993(v=sql.105))

  These same requirements apply to SQL Server 2008 and later versions that are running in a virtualization environment.

- **Q5: Is Quick and Live Migration with Windows Server 2012 or Windows Server 2008 R2 Hyper-V supported with SQL Server?**

  A5: Yes, Live Migration is supported for SQL Server 2008 and later versions when used with Windows Server 2008 R2 or later versions with Hyper-V and with Hyper-V server 2008 R2 or later versions. Quick Migration, which was introduced with Windows Server 2008 with Hyper-V and Hyper-V Server 2008, is also supported for SQL Server (All versions from SQL Server 2008 and later) in Windows Server 2008 (or later versions) with Hyper-V and Hyper-V Server 2008  (or later versions).

- **Q6: What is the support policy for SQL Server when using an SVVP vendor virtualization feature such as snapshots or migration?**

  A6: Snapshots for any virtualization vendor that do not use VSS are not supported with SQL Server. Any other virtualization additional functionality of an SVVP vendor such as migration must be supported by the SVVP vendor. This includes any problems that might occur with SQL Server when using these features. Read this resource for more information about the support policy for additional functionality of a virtualization product:

  [Server Virtualization Validation Program](https://www.windowsservercatalog.com/svvp.aspx?svvppage=svvpsupport.htm)

- **Q7: Is Hyper-V Dynamic Memory supported for SQL Server?**

  A7: Hyper-V Dynamic Memory is fully supported with SQL Server. Only SQL Server versions and editions that support Hot Add Memory (Enterprise and Datacenter) can see memory that is added by using Hyper-V Dynamic Memory. SQL Server 2012 and later versions of standard editionS also recognize Hot Add memory when running in a virtual environment. SQL Server versions that do not support Hot Add Memory are still supported. But these versions will detect only the memory that is present in the operating system when SQL Server starts. Before you deploy Hyper-V Dynamic Memory, please read the following resources when you use Hyper-V Dynamic Memory with SQL Server:

  - [Hyper-V Dynamic Memory Evaluation Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff817651(v=ws.10))

  - [SQL Server and Hyper-V Dynamic Memory - Part 1](/archive/blogs/sqlosteam/sql-server-and-hyper-v-dynamic-memory-part-1)

  - [SQL Server and Hyper-V Dynamic Memory - Part 2](/archive/blogs/sqlosteam/sql-server-and-hyper-v-dynamic-memory-part-2)

- **Q8: Do you support SQL Server running in Microsoft Azure Virtual Machine?**

  A8: Yes. Microsoft supports SQL Server 2008 and later versions in Microsoft Azure Infrastructure Services that includes Microsoft Azure Virtual Machines and Microsoft Azure Virtual Network. Consider the following when you deploy SQL Server 2008 and later versions in Microsoft Azure Virtual Machine:

  - Microsoft Azure Storages Geo-Replication is not supported if the data and log files of a database are stored in more than one disk.

  - AlwaysOn Availability Groups (with multiple Listeners) fully supported.

  - We recommend a DS3 VM or higher for SQL Enterprise edition, and DS2 or higher for SQL Standard and Web.

  - [Azure files](/azure/storage/files/storage-files-introduction) are not currently supported to store SQL Server data or log files.

  - For more information about Microsoft Azure Virtual Machine and SQL Server, see [What is SQL Server on Azure Virtual Machines (Windows)](/azure/azure-sql/virtual-machines/windows/sql-server-on-azure-vm-iaas-what-is-overview).

  - SQL Server failover cluster instances (FCI) are supported in the following scenarios:

    - SQL Server FCI on Windows Server 2016  and later versions with Storage Spaces Direct. For more information, see [Configure SQL Server Failover Cluster Instance on Azure Virtual Machines](/azure/azure-sql/virtual-machines/windows/failover-cluster-instance-premium-file-share-manually-configure).

    - SQL Server FCI on Windows Server 2016 and later versions with premium file shares. For more information review [Create an FCI with a premium file share (SQL Server on Azure VMs)](/azure/azure-sql/virtual-machines/windows/failover-cluster-instance-premium-file-share-manually-configure?tabs=windows2012).

    - SQL Server FCI n Windows Server 2016 and later versions with Azure shared disks. For more information review [Create an FCI with Azure shared disks (SQL Server on Azure VMs)](/azure/azure-sql/virtual-machines/windows/failover-cluster-instance-azure-shared-disks-manually-configure).

- **Q9: Can customers run SQL Server in the Microsoft Azure VM role?**

  A9:  Microsoft Azure VM role is a non-persistent role and not the same as Microsoft Azure Virtual Machine. It is not supported for SQL Server production use. Customers who want to deploy data platform capabilities today in the Microsoft Azure platform should use Microsoft Azure Virtual Machine or Microsoft Azure SQL Database.

- **Q10: Are there any recommended configuration or best practices to consider while deploying SQL Server in virtualized environments?**

  A10: Yes, you should consult with the following recommendations from the respective hypervisor:

  - [Best Practices for Virtualizing and Managing SQL Server](https://download.microsoft.com/download/6/1/D/61DDE9B6-AB46-48CA-8380-D7714C9CB1AB/Best_Practices_for_Virtualizing_and_Managing_SQL_Server_2012.pdf)

  - [ARCHITECTING MICROSOFT SQL SERVER ON VMWARE VSPHERE](https://www.vmware.com/content/dam/digitalmarketing/vmware/en/pdf/solutions/sql-server-on-vmware-best-practices-guide.pdf)

## Applies to

- SQL Server 2008 Standard
- SQL Server 2008 Standard Edition for Small Business
- SQL Server 2008 Enterprise
- SQL Server 2008 Developer
- SQL Server 2008 Workgroup
- SQL Server 2008 Web
- SQL Server 2008 Express
- SQL Server 2008 R2 Datacenter
- SQL Server 2008 R2 Developer
- SQL Server 2008 R2 Enterprise
- SQL Server 2008 R2 Express
- SQL Server 2008 R2 Express with Advanced Services
- SQL Server 2008 R2 PowerPivot for Excel 2010
- SQL Server 2008 R2 Standard
- SQL Server 2008 R2 Standard Edition for Small Business
- SQL Server 2008 R2 Web
- SQL Server 2008 R2 Workgroup
- SQL Server 2012 Developer
- SQL Server 2012 Enterprise
- SQL Server 2012 Express
- SQL Server 2012 Standard
- SQL Server 2012 Web
- SQL Server 2012 Enterprise Core
- SQL Server 2014 Standard
- SQL Server 2014 Developer
- SQL Server 2014 Web
- SQL Server 2014 Enterprise
- SQL Server 2016 Standard
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Web
- SQL Server 2017 on Windows (all editions)
