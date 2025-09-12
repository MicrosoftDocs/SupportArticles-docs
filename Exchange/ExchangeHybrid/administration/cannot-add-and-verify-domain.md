---
title: Can't add and verify a domain in hybrid
description: Fixes an issue that prevents you from verifying a domain in Microsoft 365 when you have an Exchange hybrid deployment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: rayfong, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# An error occurred while working on your domain when you verify your domain in a hybrid deployment

_Original KB number:_ &nbsp; 3089230

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the [Microsoft 365 Hybrid Configuration wizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Problem

You have a hybrid deployment of on-premises Exchange Server and Exchange Online in Microsoft 365. When you try to add and verify a domain in the Microsoft 365 admin center, you receive the following error message after you add the TXT record or MX record:

> An error occurred while working on your domain. Please go back to the Domains page to restart the process.

When you go to the **Domains** page, you're redirected to the **Domain Setup** page. However, a new TXT or MX record is generated. After you update the TXT or MX record, you receive the same error message again. You cannot verify the domain.

## Cause

The domain name that you're trying to add to Microsoft 365 is already being used in the on-premises Exchange federation trust as the primary federation organization identifier (`ApplicationUri`).

> [!NOTE]
> To confirm that this is the cause of the issue, open the Exchange Management Shell, and then run the `Get-FederationTrust` cmdlet to locate the `ApplicationUri` attribute. Confirm that the `ApplicationUri` attribute is set to the domain name that you're trying to verify in Microsoft 365.

## Solution

To resolve this issue, follow these steps:

1. Remove the on-premises federation trust. For more info, see the following:
   - In Exchange Server 2013: [Remove a federation trust](/exchange/remove-a-federation-trust-exchange-2013-help).
   - In Exchange Server 2010: [Remove a Federation Trust](/previous-versions/office/exchange-server-2010/dd297972(v=exchg.141)).

2. Add and verify the domain in Microsoft 365. For more info, see [Add a domain to Microsoft 365](/microsoft-365/admin/setup/add-domain).

3. Re-create the on-premises federation trust. For more info, see the following:
   - In Exchange Server 2013: [Configure a federation trust](/exchange/configure-a-federation-trust-exchange-2013-help).
   - In Exchange Server 2010: [Create a Federation Trust](/previous-versions/office/exchange-server-2010/dd335198(v=exchg.141)).

4. Re-create the organization relationship at the organization with whom you have set up the organization relationship. For more info, see the following:
   - In Exchange Server 2013: [Create an organization relationship](/exchange/create-an-organization-relationship-exchange-2013-help).
   - In Exchange Server 2010: [Create an Organization Relationship](/previous-versions/office/exchange-server-2010/dd351260(v=exchg.141)).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
