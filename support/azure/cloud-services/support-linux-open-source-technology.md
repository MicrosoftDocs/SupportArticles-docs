---
title: Support for Linux and open-source technology in Azure
description: Describes support for Linux images in Microsoft Azure.
ms.date: 07/06/2020
ms.reviewer: patcatun
author: genlin
ms.author: genli
ms.service: cloud-services
---
# Support for Linux and open-source technology in Azure

_Original product version:_ &nbsp; Cloud Services (Web roles/Worker roles), MSfC Azure-Azure Apps (IaaS)  
_Original KB number:_ &nbsp; 2941892

This article describes the support policies for [Endorsed Linux distributions](/azure/virtual-machines/linux/endorsed-distros) and [open source technologies](https://azure.microsoft.com/overview/open-source/) in Azure.

> [!NOTE]
> The supported Linux distributions for Azure Stack Hub can be found in [this article](/azure-stack/operator/azure-stack-supported-os?view=azs-2002&preserve-view=true#linux).

## Linux in Azure

The endorsed Linux distributions are created and published by Linux partners for use in Azure environments. It's recommended to use an [Endorsed Linux distribution](/azure/virtual-machines/linux/endorsed-distros), because they're maintained by some of the most well-known Linux vendors in the world. You're welcome to bring your distributions of Linux into Azure. All distributions are welcome.

## Linux support matrix

|Linux Distribution|Microsoft Support Policy|Customer Resources|
|---|---|---|
| Customers who bring their own Linux virtual machine into Azure| Microsoft Support will assist you in using Azure platform or services, and may offer guidance for issues within Linux. A [support plan](https://azure.microsoft.com/support/plans/) is required to engage Microsoft Support.| The primary responsibility is with the customer. Microsoft may be able to offer guidance for issues within Linux. <br/><br/> Want to bring your own custom image? Start here: [Microsoft Azure: Linux Virtual Machines](/azure/virtual-machines/linux/) |
| CentOS by Rogue Wave Software (formerly Open Logic)| Microsoft Support will assist you in using Azure platform or services, and may offer guidance for issues within Linux. A [support plan](https://azure.microsoft.com/support/plans/) is required to engage Microsoft Support.| [The CentOS Project](https://wiki.centos.org/About) |
| CoreOS <br/> CoreOS is scheduled to be [end of life](https://coreos.com/os/eol/) by May 26, 2020.| Microsoft Support will assist you in using Azure platform or services, and may offer guidance for issues within Linux. A [support plan](https://azure.microsoft.com/support/plans/) is required to engage Microsoft Support.| Microsoft has two (2)  channels of migration for CoreOS users. <br/><br/>1. Flatcar by Kinvolk (see the "Flatcar Container Linux by Kinvolk" entry. ) <br/><br/>2. [Fedora Core OS](https://docs.fedoraproject.org/en-US/fedora-coreos/provisioning-azure/) (customers must upload their own image. Here's the [migration documentation](https://docs.fedoraproject.org/en-US/fedora-coreos/migrate-cl/)). |
| Debian by Credativ| Microsoft Support will assist you in using Azure platform or services, and may offer guidance for issues within Linux. A [support plan](https://azure.microsoft.com/support/plans/) is required to engage Microsoft Support.| [Debian GNU/Linux as an endorsed distribution in Azure Marketplace](https://azure.microsoft.com/blog/debian-images-now-available-on-azure/) [Credativ Support Contacts](https://www.credativ.de/en/portfolio/support/) |
| Flatcar Container Linux by Kinvolk| Microsoft Support will assist you in using Azure platform or services, and may offer guidance for issues within Linux. A [support plan](https://azure.microsoft.com/support/plans/) is required to engage Microsoft Support.| [Migrating from CoreOS to Flatcar Container Linux](https://kinvolk.io/blog/2020/04/running-flatcar-container-linux-in-microsoft-azure/). |
| Oracle Linux by Oracle| Microsoft Support will assist you in using Azure platform or services, and may offer guidance for issues within Linux. A [support plan](https://azure.microsoft.com/support/plans/) is required to engage Microsoft Support.| Oracle Linux users must have an active Oracle license. Microsoft may be able to give some guidance, but may defer support issues to Oracle. [Lifetime Support Policy: Coverage for Oracle Linux and Oracle VM](https://www.oracle.com/a/ocom/docs/elsp-lifetime-069338.pdf) [Oracle Support Contacts](https://support.oracle.com/portal/) |
| Red Hat Enterprise Linux (RHEL) by Red Hat| Microsoft Support will assist you in using Azure platform or services, and may offer guidance for issues within Linux. A [support plan](https://azure.microsoft.com/support/plans/) is required to engage Microsoft Support. For more information, please visit [Red Hat and Microsoft Azure Certified Cloud & Service Provider Support Policies](https://access.redhat.com/articles/2041273).| Red Hat has two (2) offerings for RHEL in Azure: <br/>1. [On-Demand (PAYG)](https://access.redhat.com/public-cloud/microsoft-azure) <br/>2. [Cloud Access (Gold Images)](https://www.redhat.com/en/technologies/cloud-computing/cloud-access)<br/><br/>Microsoft and Red Hat partner offer an integrated support experience. Support cost is integrated in the consumption cost of On-Demand images.<br/><br/>Cloud Access (BYOS) Support customers must have support agreements with both companies. The customer may be requested to engage Red Hat through their support agreement and bring Microsoft and Red Hat together on a service request.<br/><br/>Converting either On-Demand to Cloud Access, or Cloud Access to On-Demand can be done through the Azure Hybrid Benefit.<br/><br/>For more information, please see [Preview: Azure Hybrid Benefit – how it applies for Linux Virtual Machines](/azure/virtual-machines/linux/azure-hybrid-benefit-linux).|
| SUSE Linux Enterprise Server by SUSE openSUSE by SUSE| Microsoft Support will assist you in using Azure platform or services, and may offer guidance for issues within Linux. A [support plan](https://azure.microsoft.com/support/plans/) is required to engage Microsoft Support.| SUSE has 3 offerings in Azure: <br/>1. Bring Your Own Subscription (BYOS) <br/>2. SUSE Images with Patching Support <br/>3. 24x7 Support Images <br/><br/> Bring Your Own Subscription (BYOS)<br/> <br/>Customers must register with SUSE to use these images. Microsoft may provide guidance for Linux issues, but may defer customer issues to SUSE directly.<br/> <br/>SUSE Images with Patching Support<br/><br/> This image includes updates for your virtual machine from SUSE. Microsoft may assist for Linux issues, but this image doesn't include additional support from SUSE. SUSE related inquiries may require the customer to engage SUSE directly, and require an active SUSE support agreement. <br/><br/>24x7 Support Images<br/><br/> 24x7 support includes updates and support through 24x7 web, email, chat, and telephone from Microsoft and SUSE. Virtual machines that are created from this image incur per-hour support fees, in addition to Azure platform fees. <br/><br/>Conversion between PAYG Offerings to BYOS can be done through the Azure Hybrid Benefit.<br/><br/> For more information, see [Preview: Azure Hybrid Benefit – how it applies for Linux Virtual Machines](/azure/virtual-machines/linux/azure-hybrid-benefit-linux)|
| Ubuntu Linux by Canonical| Microsoft Support will assist you in using Azure platform or services, and may offer guidance for issues within Linux. A [support plan](https://azure.microsoft.com/support/plans/) is required to engage Microsoft Support.| [Ubuntu Wiki: Releases](https://wiki.ubuntu.com/Releases)<br/><br/> [The Ubuntu lifecycle and release cadence](http://www.ubuntu.com/info/release-end-of-life) |
  
## Linux support scope

Microsoft offers Linux support for [endorsed Linux distributions](/azure/virtual-machines/linux/endorsed-distros) in Azure. The Linux vendor may need to be engaged depending on the scenario.

- Microsoft will assist you with commercially viable support in the form of break-fix issues for Linux. The Linux vendor may have to be engaged by the customer to troubleshoot specific system-related problems. Microsoft may be able to collaborate with the vendor for those issues.
- Have your Linux administrator engaged when working with Azure support. Any consulting work may be referred to Microsoft Services if that type of guidance is needed.
- Customizing Linux is one of the hallmarks of the operating system. We encourage you to use a Linux solution that benefits your organization. However, some modifications may not be supported by the Linux vendor, such as custom kernel or modules. For vendor support, you may be required to use stock kernels or libraries for your image. For more information, contact your Linux vendor.
- Microsoft may provide recommendations about Azure platform and services. For some troubleshooting and performance tuning within Linux or applications, the customer should directly contact the vendor of the supported Linux distribution or application.
- Microsoft Support doesn't assist in the design, architecture, or deployment of applications or solutions on Azure.
- Scenarios related to security aren't supported. They include but aren't limited to:

  - compromised virtual machines
  - security forensics
  - DDoS
  - intrusion-prevention assistance

## Open-source technology support matrix

Microsoft may offer support for the following specific open-source technologies (subject to change):

- Languages: PHP, Java, Python, Node.JS
- Database: MySQL
- Web and application servers: Apache HTTP Server, Apache Tomcat
- Frameworks: WordPress

## Open-source technology support scope

Microsoft will assist with supported open-source technologies. Customers who request support for design guidance or development assistance may be directed to forums or community support. Customers may also have to work with our Linux partners or software vendors directly for scenarios that aren't supported by Microsoft. Examples include, but aren't limited to:

- application development
- troubleshooting custom applications
- custom code

Here are some of the support scenarios that Microsoft will assist with:

- Issues during installation or configuration.
- Deployment errors when customers try to deploy applications to the Azure platform and services.
- Runtime errors when customers use the Azure platform and services.
- Performance issues that affect applications that were built by using the supported open-source technologies on the Azure platform and services.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../includes/third-party-contact-disclaimer.md)]
