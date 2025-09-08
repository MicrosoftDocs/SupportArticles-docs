---
title: Email remains in Pending Send status with 403 error
description: Solves an ErrorQuotaExceeded. Exchange.server returned 403 error that occurs when you send an email in Microsoft Dynamics 365.
ms.reviewer: 
ms.date: 04/17/2025
ms.custom: sap:Email and Exchange Synchronization
---
# "ErrorQuotaExceeded Exchange server returned 403" error in Microsoft Dynamics 365 mailbox alert

This article provides a resolution for the issue where an email remains in a Pending Send status after you send it in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4556585

## Symptoms

When you try to send an email in Dynamics 365, the email remains in a Pending Send status, and the following alert is logged in the user's mailbox record:

> The email message [Message Subject] cannot be sent. Make sure that the credentials specified in the mailbox [Mailbox Name] are correct and have sufficient permissions for sending email. Then, enable the mailbox for email processing.  
> **Email Server Error Code:**  ErrorQuotaExceeded. Exchange.server returned 403 error.

## Cause

This error indicates that Microsoft Exchange Server prevents the user from sending the email due to a quota or limit being exceeded. For example, if the mailbox has exceeded its limit for storage, Microsoft Exchange Server might prevent you from sending the email from that mailbox until the mailbox is within the allowed quota. Microsoft Exchange Online has multiple limits that might prevent you from sending the email. For more information, see [Exchange Online limits](/office365/servicedescriptions/exchange-online-service-description/exchange-online-limits).

## Resolution

Verify that you can directly send an email from the mailbox in Outlook or [Outlook on the web (formerly known as Outlook Web App)](/exchange/clients-and-mobile-in-exchange-online/outlook-on-the-web/outlook-on-the-web). If you can't send an email and you verify the mailbox doesn't exceed any quotas, contact your Exchange administrator or Microsoft Exchange support.
