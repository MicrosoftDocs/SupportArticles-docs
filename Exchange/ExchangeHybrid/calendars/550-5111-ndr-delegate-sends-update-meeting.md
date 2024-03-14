---
title: 550 5.1.11 NDR when delegate sends update to meeting after manager moved to Microsoft 365 hybrid environment
description: Delegate receives an NDR when they send updates to a meeting invitee after a manager is moved to Microsoft 365 hybrid environment.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto: 
- Exchange Online
search.appverid: MET150
ms.reviewer: kellybos, v-jeffbo, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/24/2024
---
# "550 5.1.11 RESOLVER.ADR.ExRecipNotFound" when delegate sends update to meeting after manager moved to Microsoft 365 hybrid environment

## Symptoms

Consider the following scenario:

- A manager, who has a delegate, has their mailbox moved to Microsoft 365.
- The delegate's mailbox remains in on-premises environment.
- The manager creates a meeting on their calendar after the mailbox is migrated.
- The delegate updates the meeting time and sends an updated version of the meeting to the invitees.

In this scenario, the delegate receives a non-delivery report that includes the following IMCEAEX address and error message:  

> `IMCEAEX-_o=ExchangeLabs_ou=Exchange+20Administrative+20Group+20+28FYDIBOHF23SPDLT+29_cn=Recipients_cn=SystemMailbox-john@mgd.contoso.com`
>
> Remote Server returned '550 5.1.11 RESOLVER.ADR.ExRecipNotFound; Recipient not found by Exchange Legacy encapsulated email address lookup'

## Cause

The **legacyExchangeDN** attribute value of the invitee's cloud object is stored in the calendar item. If the Microsoft Entra Connect (Microsoft Entra Connect) Exchange hybrid deployment settings aren't enabled, the **legacyExchangeDN** attribute values in the cloud aren't written back to the on-premises.

## Resolution

To resolve this issue, enable the Exchange hybrid deployment settings in Microsoft Entra Connect. For more information, see [Exchange hybrid writeback](/azure/active-directory/connect/active-directory-aadconnectsync-attributes-synchronized#exchange-hybrid-writeback).
