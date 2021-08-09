---
title: Azure Stack guidance to protect against the speculative execution side-channel vulnerabilities
description: Provides Azure Stack guidance to protect against the speculative execution side-channel vulnerabilities.
ms.date: 08/14/2020
ms.prod-support-area-path: 
ms.service: azure-stack
ms.author: genli
author: genlin
ms.reviewer: 
---
# Azure Stack guidance to protect against the speculative execution side-channel vulnerabilities

This article provides Azure Stack FAQ and recommended actions to protect against the speculative execution side-channel vulnerabilities.

_Original product version:_ &nbsp; Azure Stack Hub  
_Original KB number:_ &nbsp; 4073418

## Summary

Microsoft is aware of a new publicly disclosed class of vulnerabilities referred to as "speculative execution side-channel attacks" that affect many modern processors and operating systems including Intel, AMD, and ARM.

Microsoft has not received any information to indicate that these vulnerabilities have been used to attack customers at this time. Microsoft continues working closely with industry partners, including chip makers, hardware OEMs, and app vendors, to protect customers. To get all available protections, hardware or firmware updates and software updates are required. This includes microcode from device OEMs and, in some cases, updates to antivirus software. 

This advisory addresses the following vulnerabilities: 

- CVE-2017-5715 (branch target injection) 
- CVE-2017-5753 (bounds check bypass) 
- CVE-2017-5754 (rogue data cache load) 

To learn more about this class of vulnerabilities, see [ADV180002](https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/ADV180002). 

## Overview

The following sections will help you identify, mitigate, and remedy Azure Stack environments that are affected by the vulnerabilities that are identified in [Microsoft Security Advisory ADV180002](https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/ADV180002). 
 To address these issues, Microsoft is working in partnership with the hardware industry to develop mitigations and guidance. 

## Recommended actions

Azure Stack customers should take the following actions to help protect the Azure Stack infrastructure against the vulnerabilities:

1. Apply Azure Stack 1712 update. See the [Azure Stack 1712 update release notes](https://docs.microsoft.com/azure/azure-stack/azure-stack-update-1712) for instructions about how to apply this update to your Azure Stack integrated system.  
2. Install firmware updates from your Azure Stack OEM vendor after the Azure Stack 1712 update installation is completed. Refer to your OEM vendor website to download and apply the updates.  
3. Some variations of these vulnerabilities apply also to the virtual machines (VMs) that are running in the tenant space. Customers should continue to apply security best practices for their VM images, and apply all available operating system updates to the VM images that are running on Azure Stack. Contact the vendor of your operating systems for updates and instructions, as necessary. For Windows VM customers, guidance has now been published and is available [in this Security Update Guide](https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/ADV180002). 

## Frequently asked questions

**Q1. How can I tell whether my Azure Stack is affected by this class of vulnerabilities?**  
**A1:** All Azure Stack integrated systems are affected by the class of vulnerabilities that are described in the [MSRC Security Advisory ADV180002](https://portal.msrc.microsoft.com/en-US/security-guidance/advisory/ADV180002).

**Q2. Where can I find the Azure Stack update to fix this class of vulnerabilities?**   
**A2:** See [Azure Stack 1712 update release notes](https://docs.microsoft.com/azure/azure-stack/azure-stack-update-1712) for instructions about how to download and apply this update to your Azure Stack integrated system. For more information about updates for Microsoft Azure Stack, see [Update package release cadence](https://docs.microsoft.com/azure-stack/operator/azure-stack-servicing-policy?view=azs-2005&preserve-view=true#update-package-release-cadence).

**Q3. Where can I find the firmware updates for my Azure Stack integrated system?**   
**A3:** Firmware updates are OEM-specific. Refer to your OEM vendor website to download and apply the updates.

**Q4. My Azure Stack integrated system is not running the latest update (1711). What should I do?**   
**A4:** Azure Stack updates are sequential. You would have to apply all previous updates before you can apply the Azure Stack 1712 update. For more information, see [Azure Stack 1711 Update](https://docs.microsoft.com/azure/azure-stack/azure-stack-update-1711).

**Q5. I'm running an Azure Stack Development Kit (ASDK). Is that affected by this class of vulnerabilities?**    
**A5:** Yes, it is. We recommend that you deploy the [latest version of the ASDK](https://azure.microsoft.com/overview/azure-stack/development-kit/). For firmware update, see your OEM vendor website to download and apply the updates.
