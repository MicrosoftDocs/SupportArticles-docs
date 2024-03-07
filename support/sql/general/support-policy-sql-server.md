---
title: Support policy for SQL Server
description: This article describes the support policy for Microsoft SQL Server.
ms.date: 06/30/2023
ms.custom: 'sap:General', linux-related-content
ms.reviewer: sureshka
---
# Technical support policy for Microsoft SQL Server

This article describes the support policy for Microsoft SQL Server.

_Original product version:_ &nbsp; SQL Server 2017 on Linux (all editions), SQL Server 2017 on Windows (all editions)  
_Original KB number:_ &nbsp; 4047326

## Summary

This article describes the support policies and troubleshooting boundaries for SQL Server products that are installed on supported platforms.

## Supported operating systems

Depending on the version and edition of SQL Server, you can install SQL Server on a supported Windows or Linux operating system.

This documentation outlines the specific operating systems on which the product is tested and validated. When you install older version of SQL Server on newer Windows operating systems, you have to be on a supported service pack.

Starting in SQL Server 2017, you can install SQL Server on Linux operating systems. [Installation guidance for SQL Server on Linux](/sql/linux/sql-server-linux-setup) outlines the current list of supported Linux operating systems on which you can install and configure SQL Server for production use.

Starting from SQL Server 2019, you can deploy the SQL Server Big Data Cluster on Kubernetes. Review the supported Host OS for Kubernetes in the [SQL Server 2019 Big Data Clusters release notes](/sql/big-data-cluster/release-notes-big-data-cluster) under the **Supportability** section.

## Supported hardware

SQL Server Installations are supported on x64-based (AMD and Intel) processors. They are no longer supported on x86-based processors. For current information, see the [SQL Server 2016 and 2017: Hardware and software requirements](/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server).

## Supported virtualization technologies

Microsoft supports deploying SQL Server on virtualization technologies that include Microsoft Hyper-V and other hypervisors that are certified through the Server Virtualization Validation Program (SVVP). For more information about SVVP, see [Windows Server Virtualization Validation Program](https://www.windowsservercatalog.com/svvp.aspx?svvppage=svvp.htm).

If you host a Linux virtual machine on Hyper-V, make sure that you have [Linux Virtual Machines on Hyper-V](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dn743675(v=ws.10)). Microsoft supports SQL Server installations on cloud infrastructure services such as Azure Virtual Machine, Amazon EC2, and Google Cloud.

The host operating system vendors publish supported hypervisors for their systems. The following list includes some examples:

- [Which hypervisors are certified to run Red Hat Enterprise Linux?](https://access.redhat.com/certified-hypervisors)

- [Ubuntu Server Guide Changes, errors and bugs](https://ubuntu.com/server/docs)

- [Supported SUSE virtual machines on Hyper-V](/windows-server/virtualization/hyper-v/supported-suse-virtual-machines-on-hyper-v)

Look in the operating system documentation for the current and updated hypervisor that is supported on specific versions of the operating system.

Microsoft also supports deploying SQL Server on VMware vSphere, allowing users to take advantage of the software-defined data center (SDDC) platform and capabilities such as network and storage virtualization. To learn more about how to best deploy SQL Server using vSphere, including right-sizing your SQL Server VMs and managing your vCenter Server configuration, see [Architecting Microsoft SQL Server on VMware vSphere](https://core.vmware.com/resource/architecting-microsoft-sql-server-vmware-vsphere#introduction).

[Azure VMware Solution](https://azure.microsoft.com/products/azure-vmware#overview) is Microsoft's first-party solution that allows customers to run VMware workloads natively on Azure and also supports running SQL Server deployments on the same vSphere infrastructure you are used to running on VMware on-premises.

## SQL Server running in Linux containers

This section describes the support policies and supported configurations for SQL Server running in Linux containers.

SQL Server is an application that runs in the user space of a Linux container. SQL Server and its dependencies in the SQL Server container make calls to the underlying host operating system and its kernel. Different Linux operating systems come with different sets of user space applications and Linux Kernel that are well tested in combination with SQL Server. While it is possible to run SQL Server in an untested or unsupported configuration of container and host combinations, Microsoft does not recommend that you do this. We support only configurations that use the following guidelines. These guidelines dictate the well tested and supported configurations for running SQL Server Linux containers.  

The following guidelines and examples apply to the support for SQL Server on Linux container deployments.

### Guidelines

1. The SQL Server container OS must match the container host OS in terms of distribution and major version.
2. A SQL Server on Linux containers deployment supports the same set of supported platforms as for SQL Server on Linux running in non-containerized workloads. For more information, see [Installation guidance for SQL Server on Linux](/sql/linux/sql-server-linux-setup?view=sql-server-2017&preserve-view=true#supportedplatforms).

- **Examples of supported configurations**

  - SQL Server 2019 on Red Hat 7.x containers running on a Red Hat 7.x host  
  - SQL Server 2017 on Ubuntu 16.04 container running on an Ubuntu 16.04 host  
  - SQL Server 2017 on SLES 12.x container running on a SLES 12.x host  
  - SQL Server 2017 on Ubuntu 16.04 container running on an Ubuntu 16.04 virtual machine that's hosted on the Windows operating system

- **Examples of unsupported configurations**

  - SQL Server 2017 on Red Hat 7.6 containers running on an Ubuntu Container host

  - A Linux OS distribution that is not matched between the container and host

  - SQL Server 2017 on Ubuntu 16.04 container running on an Ubuntu 18.04 host

  - A Linux OS version that is not matched between the container and host

  - SQL Server 2017 on a CentOS container on a CentOS Container host (CentOS is not a supported Linux OS distribution for SQL Server on Linux. Microsoft will address only problems that are reproducible on a supported configuration.)

The Linux container image for SQL Server 2017 is available on the Container Registry. You can use the Linux image in your typical DevOps, CI/CD pipeline, or production deployment scenarios. For more information, see [the documentation page for container deployment](/sql/linux/quickstart-install-connect-docker).

For more information about how the operating system vendors support the components in the container and the host operating system, see the following channels:

- [Red Hat Enterprise Linux Container Compatibility Matrix](https://access.redhat.com/support/policy/rhel-container-compatibility)

- [Red Hat Container Support Policy](https://access.redhat.com/articles/2726611)

## SQL Server running in Windows containers

SQL Server deployments in Windows containers are not covered by support. For development and testing, create your own custom container images to work with SQL Server in Windows containers. Sample files are available on [GitHub](https://github.com/microsoft/mssql-docker/tree/master/windows) but are provided for reference only.

## SQL Server Containers running on container orchestrators

Microsoft supports deploying and managing SQL Server containers by using OpenShift and Kubernetes.

Starting from SQL Server 2019, you can deploy the SQL Server Big Data Cluster on Kubernetes. Review the supported **Kubernetes platforms** in the [SQL Server 2019 Big Data Clusters release notes](/sql/big-data-cluster/release-notes-big-data-cluster) under the **Supportability** section.

## Customizing SQL Server Containers

Creation of custom SQL Server Linux Containers is supported when customized on top of SQL Server base containers downloaded from MCR (Container Registry), as well as ensuring that you do not modify the `SQL directories/binaries/licenses` located at the locations: `/opt/mssql/*` and `/usr/share/doc/*`, which when incorrectly modified could result in SQL Server process not starting.

You can also build your own SQL Server container images from scratch, given that the base image of the Linux OS container used to generate the custom SQL Server container image matches the [supported platforms](/sql/linux/sql-server-linux-release-notes-2019) for SQL Server on Linux and you follow the guidelines mentioned above.  

As part of troubleshooting, if the customized container has SQL Server startup issues or some other SQL Server exception/error, then Microsoft can require you to uninstall the customization or add specific tools or packages to help troubleshoot and replicate the problem. If the issue does not occur after the removal of customization, then Microsoft will not support the customization or custom script.

SQL container customization is not supported for use in other Microsoft products that use SQL Linux containers such as Azure Arc for Data Services, Azure SQL Edge etc.,

- **Examples of supported configurations:**

  1. You download SQL Container image from MCR, and then using dockerfile you add features like Polybase, MSDTC, etc. These changes or similar changes are supported to help create your own custom SQL container image.

  1. You can also build a custom SQL Server 2019 container image on top of a supported Linux OS platform like RHEL 8.2 UBI container image or SLES 12 base images.

- **Examples of unsupported configurations:**

  You try building a customized image on top of any Linux platform that is not mentioned in the [supported platforms](/sql/linux/sql-server-linux-release-notes-2019) documentation.

## Supported file systems

If you install SQL Server on Windows, the supported file systems are NTFS and ReFS. This applies to the volumes that store the database files and program binaries.

If you install SQL Server on Linux, the supported file systems for the volumes that host database files are EXT4 and XFS.

## Supported high availability solutions

When you set up a high availability solution for SQL Server on Windows, refer to the support policies and requirements at [The Microsoft SQL Server support policy for Microsoft Clustering](https://support.microsoft.com/help/327518) and [Prerequisites, Restrictions, and Recommendations for Always On availability groups](/sql/database-engine/availability-groups/windows/prereqs-restrictions-recommendations-always-on-availability).

When you set up a high availability solution for SQL Server on Linux, review the support policies of the OS vendor that are specific to high availability. Production environments require a fencing agent, such as STONITH, for high availability. A Linux cluster uses fencing to return the cluster to a known state. The correct manner in which to configure fencing depends on the distribution and the environment. Currently, fencing is not available in some cloud environments. For more information, see the following OS vendor policies and recommendations:

- [Support Policies for RHEL High Availability Clusters - Virtualization Platforms](https://access.redhat.com/articles/2912891)

- [Support Policies for RHEL High Availability Clusters - Subscriptions, Support Services, and Software Access](https://access.redhat.com/articles/3290191)

- [SUSE Linux Enterprise High Availability Extension](https://documentation.suse.com/sle-ha/12-SP4/#redirectmsg)

For supported high availability solution in SQL Server on Linux, see [Business continuity and database recovery - SQL Server on Linux](/sql/linux/sql-server-linux-business-continuity-dr).

## Unsupported features

You can find the current list of SQL Server features that aren't supported in the unsupported features and services section in [Release notes for SQL Server 2017 on Linux](/sql/linux/sql-server-linux-release-notes?view=sql-server-ver15&preserve-view=true). If you try to use components or features that are listed in the notes as unsupported, you might experience unexpected symptoms and errors. When you use a combination of features for your application or solution, make sure that the interoperability between the features is documented as supported. For guidance, see [Always On availability groups: interoperability (SQL Server)](/sql/database-engine/availability-groups/windows/always-on-availability-groups-interoperability-sql-server).

## Support policy

Microsoft provides technical support and product fixes for SQL Server components that are deployed on supported operating system, file systems, hypervisors, and hardware architectures in accordance with the product documentation. Microsoft may provide limited or no technical support for SQL Server software components that are deployed on unsupported operating systems, file systems, hypervisors, and hardware platforms.

If you deploy SQL Server on an unsupported operating system, file system, or hypervisor, you might experience unexplained behavior and results. When you troubleshoot such problems, the Microsoft Support team may ask you to reproduce the problem on a supported combination of operating system, file system, hypervisor, and hardware architecture. Under these circumstances, Microsoft might be unable to provide support or a resolution for the problem if the problem occurs only in the unsupported combination of operating system, file system, hypervisor, or architecture.

When you troubleshoot problems that occur when you use a solution or application that's built by using SQL Server, Microsoft Support will try to isolate the cause of the problem to the specific software or hardware layer source. The problem might be either in the SQL Server software or the operating system components that SQL Server interacts with. If the problem is in SQL Server, Microsoft Support will provide appropriate resolution and application workarounds for the problem. If the problem is in the operating system behavior, Microsoft Support will refer you to the operating system vendor for follow-up and resolution. For supported operating systems,
Microsoft Support will collaborate with the operating system support vendor to give you a commercially workable resolution.

Before you deploy SQL Server on a specific version of an operating system, check the product documentation for SQL Server and also check with the operating system vendor about support requirements for the whole solution that you're building to make sure that the different components that are involved are compatible and supported.
Contact the operating system vendor about the support policies that apply to the additional support policies for virtualization, storage, and hardware layers.

Microsoft will support using official container images that are published by Microsoft to the various container repositories. If you use SQL Server container images from other contributors, Microsoft Support might request that you reproduce the problem on the official container image. This step might be necessary to exclude the possibility that customizations or modifications to the private container image are contributing to the problem.

If the problem is isolated to container engine behavior, you must work with the vendor of the container engine to address the problem.

Microsoft might be unable to provide technical support if you use an unsupported feature or use a feature in an unsupported or undocumented manner.

## SQL Server in Azure

If you deployed SQL Server on a virtual machine in Azure, the support policies for Azure apply when you troubleshoot problems. See [Endorsed Linux distributions on Azure](/azure/virtual-machines/linux/endorsed-distros).

If you deploy SQL Server on other cloud solutions or platforms, check with the cloud solution provider about their specific policies that govern production or commercial support.

## Product lifecycle

SQL Server follows the Fixed Lifecycle Policy for obtaining support and updates. See [Search Product and Services Lifecycle Information](/lifecycle/products/) for the lifecycle and stage (mainstream, extended, and out-of-support) for each product version. Big Data Clusters is an add-on to SQL Server 2019 and is governed as such under the Fixed Lifecycle Policy.

Service Packs are released for SQL Server through version 2016. Support ends 12 months after the next service pack releases or at the end of the product's support life cycle, whichever comes first. For more information, see the [Fixed Lifecycle Policy](/lifecycle/policies/fixed#service-packs).

No service packs will be released starting from SQL Server 2017. For more information, see [SQL Server Service Packs are discontinued starting from SQL Server 2017](https://support.microsoft.com/help/4041553/sql-server-service-packs-are-discontinued-starting-from-sql-server).

For releases that start at SQL Server 2017, we recommend that you apply the latest cumulative update (or a CU that was released during the past year) for the corresponding release. The support team might require you to apply a specific CU that addresses a specific problem when you troubleshoot an issue.

Operating systems follow their own life cycles. Contact the system vendor about the applicable life-cycle timeframe and supported versions.

## Obtain support from Microsoft

There are many channels through which you can obtain support for SQL Server. If you encounter a problem that affects an on-premises deployment of SQL Server, you can review [support options for business users](https://support.microsoft.com/topic/support-for-business-1f4c4d09-9047-28ac-bb3b-618757e3bffd) to obtain assisted support from the Support team. If you deployed SQL Server in an Azure cloud environment, you can submit support requests from the [Help + Support](https://portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview) in the Azure management portal.

You can also submit your problem report or product suggestion to [the Connect site](/collaborate/connect-redirect).

Additionally, you can engage with the SQL Server engineering team by using the following options:

- [Stack Exchange (tag sql-server)](https://dba.stackexchange.com/questions/tagged/sql-server) - Database administration questions

- [Stack Overflow (tag sql-server)](http://stackoverflow.com/questions/tagged/sql-server) - Development questions

- [Microsoft Q&A](/answers/topics/58065/sql-server-general.html) - Technical questions

- [Reddit](https://www.reddit.com/r/SQLServer/) - Discuss SQL Server

## Obtain support from Linux operating system vendors

If the technical problem that you experience doesn't exist in the SQL Server product but does occur in the operating system, you can work directly with the operating system vendor to troubleshoot the problem. You can contact the support teams of the operating system vendors by using the following channels:

- [Ubuntu Operating System](https://login.ubuntu.com/+login)
- [Red Hat Operating System](https://access.redhat.com/support/customer-service)
- [SUSE Operating System](https://www.suse.com/support/)

## Obtain support from SQL Server-based PaaS and IaaS cloud vendors

If the technical problem that you experience exists in a third-party cloud Platform as a Service (PaaS) or Infrastructure as a Service (IaaS) offering, work directly with the solution vendor to troubleshoot the problem. For example:

- [Amazon RDS (Amazon Web Services))](https://aws.amazon.com/rds)
- [Microsoft SQL Server on AWS (Amazon Web Services))](https://aws.amazon.com/sql)
  - For more information, see [Microsoft FAQ – Amazon Web Services (AWS)](https://aws.amazon.com/windows/faq/#eos-microsoft-products)
- [Cloud SQL: for PostgreSQL, MySQL & SQL Server (Google Cloud)](https://cloud.google.com/sql/)

## Third-party information disclaimer

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
