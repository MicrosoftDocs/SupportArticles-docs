---
title: A general mailbox access error occurred while receiving email error
description: A general mailbox access error occurred while receiving email through the mailbox warning alert is logged in Microsoft Dynamics 365. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-email-office-integration
---
# A general mailbox access error occurred while receiving email through the mailbox warning occurs in Microsoft Dynamics 365

This article provides a resolution for the **A general mailbox access error occurred while receiving email through the mailbox** warning that's logged in a Microsoft Dynamics 365 mailbox record.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4340389

## Symptoms

A warning alert with the following message is logged in a Microsoft Dynamics 365 mailbox record:

> A general mailbox access error occurred while receiving email through the mailbox \<mailbox name>. The owner of the associated email server profile Microsoft Exchange Online has been notified. The system will try to receive email again later.  
**Email Server Error Code:** Exchange server returned ErrorMailboxStoreUnavailable exception.

## Cause

This warning may be logged when using the Server-Side Synchronization feature in Microsoft Dynamics 365 to integrate with Microsoft Exchange. Microsoft Dynamics 365 communicates with Microsoft Exchange using Exchange web services (EWS). If Microsoft Dynamics 365 attempts to retrieve information for a mailbox, Microsoft Exchange may respond with an **ErrorMailboxStoreUnavailable**. As documented in the following Microsoft Exchange documentation, this response indicates Exchange could not process the request because the mailbox was not available at the time:

[ResponseCode](/exchange/client-developer/web-service-reference/responsecode)

This error indicates that one of the following error conditions occurred:

- The mailbox store is corrupt.
- The mailbox store is being stopped.
- The mailbox store is offline.
- A network error occurred when an attempt was made to access the mailbox store.
- The mailbox store is overloaded and cannot accept any more connections.
- The mailbox store has been paused.

## Resolution

If this warning message is found but does not continue to occur and incoming/outgoing emails are processing successfully, this warning can be ignored. Microsoft Dynamics 365 will try accessing the mailbox again. If the warning persists, it may be necessary to investigate why Microsoft Exchange is returning this message. Verify the Exchange mailbox is accessible. If you are using Exchange Online, access the [Service Health Dashboard](https://portal.office.com/adminportal/home#/servicehealth) as an Office 365 administrator to verify that no known service health issues are posted for the Exchange Online service.

## More information

If you want to disable Warning level alerts for Server-Side Synchronization, you can disable these events within System Settings:

1. As a user with the System Administrator role, access the Microsoft Dynamics 365 web application.
2. Navigate to **Settings** and then select **Email Configuration**.
3. Select **Email Configuration Settings**. The Email tab should be selected by default.
4. Within the **Configure alerts** section, remove the check for **Warning** and select **OK**.
