---
title: GeneralOutgoingEmailServerError error
description: Email Server Error Code GeneralOutgoingEmailServerError occurs in a Microsoft Dynamics 365 mailbox record. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# GeneralOutgoingEmailServerError error occurs in Microsoft Dynamics 365 mailbox

This article provides a resolution for the **GeneralOutgoingEmailServerError** that occurs in a Microsoft Dynamics 365 mailbox record.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4471979

## Symptoms

The following alert appears within a Microsoft Dynamics 365 mailbox record:

> An unexpected error occurred while sending the email message "[Email Subject]". Mailbox [Mailbox Name] didn't synchronize. The owner of the associated email server profile [Profile Name] has been notified.  
Email Server Error Code: GeneralOutgoingEmailServerError

## Cause

This message may appear if Server-Side Synchronization attempted to send an email but encountered an unexpected error. This is typically a temporary issue and the item will be sent successfully when the item is retried.

## Resolution

If this message does not continue to occur, it can be ignored. If this message continues to be logged and you have emails that won't send successfully, you can contact Microsoft Support for assistance. There may be an issue with your email server so you can first verify you can send and receive email successfully with your email service.
