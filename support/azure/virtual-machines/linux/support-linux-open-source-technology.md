---
title: Linux and open-source technology support
description: Describes support for Linux distributions and open-source technology support in Microsoft Azure.
ms.service: azure-virtual-machines
ms.custom: sap:VM Admin - Linux (Guest OS), linux-related-content
ms.topic: article
ms.date: 05/31/2024
ms.reviewer: patcatun, clausw, divargas, rondom, azurevmlnxcic, v-weizhu
---

# Linux and open-source technology support in Azure

**Applies to:** :heavy_check_mark: Linux VMs

Microsoft Azure supports the [Linux operating system](https://azure.microsoft.com/solutions/linux-on-azure). All Linux distributions are welcome in Azure. To upload your Linux distribution to Azure, see the [requirements](/azure/virtual-machines/linux/imaging). Marketplace images of the most popular Linux distributions are also available. Support for these images is available but requires a support contract. See the following Linux support for more details.

## Linux support matrix

> [!NOTE] 
> For more information about endorsed distributions and major releases, see [Endorsed Linux distributions on Azure](/azure/virtual-machines/linux/endorsed-distros).

|Linux Publisher / Distribution | Images (Offers) | Microsoft Support Policy | Description|
|---|---|---|---|
|**AlmaLinux**|[AlmaLinux OS (x86_64/AMD64)](https://azuremarketplace.microsoft.com/marketplace/apps/almalinux.almalinux-x86_64?tab=Overview) <br/><br/> [AlmaLinux OS (AArch64/ARM64)](https://azuremarketplace.microsoft.com/marketplace/apps/almalinux.almalinux-arm?tab=Overview) <br/><br/> [AlmaLinux OS (x86_64/AMD64) HPC](https://azuremarketplace.microsoft.com/marketplace/apps/almalinux.almalinux-hpc?tab=Overview) <br/><br/> |Microsoft CSS provides commercially reasonable support for these images.|AlmaLinux OS is a 100% community owned and governed, open source and forever free enterprise-grade Linux distribution. With long-term stability and providing a robust production-grade platform, AlmaLinux OS is 1:1 compatible with RHEL/CentOS.|
|**Canonical / Ubuntu**| [Ubuntu Server 20.04 LTS](https://azuremarketplace.microsoft.com/marketplace/apps/canonical.0001-com-ubuntu-server-focal?tab=Overview) <br/><br/> [Ubuntu Pro 20.4 LTS](https://azuremarketplace.microsoft.com/marketplace/apps/canonical.0001-com-ubuntu-pro-focal?tab=Overview) <br/><br/> [Ubuntu Server 22.04 LTS](https://azuremarketplace.microsoft.com/marketplace/apps/canonical.0001-com-ubuntu-server-jammy?tab=Overview) <br/><br/> [Ubuntu Pro 22.04 LTS](https://azuremarketplace.microsoft.com/marketplace/apps/canonical.0001-com-ubuntu-pro-jammy?tab=Overview) <br/><br/> [Ubuntu 22.04 LTS (including Pro)](https://azuremarketplace.microsoft.com/marketplace/apps/canonical.ubuntu-24_04-lts?tab=Overview) <br/><br/> |Microsoft CSS provides commercially reasonable support these images. | Canonical produces official Ubuntu images for Microsoft Azure and continuously tracks and delivers updates to these, ensuring security and stability are built from the moment your virtual machines launch. <br/><br/> Canonical works closely with Microsoft to optimize Ubuntu images on Azure and ensure Ubuntu supports the latest cloud features as they're released. Ubuntu powers more mission-critical workloads on Azure than any other operating system. <br/><br/> https://ubuntu.com/azure |
|**Credativ / Debian**| [Debian 11 "Bullseye"](https://azuremarketplace.microsoft.com/marketplace/apps/debian.debian-11?tab=Overview) <br/><br/> [Debian 12 "Bookworm"](https://azuremarketplace.microsoft.com/marketplace/apps/debian.debian-12?tab=Overview) |Microsoft CSS provides support for these images. | Credativ is an independent consulting and services company that specializes in the development and implementation of professional solutions by using free software. As leading open-source specialists, Credativ has international recognition with many IT departments that use their support. In conjunction with Microsoft, Credativ is preparing Debian images. The images are specially designed to run on Azure and can be easily managed via the platform. credativ will also support the long-term maintenance and updating of the Debian images for Azure through its Open Source Support Centers. <br/><br/> https://www.credativ.de/portfolio/support/open-source-support-center |
|**Kinvolk / Flatcar**| [Flatcar Container Linux](https://azuremarketplace.microsoft.com/marketplace/apps/kinvolk.flatcar-container-linux-free) <br/><br/> [Flatcar Container Linux (BYOL)](https://azuremarketplace.microsoft.com/marketplace/apps/kinvolk.flatcar-container-linux) <br/><br/> [Flatcar Container Linux ARM64](https://azuremarketplace.microsoft.com/marketplace/apps/kinvolk.flatcar-container-linux-corevm) |Microsoft CSS provides commercially reasonable support these images. | Flatcar Container Linux is a minimal, immutable, and auto-updating operating system for containerized applications. Originally developed by Kinvolk, it's now 100% community governed as a Cloud Native Computing Foundation (CNCF) project. Flatcar is a minimal distro, containing just those packages required for deploying containers. Its immutable file system guarantees consistency and security, while its auto-update capabilities enable you to be always up-to-date with the latest security fixes. Kinvolk was acquired by Microsoft in April 2021 and, post-acquisition, continues its mission within Microsoft to support the Flatcar community.<br/><br/> https://www.flatcar.org |
|**Oracle Linux**|[Oracle Linux](https://azuremarketplace.microsoft.com/marketplace/apps/oracle.oracle-linux) |Microsoft CSS provides commercially reasonable support these images. | Oracle's strategy is to offer a broad portfolio of solutions for public and private clouds. The strategy gives customers choice and flexibility in how they deploy Oracle software in Oracle clouds and other clouds. Oracle's partnership with Microsoft enables customers to deploy Oracle software to Microsoft public and private clouds with the confidence of certification and support from Oracle. Oracle's commitment and investment in Oracle public and private cloud solutions is unchanged. <br/><br/> https://www.oracle.com/cloud/azure |
|**Red Hat / Red Hat Enterprise Linux (RHEL)** | [Red Hat Enterprise Linux](https://azuremarketplace.microsoft.com/marketplace/apps/redhat.rhel-20190605) <br/><br/> [Red Hat Enterprise Linux RAW](https://azuremarketplace.microsoft.com/marketplace/apps/redhat.rhel-raw) <br/><br/> [Red Hat Enterprise Linux ARM64](https://azuremarketplace.microsoft.com/marketplace/apps/redhat.rhel-arm64) <br/><br/> [Red Hat Enterprise Linux for SAP Apps](https://azuremarketplace.microsoft.com/marketplace/apps/redhat.rhel-sap-apps) <br/><br/> [Red Hat Enterprise Linux for SAP, HA, Updated Services](https://azuremarketplace.microsoft.com/marketplace/apps/redhat.rhel-sap-ha) <br/><br/> [Red Hat Enterprise Linux with HA add-on](https://azuremarketplace.microsoft.com/marketplace/apps/redhat.rhel-ha) <br/><br/> |Microsoft CSS provides commercially reasonable support these images. | The world's leading provider of open-source solutions, Red Hat helps more than 90% of Fortune 500 companies solve business challenges, align their IT and business strategies, and prepare for the future of technology. Red Hat achieves this by providing secure solutions through an open business model and an affordable, predictable subscription model. <br/><br/> https://www.redhat.com/partners/microsoft |
|**CIQ / Rocky Linux**|[Rocky Linux from CIQ](https://azuremarketplace.microsoft.com/marketplace/apps?search=ciq&page=1)|Microsoft CSS provides commercially reasonable support for these images.|Rocky Linux, developed by the Rocky Enterprise Software Foundation (RESF), is an open-source Enterprise Linux operating system designed for the community. As the founding sponsor of RESF, CIQ enhances and supports Rocky Linux on Microsoft Azure, delivering a secure, compliant, high-performance, and user-friendly platform for both development and production workloads.<br/><br/>https://ciq.com/partners/cloud/azure/|
|**SUSE / SUSE Linux Enterprise Server (SLES)** | [SUSE 12 SP5 - +24x7 Support](https://azuremarketplace.microsoft.com/marketplace/apps/suse.sles-12-sp5?tab=Overview) <br/><br/> [SUSE 12 SP5 - SAP +24x7 Support](https://azuremarketplace.microsoft.com/marketplace/apps/suse.sles-sap-12-sp5?tab=Overview) <br/><br/> [SUSE 12 SP5 - BYOS](https://azuremarketplace.microsoft.com/marketplace/apps/suse.sles-12-sp5-byos?tab=Overview) <br/><br/> [SUSE 12 SP5 - SAP BYOS](https://azuremarketplace.microsoft.com/marketplace/apps/suse.sles-sap-12-sp5-byos?tab=Overview) <br/><br/>[SUSE 15 SP6 - +24x7 Support](https://azuremarketplace.microsoft.com/marketplace/apps/suse.sles-15-sp5?tab=Overview) <br/><br/> [SUSE 15 SP6 - Patching only](https://azuremarketplace.microsoft.com/marketplace/apps/suse.sles-15-sp6-basic?tab=Overview) <br/><br/> [SUSE 15 SP6 - SAP +24x7 Support](https://azuremarketplace.microsoft.com/marketplace/apps/suse.sles-sap-15-sp6?tab=Overview) <br/><br/> [SUSE 15 SP6 - BYOS](https://azuremarketplace.microsoft.com/marketplace/apps/suse.sles-15-sp6-byos?tab=Overview) <br/><br/> [SUSE 15 SP6 - SAP BYOS](https://azuremarketplace.microsoft.com/marketplace/apps/suse.sles-sap-15-sp6-byos?tab=Overview) <br/><br/> [SUSE 15 SP6 - arm64 +24x7 Support](https://azuremarketplace.microsoft.com/marketplace/apps/suse.sles-15-sp6-arm64?tab=overview) <br/><br/> |Microsoft CSS provides commercially reasonable support these images.| SUSE Linux Enterprise Server on Azure is a proven platform that provides superior reliability and security for cloud computing. SUSE's versatile Linux platform seamlessly integrates with Azure cloud services to deliver an easily manageable cloud environment. With more than 9,200 certified applications from more than 1,800 independent software vendors for SUSE Linux Enterprise Server, SUSE ensures that workloads running supported in the data center can be confidently deployed on Azure. <br/><br/> https://www.suse.com/partners/alliance/microsoft |

## Linux support scope

Microsoft Support provides assistance with the Azure platform or services. Microsoft also provides commercially viable support for Linux. A support plan is required to receive Microsoft Support.

- In Azure Marketplace, Linux distributions such as Rocky, AlmaLinux, Kali, and many others are available. Microsoft assists with these distributions but may require customers to engage with vendors to allow collaboration between organization. Vendors must provide distribution-specific fixes.
- In Azure Marketplace, you may select a highly customized Linux image, such as a firewall appliance. Microsoft assists you with these images, but the Linux vendor must be engaged to troubleshoot specific system-related problems. Microsoft may collaborate with the vendor for those issues.
- Microsoft Support doesn't assist with basic Linux administration, design, architecture, or deployment of applications or solutions on Azure.
- The ability to customize Linux is one of the hallmarks of the operating system. We encourage you to use a Linux solution that benefits your organization. However, the Linux vendor may not support some modifications such as custom kernels or modules. For vendor support, you may be required to use stock kernels or libraries for your image.
- For some troubleshooting and performance tuning within Linux or applications, customers should directly contact the vendor of the supported Linux distribution or application.
- Scenarios that are related to security aren't supported. These include but aren't limited to:
  - Compromised VMs
  - Security incident response investigations
  - Intrusion prevention assistance

## Open-source technology support matrix

Microsoft may offer support for the following specific open-source technologies (subject to change):

- Languages: PHP, Java, Python, and Node.JS
- Database: MySQL
- Web and application servers: Apache HTTP Server and Apache Tomcat
- Frameworks: WordPress

## Open-source technology support scope

Microsoft assists with supported open-source technologies. Customers who request support for design guidance or development assistance may be directed to forums or community support. Customers may also have to work directly with our Linux partners or software vendors for scenarios that Microsoft doesn't support. Examples include but aren't limited to:

- Application development
- Custom application troubleshooting 
- Custom code

Here are some of the support scenarios that Microsoft assists with:

- Issues that occur during installation or configuration.
- Deployment errors that occur when customers try to deploy applications to the Azure platform and services.
- Runtime errors that occur when customers use the Azure platform and services.
- Performance issues that affect applications built using the supported open-source technologies on the Azure platform and services.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
