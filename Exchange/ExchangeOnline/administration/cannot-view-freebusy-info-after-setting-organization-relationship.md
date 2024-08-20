---
title: Cannot see free/busy if setting organization relationship
description: Describes a scenario in which on-premises users can't view calendar availability of cloud users after you set up an organization relationship. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: timothyh, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2010 Standard
  - Exchange Server 2010 Enterprise
search.appverid: MET150
ms.date: 01/24/2024
---
# On-premises users can't view free/busy information of Exchange Online users after you set up an organization relationship

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard that's available at [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

_Original KB number:_ &nbsp; 2896834

## Symptoms

You set up an organization relationship between your Exchange Online organization in Microsoft 365 and an on-premises Exchange organization that's running Microsoft Exchange Server 2010. However, on-premises users can't view the free/busy information of cloud users. Additionally, you experience the following symptoms:

- When you run the `test-Organizationrelationship` cmdlet from the Exchange Server 2010 server, you receive the following error message:

  The request failed with HTTP status 404: Not Found.
- If Outlook logging is enabled, the following error is logged when an on-premises user tries to view the free/busy information of a cloud user:

  An exception System.Net.WebException: The request failed with HTTP status 404: Not Found.&#xD

## Cause

This behavior is by design. For on-premises users and cloud users to share free/busy information with one another, you must be running Exchange Server 2010 Service Pack 3 (SP3) or a later version.

This is a known requirement for hybrid deployments. However, this is also a requirement if you set up a relationship between your Exchange Online organization in Microsoft 365 and another organization.

## Resolution

Install Update Rollup 2 or later for Exchange 2010 SP3 in the on-premises environment.

## More information

For more information about the latest updates for Exchange 2010, see [Exchange Server build numbers and release dates](/Exchange/new-features/build-numbers-and-release-dates).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
