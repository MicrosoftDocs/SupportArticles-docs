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

 
