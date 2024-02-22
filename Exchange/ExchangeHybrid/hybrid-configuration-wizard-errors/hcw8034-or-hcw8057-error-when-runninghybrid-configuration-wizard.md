---
title: HCW8034 or HCW8057 when running Hybrid Configuration wizard
description: Describes an issue that triggers an HCW8034 or HCW8057 error when you run the Hybrid Configuration wizard. Provides a resolution.
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
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# HCW8034 or HCW8057 error when you run the Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3087170

## Symptoms

When you run the Hybrid Configuration wizard in Microsoft Exchange Online or Exchange Server 2013, you receive one of the following error messages:

> HCW8034 Failed to provision Organization Relationship for {0}

> HCW8057 Office 365 was unable to communicate with your on-premises Autodiscover endpoint. This is typically due to incorrect DNS or firewall configuration. The Office 365 tenant is currently configured to use the following URL for Autodiscover queries from the Office 365 tenant to the on-premises organization - {0}.

## Cause

This issue may occur if one of the following conditions is true:

- The perimeter device uses preauthentication.
- The firewall is blocking required IP addresses from accessing on-premises servers in your environment.
- You have an internal DNS domain that's configured to block forwarding and that's missing the DNS record for Autodiscover.
- You're experiencing general on-premises configuration issues.

## Resolution

To resolve this issue, do one of the following, as appropriate for your situation.

### Perimeter device uses preauthentication

To troubleshoot preauthentication issues on a perimeter device, see [Configure Forefront TMG for a hybrid environment](/SharePoint/hybrid/configure-forefront-tmg-for-a-hybrid-environment).

### Firewall is blocking required IP addresses from accessing on-premises servers

Review the IP address and URL requirements for Microsoft 365 at [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges?view=o365-worldwide&preserve-view=true).

### You have an internal DNS domain that's configured to block forwarding

Add an A record for the Autodiscover URL (for example, `Autodiscover.contoso.com`) to the internal DNS record, and then point that record to the on-premises Client Access server.

### General on-premises configuration issues

For information about how to troubleshoot general on-premises issues, see [Troubleshoot a hybrid deployment](/exchange/hybrid-deployment/troubleshoot-a-hybrid-deployment).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
