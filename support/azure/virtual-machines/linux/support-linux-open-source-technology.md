---
title: Linux and open-source technology support
description: Describes support for Linux distributions and open-source technology in Microsoft Azure.
ms.service: azure-virtual-machines
ms.custom: sap:VM Admin - Linux (Guest OS), linux-related-content
ms.date: 04/25/2025
ms.reviewer: patcatun, clausw, divargas, rondom, azurevmlnxcic, v-weizhu
---

# Linux and open-source technology support in Azure

**Applies to:** :heavy_check_mark: Linux VMs

## Summary

This article describes the support available for Linux distributions and open-source technology in Microsoft Azure. It covers the [endorsed Linux distributions](/azure/virtual-machines/linux/endorsed-distros), support options, and resources available to you when you run Linux on Azure. 

Microsoft Azure supports the [Linux operating system](https://azure.microsoft.com/solutions/linux-on-azure), and all Linux distributions are welcome. To upload your own Linux distribution, review the [requirements](/azure/virtual-machines/linux/imaging). Azure Marketplace also offers images of the most popular Linux distributions; support for these images requires a support contract. For details, see the following sections. 

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

Microsoft Support helps with the Azure platform and its services, and also offers commercially viable support for Linux. To get help from Microsoft Support, you need a support plan.

- Azure Marketplace offers a range of Linux distributions. Microsoft supports Linux customers, but you might need to work with the specific Linux vendor for further help, because the vendor might need to deliver distribution-specific fixes.
  - **Red Hat and SUSE PAYG images:** Start with Microsoft Support, which manages the first levels of Linux support and engages the vendor if needed.
  - **Red Hat and SUSE BYOS images**: You can contact the vendor directly for support. The vendor is primarily responsible for Linux support, but Microsoft can provide additional help if needed. 
- Azure Marketplace also offers highly customized Linux images, such as firewall appliances. While Microsoft supports the Azure platform hosting these images, the image vendor is responsible for guest OS and image-specific support. Microsoft may collaborate with the vendor to help resolve issues when needed.
- Microsoft Support doesn't provide help with basic Linux administration, design, architecture, or the deployment of applications or solutions on Azure.
- Customizing Linux is one of the operating system's key strengths, and we encourage you to use the Linux solution that best fits your organization. However, Linux vendors might not support some modifications, such as custom kernels or modules. To receive vendor support, you might need to use stock kernels or libraries in your image
- For some troubleshooting and performance tuning in Linux or your applications, contact the vendor of the supported Linux distribution or application directly.

Microsoft Support doesn't cover security-related scenarios. These include, but aren't limited to: 
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

Microsoft may offer support for the following open-source technologies (subject to change): PHP, Java, Python, and Node.js (languages); MySQL (database); Apache HTTP Server and Apache Tomcat (web and application servers); and WordPress (frameworks). 

Microsoft provides help with supported open-source technologies. If you request design guidance or development assistance, you might be directed to forums or community support. For scenarios that Microsoft doesn't support, you might need to work directly with our Linux partners or software vendors. Examples include, but aren't limited to:
- Application development
- Custom application troubleshooting 
- Custom code

By contrast, Microsoft can help with support scenarios such as the following: 
- Issues that occur during installation or configuration
- Deployment errors that occur when you deploy applications to the Azure platform and services
- Runtime errors that occur when you use the Azure platform and services
- Performance issues that affect your applications built with supported open-source technologies on the Azure platform and services

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]

 
