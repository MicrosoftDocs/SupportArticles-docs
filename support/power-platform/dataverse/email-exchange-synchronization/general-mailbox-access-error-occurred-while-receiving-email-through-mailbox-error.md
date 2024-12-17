---
title: A general mailbox access error occurred while receiving email error
description: Solves the email server error code ErrorMailboxStoreUnavailable that occurs in Microsoft Dynamics 365.
ms.reviewer: 
ms.date: 12/10/2024
ms.custom: sap:Email and Exchange Synchronization
---
# "A general mailbox access error occurred while receiving email through the mailbox" occurs in Microsoft Dynamics 365

This article provides a resolution for an error that's logged in a Microsoft Dynamics 365 mailbox record.

_Applies to:_ &nbsp; Microsoft Dynamics 365  
_Original KB number:_ &nbsp; 4340389

## Symptoms

The following error is logged in the [Alerts](/power-platform/admin/monitor-email-processing-errors#view-alerts) section in a Dynamics 365 mailbox record:

> A general mailbox access error occurred while receiving email through the mailbox \<mailbox name>. The owner of the associated email server profile Microsoft Exchange Online has been notified. The system will try to receive email again later.  
> **Email Server Error Code:** Exchange server returned ErrorMailboxStoreUnavailable exception.

## Cause

The alert might occur when using the [server-side synchronization](/power-platform/admin/set-up-server-side-synchronization-of-email-appointments-contacts-and-tasks) feature in Dynamics 365 to integrate with Microsoft Exchange. When Dynamics 365 attempts to retrieve information for a mailbox using Exchange web services (EWS), Exchange might respond with an **ErrorMailboxStoreUnavailable**. As documented in [ResponseCode](/exchange/client-developer/web-service-reference/responsecode), the response indicates that Exchange couldn't process the request because the mailbox wasn't available at the time.

This error indicates that one of the following error conditions occurred.

- The mailbox store is corrupt.
- The mailbox store is being stopped.
- The mailbox store is offline.
- A network error occurred when an attempt was made to access the mailbox store.
- The mailbox store is overloaded and can't accept any more connections.
- The mailbox store has been paused.

## Resolution

If this error appears intermittently but incoming and outgoing emails are processing successfully, you can disregard it. Dynamics 365 will try accessing the mailbox again.

If the error persists, ensure the Exchange mailbox is accessible. If you're using Exchange Online, check the [Service Health Dashboard](https://portal.office.com/adminportal/home#/servicehealth) as a Microsoft 365 administrator to ensure there are no reported service health issues for Exchange Online.

## More information

To disable warning-level alerts for server-side synchronization in the system settings:

1. Sign in to the Dynamics 365 web application as a user with the System Administrator role.
2. Navigate to **Settings** and then select **Email Configuration**.
3. Select **Email Configuration Settings**. The **Email** tab should be selected by default.
4. In the **Configure alerts** section, disable the **Warning** option and select **OK**.
