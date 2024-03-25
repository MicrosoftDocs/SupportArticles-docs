---
title: Support for Linux and open-source technology in Azure
description: Describes support for Linux images in Microsoft Azure.
ms.date: 03/21/2024
ms.reviewer: divargas, hokamath, genli, v-leedennis, v-weizhu
author: patcatun
ms.author: patcatun
ms.service: cloud-services
ms.subservice: reference
ms.custom: linux-related-content
---

# Support for Linux and open-source technology in Azure

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), MSfC Azure-Azure Apps (IaaS)  
_Original KB number:_ &nbsp; 2941892

This article describes the support policies for [Endorsed Linux distributions](/azure/virtual-machines/linux/endorsed-distros) and [open source technologies](https://azure.microsoft.com/overview/open-source/) in Azure.

> [!NOTE]
> The supported Linux distributions for Azure Stack Hub can be found in [this article](/azure-stack/operator/azure-stack-supported-os?view=azs-2002&preserve-view=true#linux).

## Linux in Azure

The endorsed Linux distributions are created and published by Linux partners for use in Azure environments. We recommend that you use an [Endorsed Linux distribution](/azure/virtual-machines/linux/endorsed-distros) because they're maintained by some of the most well-known Linux vendors in the world. You're welcome to bring your distributions of Linux into Azure. All distributions, such as Rocky, Alma, and Kali, are welcome.

## Linux support matrix

|Linux Distribution|Microsoft Support Policy|Customer Resources|
|---|---|---|
| Customers who bring their own Linux virtual machine (VM) into Azure| Microsoft Support will assist you in using Azure platform or services, and may offer guidance for issues within Linux. A [support plan](https://azure.microsoft.com/support/plans/) is required to engage Microsoft Support.| The primary responsibility is with the customer. Microsoft may be able to offer guidance for issues within Linux. <br/><br/> Want to bring your own custom image? Start here: [Microsoft Azure: Linux Virtual Machines](/azure/virtual-machines/linux/) |
| CentOS by Rogue Wave Software (formerly Open Logic)| Microsoft Support will assist you in using Azure platform or services, and may offer guidance for issues within Linux. A [support plan](https://azure.microsoft.com/support/plans/) is required to engage Microsoft Support.| [The CentOS Project](https://wiki.centos.org/About.html) |
| CoreOS <br/> CoreOS is scheduled to be end of life by May 26, 2020.| Microsoft Support will assist you in using Azure platform or services, and may offer guidance for issues within Linux. A [support plan](https://azure.microsoft.com/support/plans/) is required to engage Microsoft Support.| Microsoft has two (2) channels of migration for CoreOS users: <br/><br/>1. Flatcar by Kinvolk (see the "Flatcar Container Linux by Kinvolk" entry. ) <br/><br/>2. [Fedora Core OS](https://docs.fedoraproject.org/en-US/fedora-coreos/provisioning-azure/) (customers must upload their own image. Here's the [migration documentation](https://docs.fedoraproject.org/en-US/fedora-coreos/migrate-cl/)). |
| Debian by Credativ| Microsoft Support will assist you in using Azure platform or services, and may offer guidance for issues within Linux. A [support plan](https://azure.microsoft.com/support/plans/) is required to engage Microsoft Support.| [Debian GNU/Linux as an endorsed distribution in Azure Marketplace](https://azure.microsoft.com/blog/debian-images-now-available-on-azure/) [Credativ Support Contacts](https://www.credativ.de/en/portfolio/support/) |
| Flatcar Container Linux by Kinvolk| Microsoft Support will assist you in using Azure platform or services, and may offer guidance for issues within Linux. A [support plan](https://azure.microsoft.com/support/plans/) is required to engage Microsoft Support.| [Migrating from CoreOS to Flatcar Container Linux](https://kinvolk.io/blog/2020/04/running-flatcar-container-linux-in-microsoft-azure/). |
| Oracle Linux by Oracle| Microsoft Support will assist you in using Azure platform or services, and may offer guidance for issues within Linux. A [support plan](https://azure.microsoft.com/support/plans/) is required to engage Microsoft Support.| Oracle Linux users must have an active Oracle license. Microsoft may be able to give some guidance, but may defer support issues to Oracle. [Lifetime Support Policy: Coverage for Oracle Linux and Oracle VM](https://www.oracle.com/a/ocom/docs/elsp-lifetime-069338.pdf) [Oracle Support Contacts](https://support.oracle.com/portal/) |
| Red Hat Enterprise Linux (RHEL) by Red Hat| Microsoft Support will assist you in using Azure platform or services, and may offer guidance for issues within Linux. A [support plan](https://azure.microsoft.com/support/plans/) is required to engage Microsoft Support. For more information, please visit [Red Hat and Microsoft Azure Certified Cloud & Service Provider Support Policies](https://access.redhat.com/articles/2041273).| Red Hat has two (2) offerings for RHEL in Azure: <br/><br/>1. [On-Demand (PAYG)](https://access.redhat.com/public-cloud/microsoft-azure) <br/>2. [Cloud Access (Gold Images)](https://www.redhat.com/en/technologies/cloud-computing/cloud-access)<br/><br/>Microsoft and Red Hat partner offer an integrated support experience. Support cost is integrated into the consumption cost of On-Demand images.<br/><br/>Cloud Access (BYOS) Support customers must have support agreements with both companies. The customer may be requested to engage Red Hat through their support agreement and bring Microsoft and Red Hat together on a service request.<br/><br/>Converting either On-Demand to Cloud Access or Cloud Access to On-Demand can be done through the Azure Hybrid Benefit.<br/><br/>For more information, please see [Preview: Azure Hybrid Benefit – how it applies for Linux Virtual Machines](/azure/virtual-machines/linux/azure-hybrid-benefit-linux).|
| SUSE Linux Enterprise Server by SUSE openSUSE by SUSE| Microsoft Support will assist you in using Azure platform or services, and may offer guidance for issues within Linux. A [support plan](https://azure.microsoft.com/support/plans/) is required to engage Microsoft Support.| <p>SUSE has three offerings in Azure:</p> <ol><li><p>**Bring Your Own Subscription (BYOS)**</p> <p>Customers must register with SUSE to use these images. Microsoft may provide guidance for Linux issues, but may defer customer issues to SUSE directly.</p><br/></li> <li><p>**SUSE Images with Patching Support**</p> <p>These images include updates for your VM from SUSE. Microsoft may assist for Linux issues, but these images don't include extra support from SUSE. SUSE-related inquiries may require the customer to engage SUSE directly and require an active SUSE support agreement.</p><br/></li> <li><p>**24x7 Support Images**</p> <p>These images include updates and support through web, email, chat, and telephone from Microsoft. SUSE supports these images all day, every day, as defined in their support policies for public cloud images in the [SUSE Public Cloud Guide](https://documentation.suse.com/sle-public-cloud/all/html/public-cloud/cha-intro.html). These images are considered [SUSE Level 3 subscriptions](https://www.suse.com/support/handbook/#level-3-subscriptions). VMs that are created from these images incur per-hour support fees in addition to Azure platform fees.</p></li></ol> <p>Conversion between PAYG Offerings to BYOS can be done through the Azure Hybrid Benefit.</p> <p>For more information, see [Preview: Azure Hybrid Benefit – how it applies for Linux Virtual Machines](/azure/virtual-machines/linux/azure-hybrid-benefit-linux).</p> |
| Ubuntu Linux by Canonical| Microsoft Support will assist you in using Azure platform or services, and may offer guidance for issues within Linux. A [support plan](https://azure.microsoft.com/support/plans/) is required to engage Microsoft Support.| [Ubuntu Wiki: Releases](https://wiki.ubuntu.com/Releases)<br/><br/> [The Ubuntu lifecycle and release cadence](http://www.ubuntu.com/info/release-end-of-life) |

> [!IMPORTANT]
>
> ***Action recommended: Canonical Ubuntu 18.04 LTS Reaching End of Standard Support on 31 May 2023***
>
> You can continue to use your existing VMs. However, security, feature, and maintenance updates will no longer be provided by Canonical and may leave your systems vulnerable. We recommend that you either migrate to the next Ubuntu LTS release or upgrade to Ubuntu Pro to gain access to extended security and maintenance from Canonical.
> - Upgrading to Ubuntu 20.04 LTS or Ubuntu 22.04
> 
>   Transitioning to the latest operating system, such as [Ubuntu 20.04 LTS](https://azuremarketplace.microsoft.com/marketplace/apps/canonical.0001-com-ubuntu-server-focal?tab=Overview) or [Ubuntu Pro 22.04](https://azuremarketplace.microsoft.com/marketplace/apps/canonical.0001-com-ubuntu-pro-jammy?tab=Overview) LTS, is important for performance, hardware enablement, and new technology benefits, and we recommend it for new instances. The transition may be a complex process for existing deployments. Therefore, it should be properly scoped and tested with your workloads. Although there's no direct upgrade path from Ubuntu 18.04 LTS to Ubuntu 22.04 LTS, you can directly upgrade to Ubuntu 20.04 LTS, and then to Ubuntu 22.04 LTS, or directly install Ubuntu 22.04 LTS. For more information, see the [Ubuntu Server upgrade guide](https://ubuntu.com/server/docs/upgrade-introduction).
> - Ubuntu Pro – Extended Security Maintenance to 2028
> 
>   Ubuntu Pro includes security patching for all Ubuntu packages because of Extended Security Maintenance (ESM) for Infrastructure and Applications and optional 24/7 phone and ticket support. Ubuntu Pro 18.04 LTS will remain fully supported until April 2028. Ubuntu Pro is available for free for personal and small-scale commercial users on up to five VMs and with transparent, per-machine pricing for enterprises. New VMs can be deployed with Ubuntu Pro from the [Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps/canonical.0001-com-ubuntu-pro-bionic?tab=Overview). You can also upgrade existing VMs to [Ubuntu Pro](https://ubuntu.com/pro) by purchasing from Canonical. For more information about Ubuntu 18.04 LTS End of Standard Support, see [Ubuntu 18.04 LTS (Bionic Beaver) on Azure](https://ubuntu.com/18-04/azure). 

## Linux support scope

Microsoft offers Linux support for [endorsed Linux distributions](/azure/virtual-machines/linux/endorsed-distros) in Azure. Depending on the scenario, the Linux vendor may have to be engaged.

- Microsoft will assist you with commercially viable support in the form of break-fix issues for Linux. The Linux vendor may have to be engaged by the customer to troubleshoot specific system-related problems. Microsoft may be able to collaborate with the vendor for those issues.
- Have your Linux administrator engaged when you work with Azure support. Any consulting work may be referred to Microsoft Services if that type of guidance is needed.
- The ability to customize Linux is one of the hallmarks of the operating system. We encourage you to use a Linux solution that benefits your organization. However, some modifications may not be supported by the Linux vendor, such as custom kernel or modules. For vendor support, you may be required to use stock kernels or libraries for your image. For more information, contact your Linux vendor.
- Microsoft may provide recommendations about Azure platform and services. For some troubleshooting and performance tuning within Linux or applications, the customer should directly contact the vendor of the supported Linux distribution or application.
- Microsoft Support doesn't assist in the design, architecture, or deployment of applications or solutions on Azure.
- Scenarios that are related to security aren't supported. These include, but aren't limited to:

  - Compromised VMs
  - Security incident response investigations
  - Intrusion-prevention assistance

## Open-source technology support matrix

Microsoft may offer support for the following specific open-source technologies (subject to change):

- Languages: PHP, Java, Python, Node.JS
- Database: MySQL
- Web and application servers: Apache HTTP Server, Apache Tomcat
- Frameworks: WordPress

## Open-source technology support scope

Microsoft will assist with supported open-source technologies. Customers who request support for design guidance or development assistance may be directed to forums or community support. Customers may also have to work with our Linux partners or software vendors directly for scenarios that aren't supported by Microsoft. Examples include, but aren't limited to:

- Application development
- Troubleshooting custom applications
- Custom code

The following are some of the support scenarios that Microsoft will assist with:

- Issues that occur during installation or configuration
- Deployment errors that occur when customers try to deploy applications to the Azure platform and services
- Runtime errors that occur when customers use the Azure platform and services
- Performance issues that affect applications that were built by using the supported open-source technologies on the Azure platform and services

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]
