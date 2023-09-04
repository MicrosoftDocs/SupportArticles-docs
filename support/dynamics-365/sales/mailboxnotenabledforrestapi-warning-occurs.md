---
title: MailboxNotEnabledForRESTAPI warning occurs
description: Provides a solution to an error that occurs in a Microsoft Dynamics 365 mailbox alert.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# MailboxNotEnabledForRESTAPI warning appears in Microsoft Dynamics 365 mailbox alert

This article provides a solution to an error that occurs in Microsoft Dynamics 365 mailbox alert.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4534628

## Symptoms

You see a warning like the following example within a mailbox alert in Dynamics 365:

> "A general mailbox access error occurred while sending the email message Test SSS with incoming via EXO profile but really on-prem through the mailbox \<Mailbox Name>. The owner of the associated email server profile Microsoft Exchange Online has been notified. The system will try to send the message again later.  
**Email Server Error Code:** MailboxNotEnabledForRESTAPI. Exchange.server returned 404 error."

## Cause

This warning may be logged if the mailbox is configured with an Exchange Online email server profile in Dynamics 365 but the mailbox is actually an Exchange on-premises mailbox.

## Resolution

If the mailbox is an Exchange on-premises mailbox, verify the Email Server Profile configured on the mailbox record isn't an Exchange Online profile. An Exchange Server (Hybrid) profile should be used when connecting to an Exchange on-premises mailbox.

For more information about configuring Dynamics 365 Online with Exchange on-premises, see [Connect Dynamics 365 for Customer Engagement apps (online) to Exchange Server (on-premises)](/dynamics365/customerengagement/on-premises/admin/connect-exchange-server-on-premises).
