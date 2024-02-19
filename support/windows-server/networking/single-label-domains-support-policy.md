---
title: Microsoft support for Single Label Domains
description: Provides information about Microsoft's support policy about Single Label Domains (SLD).
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dns, csstroubleshoot
---
# Microsoft support for Single Label Domains

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2269810

## Summary

This article contains information about Microsoft's support policy about Single Label Domains (SLDs). SLDs are DNS names that don't contain a suffix, such as .com, .corp, .net, or .org. For example, contoso would be an SLD. However, `contoso.com`, `contoso.net`, or contoso.local would not be an SLD.

## More information

Although an SLD isn't a common configuration worldwide, some Microsoft products can be installed in an SLD configuration and in other uncommon namespace configurations. However, certain considerations may apply, as noted by individual product groups. Existing products may continue to function with SLDs, but SLDs aren't a recommended configuration for future deployments and may not work with some products or versions. Other Microsoft or third-party applications that end users may want to run in your environment may not be compatible on an SLD. We recommend that customers deploy their infrastructure by using common, tested configurations to minimize extra deployment and testing costs.

The [Microsoft Common Engineering Criteria](https://cloudblogs.microsoft.com/windowsserver/2010/04/05/common-engineering-criteria-website-re-launches/#:~:text=The%20Microsoft%20Common%20Engineering%20Criteria,and%20other%20critical%20infrastructure%20attributes) program establishes a set of engineering requirements across all [Microsoft server products](https://www.microsoft.com/servers/home.mspx). The Microsoft Common Engineering Criteria program continues to evaluate the development guidelines for various naming configurations, including guidelines on namespace topology, in our Microsoft server products.

Microsoft remains committed to evaluating any technical issues that customers experience with SLD. Microsoft encourages customers to examine their SLD configuration and issues to determine whether migration to a fully qualified domain name (FQDN) is necessary.

Microsoft will continue to provide commercially reasonable support to customers who have existing SLD configurations, subject to the terms of the [Microsoft Support Lifecycle policy](/lifecycle/) and their Microsoft support agreement. This clarification of the support policy means that Microsoft Premier Support customers who have SLD configurations can contact Microsoft Customer Service and Support (CSS) per their Premier Support agreement to report problems or issues. Their support requests will be carefully evaluated by CSS or by the respective product groups.
