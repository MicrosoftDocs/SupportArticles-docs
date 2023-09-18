---
title: Web server returned SendFailure exception
description: Provides a solution to an error that occurs in Microsoft Dynamics 365.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-server
---
# Web server returned SendFailure exception warning appears in Microsoft Dynamics 365

This article provides a solution to an error that occurs in Microsoft Dynamics 365.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4471945

## Symptoms

The following warning level alert appears within a Dynamics 365 mailbox record:

> "An error occurred in sending email for mailbox [Mailbox Name] while connecting to the email server. The owner of the associated email server profile [Profile Name] has been notified. The system will try to send email again later.  
Email Server Error Code: Web server returned SendFailure exception."

## Cause

This warning may appear if Server-Side Synchronization attempted to send an email but received an error while connecting to your email server. It's typically a temporary issue and the item will be sent successfully when the item is retried.

## Resolution

If this message doesn't continue to occur, it can be ignored. If this message continues to be logged and you have emails that won't send successfully, you can contact Microsoft Support for assistance. There may be an issue with your email server, so you can first verify you can send and receive email successfully with your email service.
