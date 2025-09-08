---
title: Cannot add more than 250 domains
description: Discusses an error message that you receive when you run the Hybrid Configuration Wizard to set up an Exchange hybrid deployment. Provides a solution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: rrajan, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# (Total number of explicit and implicit sub filters exceeds maximum allowed number of 250) error in Hybrid Configuration Wizard

_Original KB number:_ &nbsp; 3001493

## Symptoms

When you use the Hybrid Configuration Wizard to add more than 250 domains in an Exchange Online environment, you receive the following error message:

> The total number of explicit and implicit sub filters exceeds maximum allowed number of 250

## Cause

Currently, 238 domains can be added to one organization relationship. The Hybrid Configuration Wizard cannot set up the organization relationship for Exchange Online if there are more than 238 domains associated with one organization relationship.

## Resolution

To resolve this problem, follow these steps:

1. Add the first 238 domains by using the Hybrid Configuration Wizard. The wizard should complete successfully and create the organization relationship for the Exchange Online organization.

2. Create another organization relationship in Exchange Online, and then add the remaining domains to it. To do this, run the following command:

    ```powershell
    $or=Get-organizationrelationship "Name of the organization relationship created by hybrid" New-organizationrelationship -Name "O365 to On-premises1" -DomainNames "Remaining domains to be added separated by commas" -FreeBusyAccessEnabled:$true -FreeBusyAccessLevel "LimitedDetails" -DeliveryReportEnabled:$true -MailTipsAccessEnabled:$true -MailTipsAccessLevel All -PhotosEnabled:$true -ArchiveAccessEnabled:$true -TargetApplicationUri $or.TargetApplicationUri.OriginalString -TargetAutodiscoverEpr -$or.TargetAutodiscoverEpr.OriginalString
    ```

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
