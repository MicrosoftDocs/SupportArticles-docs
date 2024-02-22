---
title: Free/busy lookups return hash marks
description: Fixes a problem that occurs when Exchange Online users and on-premises users in a hybrid deployment perform free/busy lookups between their organizations. Instead of availability info, only hash marks are returned.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: timothyh, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Free/busy lookups between Exchange Online and on-premises users don't work as expected

_Original KB number:_ &nbsp; 3012701

## Problem

Free/busy lookups between on-premises Exchange users and Exchange Online users in an Exchange hybrid deployment don't work correctly. Users see hash marks (\\\\\\\\) instead of availability information in their calendars. However, free/busy lookups between on-premises Exchange users still work as expected.

## Cause

This issue may occur if an accepted domain is missing from the on-premises Exchange organization, the Exchange Online organization or both in the hybrid deployment configuration.

## Solution

To resolve this issue, follow these steps:

1. Make sure that the domain or domains are added to your on-premises organization as accepted domains. For more information, see [Accepted domains](/exchange/accepted-domains-exchange-2013-help).
2. Make sure that the domain or domains are added to Exchange Online as accepted domains. For more information, see [Verify a domain at any domain name registrar](/previous-versions/azure/jj151803(v=azure.100)).
3. Rerun the Hybrid Configuration Wizard. When you're prompted to add your domain or domains, select the domains that you added. For more information, see [Create a hybrid deployment with the Hybrid Configuration Wizard](/exchange/hybrid-deployment/deploy-hybrid).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).
