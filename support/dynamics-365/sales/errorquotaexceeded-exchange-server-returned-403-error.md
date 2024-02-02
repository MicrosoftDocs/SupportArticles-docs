---
title: Email remains in Pending Send status with 403 error
description: You may receive a ErrorQuotaExceeded. Exchange.server returned 403 error when sending an email in Microsoft Dynamics 365. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# ErrorQuotaExceeded Exchange server returned 403 error in Microsoft Dynamics 365 mailbox alert

This article provides a resolution for the issue that email remains in a Pending Send status after you send it in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Engagement Online  
_Original KB number:_ &nbsp; 4556585

## Symptoms

When attempting to send an email in Microsoft Dynamics 365, the email remains in a Pending Send status and the following alert is logged in the user's mailbox record:

> The email message [Message Subject] cannot be sent. Make sure that the credentials specified in the mailbox [Mailbox Name] are correct and have sufficient permissions for sending email. Then, enable the mailbox for email processing.
>
> **Email Server Error Code:**  ErrorQuotaExceeded. Exchange.server returned 403 error.

## Cause

This error indicates Microsoft Exchange is preventing the user from sending the email due to a quota/limit being exceeded. For example: If the mailbox has a limit of 10 GB of storage but has exceeded this limit, Microsoft Exchange may prevent you from sending email from that mailbox until the mailbox is within the allowed quota. Microsoft Exchange Online has multiple limits, which may prevent you from sending email. For more information, see [Exchange Online limits](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits).

## Resolution

Verify you can send email from the mailbox directly in Outlook or Outlook Web Access (OWA). If you cannot send email from Outlook as this mailbox and you have verified the mailbox has not exceeded any quotas, contact your Exchange administrator or Microsoft Exchange support.
