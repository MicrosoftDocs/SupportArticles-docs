---
title: Linux and open-source technology support
description: Describes support for Linux distributions and open-source technology in Microsoft Azure.
ms.service: azure-virtual-machines
ms.custom: sap:VM Admin - Linux (Guest OS), linux-related-content
ms.topic: article
ms.date: 04/25/2025
ms.reviewer: patcatun, clausw, divargas, rondom, azurevmlnxcic, v-weizhu
---

# Linux and open-source technology support in Azure

**Applies to:** :heavy_check_mark: Linux VMs

Microsoft Azure supports the [Linux operating system](https://azure.microsoft.com/solutions/linux-on-azure). All Linux distributions are welcome in Azure. To upload your Linux distribution to Azure, see the [requirements](/azure/virtual-machines/linux/imaging). Marketplace images of the most popular Linux distributions are also available. Support for these images is available but requires a support contract. See the following sections for more details.

## Linux support matrix

> [!NOTE] 
> For more information about endorsed distributions and major releases, see [Endorsed Linux distributions on Azure](/azure/virtual-machines/linux/endorsed-distros).

|Azure-endorsed Linux distribution| Customer resources|
|:------------------- |:------------------- |
|AlmaLinux|<ul><li><a href="https://azuremarketplace.microsoft.com/marketplace/apps/almalinux.almalinux-x86_64?tab=Overview">AlmaLinux OS (x86_64/AMD64)</a></li><li><a href="https://azuremarketplace.microsoft.com/marketplace/apps/almalinux.almalinux-arm?tab=Overview">AlmaLinux OS (AArch64/ARM64)</a></li><li><a href="https://azuremarketplace.microsoft.com/marketplace/apps/almalinux.almalinux-hpc?tab=Overview">AlmaLinux OS (x86_64/AMD64) HPC</a></ul>|
|Debian by Credativ|<ul><li>[Debian GNU/Linux as an endorsed distribution in Azure Marketplace](https://azure.microsoft.com/blog/debian-images-now-available-on-azure/)</li><li>[Credativ Support Contacts](https://www.credativ.de/en/portfolio/support/)</li></ul>|
|Kinvolk Flatcar|<ul><li>[Flatcar Linux](https://kinvolk.io/)</li><li>[Migrating from CoreOS to Flatcar Container Linux](https://kinvolk.io/blog/2020/04/running-flatcar-container-linux-in-microsoft-azure/)</li></ul>|
|Ubuntu by Canonical|<ul><li>[Ubuntu on Azure](https://azure.microsoft.com/solutions/linux-on-azure/ubuntu/#overview)</li><li>[Ubuntu Wiki: Releases](https://wiki.ubuntu.com/Releases)</li><li>[Canonical Ubuntu 18.04 LTS has been out of standard support since May 31, 2023](/azure/virtual-machines/workloads/canonical/ubuntu-els-guidance)</li></ul>|
|Oracle Linux|<ul><li>[Oracle Linux in Azure](https://www.oracle.com/linux/)</li><li>[Lifetime Support Policy: Coverage for Oracle Linux and Oracle virtual machine (VM)](https://www.oracle.com/a/ocom/docs/elsp-lifetime-069338.pdf)</li><li>[Oracle Support Contacts](https://support.oracle.com/portal/)</li><li>Oracle Linux users must have an active Oracle license. Microsoft may be able to provide some guidance, but may defer support issues to Oracle.</li></ul>|
|Red Hat Enterprise Linux (RHEL)|<ul><li>Red Hat has two offerings for RHEL in Azure: [On-Demand (pay-as-you-go)](/azure/virtual-machines/linux/azure-hybrid-benefit-linux#defining-pay-as-you-go-payg-and-bring-your-own-subscription-byos) and [Cloud Access (Gold Images)](https://www.redhat.com/en/technologies/cloud-computing/cloud-access).</li><li>Microsoft and Red Hat partner to offer an integrated support experience. Support cost is integrated into the consumption cost of on-demand images.</li><li>Cloud Access (Bring-Your-Own-Subscription (BYOS)) support customers must have support agreements with both companies. Customers may be requested to engage with Red Hat through the Red Hat support agreement and bring Microsoft and Red Hat together on a service request.</li><li>Converting either On-Demand to Cloud Access or Cloud Access to On-Demand can be done through Azure Hybrid Benefit. For more information, see [Azure Hybrid Benefit for Red Hat Enterprise Linux (RHEL) and SUSE Linux Enterprise Server (SLES) virtual machines](/azure/virtual-machines/linux/azure-hybrid-benefit-linux).</li></ul>|
|Rocky Linux from CIQ|<ul><li>[Rocky Linux from CIQ](https://azuremarketplace.microsoft.com/marketplace/apps?search=ciq&page=1)</li></ul>|
|SUSE Linux Enterprise Server (SLES)|<ul><li>[SUSE on Azure](https://azure.microsoft.com/solutions/linux-on-azure/suse/)</li><li>SUSE has three offerings in Azure:<br/></p> <ul><li><p>**Bring Your Own Subscription (BYOS)**</p> <p>Customers must register with SUSE to use these images. Microsoft may provide guidance for Linux issues, but may also defer customer issues to SUSE directly.<br/></p></li><li><p>**SUSE Images with Patching Support**</p> <p>These images include updates for your VM from SUSE. Microsoft may assist customers for Linux issues, but these images don't include extra support from SUSE. SUSE-related inquiries may require customers to engage with SUSE directly and require an active SUSE support agreement.<br/></p></li><li><p>**24x7 Support Images**</p> <p>These images include updates and support from Microsoft through the web, email, chat, and telephone. SUSE supports these images daily, as defined in their support policies for public cloud images in the [SUSE Public Cloud Guide](https://documentation.suse.com/sle-public-cloud/all/html/public-cloud/cha-intro.html). These images are considered [SUSE Level 3 subscriptions](https://www.suse.com/support/handbook/#level-3-subscriptions). VMs that are created from these images incur per-hour support fees and Azure platform fees.</p></li> <p>Conversion between PAYG offerings to BYOS can be done through Azure Hybrid Benefit. For more information, see [Azure Hybrid Benefit for Red Hat Enterprise Linux (RHEL) and SUSE Linux Enterprise Server (SLES) virtual machines](/azure/virtual-machines/linux/azure-hybrid-benefit-linux).</p></ul></li></ul> |

## Linux support scope

Microsoft Support provides assistance for the Azure platform or services. Microsoft also provides commercially viable support for Linux. A support plan is required to receive Microsoft Support.

- Azure Marketplace offers various Linux distributions. Microsoft provides support for Linux customers, but they might need to work with specific Linux vendors for further assistance. These vendors might be required to deliver distribution-specific fixes.
  - **Red Hat and SUSE PAYG images:** Microsoft Support manages the first levels of Linux support and will engage the vendor if required.
  - **Red Hat and SUSE BYOS images**: Customers might contact the vendor directly for support. The vendor is primarily responsible for Linux support; however, Microsoft can provide additional assistance if required.
- In Azure Marketplace, you may select a highly customized Linux image, such as a firewall appliance. Microsoft provides assistance for these images, but the Linux vendor must be engaged to troubleshoot specific system-related problems. Microsoft may collaborate with the vendor for those issues.
- Microsoft Support doesn't assist customers for basic Linux administration, design, architecture, or deployment of applications or solutions on Azure.
- The ability to customize Linux is one of the hallmarks of the operating system. We encourage you to use a Linux solution that benefits your organization. However, the Linux vendor may not support some modifications, such as custom kernels or modules. For vendor support, you may be required to use stock kernels or libraries for your image.
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

Microsoft assists customers for supported open-source technologies. Customers who request support for design guidance or development assistance may be directed to forums or community support. Customers may also have to work directly with our Linux partners or software vendors for scenarios that Microsoft doesn't support. Examples include but aren't limited to:

- Application development
- Custom application troubleshooting 
- Custom code

The following situations are some of the support scenarios that Microsoft provides assistance for:

- Issues that occur during installation or configuration
- Deployment errors that occur when customers try to deploy applications to the Azure platform and services
- Runtime errors that occur when customers use the Azure platform and services
- Performance issues that affect applications that are built using the supported open-source technologies on the Azure platform and services

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
