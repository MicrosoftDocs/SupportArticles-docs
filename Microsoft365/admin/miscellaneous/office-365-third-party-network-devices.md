---
title: Use third-party network devices or solutions with Office 365
description: Recommendations and support position to use advanced network solutions for active decryption, filtering, inspection functions, and other protocol-level or content-level action on Office 365 user traffic.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office 365
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
search.appverid: 
- MET150
appliesto:
- Office 365
---

# Using third-party network devices or solutions with Office 365

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Summary 

Microsoft Office 365 is Software-as-a-Service that provides productivity and collaboration opportunities through a distributed set of cloud-hosted applications and services.

The quality and performance of a user's Office 365 experience is directly influenced by the kind of network solutions that users have on the path between the user and Office 365. Third-party network devices and services that do advanced protocol-level and data-level processing and network optimization may interfere with Office 365 client connectivity and affect the availability, performance, interoperability, and supportability of Office 365 to users.

This article outlines Microsoft recommendations and support position for Office 365 users who plan to use advanced network solutions that run active decryption, filtering, inspection functions and other protocol-level or content-level action on Office 365 user traffic. Such solutions include the following: 
 
- WAN acceleration and optimization    
- Traffic redirection and inspection devices    
- Proxy solutions    
- Cloud Access Security Brokers (CASB)    
- Secure Web Gateways (SWG)    
- Data Leakage Prevention (DLP) systems    
- Other network and cloud services    
 
The provisions of this article are focused on Office 365 cloud applications and services, and these provisions do not apply to on-premises based versions of Microsoft products. Office 365 users may see different effects if these provisions are not followed, depending on the kind of Office 365 service. 

For more information, see [this Office 365 Blog article](https://aka.ms/ipurlblog).  

## More Information 

The following guidelines applies to network devices and solutions that act as intermediary, man-in-the-middle, or proxy services that handle Office 365 user traffic: 
- Microsoft does not require and does not recommend using third-party WAN optimization solutions, traffic redirection or inspection devices, or any other network solutions that decrypt, inspect, or take protocol-level or content-level action on Office 365 user traffic. Microsoft does not provide support for integrating such solutions with the Office 365 service.    
- Although Microsoft currently does not block users from using such solutions, these devices are not tested by Microsoft for compatibility, interoperability, or performance together with Office 365. Microsoft cannot comment on the current or future effectiveness of such network solutions for Office 365 scenarios or whether such network solutions will continue to be functional after future features and protocol changes to Office 365. Because of differences in Office 365 protocols, features, and architectures, the functionality of such network solutions in on-premises Microsoft products should not be used as a baseline.    
- The mentioned network technologies on Office 365 application protocol stacks may introduce additional interoperability, availability, and performance issues in the Office 365 service, and may hinder a user's ability to optimize Office 365 connectivity and the user experience per Microsoft recommendations.    
- Third-party solutions that can intercept and decrypt network requests may have features to change, scrub, or block decrypted content. Applying those features to Office 365 user traffic causes changes to Office 365 protocols and data streams (outside standard and documented APIs). Therefore, this behavior is not supported by Microsoft and may violate the terms of service.    
- Users should be aware that, except for cases of documented public Office 365 APIs, Microsoft reserves the right to change any details of the application protocol, authentication methods, topologies, and data structures without informing third parties about the change. Microsoft cannot take responsibility for any issues that may be caused by such third-party solution because of such changes.    
- Microsoft will not delay innovation, features, and service changes to the Office 365 cloud to allow third-party network solutions performing decryption and application protocol specific action on Office 365 traffic, to make design and configuration changes to their solution and address issues that are specific to the use of third-party stacks. Any third-party solutions that take a hard dependency on specific Office 365 application protocol stacks may experience outages or decreased performance.    
- Microsoft requires users to disclose when they use the mentioned solutions to create support requests in Office 365. For Microsoft to provide support for issues regarding Office 365, users will be required to disable decryption of affected Office 365 traffic by those solutions and to bypass or turn off such solution for Office 365 traffic for troubleshooting until the issue is fully resolved and the user's Office 365 experience is no longer affected.    
- Microsoft provides support for the Office 365 service and components that are under its direct management and operational control. Third-party network devices and network services are considered a part of the user's network landscape. Users should engage with their network vendor or solution provider for all support needs that are associated with their products.    
- These policies apply to mentioned third-party network solutions that are operated in a user's on-premises environment, provided by third-parties as cloud services, or built by users or network providers in IaaS datacenters. This includes solutions that are built in Microsoft Azure.    
 
Many of the features and outcomes for which users use third-party advanced network and security solutions that do decryption, inspection, and modification of network traffic are natively available through Office 365 and the Microsoft cloud architecture, service commitments, customer-facing features, and documented integration APIs. We strongly recommend that users evaluate native features that are provided by Microsoft, and remove or bypass duplicate network processing layers for Office 365 traffic. 

In addition to these policies, the following are general recommendations to optimize connectivity to Office 365: 
 
- For the best Office 365 user experience and optimal performance, we strongly recommend that users provide direct and non-restrictive distributed connectivity for Office 365 traffic from the user or client location to the nearest points of presence or peering locations of the Microsoft global network. Minimizing the network distance (route-trip time (RTT) latency) from the user to the nearest peering point of Microsoft network lets users take advantage of the Office 365 highly distributed service front-door infrastructure and makes sure that Office 365 user connections are served as quickly and as closely to the user as possible (frequently in the user's own metro location). Building user network solutions in relation to the location of the Office 365 user tenant instead of the location of the user might reduce the benefits of Office 365 distributed front-door optimizations and cause suboptimal or poor performance.    
- Usually, the best way to optimize the user experience and prevent the network from becoming a performance bottleneck is by using the following methods:

- Use local Internet egress (which might be scoped to Office 365 traffic)    
   - Use an Internet service provider (ISP) that has direct peering with Microsoft global network close to the user location    
   - Bypass network traffic inspection and decryption devices for trusted Office 365 destinations    
     
- To help users plan and implement their connectivity to Office 365, Microsoft has established [Getting the best connectivity and performance in Office 365 ](https://aka.ms/Office365Networking). The [Office 365 endpoint categorization guidance](https://aka.ms/ipUrlBlog) can help users prioritize which Office 365 application flows and URLs will benefit the most from these recommendations.    
