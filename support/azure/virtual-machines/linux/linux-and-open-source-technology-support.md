---
title: Linux and open-source technology support
description: Describes support for Linux distributions and open-source technology support in Microsoft Azure.
ms.service: virtual-machines
ms.custom: sap:VM Admin - Linux (Guest OS)
ms.topic: article
ms.date: 04/18/2024
ms.reviewer: clausw, divargas, rondom, azurevmlnxcic, v-weizhu
---
# Linux and open-source technology support in Azure

Microsoft Azure supports the [Linux operating system](https://azure.microsoft.com/solutions/linux-on-azure). All Linux distributions are welcome in Azure. To upload your Linux distribution to Azure, see the [requirements](/azure/virtual-machines/linux/imaging). Marketplace images of the most popular Linux distributions are also available. Support for these images is available but requires a support contract. See the Linux support below for more details.

## Linux support matrix

|Linux distribution|Customer resources|
|---|---|
|Red Hat Enterprise Linux (RHEL)<br/><br/>Red Hat on Azure accelerates your innovation and digital transformation with Red Hat Linux solutions on Azure. <br/><br/>[Azure Endorsed Distribution](/azure/virtual-machines/linux/endorsed-distros)|Red Hat has two (2) offerings for RHEL in Azure:<br/><br/><ul><li>[On-Demand (PAYG)](https://access.redhat.com/public-cloud/microsoft-azure)</li><li>[Cloud Access (Gold Images)](https://www.redhat.com/en/technologies/cloud-computing/cloud-access)</li></ul><br/>Microsoft and Red Hat partner offer an integrated support experience. Support cost is integrated into the consumption cost of On-Demand images.<br/><br/>Cloud Access (BYOS) Support customers must have support agreements with both companies. The customer may be requested to engage Red Hat through their support agreement and bring Microsoft and Red Hat together on a service request.<br/><br/>Converting either On-Demand to Cloud Access or Cloud Access to On-Demand can be done through the Azure Hybrid Benefit.<br/><br/>For more information, see [Preview: Azure Hybrid Benefit – how it applies for Linux Virtual Machines](/azure/virtual-machines/linux/azure-hybrid-benefit-linux).|
|Community-driven free software effort focused around the goal of providing a rich base platform for open source communities to build upon. <br/><br/>[Azure Endorsed Distribution](/azure/virtual-machines/linux/endorsed-distros)|[The CentOS Project](https://wiki.centos.org/About.html)<br/><br/>CentOS is reaching End-of-life (EOL) on June 30, 2024. For more information, see [CentOS End-Of-Life guidance - migration options](/azure/virtual-machines/workloads/centos/centos-end-of-life).|
|Canonical Ubuntu<br/><br/>Optimize your Ubuntu experience on Azure, delivered in partnership with Canonical.<br/><br/>[Azure Endorsed Distribution](/azure/virtual-machines/linux/endorsed-distros)|<ul><li>[Ubuntu on Azure](https://azure.microsoft.com/solutions/linux-on-azure/ubuntu/#overview)</li><li>[Ubuntu Wiki: Releases](https://wiki.ubuntu.com/Releases)</li><li>[The Ubuntu lifecycle and release cadence](http://www.ubuntu.com/info/release-end-of-life)</li><li>[Canonical Ubuntu 18.04 LTS is reaching end of standard support on 31 May 2023](#canonical-ubuntu-1804-lts-is-reaching-end-of-standard-support-on-31-may-2023)</li></ul>|
|Community favorite Container Linux<br/><br/>[Azure Endorsed Distribution](/azure/virtual-machines/linux/endorsed-distros)|<ul><li>[Flatcar Linux](https://kinvolk.io/)</li><li>[Migrating from CoreOS to Flatcar Container Linux](https://kinvolk.io/blog/2020/04/running-flatcar-container-linux-in-microsoft-azure/)</li></ul>|
|:::image type="content" source="media/linux-and-open-source-technology-support/debian-credativ.png" alt-text="An icon for Debian." border="false"::: <br/><br/>Debian by Credativ<br/><br/>Debian is a free operating system that comes with over 43,000 packages and runs in many architectures and even different kernels.<br/><br/>[Azure Endorsed Distribution](/azure/virtual-machines/linux/endorsed-distros)|<ul><li>[Debian GNU/Linux as an endorsed distribution in Azure Marketplace](https://azure.microsoft.com/blog/debian-images-now-available-on-azure/)</li><li>[Credativ Support Contacts](https://www.credativ.de/en/portfolio/support/)</li></ul>|
|Oracle Linux<br/><br/>Oracle uniquely delivers Linux with everything required to deploy, optimize, and manage applications on-premises, in the cloud, and at the edge.<br/><br/>[Azure Endorsed Distribution](/azure/virtual-machines/linux/endorsed-distros)|<ul><li>[Oracle Linux in Azure](https://www.oracle.com/linux/)</li><li>[Lifetime Support Policy: Coverage for Oracle Linux and Oracle VM](https://www.oracle.com/a/ocom/docs/elsp-lifetime-069338.pdf)</li><li>[Oracle Support Contacts](https://support.oracle.com/portal/)</li></ul> <br/>Oracle Linux users must have an active Oracle license. Microsoft may be able to give some guidance, but may defer support issues to Oracle. |
|SUSE<br/><br/>Take advantage of high-performance solutions that come with running SUSE Linux on Azure.<br/><br/>[Azure Endorsed Distribution](/azure/virtual-machines/linux/endorsed-distros)|[SUSE on Azure](https://azure.microsoft.com/solutions/linux-on-azure/suse/)<p>SUSE has three offerings in Azure:</p> <ul><li><p>**Bring Your Own Subscription (BYOS)**</p> <p>Customers must register with SUSE to use these images. Microsoft may provide guidance for Linux issues, but may defer customer issues to SUSE directly.</p></li><li><p>**SUSE Images with Patching Support**</p> <p>These images include updates for your VM from SUSE. Microsoft may assist for Linux issues, but these images don't include extra support from SUSE. SUSE-related inquiries may require the customer to engage SUSE directly and require an active SUSE support agreement.</p></li><li><p>**24x7 Support Images**</p> <p>These images include updates and support through web, email, chat, and telephone from Microsoft. SUSE supports these images all day, every day, as defined in their support policies for public cloud images in the [SUSE Public Cloud Guide](https://documentation.suse.com/sle-public-cloud/all/html/public-cloud/cha-intro.html). These images are considered [SUSE Level 3 subscriptions](https://www.suse.com/support/handbook/#level-3-subscriptions). VMs that are created from these images incur per-hour support fees in addition to Azure platform fees.</p></li> <p>Conversion between PAYG Offerings to BYOS can be done through the Azure Hybrid Benefit.For more information, see [Preview: Azure Hybrid Benefit – how it applies for Linux Virtual Machines](/azure/virtual-machines/linux/azure-hybrid-benefit-linux).</p></ul> |

### Canonical Ubuntu 18.04 LTS is reaching end of standard support on 31 May 2023

You can continue to use your existing VMs. However, security, feature, and maintenance updates will no longer be provided by Canonical and may leave your systems vulnerable. We recommend that you either migrate to the next Ubuntu LTS release or upgrade to Ubuntu Pro to gain access to extended security and maintenance from Canonical.

- Upgrading to Ubuntu 20.04 LTS or Ubuntu 22.04

  Transitioning to the latest operating system, such as [Ubuntu 20.04 LTS](https://azuremarketplace.microsoft.com/marketplace/apps/canonical.0001-com-ubuntu-server-focal?tab=Overview) or [Ubuntu Pro 22.04](https://azuremarketplace.microsoft.com/marketplace/apps/canonical.0001-com-ubuntu-pro-jammy?tab=Overview) LTS, is important for performance, hardware enablement, and new technology benefits, and we recommend it for new instances. The transition may be a complex process for existing deployments. Therefore, it should be properly scoped and tested with your workloads. Although there's no direct upgrade path from Ubuntu 18.04 LTS to Ubuntu 22.04 LTS, you can directly upgrade to Ubuntu 20.04 LTS, and then to Ubuntu 22.04 LTS, or directly install Ubuntu 22.04 LTS. For more information, see the [Ubuntu Server upgrade guide](https://ubuntu.com/server/docs/upgrade-introduction).

  > [!NOTE]
  > An in-place upgrade to a new major version (for exmaple, upgrading from Ubuntu 18.04 to 20.04) will cause a disconnection between the data plane and the [control plane](/azure/architecture/guide/multitenant/considerations/control-planes) of the virtual machine (VM). Azure capabilities such as [Auto guest patching](/azure/virtual-machines/automatic-vm-guest-patching), [Auto OS image upgrades](/azure/virtual-machine-scale-sets/virtual-machine-scale-sets-automatic-upgrade), [Hotpatching](/windows-server/get-started/hotpatch?toc=%2Fazure%2Fvirtual-machines%2Ftoc.json), and [Azure Update Manager](/azure/update-manager/overview) won't be available. To use these features, we recommended that you create a new VM by using your preferred operating system instead of performing an in-place upgrade.

- Ubuntu Pro – Extended Security Maintenance to 2028

  Ubuntu Pro includes security patching for all Ubuntu packages because of Extended Security Maintenance (ESM) for Infrastructure and Applications and optional full-time (24 hours a day, seven days a week) telephone and ticket support. Ubuntu Pro 18.04 LTS will remain fully supported until April 2028. Ubuntu Pro is available for free for personal and small-scale commercial users on up to five VMs and with transparent, per-machine pricing for enterprises. New VMs that run Ubuntu Pro can be deployed from the [Azure Marketplace](https://azuremarketplace.microsoft.com/marketplace/apps/canonical.0001-com-ubuntu-pro-bionic?tab=Overview). You can also upgrade existing VMs to [Ubuntu Pro](https://ubuntu.com/pro) by purchasing from Canonical. For more information about Ubuntu 18.04 LTS End of Standard Support, see [Ubuntu 18.04 LTS (Bionic Beaver) on Azure](https://ubuntu.com/18-04/azure). 

## Linux support scope

Microsoft Support will assist you in using Azure platform or services and may offer guidance for issues within Linux. A support plan is required to engage Microsoft Support.

- Microsoft will assist you with commercially viable support for Linux. The endorsed Linux distributions are created and published by Linux partners for use in Azure environments. We recommend that you use an [Endorsed Linux distribution](/azure/virtual-machines/linux/endorsed-distros) because these are maintained by some of the most well-known Linux vendors in the world.
- Take the opportunity to explore the marketplace to find systems from other vendors, such as Rocky, AlmaLinux, and Kali. Microsoft will support these distributions but may require customers to engage the vendor to allow collaboration between the organizations for support. Fixes that are distribution-specific must be provided by the vendor.
- The Linux vendor may have to be engaged by the customer to troubleshoot specific system-related problems. Microsoft may be able to collaborate with the vendor for those issues.
- Have your Linux administrator engaged when you work with Azure support. Microsoft Support doesn't assist in basic Linux administration, design, architecture, or deployment of applications or solutions on Azure.
- The ability to customize Linux is one of the hallmarks of the operating system. We encourage you to use a Linux solution that benefits your organization. However, some modifications may not be supported by the Linux vendor, such as custom kernel or modules. For vendor support, you may be required to use stock kernels or libraries for your image. 
- Microsoft may provide recommendations about Azure platform and services. For some troubleshooting and performance tuning within Linux or applications, the customer should directly contact the vendor of the supported Linux distribution or application.
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
