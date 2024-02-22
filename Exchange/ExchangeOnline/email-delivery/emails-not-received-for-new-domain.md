---
title: Emails aren't received for a new domain
description: Discusses an issue in which email messages aren't received for a new domain that you add in the Microsoft 365 portal.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: willfid, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Email messages aren't received for a new domain that you add in the Microsoft 365 portal

_Original KB number:_ &nbsp; 2415053

## Symptoms

When you add a new domain in Microsoft 365 portal, and you create users or change existing users to use the new domain, email messages aren't received for the new domain.

This can occur if one of the following is true:

- The domain has to replicate to all Microsoft Exchange Online servers. This could take up to one hour.
- The appropriate MX record doesn't exist or has to replicate to all applicable Domain Name System (DNS) servers around the world. This could take up to 72 hours.

## Resolution

To fix this issue, follow these steps:

1. Make sure that the new domain is verified in the Microsoft 365 portal.
2. Make sure that the MX record for the new domain points to the value that's listed in the **DNS Settings** section of the Microsoft 365 portal for Exchange Online. For more information, see [Work with domain names and DNS records in Microsoft Entra ID](/previous-versions/azure/jj151817(v=azure.100)).

3. You may have to wait up to 72 hours.

If your MX record must point to its current location, you have to take additional steps to have your email forwarded to your Microsoft 365 users. Use one of the following methods:

- Set up a hybrid deployment. For more information, see [Exchange Server Deployment Assistant](/exchange/exchange-deployment-assistant?view=exchserver-2019&preserve-view=true).

  For more information about mail flow setup options in a hybrid deployment, see the following Microsoft resources:

  - For on-premises Exchange 2013: [Transport Options in Exchange 2013 Hybrid Deployments](/exchange/transport-options)
  - For on-premises Exchange 2010: [Understanding Transport Options in Exchange 2010 Hybrid Deployments](/previous-versions/office/exchange-server-2010/hh945232(v=exchg.141))
- Set up forwarding to the Microsoft 365 users' Online Email Routing Address (`domain.onmicrosoft.com`). For more information, see [Forward email to another email account](https://support.microsoft.com/office/create-reply-to-or-forward-email-messages-in-outlook-on-the-web-ecafbc06-e812-4b9e-a7af-5074a9c7abd0).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
