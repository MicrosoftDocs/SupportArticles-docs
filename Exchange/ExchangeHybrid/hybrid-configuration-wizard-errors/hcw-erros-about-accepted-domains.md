---
title: HCW errors about accepted domain
description: Fixes an issue in which you receive an HCW8004, HCW8009, HCW8016, HCW8017, HCW8029, or HCW8030 error message when you run the Hybrid Configuration wizard.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: timothyh, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# HCW8004, HCW8009, HCW8016, HCW8017, HCW8029, or HCW8030 error when running the HCW

_Original KB number:_ &nbsp; 3087155

## Problem

When you run the Hybrid Configuration wizard (HCW), you receive one of the following error messages:

> HCW8004 No accepted domains were found on-premises.

> HCW8009 Coexistence domain contoso.com is not an Accepted Domain in your \<NameOfTenant> tenant.

> HCW8016 Hybrid domain Contoso.com isn't an accepted domain in the on-premises organization.

> HCW8017 Hybrid domain Contoso.com isn't an accepted domain in the Microsoft 365 tenant.

> HCW8029 No hybrid domains specified.

> HCW8030 No Accepted Domains found on tenant.

## Cause

This problem may occur if an accepted domain (other than onmicrosoft.com) wasn't added to your on-premises environment or to Exchange Online.

## Solution

To resolve this problem, follow these steps:

1. Make sure that the domain or domains are added to your on-premises organization as accepted domains. For more information, see [Accepted domains](/exchange/accepted-domains-exchange-2013-help).
2. Make sure that the domain or domains are added to Exchange Online as accepted domains. For more information, see [Verify a domain at any domain name registrar](/previous-versions/azure/jj151803(v=azure.100)).
3. Run the Hybrid Configuration wizard again. When you're prompted to add a domain, select the domains that you added. For more information, see [Create a hybrid deployment with the Hybrid Configuration Wizard](/exchange/hybrid-deployment/deploy-hybrid).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
