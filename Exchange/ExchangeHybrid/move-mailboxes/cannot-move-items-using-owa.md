---
title: Can't use OWA move items in a hybrid deployment
description: Describes a scenario in an Exchange hybrid deployment in which users can't move items between their primary mailbox in on-premises Exchange Server 2010 and their cloud-based archive by using Outlook Web Access.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: danielsl, v-six
appliesto: 
  - Exchange Online
  - Exchange Online Archiving
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
  - Exchange Server 2010 Service Pack 3
search.appverid: MET150
ms.date: 01/24/2024
---
# Can't move items between on-premises Exchange mailboxes and their cloud-based archive in OWA

_Original KB number:_ &nbsp; 2970120

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the [Microsoft 365 Hybrid Configuration wizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Problem

In a hybrid deployment of on-premises Microsoft Exchange Server and Microsoft Exchange Online in Microsoft 365, users can't use Outlook Web Access (OWA) to move items between their primary mailbox in Exchange Server 2010 and their cloud-based archive.

## Cause

This behavior is by design. You can't use Outlook Web Access to move items between an on-premises Exchange Server 2010 mailbox and a cloud-based archive.

## Solution

Use Microsoft Outlook to move archived items.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).
