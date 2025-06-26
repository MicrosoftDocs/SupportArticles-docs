---
title: SFB Online users in a Microsoft 365 domain can't IM or detect users
description: Fixes a problem in which Skype for Business Online users in a domain that's not added to the on-premises Skype for Business Server or Lync Server 2013 hybrid deployment can't see the presence of on-premises users or send them an IM.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.reviewer: dahans
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Skype for Business Online
  - Skype for Business 2015
  - Skype for Business Server 2015
  - Skype for Business 2016
  - Lync 2013
  - Lync Server 2013
ms.date: 03/31/2022
---

# Skype for Business Online users in a Microsoft 365 domain can't IM or detect users in an on-premises domain

## Problem

Consider the following scenario:

- You have a hybrid deployment of on-premises Skype for Business Server or Lync Server 2013.   
- The contoso.com domain is confirmed in the on-premises topology and verified by the Microsoft 365 organization.   
- The my.contoso.com domain is verified by the Microsoft 365 organization.   
- Federation DNS records for contoso.com point to the on-premises edge server. 
- Federation DNS records for my.contoso.com point to Microsoft 365.   

In this scenario, users in the my.contoso.com domain can't see the presence status of users in the contoso.com domain and can't send an instant message (IM) to those users. However, they can receive an IM from a contoso.com domain user. Users in the contoso.com domain can see the presence status of users in the my.contoso.com domain and can also send IMs to those users.

You may also see the following detail recorded in the client logs: 

```adoc
ms-diagnostics: 1017; reason="Cannot route From and To domains in this combination"; summary="Domain type analysis indicates that the ms-split-domain-info header in the message is the wrong type"
```

## Solution

To resolve this problem, add the Microsoft 365 domain to the on-premises topology. For more information about how to configure the domains for hybrid deployment, go to the following Microsoft resource:

[Plan hybrid connectivity between Skype for Business Server and Microsoft 365](/skypeforbusiness/hybrid/plan-hybrid-connectivity?bc=%2fSkypeForBusiness%2fbreadcrumb%2ftoc.json&toc=%2fSkypeForBusiness%2ftoc.json)

## More Information

The hybrid configuration is correct for the contoso.com domain. However, the configuration isn't correct for the my.contoso.com domain.

To configure your on-premises deployment for a hybrid deployment, federation DNS records must be pointed to the on-premises edge server for all domains that are verified by the Microsoft 365 organization. Domain matching must be configured in the same manner for both the on-premises deployment and the Microsoft 365 organization.

> [!NOTE]
> The shared Session Initiation Protocol (SIP) address space configuration option is configured for all domains in the organization. It can't be configured for only a specific domain.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
