---
title: Hybrid domain isn't accepted domain for cloud organization
description: Describes an issue in which you receive an error message when you run the Hybrid Configuration wizard. Provides a solution.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: timothyh
appliesto:
- Exchange Online
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition
search.appverid: MET150
---
# Hybrid domain isn't an accepted domain for the cloud organization error when you run the Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3067179

## Symptoms

When you run the Hybrid Configuration wizard, you receive a **Hybrid domain \<Domain> isn't an accepted domain for the cloud organization** error message. The full text of this message resembles the following:

> ERROR:Updating hybrid configuration failed with error 'Subtask CheckPrereqs execution failed: Check Prerequisites
Microsoft.Exchange.Data.Common.LocalizedException: Hybrid domain `contoso.com` isn't an accepted domain for the cloud organization.  
Hybrid domain `contoso.com` isn't an accepted domain for the cloud organization.

## Cause

This problem occurs if the accepted domain is missing.

## Resolution

To resolve this issue, follow these steps:

1. Make sure that domains are added to your on-premises organization as accepted domains. For more information, see [Accepted domains](/exchange/accepted-domains-exchange-2013-help).

2. Make sure that domains are added to Microsoft Exchange Online as accepted domains. For more information, see [Verify a domain at any domain name registrar](/previous-versions/azure/jj151803(v=azure.100)).

3. Rerun the Hybrid Configuration wizard. When you're prompted to add your domain or domains, select the domains that you added. For more information, see step 5 of [Create a hybrid deployment with the Hybrid Configuration Wizard](/exchange/hybrid-deployment/deploy-hybrid).

## More information

If you experience issues with the Hybrid Configuration wizard, you can run the [Exchange Hybrid Configuration Diagnostic](https://aka.ms/hcwcheck). This diagnostic is an automated troubleshooting experience. Run it on the same server on which the Hybrid Configuration wizard failed. Doing this collects the Hybrid Configuration wizard logs and parses them for you. If you're experiencing a known issue, a message is displayed that tells you what went wrong. The message includes a link to an article that contains the solution. Currently, the diagnostic is supported only in Internet Explorer.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
