---
title: Linux and open-source technology support
description: Describes support for Linux distributions and open-source technology support in Microsoft Azure.
ms.service: virtual-machines
ms.custom: sap:VM Admin - Linux (Guest OS)
ms.topic: article
ms.date: 04/23/2024
ms.reviewer: clausw, divargas, rondom, azurevmlnxcic, v-weizhu
---
# Linux and open-source technology support in Azure

Microsoft Azure supports the [Linux operating system](https://azure.microsoft.com/solutions/linux-on-azure). All Linux distributions are welcome in Azure. To upload your Linux distribution to Azure, see the [requirements](/azure/virtual-machines/linux/imaging). Marketplace images of the most popular Linux distributions are also available. Support for these images is available but requires a support contract. See the Linux support below for more details.

## Linux support matrix

|Linux distribution|Customer resources|
|---|---|
|Red Hat Enterprise Linux (RHEL)<br/><br/>[Azure Endorsed Distribution](/azure/virtual-machines/linux/endorsed-distros)|Red Hat has two (2) offerings for RHEL in Azure:<br/><br/><ul><li>[On-Demand (PAYG)](https://access.redhat.com/public-cloud/microsoft-azure)</li><li>[Cloud Access (Gold Images)](https://www.redhat.com/en/technologies/cloud-computing/cloud-access)</li></ul><br/>Microsoft and Red Hat partner offer an integrated support experience. Support cost is integrated into the consumption cost of On-Demand images.<br/><br/>Cloud Access (BYOS) Support customers must have support agreements with both companies. The customer may be requested to engage Red Hat through their support agreement and bring Microsoft and Red Hat together on a service request.<br/><br/>Converting either On-Demand to Cloud Access or Cloud Access to On-Demand can be done through the Azure Hybrid Benefit.<br/><br/>For more information, see [Preview: Azure Hybrid Benefit – how it applies for Linux Virtual Machines](/azure/virtual-machines/linux/azure-hybrid-benefit-linux).|
|CentOS by Perforce<br/><br/>[Azure Endorsed Distribution](/azure/virtual-machines/linux/endorsed-distros)|[The CentOS Project](https://wiki.centos.org/About.html)<br/><br/>CentOS is reaching End-of-life (EOL) on June 30, 2024. For more information, see [CentOS End-Of-Life guidance - migration options](/azure/virtual-machines/workloads/centos/centos-end-of-life).|
|Canonical Ubuntu<br/><br/>[Azure Endorsed Distribution](/azure/virtual-machines/linux/endorsed-distros)|<ul><li>[Ubuntu on Azure](https://azure.microsoft.com/solutions/linux-on-azure/ubuntu/#overview)</li><li>[Ubuntu Wiki: Releases](https://wiki.ubuntu.com/Releases)</li><li>[The Ubuntu lifecycle and release cadence](http://www.ubuntu.com/info/release-end-of-life)</li><li>[Canonical Ubuntu 18.04 LTS is reaching end of standard support on 31 May 2023](upgrade-canonical-ubuntu-18dot04-lts.md)</li></ul>|
|Kinvolk Flatcar<br/><br/>[Azure Endorsed Distribution](/azure/virtual-machines/linux/endorsed-distros)|<ul><li>[Flatcar Linux](https://kinvolk.io/)</li><li>[Migrating from CoreOS to Flatcar Container Linux](https://kinvolk.io/blog/2020/04/running-flatcar-container-linux-in-microsoft-azure/)</li></ul>|
|Debian by Credativ<br/><br/>Debian is a free operating system that comes with over 43,000 packages and runs in many architectures and even different kernels.<br/><br/>[Azure Endorsed Distribution](/azure/virtual-machines/linux/endorsed-distros)|<ul><li>[Debian GNU/Linux as an endorsed distribution in Azure Marketplace](https://azure.microsoft.com/blog/debian-images-now-available-on-azure/)</li><li>[Credativ Support Contacts](https://www.credativ.de/en/portfolio/support/)</li></ul>|
|Oracle Linux<br/><br/>Oracle uniquely delivers Linux with everything required to deploy, optimize, and manage applications on-premises, in the cloud, and at the edge.<br/><br/>[Azure Endorsed Distribution](/azure/virtual-machines/linux/endorsed-distros)|<ul><li>[Oracle Linux in Azure](https://www.oracle.com/linux/)</li><li>[Lifetime Support Policy: Coverage for Oracle Linux and Oracle VM](https://www.oracle.com/a/ocom/docs/elsp-lifetime-069338.pdf)</li><li>[Oracle Support Contacts](https://support.oracle.com/portal/)</li></ul> <br/>Oracle Linux users must have an active Oracle license. Microsoft may be able to give some guidance, but may defer support issues to Oracle. |
|SUSE Linux Enterprise Server (SLES)<br/><br/>[Azure Endorsed Distribution](/azure/virtual-machines/linux/endorsed-distros)|[SUSE on Azure](https://azure.microsoft.com/solutions/linux-on-azure/suse/)<p>SUSE has three offerings in Azure:</p> <ul><li><p>**Bring Your Own Subscription (BYOS)**</p> <p>Customers must register with SUSE to use these images. Microsoft may provide guidance for Linux issues, but may defer customer issues to SUSE directly.</p></li><li><p>**SUSE Images with Patching Support**</p> <p>These images include updates for your VM from SUSE. Microsoft may assist for Linux issues, but these images don't include extra support from SUSE. SUSE-related inquiries may require the customer to engage SUSE directly and require an active SUSE support agreement.</p></li><li><p>**24x7 Support Images**</p> <p>These images include updates and support through web, email, chat, and telephone from Microsoft. SUSE supports these images all day, every day, as defined in their support policies for public cloud images in the [SUSE Public Cloud Guide](https://documentation.suse.com/sle-public-cloud/all/html/public-cloud/cha-intro.html). These images are considered [SUSE Level 3 subscriptions](https://www.suse.com/support/handbook/#level-3-subscriptions). VMs that are created from these images incur per-hour support fees in addition to Azure platform fees.</p></li> <p>Conversion between PAYG Offerings to BYOS can be done through the Azure Hybrid Benefit.For more information, see [Preview: Azure Hybrid Benefit – how it applies for Linux Virtual Machines](/azure/virtual-machines/linux/azure-hybrid-benefit-linux).</p></ul> |

## Linux support scope

Microsoft Support provides assistance with Azure platform or services. Microsoft also provides commercially viable support for Linux. A support plan is required to engage Microsoft Support.

- In the Azure marketplace you will find Linux distributions such as Rocky, AlmaLinux, Kali, and many others available. Microsoft assists with these distributions but may require customers to engage the vendor to allow collaboration between the organizations. Fixes that are distribution specific must be provided by the vendor.
- The Linux vendor may have to be engaged by the customer to troubleshoot specific system-related problems. Microsoft may collaborate with the vendor for those issues.
- Microsoft Support doesn't assist in basic Linux administration, design, architecture, or deployment of applications or solutions on Azure.
- The ability to customize Linux is one of the hallmarks of the operating system. We encourage you to use a Linux solution that benefits your organization. However, some modifications may not be supported by the Linux vendor, such as custom kernel or modules. For vendor support, you may be required to use stock kernels or libraries for your image.
- For some troubleshooting and performance tuning within Linux or applications, customers should directly contact the vendor of the supported Linux distribution or application.
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

- Issues that occur during installation or configuration.
- Deployment errors that occur when customers try to deploy applications to the Azure platform and services.
- Runtime errors that occur when customers use the Azure platform and services.
- Performance issues that affect applications that were built by using the supported open-source technologies on the Azure platform and services.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
