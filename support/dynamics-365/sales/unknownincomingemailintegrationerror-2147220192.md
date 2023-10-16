---
title: UnknownIncomingEmailIntegrationError 2147220192 error
description: UnknownIncomingEmailIntegrationError -2147220192 appears in alert in Microsoft Dynamics 365 mailbox. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# UnknownIncomingEmailIntegrationError -2147220192 appears in alert in Microsoft Dynamics 365 mailbox

This article provides a resolution for the issue that you may receive an error code **UnknownIncomingEmailIntegrationError -2147220192** that occurs in a warning alert in a Microsoft Dynamics 365 mailbox record.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4551320

## Symptoms

Emails are not received in a Microsoft Dynamics 365 mailbox and you see a warning alert like the following in a user's mailbox record:

> An unknown error occurred while receiving email through the mailbox "[Mailbox Name]". The owner of the associated email server profile [Profile Name] has been notified. The system will try to receive email again later.
>
> **Email Server Error Code:** Exchange server returned UnknownIncomingEmailIntegrationError -2147220192

## Cause

Error -2147220192 indicates the owner of the queue does not have sufficient privileges to work with the queue. The user is likely missing sufficient Read access to the Queue entity.

## Resolution

Verify the user's Microsoft Dynamics 365 security role has Read access to the Queue entity. Within a Microsoft Dynamics 365 security role, privileges for the Queue entity are located on the **Core Records** tab.

> [!NOTE]
> If you verify the owner of the mailbox record has Read access to the Queue entity, check if there are other Microsoft Dynamics 365 users or queues that received the same email. You may need to verify privileges for those users as well.
