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

|Azure endorsed Linux distribution| Customer resources|
|:------------------- |:------------------- |
|Red Hat Enterprise Linux (RHEL)|<ul><li>Red Hat has two offerings for RHEL in Azure: [On-Demand (Pay-As-You-Go (PAYG)](/azure/virtual-machines/linux/azure-hybrid-benefit-linux#defining-pay-as-you-go-payg-and-bring-your-own-subscription-byos) and [Cloud Access (Gold Images)](https://www.redhat.com/en/technologies/cloud-computing/cloud-access).</li><li>Microsoft and Red Hat partner to offer an integrated support experience. Support cost is integrated into the consumption cost of on-demand images.</li><li>Cloud Access (Bring-Your-Own-Subscription (BYOS)) support customers must have support agreements with both companies. Customers may be requested to engage with Red Hat through Red Hat's support agreement and bring Microsoft and Red Hat together on a service request.</li><li>Converting either On-Demand to Cloud Access or Cloud Access to On-Demand can be done through Azure Hybrid Benefit. For more information, see [Azure Hybrid Benefit for Red Hat Enterprise Linux (RHEL) and SUSE Linux Enterprise Server (SLES) virtual machines](/azure/virtual-machines/linux/azure-hybrid-benefit-linux).</li></ul>|
|CentOS by Perforce|<ul><li>[The CentOS Project](https://wiki.centos.org/About.html)</li><li>CentOS will reach end-of-life (EOL) on June 30, 2024. For more information, see [Migration options](/azure/virtual-machines/workloads/centos/centos-end-of-life#migration-options) in the "CentOS End-Of-Life guidance." </li></ul>|
|Ubuntu by Canonical|<ul><li>[Ubuntu on Azure](https://azure.microsoft.com/solutions/linux-on-azure/ubuntu/#overview)</li><li>[Ubuntu Wiki: Releases](https://wiki.ubuntu.com/Releases)</li><li>[The Ubuntu lifecycle and release cadence](http://www.ubuntu.com/info/release-end-of-life)</li><li>[Canonical Ubuntu 18.04 LTS has been out of standard support since May 31, 2023](upgrade-canonical-ubuntu-18dot04-lts.md)</li><li>[See endorsed major releases](/azure/virtual-machines/linux/endorsed-distros)</li></ul>|
|Kinvolk Flatcar|<ul><li>[Flatcar Linux](https://kinvolk.io/)</li><li>[Migrating from CoreOS to Flatcar Container Linux](https://kinvolk.io/blog/2020/04/running-flatcar-container-linux-in-microsoft-azure/)</li></ul>|
|Debian by Credativ|<ul><li>[Debian GNU/Linux as an endorsed distribution in Azure Marketplace](https://azure.microsoft.com/blog/debian-images-now-available-on-azure/)</li><li>[Credativ Support Contacts](https://www.credativ.de/en/portfolio/support/)</li></ul>|
|Oracle Linux|<ul><li>[Oracle Linux in Azure](https://www.oracle.com/linux/)</li><li>[Lifetime Support Policy: Coverage for Oracle Linux and Oracle virtual machine (VM)](https://www.oracle.com/a/ocom/docs/elsp-lifetime-069338.pdf)</li><li>[Oracle Support Contacts](https://support.oracle.com/portal/)</li><li>Oracle Linux users must have an active Oracle license. Microsoft may be able to provide some guidance, but may defer support issues to Oracle.</li></ul>|
|SUSE Linux Enterprise Server (SLES)|<ul><li>[SUSE on Azure](https://azure.microsoft.com/solutions/linux-on-azure/suse/)</li><li>SUSE has three offerings in Azure:<br/></p> <ul><li><p>**Bring Your Own Subscription (BYOS)**</p> <p>Customers must register with SUSE to use these images. Microsoft may provide guidance for Linux issues, but may defer customer issues to SUSE directly.<br/><br/></p></li><li><p>**SUSE Images with Patching Support**</p> <p>These images include updates for your VM from SUSE. Microsoft may assist with Linux issues, but these images don't include extra support from SUSE. SUSE-related inquiries may require customers to engage with SUSE directly and require an active SUSE support agreement.<br/><br/></p></li><li><p>**24x7 Support Images**</p> <p>These images include updates and support from Microsoft through the web, email, chat, and telephone. SUSE supports these images daily, as defined in their support policies for public cloud images in the [SUSE Public Cloud Guide](https://documentation.suse.com/sle-public-cloud/all/html/public-cloud/cha-intro.html). These images are considered [SUSE Level 3 subscriptions](https://www.suse.com/support/handbook/#level-3-subscriptions). VMs that are created from these images incur per-hour support fees and Azure platform fees.</p></li> <p>Conversion between PAYG offerings to BYOS can be done through Azure Hybrid Benefit. For more information, see [Azure Hybrid Benefit for Red Hat Enterprise Linux (RHEL) and SUSE Linux Enterprise Server (SLES) virtual machines](/azure/virtual-machines/linux/azure-hybrid-benefit-linux).</p></ul></li></ul> |

> [!NOTE] 
> For more information about endorsed distributions and major releases, see [Endorsed Linux distributions on Azure](/azure/virtual-machines/linux/endorsed-distros).

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
